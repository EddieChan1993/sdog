<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 17:41
 */

namespace app\home\controller\v1;


use app\home\controller\Base;
use app\home\service\AuthService;
use app\home\service\ClientService;

class SelfCenter extends Base
{
    function __construct()
    {
        parent::__construct();
    }

    //用户个人中心页面
    function selfInfo()
    {
        AuthService::authToken($_POST);
        $res = ClientService::getSelfInfo();
        if (empty($res)) {
            $this->warning(ClientService::getErr());
        }
        $this->output($res);
    }

    //编辑前获取用户信息
    public function beforeEditInfo()
    {
        AuthService::authToken($_POST,false);
        $res = ClientService::beforeEditSelfInfo();
        $this->output($res);
    }

    //编辑个人信息
    function editSelfInfo()
    {
        AuthService::authToken($_POST,false);
        $res = ClientService::editSelfInfo($_POST);
        if (empty($res)) {
            $this->warning(ClientService::getErr());
        }
        $this->output($res);
    }


}