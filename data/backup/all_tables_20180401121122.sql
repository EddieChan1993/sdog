DROP TABLE IF EXISTS sdog_client_img;
CREATE TABLE `sdog_client_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL DEFAULT '0',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `c_time` int(11) NOT NULL COMMENT '创建时间',
  `u_time` int(11) NOT NULL COMMENT '编辑时间',
  `d_time` int(11) NOT NULL COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='用户相册表';
INSERT INTO `sdog_client_img` VALUES 
('4','1','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('5','2','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('6','3','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\"]','1521698343','0','0'),
('7','4','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\"]','1521698343','0','0'),
('9','5','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('13','6','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('14','7','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('15','8','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521698343','0','0'),
('17','9','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521963414','1521965441','0'),
('18','10','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521967206','0','0'),
('19','11','[\"http://sj.zol.com.cn/bizhi/showpic/480x800_96212_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\",\"http://sj.zol.com.cn/bizhi/showpic/480x800_96209_5.html\"]','1521967206','0','0'),
('20','1000','[\"one.jpg\",\"two.jpg\",\"three.jpg\"]','1521967206','1522553377','0');
DROP TABLE IF EXISTS sdog_clients;
CREATE TABLE `sdog_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL DEFAULT '',
  `c_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `u_time` int(11) DEFAULT '0' COMMENT '编辑时间',
  `d_time` int(11) DEFAULT '0' COMMENT '软删除',
  `in_time` int(11) NOT NULL DEFAULT '0' COMMENT '进入app时间',
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '用户名',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别0-男 1-女',
  `school` varchar(10) NOT NULL DEFAULT '' COMMENT '学校',
  `birth` varchar(12) NOT NULL DEFAULT '0' COMMENT '生日',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '心目中的另一半',
  `weixin` varchar(10) NOT NULL DEFAULT '' COMMENT '微信号',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '电话',
  `score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前积分',
  `province` varchar(10) NOT NULL DEFAULT '' COMMENT '省',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `country` varchar(10) NOT NULL DEFAULT '' COMMENT '国家',
  `city` varchar(10) NOT NULL DEFAULT '' COMMENT '城市',
  `self_info_ok` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否完善个人信息0-没有1-有',
  `age` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '年龄',
  `collect_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被收藏数量',
  `thumb_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被点赞数量',
  `view_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-禁用',
  `height` int(3) NOT NULL DEFAULT '0' COMMENT '身高',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
INSERT INTO `sdog_clients` VALUES 
('1','123','1521698343','1521967206','0','0','小花猫','1','电子科技大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','72','四川','123','绵阳','升家坝','1','21','33','12','11','0','160'),
('2','123123123','1521698812','0','0','0','抠脚大汉','0','东南大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','22','0','3','22','0','166'),
('3','12312312323','1521698817','0','0','0','噩梦终结者','1','四川大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','25','22','12','0','0','165'),
('4','12312312312','1521698820','0','0','0','无敌香港脚','0','西华师范','2012-01-14','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','21','1','22','11','0','162'),
('5','12312311212','1521698829','0','0','0','熏衣草','1','四川大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','22','1','32','22','0','163'),
('6','123123111212','1521698833','0','0','0','茅房不知','0','北大青鸟','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','24','11','0','11','0','160'),
('7','1231231112121233','1521698836','0','0','0','干饼子','1','四川大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','22','0','23','0','0','170'),
('8','123123111213434','1521698840','0','0','0','牛肉丸子','0','西南石油','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','23','22','2','33','0','155'),
('9','12312311121123132','1521698844','0','0','0','花千骨小妹子','1','四川大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','22','0','23','33','0','156'),
('10','12312311121333','1521707499','0','0','0','流氓兔','0','西南科技大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','20','0','111','0','0','157'),
('11','123123111213333331','1521707502','0','0','0','霹雳芭芭拉','1','四川外国语学院','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','0','四川','123123','绵阳','升家坝','1','19','33','0','22','0','158'),
('1000','1231231112133333311','1521707770','1522555203','0','1522555541','小花猫ee','1','四川大学','2012-01-13','高大威猛，帅气逼人','dc_wen2','18380591555','5184','四川','123123','绵阳','升家坝','1','20','0','44','11','0','160');
DROP TABLE IF EXISTS sdog_collect;
CREATE TABLE `sdog_collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collect_client_id` int(11) NOT NULL DEFAULT '0' COMMENT '收藏的用户id',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `c_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `u_time` int(11) DEFAULT '0' COMMENT '编辑时间',
  `d_time` int(11) DEFAULT '0' COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='收藏';
