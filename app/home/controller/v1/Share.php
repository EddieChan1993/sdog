<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/22
 * Time: 17:48
 */

namespace app\home\controller\v1;

use app\home\controller\Base;
use app\home\service\AuthService;
use app\home\service\ExtraService;

//分享
class Share extends Base
{
    function __construct()
    {
        parent::__construct();
        AuthService::authToken($_POST);
    }

    //分享回调
    function shareCallBack()
    {
       $res=ExtraService::shareCallBack();
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);
    }

    //我的积分记录
    function scoreLog()
    {
        $res = ExtraService::scoreLog($_POST);
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);
    }

    //离线阶段的积分情况
    function noSeeScoreLog()
    {
        $res = ExtraService::noSeeScoreLog();
        if (empty($res)) {
            $this->warning(ExtraService::getErr());
        }
        $this->output($res);

    }
}