<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018-02-24
 * Time: 11:12
 */

namespace app\common\service;

use think\Db;

class CurdService
{
    private static $dbName;
    public static function name($dbName)
    {
        self::$dbName = $dbName;
        return new CurdService();
    }

    /**
     * 删除指定行
     * @param int $id
     * @param bool $softDel
     * @return int
     */
    public function del(int $id,bool $softDel=false)
    {
        if ($softDel) {
            $updateData = [
                'd_time'=>time(),
                'id'=>$id,
            ];
            $res = Db::name(self::$dbName)->update($updateData);
        }else{
            $res=Db::name(self::$dbName)->delete($id);
        }
        return $res;
    }

    /**
     * 添加
     * @param array $data
     * @return int|string
     */
    public function add(array $data)
    {
        $data['c_time'] = time();
        return Db::name(self::$dbName)->insert($data);
    }

    /**
     * 添加并获取id
     * @param array $data
     * @return int|string
     */
    public function addGetId(array $data)
    {
        $data['c_time'] = time();
        return Db::name(self::$dbName)->insertGetId($data);
    }
    /**
     * 更新
     * @param array $data
     * @return int|string
     */
    public function update(array $data)
    {
        $data['u_time'] = time();
        return Db::name(self::$dbName)->update($data);
    }

    /**
     * 获取指定某行数据
     * @param array $whereData
     * @param string $fieldData
     * @return array|false|\PDOStatement|string|\think\Model
     */
    public function getOneData(array $whereData,string $fieldData='*')
    {
        return Db::name(self::$dbName)
            ->where($whereData)
            ->field($fieldData)
            ->find();
    }

    /**
     * 获取分页数据
     * @param array $whereData
     * @param int $pageNum
     * @param int $pageLimit
     * @param string $fieldData
     * @param string $orderData
     * @return false|\PDOStatement|string|\think\Collection
     */
    public function getLimitData(array $whereData=[], int $pageNum=1, int $pageLimit=15, string $fieldData = '*', string $orderData='id desc')
    {
        return Db::name(self::$dbName)
            ->where($whereData)
            ->order($orderData)
            ->field($fieldData)
            ->page($pageNum,$pageLimit)
            ->select();
    }

    /**
     * 获取所有信息
     * @param array $whereData
     * @param string $fieldData
     * @param string $orderData
     * @return false|\PDOStatement|string|\think\Collection
     */
    public function getAllData(array $whereData = [], string $fieldData = '*', string $orderData = 'id desc')
    {
        return Db::name(self::$dbName)
            ->where($whereData)
            ->order($orderData)
            ->field($fieldData)
            ->select();
    }
    /**
     * 后台获取更多数据，带分页样式
     * @param array $whereData
     * @param string $fieldData
     * @param string $orderData
     * @return false|\PDOStatement|string|\think\Collection
     */
    public function getPageData(array $whereData,string $fieldData = '*',string $orderData='id desc')
    {
        return Db::name(self::$dbName)
            ->where($whereData)
            ->order($orderData)
            ->field($fieldData)
            ->epage()
            ->select();
    }
}