<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 13:59
 */

namespace app\home\controller\v1;


use app\home\controller\Base;
use app\home\service\AuthService;
use app\home\service\ClientService;
use app\home\service\ExtraService;

//首页
class HomePage extends Base
{
    function __construct()
    {
        parent::__construct();
       AuthService::authToken($_POST);
    }
    //获取首页用户展示信息
    function getClientList()
    {
        $res = ClientService::getCLientList($_POST);
        $this->output($res);
    }

    //查看他人信息
    function otherInfo()
    {
        $res = ClientService::getOtherInfo($_POST);
        if (empty($res)) {
            $this->warning(ClientService::getErr());
        }
        $this->output($res);
    }

    //我的收藏
    function myCollect()
    {
        $res = ClientService::collectInfo($_POST);
        if (empty($res)) {
            $this->warning(ClientService::getErr());
        }
        $this->output($res);
    }

    //收藏,取消收藏
    function collect()
    {
        $res = ExtraService::collect($_POST);
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);
    }

    //点赞
    function thumbUp()
    {
        $res = ExtraService::thumbUp($_POST);
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);
    }

    function signIn()
    {
        $res = ExtraService::signIn();
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);
    }
}