INSERT INTO `sdog_collect` VALUES 
('1','10','1','1521698833','0','0'),
('2','11','1','1521698833','0','0'),
('3','8','2','1521698833','0','0'),
('4','4','3','1521698833','0','0'),
('5','1','1000','1521698833','0','0'),
('9','2','1000','1521966887','0','0'),
('12','1000','1','1522553519','0','0');
DROP TABLE IF EXISTS sdog_imgs;
CREATE TABLE `sdog_imgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_size` varchar(255) DEFAULT NULL,
  `upload_date` varchar(255) DEFAULT NULL COMMENT '上传日期',
  `user_id` varchar(255) DEFAULT NULL COMMENT '操作者',
  `ip` varchar(255) DEFAULT NULL COMMENT '操作ip',
  `img_path` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '来源0-本地1-七牛',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片管理';
DROP TABLE IF EXISTS sdog_log;
CREATE TABLE `sdog_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `log_time` int(11) DEFAULT NULL,
  `from_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';
INSERT INTO `sdog_log` VALUES 
('13','管理员编辑提交','1490085875','13'),
('14','管理员编辑提交','1490085928','13'),
('15','管理员编辑提交','1490086060','13'),
('16','管理员编辑提交','1490086067','13'),
('17','管理员编辑提交','1490086113','13'),
('18','管理员编辑提交','1490086118','13'),
('19','管理员编辑提交','1491459715','13');
DROP TABLE IF EXISTS sdog_menu;
CREATE TABLE `sdog_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `module` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器',
  `method` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `data` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单类型 1：权限认证；0：只作为菜单',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1显示，0禁用',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  `nav_list` varchar(255) CHARACTER SET utf8 DEFAULT '0' COMMENT '层级关系',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';
INSERT INTO `sdog_menu` VALUES 
('211','249','admin','core.Menu','home_page','','0','1','后台菜单','fa fa-sitemap','','2','249-211'),
('216','0','admin','Default','default','','0','1','管理组','fa fa-users','12323','0','216'),
('217','216','admin','core.Admin','home_page','','0','1','管理员','fa fa-user','','0','216-217'),
('218','216','admin','core.Role','home_page','','0','1','角色管理','fa fa-map-marker','','0','216-218'),
('249','0','admin','Default','default','','0','1','设置','fa fa-gears','','0','249'),
('250','249','admin','core.Setting','home_page','','0','1','网站信息','fa fa-cog','','0','249-250'),
('252','249','admin','core.Dblist','home_page','','0','1','数据库备份','fa fa-cloud-download','','0','249-252'),
('265','0','admin','Default','default','','0','1','公告管理','fa fa-rss-square','','0','265'),
('266','265','admin','core.Posts','home_page_posts','','0','1','文章管理','fa fa-file-text','','0','265-266'),
('267','265','admin','core.Posts','home_page_term','','0','1','文章分类','fa fa-code-fork','','0','265-267'),
('304','249','admin','core.Imgs','home_page','','0','1','系统图库','glyphicon glyphicon-picture','','0','249-304'),
('305','217','admin','core.Admin','add_think','','1','1','管理员添加逻辑','','','0','216-217-305'),
('306','217','admin','core.Admin','edit_think','','1','1','管理员编辑逻辑','','','0','216-217-306'),
('307','217','admin','core.Admin','del_think','','1','1','管理员删除逻辑','','','0','216-217-307'),
('308','218','admin','core.Role','add_think','','1','1','角色添加逻辑','','','0','216-218-308'),
('309','218','admin','core.Role','del_think','','1','1','角色删除逻辑','','','0','216-218-309'),
('310','218','admin','core.Role','edit_think','','1','1','角色编辑逻辑','','','0','216-218-310'),
('311','250','admin','core.Setting','save_sites','','1','1','存储网站配置信息','','','0','249-250-311'),
('312','250','admin','core.Setting','save_seo','','1','1','存储完整seo','','','0','249-250-312'),
('313','266','admin','core.Posts','edit_think_posts','','1','1','文章编辑逻辑','','','0','265-266-313'),
('314','266','admin','core.Posts','del_think_posts','','1','1','文章删除逻辑','','','0','265-266-314'),
('315','266','admin','core.Posts','add_think_posts','','1','1','文章添加逻辑','','','0','265-266-315'),
('316','211','admin','core.Menu','del_think','','1','1','后台菜单删除逻辑','','','0','249-211-316'),
('317','211','admin','core.Menu','add_think','','1','1','后台菜单添加逻辑','','','0','249-211-317'),
('318','211','admin','core.Menu','edit_think','','1','1','后台菜单编辑逻辑','','','0','249-211-318'),
('319','252','admin','core.Dblist','export_more','','1','1','多表导出逻辑','','','0','249-252-319'),
('320','252','admin','core.Dblist','export_one','','1','1','单表导出逻辑','','','0','249-252-320'),
('321','252','admin','core.Dblist','del','','1','1','删除文件','','','0','249-252-321'),
('322','304','admin','core.Imgs','del_think','','1','1','删除图库文件','','','0','249-304-322'),
('323','267','admin','core.Posts','add_think_term','','1','1','文章分类添加逻辑','','','0','265-267-323'),
('324','267','admin','core.Posts','del_think_term','','1','1','文章分类删除逻辑','','','0','265-267-324'),
('325','267','admin','core.Posts','edit_think_term','','1','1','文章分类编辑逻辑','','','0','265-267-325'),
('326','328','admin','core.Upload','upload_sigle','','1','1','单图片上传逻辑','','','0','328-326'),
('327','328','admin','core.Upload','del_sigle_file','','1','1','单图片删除逻辑','','','0','328-327'),
('328','0','admin','Default','default','','0','0','功能模块','','','0','328'),
('329','252','admin','core.Dblist','download','','1','1','数据文件下载','','','0','249-252-329'),
('330','252','admin','core.Dblist','restore','','1','1','数据库文件执行','','','0','249-252-330'),
('331','249','admin','core.Setting','plugins_home','','0','1','插件库','fa fa-dropbox','微信、淘宝、短信接口参数','0','249-331'),
('345','0','admin','Default','default','','0','1','模板','','','0','345'),
('346','345','admin','Test','homePage','','0','1','模板1','','','0','345-346'),
('347','345','admin','Test2','homePage','','0','1','模板2','','','0','345-347');
DROP TABLE IF EXISTS sdog_options;
CREATE TABLE `sdog_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8 NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  `is_close` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1开启网站，0关闭网站',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='全站配置表';
INSERT INTO `sdog_options` VALUES 
('1','member_email_active','{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}','1','0'),
('6','site_options','{\"site_name\":\"AlphaCMS\",\"site_addr\":\"\",\"site_admin_email\":\"\",\"tel\":\"\",\"icp\":\"\",\"site_copyright\":\"\"}','1','1'),
('7','site_seo','{\"seo_title\":\"123123123\",\"seo_key\":\"Give yourself a future!,123123,asdas\",\"seo_remark\":\"\\u6211\\u4e0d\\u660e\\u767d\\uff0c\\u5929\\u7a7a\\u7684\\u9634\\u973e\\uff0c\\u662f\\u4f60\\u7684\\u4f24\\u6000\\u8fd8\\u662f\\u6211\\u7684\\u60b2\\u54c0\\uff0c\\u8c01\\u66fe\\u4ece\\u8c01\\u7684\\u9752\\u6625\\u91cc\\u8d70\\u8fc7\\uff0c\\u7559\\u4e0b\\u4e86\\u7b11\\u9765\\uff0c\\u8c01\\u66fe\\u5728\\u8c01\\u7684\\u82b1\\u5b63\\u91cc\\u505c\\u7559\\uff0c\\u6e29\\u6696\\u4e86\\u60f3\\u5ff5\\uff0c\\u8c01\\u53c8\\u4ece\\u8c01\\u7684\\u96e8\\u5b63\\u91cc\\u6d88\\u5931\\uff0c\\u6cdb\\u6ee5\\u4e86\\u773c\\u6cea\\u3002\"}','1','1');
DROP TABLE IF EXISTS sdog_posts;
CREATE TABLE `sdog_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned DEFAULT '0' COMMENT '发表者id',
  `post_keywords` varchar(150) CHARACTER SET utf8 DEFAULT '' COMMENT 'seo keywords',
  `post_source` varchar(150) CHARACTER SET utf8 DEFAULT NULL COMMENT '转载文章的来源',
  `post_date` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT 'post发布日期',
  `post_content` longtext CHARACTER SET utf8 COMMENT 'post内容',
  `post_title` text CHARACTER SET utf8 COMMENT 'post标题',
  `post_excerpt` text CHARACTER SET utf8 COMMENT 'post摘要',
  `post_status` int(2) DEFAULT '0' COMMENT 'post状态，1已审核，0未审核,3删除',
  `comment_status` int(2) DEFAULT '1' COMMENT '评论状态，1允许，0不允许',
  `post_modified` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT 'post更新时间，可在前台修改，显示给用户',
  `post_content_filtered` longtext CHARACTER SET utf8,
  `post_parent` bigint(20) unsigned DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `post_type` int(2) DEFAULT '1' COMMENT 'post类型，1文章,2页面',
  `post_mime_type` varchar(100) CHARACTER SET utf8 DEFAULT '',
  `comment_count` bigint(20) DEFAULT '0',
  `smeta` text CHARACTER SET utf8 COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `post_hits` int(11) DEFAULT '0' COMMENT 'post点击数，查看数',
  `post_like` int(11) DEFAULT '0' COMMENT 'post赞数',
  `istop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐 1推荐 0不推荐',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`id`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_date` (`post_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='Portal文章表';
