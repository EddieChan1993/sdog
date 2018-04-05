<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/4/6
 * Time: 0:29
 */

namespace app\home\service;


use app\common\extend\QiniuEx;
use app\common\service\BaseService;

class UploadService extends BaseService
{
    /**
     * 上传图片
     * @param $img_file
     * @return array
     */
    public static function qiniuUplogImg($img_file):array
    {
        $flag = [];
        try {
            $qiniu = QiniuEx::getInstance();
            $token = $qiniu->getToken();
            $filePath = $img_file['tmp_name'];
            $fileName = $img_file['name'];
            $res = $qiniu->uploadSimple($filePath, $fileName, $token);
            $key_plugin = plugins_value('qiniu', 'cdn');
            $qiniuUrl = sprintf("http://%s/%s",$key_plugin , $res['key']);

            //获取文件信息
            $fileInfo = $qiniu->getFileInfo($res["key"]);
            //插入表中
            add_img_db($qiniuUrl, 1, $fileInfo['fsize']);
            $flag = [
                'url'=>$qiniuUrl,
                'key'=>$res['key']
            ];
        } catch (\Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }

    /**
     * 删除图片
     * @param $key
     * @return bool
     */
    public static function qiniuDelImg($key):bool
    {
        $flag = false;
        try {
            $qiniu = QiniuEx::getInstance();
            $flag=$qiniu->delFile($key);
        } catch (\Exception $e) {
            self::setErr($e);
        }
        return $flag;
    }
}