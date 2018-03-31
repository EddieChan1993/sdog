<?php
/**
 * Created by PhpStorm.
 * User: EVE
 * Date: 2018/3/31
 * Time: 19:16
 */

namespace app\home\service;


use app\common\model\ScoreModel;
use app\common\service\BaseService;
use app\common\service\CurdService;
use think\Db;

class ScoreService extends BaseService
{
//操作积分
    public static function score($type, $client_id)
    {
        switch ($type) {
            case ScoreModel::$seeOtherInfoType:
                //看他人信息，减积分
                self::setDbScoreDec($client_id, ScoreModel::$seeOtherInfoNeedScore);
                self::saveScoreLog($client_id, "查看他人", -ScoreModel::$seeOtherInfoNeedScore);
                break;
            case ScoreModel::$editSelfInfoNeedType:
                //编辑个人资料
                self::setDbScoreDec($client_id, ScoreModel::$editSelfInfoNeedScore);
                self::saveScoreLog($client_id, "编辑个人资料", -ScoreModel::$editSelfInfoNeedScore);
                break;
            case ScoreModel::$shareGetType:
                //分享
                self::setDbScoreInc($client_id, ScoreModel::$shareGetScore);
                self::saveScoreLog($client_id, "推广", +ScoreModel::$shareGetScore);
                break;
            case ScoreModel::$perfectSelfInfoType:
                //完善个人资料
                self::setDbScoreInc($client_id, ScoreModel::$perfectSelfInfoScore);
                self::saveScoreLog($client_id, "完善个人资料", +ScoreModel::$perfectSelfInfoScore);
                break;
            case ScoreModel::$thumbUpedGetType:
                //被点赞
                self::setDbScoreInc($client_id, ScoreModel::$thumbUpedGetScore);
                self::saveScoreLog($client_id, "被赞", +ScoreModel::$thumbUpedGetScore);
                break;
            case ScoreModel::$collectedGetType:
                //被收藏
                self::setDbScoreInc($client_id, ScoreModel::$collectedGetScore);
                self::saveScoreLog($client_id, "被她/他所喜欢", +ScoreModel::$collectedGetScore);
                break;
            case ScoreModel::$signInType:
                //签到
                self::setDbScoreInc($client_id, ScoreModel::$signInGetScore);
                self::saveScoreLog($client_id, "签到",+ScoreModel::$signInGetScore);
                break;
            default:
                break;
        }
    }

    //写入积分日志
    public static function saveScoreLog($client_id, $remark, $score)
    {
        $data = [
            'remark' => $remark,
            'client_id' => $client_id,
            'score' => $score,
        ];
        CurdService::name('score_log')->add($data);
    }

    //增加积分
    public static function setDbScoreInc($client_id,$score)
    {
        Db::name('clients')
            ->where(['id' => $client_id])
            ->setInc('score', $score);
    }

    //减少积分
    public static function setDbScoreDec($client_id,$score)
    {
        Db::name('clients')
            ->where(['id' => $client_id])
            ->setDec('score', $score);
    }
}