INSERT INTO `sdog_posts` VALUES 
('6','1','','','1499226343','<p>123</p>','123','123','1','1','','','0','1','','0','{\"term_relation\":\"24\",\"thumb\":\"\"}','0','0','0','0');
DROP TABLE IF EXISTS sdog_role;
CREATE TABLE `sdog_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0禁用 1开启',
  `remark` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  `rules` text CHARACTER SET utf8 COMMENT '拥有的权限规则',
  `nav_list` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '该角色对应首页导航',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
INSERT INTO `sdog_role` VALUES 
('23','超级管理员','0','1','','1513757032','1516688138','0','216,218,310,309,308,217,307,306,305,249,331,304,322,252,330,329,321,320,319,250,312,311,211,318,317,316,265,267,325,324,323,266,315,314,313,328,327,326','216-217'),
('24','运营','','1','','1517386880','1517386929','0','216,218,310,309,308,217,307,306,305','249-211');
DROP TABLE IF EXISTS sdog_role_user;
CREATE TABLE `sdog_role_user` (
  `role_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='角色用户关联表';
INSERT INTO `sdog_role_user` VALUES 
('14','39','2'),
('15','1','22'),
('16','1','23');
DROP TABLE IF EXISTS sdog_score_log;
CREATE TABLE `sdog_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `client_id` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `c_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `u_time` int(11) DEFAULT '0' COMMENT '编辑时间',
  `d_time` int(11) DEFAULT '0' COMMENT '软删除',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='积分日志';
