<?php
/**
 * Created by PhpStorm.
 * User: pc
 * Date: 2018/3/28
 * Time: 11:21
 */
namespace app\common\model;

class ScoreModel
{
    public static $seeOtherInfoType=0;
    public static $editSelfInfoNeedType=1;
    public static $shareGetType=2;
    public static $perfectSelfInfoType=3;
    public static $thumbUpedGetType = 4;
    public static $collectedGetType = 5;
    public static $signInGetType = 6;
    public static $seedGetType = 7;

    public static $seeOtherInfoNeedScore=5;//查看他人资料消耗分数
    public static $editSelfInfoNeedScore=5;//编辑个人资料消耗分数
    public static $shareGetScore=10;//分享获取分数
    public static $perfectSelfInfoScore=10;//完善资料获取分数
    public static $thumbUpedGetScore = 1;//被点赞获取分数
    public static $collectedGetScore = 1;//被收藏获取分数
    public static $signInGetScore = 5;//被收藏获取分数
    public static $seedGetTypeScore = 2.5;//被查看获取分数
}