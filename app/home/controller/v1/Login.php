<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 11:38
 */

namespace app\home\controller\v1;

use app\home\controller\Base;
use app\home\service\AuthService;
//127.0.0.47/home/v1.login/saveClientInfo
class Login extends Base
{
    //微信授权后
    public function authToken()
    {
        $res = AuthService::authToken($_POST);
        if (!$res) {
            self::warning(AuthService::getErr());
        }
        self::output($res);
    }

    //进入app，获取用户信息
    public function getToken()
    {
        $res = AuthService::getToken($_POST);
        if (!$res) {
            self::warning(AuthService::getErr());
        }
        self::output($res);
    }
}