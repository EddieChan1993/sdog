<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 11:40
 */

namespace app\home\service;


use app\common\service\BaseService;
use app\common\service\CurdService;
use think\cache\driver\Redis;
use think\Db;
use think\Exception;
use think\Request;
use think\Validate;

class AuthService extends BaseService
{
    const TOKEN_WARING = 4005;//token警告，提醒重新登录
    const USER_CLOSE = 4001;//用户被禁，弹出无法使用页面
    const USER_INFO_NOT_OK = 4002;//用户信息没有完善，跳入到完善信息页面

    /**验证token的合法性
     * @param array $data
     * @param bool $checkInfoOk
     * @return string
     */
    public static function authToken(array $data,bool $checkInfoOk=true)
    {
        try {
            $redis = new Redis();
            if (empty($data['token'])) {
                throw new Exception('token为空');
            }

            $client_id = $redis->get("client_token:" . $data['token']);
            if (empty($client_id)) {
                //如果token过期或者不存在
                $res['code'] = self::TOKEN_WARING;
                throw new Exception('token无效');
            }
            self::$clientId = $client_id;
            $map['id'] = ['IN', self::$clientId];
            $isExtra = CurdService::name('clients')->getOneData($map);
            if (empty($isExtra)) {
                $res['code'] = self::TOKEN_WARING;
                throw new Exception("用户不存在");
            }
            self::$clientInfo = $isExtra;
            if ($isExtra['status'] == 1) {
                $res['code'] = self::USER_CLOSE;
                throw new Exception("该用户已被禁");
            }

            if ($isExtra['self_info_ok'] ==0&&$checkInfoOk){
                $res['code'] = self::USER_INFO_NOT_OK;
                throw new Exception("您的基本信息未完善");
            }

            self::saveTokenId($redis, $data['token'], $client_id);
            unset($_POST['token']);
        } catch (Exception $e) {
            self::setErr($e);
            $res['error'] = 1;
            $res['msg'] = $e->getMessage();
            echo json_encode($res);
            die;
        }
    }

    /**
     * 获取token
     * @param array $data
     * @return array
     */
    public static function getToken(array $data): array
    {
        $flag = [];

        try {
            $valid = new Validate([
                ['openid', 'require|unique:clients', 'openid必填|The current user already exists'],
                ['name', 'require', 'name必填'],
                ['avatar', 'require', 'avatar必填且不能为空'],
                ['country', 'require', 'country必填且不能为空'],
                ['province', 'require', 'province必填且不能为空'],
                ['city', 'require', 'city必填且不能为空'],
            ]);

            $redis = new Redis();
            if (!$valid->check($data)) {
                if ($valid->getError() == "The current user already exists") {
                    $openId = $_POST['openid'];
                    $map = [
                        'openid' => $openId,
                    ];
                    $clientIdArr = CurdService::name('clients')->getOneData($map, 'id,status');
                    if ($clientIdArr['status'] == 1) {
                        throw new Exception("该用户由于违规操作，已被禁");
                    }
                    $client_id = $clientIdArr['id'];
                    $token = $redis->get("client_id:$client_id");
                    if (empty($token)) {
                        $res = Request::instance();
                        $token = $res->token();
                        self::saveTokenId($redis, $token, $client_id);
                    }
                } else {
                    throw new Exception($valid->getError());
                }
            } else {
                Db::startTrans();
                $client_id = CurdService::name('clients')->addGetId($_POST);
                if (!$client_id) {
                    throw new Exception('sql insert error');
                }
                //redis,token和id相互关联
                $res = Request::instance();
                $token = $res->token();
                self::saveTokenId($redis, $token, $client_id);
                Db::commit();
            }
            $flag = ['token' => $token];
        } catch (Exception $e) {
            Db::rollback();
            self::setErr($e);
        }
        return $flag;
    }

    /**
     *  保存token和client_id的关联redis
     * @param $redis
     * @param $token
     * @param $client_id
     * @throws Exception
     */
    public static function saveTokenId($redis, $token, $client_id)
    {
        $res = $redis->set("client_token:$token", $client_id, 60 * 60 * 24 * 7);
        if (!$res) {
            throw new Exception("redis save client_token error");
        }
        $res = $redis->set("client_id:$client_id", $token, 60 * 60 * 24 * 7);
        if (!$res) {
            throw new Exception("redis save client_id error");
        }
    }

    public static function getOpenId($data):array
    {
        $code = $data['code'];
        $appid = "wxaeb595dcdfa3dbe0";
        $appSecret = "d1cb6c20d19167602b0afe18fc543eab";
        $url = 'https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code';
        $url = sprintf($url, $appid, $appSecret, $code);
        return http_curl($url);
    }
}