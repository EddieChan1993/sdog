<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 14:27
 */

namespace app\home\service;


use app\common\model\ScoreModel;
use app\common\service\BaseService;
use app\common\service\CurdService;
use think\Db;
use think\Exception;
use think\Validate;

class ClientService extends BaseService
{
    /**
     * 获取用户列表
     * @return array
     */
    public static function getCLientList(array $data): array
    {
        //当前用户信息
        if ($data['order'] = "1") {
            //创建时间排序
            $order = 'id desc';
        }else if ($data['order'] == "2") {
            //更新时间
            $order = 'u_time desc';
        }else{
            $order = 'id desc';
        }

        $clientMap['self_info_ok'] = 1;
        $clients = CurdService::name('clients')
            ->getLimitData($clientMap, $data['pageCur'], $data['pageLimit'], 'id,name,sex,age,school,c_time,thumb_num',$order);
        $clientIdArr = array_column($clients, 'id');

        //列表用户相册
        $mapClientMap['client_id'] = ['in', $clientIdArr];
        $clientImg = CurdService::name('client_img')->getAllData($mapClientMap, 'client_id,img');
        $clientIdArr = array_column($clientImg, 'client_id');
        $clientImgArr = array_column($clientImg, 'img');
        $clientIdMapImg = array_combine($clientIdArr, $clientImgArr);

        //获取当前用户收藏的用户列表
        $mapCollect['client_id'] = self::$clientId;
        $mapCollect['collect_client_id'] = ['in', $clientIdArr];
        $collect = CurdService::name('collect')->getAllData($mapCollect, 'collect_client_id');
        $collectClientIdArr = array_column($collect, 'collect_client_id');

        //获取当前用户点赞的用户列表
        $mapThumbUp['client_id'] = self::$clientId;
        $mapThumbUp['thumb_client_id'] = ['in', $clientIdArr];
        $thumbUp = CurdService::name('thumb_up')->getAllData($mapThumbUp, 'thumb_client_id');
        $thumbClientIdArr = array_column($thumbUp, 'thumb_client_id');

        foreach ($clients as $k => &$v) {
            if (empty($clientIdMapImg[$v['id']])) {
                unset($clients[$k]);
                continue;
            }

            $imgArr = json_decode($clientIdMapImg[$v['id']]);
            $clients[$k]['img'] = $imgArr[0];
            $v['c_time'] = tranTime($v['c_time']);
            $v['is_collected'] = in_array($v['id'], $collectClientIdArr);
            $v['is_thumb'] = in_array($v['id'], $thumbClientIdArr);
        }
        return $clients;
    }