INSERT INTO `sdog_score_log` VALUES 
('1','编辑个人资料','1000','-5','1522553378','0','0','1'),
('2','查看他人','1000','-5','1522553444','0','0','0'),
('3','被赞','1000','1','1522553511','0','0','4'),
('4','被她/他所喜欢','1000','1','1522553519','0','0','5'),
('5','推广','1000','10','1522553526','0','0','2'),
('6','被她/他查看','1','5','1522554429','0','0','7'),
('7','查看他人','1000','-5','1522554429','0','0','0'),
('8','被她/他查看','1000','5','1522554429','0','0','7'),
('9','查看他人','1','-5','1522554429','0','0','0'),
('10','被她/他查看','1000','5','1522554520','0','0','7'),
('11','查看他人','1','-5','1522554520','0','0','0');
DROP TABLE IF EXISTS sdog_term_relationships;
CREATE TABLE `sdog_term_relationships` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`tid`),
  KEY `term_taxonomy_id` (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='Portal 文章分类对应表';
INSERT INTO `sdog_term_relationships` VALUES 
('2','6','24','0','1');
DROP TABLE IF EXISTS sdog_terms;
CREATE TABLE `sdog_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '分类名称',
  `slug` varchar(200) CHARACTER SET utf8 DEFAULT '',
  `taxonomy` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '分类类型',
  `description` longtext CHARACTER SET utf8 COMMENT '分类描述',
  `parent` bigint(20) unsigned DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) DEFAULT '0' COMMENT '分类文章数',
  `path` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '分类层级关系路径',
  `seo_title` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `seo_keywords` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `seo_description` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `list_tpl` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '分类文章页模板',
  `listorder` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='Portal 文章分类表';
INSERT INTO `sdog_terms` VALUES 
('24','首页','','文章','sdfsdf213','0','0','0','','','','news','content','0','1');
DROP TABLE IF EXISTS sdog_test;
CREATE TABLE `sdog_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-one 1-two 2-three',
  `name` varchar(8) DEFAULT NULL,
  `c_time` int(11) NOT NULL COMMENT '创建时间',
  `u_time` int(11) NOT NULL COMMENT '编辑时间',
  `d_time` int(11) NOT NULL COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='模板表,其余表按这张表字段编写';
INSERT INTO `sdog_test` VALUES 
('1','0','','1499229055','0','0'),
('2','1','','1499229055','0','0'),
('3','0','','1499229055','0','0'),
('4','1','','1499229055','0','0'),
('5','0','','1499229055','0','0'),
('6','1','','1499229055','0','0'),
('7','0','','1499229055','0','0'),
('8','1','','1499229055','0','0'),
('9','0','','1499229055','0','0'),
('10','1','','1499229055','0','0'),
('11','0','','1499229055','0','0'),
('12','1','','1499229055','0','0'),
('13','0','','1499229055','0','0'),
('17','0','345345','1516688852','0','0');
DROP TABLE IF EXISTS sdog_thumb_up;
CREATE TABLE `sdog_thumb_up` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumb_client_id` int(11) NOT NULL DEFAULT '0' COMMENT '点赞用户id',
  `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `c_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `u_time` int(11) DEFAULT '0' COMMENT '编辑时间',
  `d_time` int(11) DEFAULT '0' COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='点赞';
INSERT INTO `sdog_thumb_up` VALUES 
('1','1000','1','1522553511','0','0');
DROP TABLE IF EXISTS sdog_users;
CREATE TABLE `sdog_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '用户名',
  `avatar` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `user_pass` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_pass_salt` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码验证',
  `user_nicename` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '用户美名',
  `user_email` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `last_login_ip` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` varchar(255) CHARACTER SET utf8 DEFAULT '0' COMMENT '最后登录时间',
  `update_time` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` varchar(255) CHARACTER SET utf8 DEFAULT '0' COMMENT '注册时间',
  `user_status` int(11) NOT NULL DEFAULT '0' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `mobile` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号',
  `user_hits` int(11) DEFAULT '0' COMMENT '登陆次数',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
INSERT INTO `sdog_users` VALUES 
('1','admin','','f354bc916f4979959bb4c274e8e92976','aZKZBygJtL','admin','dc_wen663@163.com','117.139.251.57','1522415595','1522115349','1489155324','1','','2');
DROP TABLE IF EXISTS sdog_widgets;
CREATE TABLE `sdog_widgets` (
  `wid_id` int(11) NOT NULL AUTO_INCREMENT,
  `wid_params` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '参数',
  `wid_color` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '模块颜色',
  `wid_icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '模块图标',
  `wid_date` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '模块时间',
  `wid_admin` int(11) DEFAULT NULL COMMENT '操作者',
  `wid_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '插件名字',
  `wid_key` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '插件关键词',
  PRIMARY KEY (`wid_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='插件表';
INSERT INTO `sdog_widgets` VALUES 
('10','api_key=78aac6166f2318bd2eaceae0fba6aa84|sign=marsmob','default','fa fa-comments-o','1499931295','1','短信接口','msn'),
('11','url=https://captcha.luosimao.com/api/site_verify|api_key=fbdd90fa23bf05f970badd9a7fde8d0b|site_key=19d4e7396b5bda1e1db0442b9d28219d','info','fa fa-cogs','1501487859','1','螺丝帽验证接口','lsm_verify'),
('12','ak=YwBMfAjdDqGQMWrwWgQrkHoES8h_sfQ4oJT7esdG|sk=b-laMNJSLbOyGj-W7qfyFOGWEtvinnaeOLZtAs2-|bucket=alphacms|cdn=p2otxz81j.bkt.clouddn.com','success','fa fa-thermometer-0','1516242221','1','七牛','qiniu');
