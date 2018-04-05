<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/4/5
 * Time: 23:08
 */

namespace app\home\controller\v1;


use app\admin\service\core\UpdateService;
use app\home\controller\Base;
use app\home\service\AuthService;
use app\home\service\UploadService;

/**
 * 七牛上传接口
 */
class Except extends Base
{
    function __construct()
    {
        parent::__construct();
        AuthService::authToken($_POST,false);
    }

    function uploadImg()
    {
        try {
            if (empty($_FILES)) {
                throw new \Exception("请上传图片");
            }
            $res=UploadService::qiniuUplogImg($_FILES['img_file']);
            if (empty($res)) {
                throw new \Exception(UpdateService::getErr());
            }
            $this->output($res);
        } catch (\Exception $e) {
            $this->warning($e->getMessage());
        }
    }

    function delImg()
    {
        $res = UploadService::qiniuDelImg($_POST['key']);
        if (empty($res)) {
            $this->warning(UploadService::getErr());
        }
        $this->output("删除成功");
    }
}