<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 17:47
 */

namespace app\home\service;

use app\common\model\ScoreModel;
use app\common\service\BaseService;
use app\common\service\CurdService;
use think\cache\driver\Redis;
use think\Db;
use think\Exception;

class ExtraService extends BaseService
{
    //收藏，取消收藏
    public static function collect(array $data): string
    {
        $flag = "";
        try {
            if (self::$clientId == $data['client_id']) {
                throw new Exception("不能收藏自己");
            }
            $isExtra = CurdService::name('clients')
                ->getOneData(['id' => $data['client_id']], 'id');
            if (empty($isExtra)) {
                throw new Exception("当前收藏用户不存在");
            }

            $collectData = [
                'collect_client_id' => $data['client_id'],
                'client_id' => self::$clientId
            ];
            $isExtraCollect = CurdService::name('collect')
                ->getOneData($collectData, 'id,d_time');
            if (empty($isExtraCollect)) {
                //没收藏过
                CurdService::name('collect')
                    ->add($collectData);
                //首次收藏才加积分
                ScoreService::score(ScoreModel::$collectedGetType, $data['client_id']);
                $flag = "收藏成功";
            } else {
                if (empty($isExtraCollect['d_time'])) {
                    CurdService::name('collect')
                        ->del($isExtraCollect['id'], true);
                    $flag = "取消收藏";
                } else {
                    //收藏过
                    CurdService::name('collect')
                        ->update(['id' => $isExtraCollect['id'], 'd_time' => 0]);
                    $flag = "收藏成功";
                }
            }
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    //点赞
    public static function thumbUp(array $data): string
    {
        $flag = "";
        try {
            if (self::$clientId == $data['client_id']) {
                throw new Exception("暂不支持给自己点赞");
            }
            $isExtra = CurdService::name('clients')
                ->getOneData(['id' => $data['client_id']], 'id');
            if (empty($isExtra)) {
                throw new Exception("当前收藏用户不存在");
            }

            $thumbUpData = [
                'thumb_client_id' => $data['client_id'],
                'client_id' => self::$clientId
            ];
            $isExtraThumb = CurdService::name('thumb_up')
                ->getOneData($thumbUpData, 'id');
            if (empty($isExtraThumb)) {
                CurdService::name('thumb_up')
                    ->add($thumbUpData);
                ScoreService::score(ScoreModel::$thumbUpedGetType, $data['client_id']);
            }
            $flag = "已赞";
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 积分记录
     * @param array $data
     * @return array
     */
    public static function scoreLog(array $data): array
    {
        $map['client_id'] = self::$clientId;
        $selfInfo = CurdService::name('clients')
            ->getOneData(['id' => self::$clientId], 'score');
        $data = CurdService::name('score_log')
            ->getLimitData($map, $data['pageCur'], $data['pageLimit'], 'remark,score,c_time');
        foreach ($data as $k => &$v) {
            $v['c_time'] = tranTime($v['c_time']);
        }
        $res['score_list'] = $data;
        $res['allScore'] = $selfInfo['score'];

        //清除未读积分消息
        $redis = new Redis();
        $key = "new_scores_log:" . self::$clientId;
        $redis->rm($key);

        return $res;
    }

    /**
     * 分享回调
     * @return string
     */
    public static function shareCallBack(): string
    {
        $flag = "";
        try {
            ScoreService::score(ScoreModel::$shareGetType, self::$clientId);
            $flag = "分享回调成功加入积分";
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 签到
     * @return string
     */
    public static function signIn():string
    {
        $flag = "";
        try {
            $redis = new Redis();
            $key = "sign_in:" . self::$clientId;
            $signInTime = $redis->get($key);
            if (!empty($redis->get($key))) {
                $today = strtotime(date('Ymd'));
                if ($signInTime < $today) {
                    $redis->set($key, time());
                    ScoreService::score(ScoreModel::$signInGetType, self::$clientId);
                    $flag = "签到成功";
                }else{
                    $flag = "今天已经签过了";
                }
            }else{
                $redis->set($key, time());
                ScoreService::score(ScoreModel::$signInGetType, self::$clientId);
                $flag = "签到成功";
            }
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    //是否签到
    public static function isSignIn()
    {
        $flag = false;
        try {
            $redis = new Redis();
            $key = "sign_in:" . self::$clientId;
            $signInTime = $redis->get($key);
            if (!empty($redis->get($key))) {
                $today = strtotime(date('Ymd'));
                if ($signInTime < $today) {
                    $flag = false;
                }else{
                    $flag = true;
                }
            }else{
                $flag = false;
            }
        } catch (Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 离线期间积分记录
     * @return array
     */
    public static function newScoreLog():array
    {
        $loginTime = self::$clientInfo['in_time'];
        $data['c_time']= ['BETWEEN',[$loginTime,time()]];
        $data['client_id'] = self::$clientId;

        $collectData['type'] = ScoreModel::$collectedGetType;
        $collectData=array_merge($collectData, $data);
        //被收藏的个数
        $colectSum=Db::name('score_log')
            ->where($collectData)
            ->count();

        //被点赞
        $thumbUpData['type'] = ScoreModel::$thumbUpedGetType;
        $thumbUpData = array_merge($thumbUpData, $data);
        $thumbUpSum = Db::name('score_log')
            ->where($thumbUpData)
            ->count();

        //被查看
        $seeData['type'] = ScoreModel::$seedGetType;
        $seeData = array_merge($seeData, $data);
        $seeNum = Db::name('score_log')
            ->where($seeData)
            ->count();

        //更新用户进入小程序时间
        $condition['id'] = self::$clientId;
        $condition['in_time'] = time();
        Db::name('clients')
            ->update($condition);

        return [
            'seeNums' => $seeNum,
            'thumbUpNums' => $thumbUpSum,
            'collectNums'=>$colectSum
        ];
    }
    /**
     *小喇叭更新状态
     * @return int
     */
    public static function noSeeScoreNums():int
    {
        $redis = new Redis();
        $key = "new_scores_log:" . self::$clientId;
        $newScoreNums = $redis->get($key);
        $newScoreNums = empty($newScoreNums) ? 0 : $newScoreNums;
        return $newScoreNums;
    }
}