    /**
     * 获取完整个人资料
     * @return array
     */
    public static function getSelfInfo(): array
    {
        $flag = [];
        try {
            //获取自己的信息
            $clientId = self::$clientId;
            $clientMap['id'] = $clientId;
            $filed = "name,school,birth,remark,weixin,height,score";
            $baseInfo = CurdService::name('clients')->getOneData($clientMap,$filed);
            $imgJson=CurdService::name('client_img')
                ->getOneData(['client_id' => self::$clientId], 'img');
            $baseInfo['img_list']=json_decode($imgJson['img']);
            $flag = $baseInfo;
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 获取他人信息
     * @param array $data
     * @return array
     */
    public static function getOtherInfo(array $data): array
    {
        $flag = [];
        Db::startTrans();
        try {
            //判断积分
            $selfInfo = CurdService::name('clients')->getOneData(['id'=>self::$clientId], 'score');
            $score = $selfInfo['score'];
            if ($score < ScoreModel::$seeOtherInfoNeedScore) {
                $str = sprintf("当前积分【%d】不足,推广可获得积分喔", $score);
                throw new Exception($str);
            }
            //获取他人的信息
            $clientId = $data['client_id'];
            $clientMap['id'] = $clientId;
            $filedData = "name,sex,school,birth,remark,weixin,remark,self_info_ok";
            $data = CurdService::name('clients')->getOneData($clientMap,$filedData);
            $imgJson=CurdService::name('client_img')
                ->getOneData(['client_id' =>$clientId], 'img');
            $data['img_list']=json_decode($imgJson['img']);
            if (empty($data)) {
                throw new Exception("当前用户不存在");
            }
            if (empty($data['self_info_ok'])) {
                //如果个人信息没有完善
                throw new Exception("她/他还没完善个人信息，无法查看");
            }
            //增加浏览量
            Db::name('clients')
                ->where($clientMap)
                ->setInc('view_num');

            //操作积分
            ScoreService::score(ScoreModel::$seedGetType, $clientId);
            ScoreService::score(ScoreModel::$seeOtherInfoType, self::$clientId);
            Db::commit();
            unset($data['self_info_ok']);
            $flag = $data;
        } catch (Exception $e) {
            Db::rollback();
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 获取编辑前的个人信息
     * @return array
     */
    public static function beforeEditSelfInfo(): array
    {
        //获取自己的信息
        $clientId = self::$clientId;
        $clientMap['id'] = $clientId;
        $filed = "name,school,birth,remark,weixin,height";
        $baseInfo = CurdService::name('clients')->getOneData($clientMap,$filed);
        $imgJson=CurdService::name('client_img')
            ->getOneData(['client_id' => self::$clientId], 'img');
        $baseInfo['img_list']=json_decode($imgJson['img']);
        return $baseInfo;
    }

    /**
     * 个人资料编辑
     * @param array $data
     * @return string
     */
    public static function editSelfInfo(array $data): string
    {
        $flag = "";
        Db::startTrans();
        try {
            $data['id'] = self::$clientId;
            $selfInfo = CurdService::name('clients')->getOneData(['id'=>self::$clientId]);
            if ($selfInfo['score']<ScoreModel::$editSelfInfoNeedScore) {
                $str = sprintf("编辑个人资料所需积分【%d】不足,您当前积分【%d】！", ScoreModel::$editSelfInfoNeedScore,$selfInfo['score']);
                throw new Exception($str);
            }
            $valid = new Validate([
                ['name','require|unique:clients','姓名需要填写|当前所填姓名已经重复'],
                ['weixin','require|unique:clients','微信号需要填写|微信号已经重复'],
                ['sex','require|in:0,1','请选择性别|当前性别无效'],
                ['birth','require','选择你的生日'],
                ['height','require|number','请选择身高|身高含有非法字符'],
                ['school','require','学校需要填写'],
                ['remark','require','你心目中的他/她?'],
                ['img_list','require','图片需要上传'],
            ]);

            if (!$valid->check($data)) {
                throw new Exception($valid->getError());
            }
            $data['self_info_ok'] = 1;
            $imgArr=explode(',', $data['img_list']);
            unset($data['img_list']);
            //更新个人信息
            $data['age'] = calcAge($data['birth']);
            CurdService::name('clients')->update($data);
            if (count($imgArr) == 0&&count($imgArr)>4) {
                throw new Exception("图片必传且不能超过4张");
            }
            if (mb_strlen($imgArr[0])==0&&mb_strlen($imgArr[1])==0) {
                throw new Exception("前两张图片地址不能为空");
            }
            //获取先前上传记录
            $isExtraImgId=CurdService::name('client_img')
                ->getOneData(['client_id' => self::$clientId],'id');
            if ($isExtraImgId) {
                $updateImgData['id'] = $isExtraImgId['id'];
                $updateImgData['img'] = json_encode($imgArr);
                CurdService::name('client_img')->update($updateImgData);
            }else{
                $imgData['client_id'] = self::$clientId;
                $imgData['img'] = json_encode($imgArr);
                CurdService::name('client_img')->add($imgData);
            }

            if (empty($selfInfo['self_info_ok'])) {
                //首次编辑，获取积分
                ScoreService::score(ScoreModel::$perfectSelfInfoType, self::$clientId);
            }else{
                //再次修改，扣除积分
                ScoreService::score(ScoreModel::$editSelfInfoNeedType, self::$clientId);
            }
            //消耗积分
            $flag = "信息更新成功";
            Db::commit();
        } catch (Exception $e) {
            Db::rollback();
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 收藏信息
     * @param array $data
     * @return array
     */
    public static function collectInfo(array $data):array
    {
        $flag = [];
        try {
            $collectMap['client_id'] = self::$clientId;
            $pageCur = $data['pageCur'];
            $pageLimit = $data['pageLimit'];
            $collect=CurdService::name('collect')->getLimitData($collectMap,$pageCur,$pageLimit,'collect_client_id');
            $collectIdArr = array_column($collect, 'collect_client_id');
            //当前用户信息
            $clientMap['id'] = ['in',$collectIdArr];
            $clients = CurdService::name('clients')->getAllData($clientMap,'id,sex,age,name,school,c_time,thumb_num');
            $clientIdArr = array_column($clients, 'id');

            //列表用户相册
            $mapClientMap['client_id'] = ['in', $clientIdArr];
            $clientImg = CurdService::name('client_img')->getAllData($mapClientMap, 'client_id,img');
            $clientIdArr = array_column($clientImg, 'client_id');
            $clientImgArr = array_column($clientImg, 'img');
            $clientIdMapImg = array_combine($clientIdArr, $clientImgArr);

            //获取当前用户收藏的用户列表
            $mapCollect['client_id'] = self::$clientId;
            $mapCollect['collect_client_id'] = ['in', $clientIdArr];
            $collect = CurdService::name('collect')->getAllData($mapCollect, 'collect_client_id');
            $collectClientIdArr = array_column($collect, 'collect_client_id');

            //获取当前用户点赞的用户列表
            $mapThumbUp['client_id'] = self::$clientId;
            $mapThumbUp['thumb_client_id'] = ['in', $clientIdArr];
            $thumbUp = CurdService::name('thumb_up')->getAllData($mapThumbUp, 'thumb_client_id');
            $thumbClientIdArr = array_column($thumbUp, 'thumb_client_id');

            foreach ($clients as $k => &$v) {
                if (empty($clientIdMapImg[$v['id']])) {
                    unset($clients[$k]);
                    continue;
                }

                $imgArr = json_decode($clientIdMapImg[$v['id']]);
                $clients[$k]['img'] = $imgArr[0];
                $v['c_time'] = tranTime($v['c_time']);
                $v['is_collected'] = in_array($v['id'], $collectClientIdArr);
                $v['is_thumb'] = in_array($v['id'], $thumbClientIdArr);
            }
            return $clients;
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }
}