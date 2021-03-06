/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 5.7.23-log : Database - community
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`community` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `tb_activity` */

DROP TABLE IF EXISTS `tb_activity`;

CREATE TABLE `tb_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `name` varchar(32) NOT NULL COMMENT '活动名字',
  `datetime` datetime DEFAULT NULL COMMENT '活动时间',
  `place` varchar(64) DEFAULT NULL COMMENT '活动地点',
  `belong` int(11) DEFAULT NULL COMMENT '活动所属社团',
  `amount` int(11) DEFAULT NULL COMMENT '参与人数',
  `detail` text COMMENT '活动详情',
  `sponsor_money` decimal(19,2) DEFAULT NULL COMMENT '所需赞助金额',
  `mid` int(11) DEFAULT NULL COMMENT '申请人ID',
  `type` int(11) NOT NULL COMMENT '审核状态',
  `aid` int(11) DEFAULT NULL COMMENT '审核人ID',
  `dismiss_message` varchar(256) DEFAULT NULL COMMENT '驳回信息',
  PRIMARY KEY (`id`),
  KEY `belong` (`belong`),
  KEY `mid` (`mid`),
  KEY `aid` (`aid`),
  CONSTRAINT `tb_activity_ibfk_1` FOREIGN KEY (`belong`) REFERENCES `tb_community` (`cid`),
  CONSTRAINT `tb_activity_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `tb_manager` (`mid`),
  CONSTRAINT `tb_activity_ibfk_3` FOREIGN KEY (`aid`) REFERENCES `tb_admin` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_activity` */

insert  into `tb_activity`(`id`,`name`,`datetime`,`place`,`belong`,`amount`,`detail`,`sponsor_money`,`mid`,`type`,`aid`,`dismiss_message`) values 
(1,'第一届ACM大赛','2020-03-19 14:00:00','花园校区东机房',1,201,'1、参赛报名：各参赛选手请于在2020年05月02日前，登录www.ncwu.club/hell 填写报名信息。\r\n2、正式比赛：2020年05月03日下午13:00-17:00于华北水利水电大学（花园校区）东机房二楼举办。\r\n3、组委会将于比赛结束后，对各参赛选手提交的程序代码进行查重，查重结束后，根据每位参赛者的比赛排名，确定获奖名单。\r\n',5000.00,1,1,1,NULL),
(2,'第一届书画大赛','2020-03-20 14:00:00','花园校区讲堂2',2,180,'书画大赛活动详情：略',2000.00,2,1,1,NULL);

/*Table structure for table `tb_activityimg` */

DROP TABLE IF EXISTS `tb_activityimg`;

CREATE TABLE `tb_activityimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动图片ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `url` varchar(64) NOT NULL COMMENT '宣传图片地址',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `tb_activityimg_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `tb_activity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tb_activityimg` */

insert  into `tb_activityimg`(`id`,`activity_id`,`url`) values 
(1,1,'/web/img/acm.png');

/*Table structure for table `tb_admin` */

DROP TABLE IF EXISTS `tb_admin`;

CREATE TABLE `tb_admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `aname` varchar(16) NOT NULL COMMENT '管理员账号',
  `password` varchar(16) NOT NULL COMMENT '管理员密码',
  `real_name` varchar(16) DEFAULT NULL COMMENT '管理员姓名',
  `type` int(11) NOT NULL COMMENT '管理员权限',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `aname` (`aname`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tb_admin` */

insert  into `tb_admin`(`aid`,`aname`,`password`,`real_name`,`type`) values 
(1,'admin','123456','杨珑奇',0),
(2,'admin1','123456','汪东升',1),
(3,'admin2','123456','赵金涛',2),
(4,'admin3','123456','唐智凯',3),
(5,'admin4','123456','倪文翰',4);

/*Table structure for table `tb_bill` */

DROP TABLE IF EXISTS `tb_bill`;

CREATE TABLE `tb_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '账单ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `way` varchar(128) DEFAULT NULL COMMENT '花销方式',
  `cost` decimal(19,2) DEFAULT NULL COMMENT '本次花销金额',
  `datetime` date DEFAULT NULL COMMENT '花销日期',
  `place` varchar(128) DEFAULT NULL COMMENT '花销地点',
  `mid` int(11) DEFAULT NULL COMMENT '上传人ID',
  `currentdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '当前时间',
  `note` text COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`),
  KEY `tb_bill_ibfk_1` (`activity_id`),
  CONSTRAINT `tb_bill_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `tb_activity` (`id`),
  CONSTRAINT `tb_bill_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `tb_manager` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_bill` */

insert  into `tb_bill`(`id`,`activity_id`,`way`,`cost`,`datetime`,`place`,`mid`,`currentdate`,`note`) values 
(1,1,'租器材',2000.00,'2020-03-19','微爱超市',1,'2020-03-19 20:46:54','摄像机1000元\r\n投影仪1000元'),
(2,2,'买奖品',1000.00,'2020-03-20','生活广场',NULL,'2020-03-20 00:19:12','奖品1000元'),
(3,1,'买奖品',1500.00,'2020-03-19','微爱超市',1,'2020-03-20 00:40:06','奖品1500元');

/*Table structure for table `tb_billdetail` */

DROP TABLE IF EXISTS `tb_billdetail`;

CREATE TABLE `tb_billdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `bill_id` int(11) NOT NULL COMMENT '账单ID',
  `sid` int(11) NOT NULL COMMENT '赞助商ID',
  `money` decimal(19,2) DEFAULT NULL COMMENT '赞助所占金额',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`),
  KEY `sid` (`sid`),
  CONSTRAINT `tb_billdetail_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `tb_bill` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tb_billdetail_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `tb_sponsor` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_billdetail` */

insert  into `tb_billdetail`(`id`,`bill_id`,`sid`,`money`) values 
(1,1,1,1000.00),
(2,1,2,1000.00),
(3,2,1,1000.00);

/*Table structure for table `tb_billprove` */

DROP TABLE IF EXISTS `tb_billprove`;

CREATE TABLE `tb_billprove` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '证明材料ID',
  `bill_id` int(11) NOT NULL COMMENT '账单ID',
  `url` varchar(64) NOT NULL COMMENT '证明材料地址',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `tb_billprove_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `tb_bill` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tb_billprove` */

insert  into `tb_billprove`(`id`,`bill_id`,`url`) values 
(1,1,'/web/a.png');

/*Table structure for table `tb_community` */

DROP TABLE IF EXISTS `tb_community`;

CREATE TABLE `tb_community` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '社团ID',
  `cname` varchar(32) NOT NULL COMMENT '社团名字',
  `mname` varchar(16) DEFAULT NULL COMMENT '社团负责人',
  `amount` int(11) DEFAULT NULL COMMENT '社团人数',
  `activity_nums` int(11) DEFAULT NULL COMMENT '社团活动数量',
  `hold_time` date DEFAULT NULL COMMENT '社团成立时间',
  `level` varchar(32) DEFAULT NULL COMMENT '社团等级',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cname` (`cname`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_community` */

insert  into `tb_community`(`cid`,`cname`,`mname`,`amount`,`activity_nums`,`hold_time`,`level`) values 
(1,'ACM社团','唐安如',300,0,'2016-06-01','校级社团'),
(2,'书画社','李丽坤',200,0,'2020-03-19','院级社团');

/*Table structure for table `tb_manager` */

DROP TABLE IF EXISTS `tb_manager`;

CREATE TABLE `tb_manager` (
  `mid` int(11) NOT NULL AUTO_INCREMENT COMMENT '社团管理员ID',
  `mname` varchar(16) NOT NULL COMMENT '社团管理员账号',
  `password` varchar(16) NOT NULL COMMENT '社团管理员密码',
  `real_name` varchar(16) DEFAULT NULL COMMENT '社团管理员姓名',
  `belong` int(11) NOT NULL COMMENT '所属社团ID',
  PRIMARY KEY (`mid`),
  UNIQUE KEY `mname` (`mname`),
  KEY `tb_manager_ibfk_1` (`belong`),
  CONSTRAINT `tb_manager_ibfk_1` FOREIGN KEY (`belong`) REFERENCES `tb_community` (`cid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_manager` */

insert  into `tb_manager`(`mid`,`mname`,`password`,`real_name`,`belong`) values 
(1,'acm','123456','唐安如',1),
(2,'shuhua','123456','李丽坤',2);

/*Table structure for table `tb_notice` */

DROP TABLE IF EXISTS `tb_notice`;

CREATE TABLE `tb_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(32) NOT NULL COMMENT '公告标题',
  `introduction` varchar(512) DEFAULT NULL COMMENT '公告概要',
  `content` varchar(2048) DEFAULT NULL COMMENT '公告内容',
  `aid` int(11) DEFAULT NULL COMMENT '发布人ID',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  CONSTRAINT `tb_notice_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `tb_admin` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_notice` */

insert  into `tb_notice`(`id`,`title`,`introduction`,`content`,`aid`,`datetime`) values 
(1,'网站须知','介绍了使用本站需要了解的信息','本站是华北水利水电大学的社团活动管理系统，方便社团申请活动，是本站的目的。',1,'2020-03-19 20:29:57'),
(2,'关于举办第一届ACM大赛','第一届ACM大赛的通知','第一届ACM大赛由ACM社团举办，致力于提高同学们的编程水平',1,'2020-03-19 20:31:52');

/*Table structure for table `tb_noticefile` */

DROP TABLE IF EXISTS `tb_noticefile`;

CREATE TABLE `tb_noticefile` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告附件ID',
  `nid` int(11) NOT NULL COMMENT '公告ID',
  `url` varchar(128) DEFAULT NULL COMMENT '附件地址',
  PRIMARY KEY (`id`),
  KEY `nid` (`nid`),
  CONSTRAINT `tb_noticefile_ibfk_1` FOREIGN KEY (`nid`) REFERENCES `tb_notice` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tb_noticefile` */

insert  into `tb_noticefile`(`id`,`nid`,`url`) values 
(1,2,'/web/noticefile/a.txt');

/*Table structure for table `tb_sponsor` */

DROP TABLE IF EXISTS `tb_sponsor`;

CREATE TABLE `tb_sponsor` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '赞助商ID',
  `sname` varchar(16) NOT NULL COMMENT '赞助商账号',
  `password` varchar(16) NOT NULL COMMENT '赞助商密码',
  `real_name` varchar(16) DEFAULT NULL COMMENT '赞助商姓名',
  `belong` varchar(32) DEFAULT NULL COMMENT '所属公司',
  `phone` varchar(24) DEFAULT NULL COMMENT '企业联系方式',
  `address` varchar(32) DEFAULT NULL COMMENT '企业地址',
  `detail` text COMMENT '企业详细信息',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sname` (`sname`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_sponsor` */

insert  into `tb_sponsor`(`sid`,`sname`,`password`,`real_name`,`belong`,`phone`,`address`,`detail`) values 
(1,'sponsor','123456','陈杰','雨羊集团','18738588307','河南省郑州市金水区金水东路136号','雨羊集团是全球企业间（B2B）电子商务的著名品牌，是目前全球最大的网上交易市场和商务交流社区。\r\n雨羊集团创建于1998年年底，总部设在杭州，并在海外设立美国硅谷、伦敦等分支机构。雨羊集团是全球企业间(B2B)电子商务的著名品牌，是目前全球最大的网上贸易市场。良好的定位，稳固的结构，优秀的服务使雨羊集团成为全球首家拥有211万商人的电子商务网站，成为全球商人网络推广的首选网站，被商人们评为\"最受欢迎的B2B网站\"。'),
(2,'sponsor2','123456','王锐','中科天地科技','15936365958','北京市海淀区银河路25号','有限公司致力于成为优秀的行业综合解决方案提供商、系统集成商和IT运维服务提供商，重点面向冶金行业、公检法司政府行业信息化领域提供综台解决方案。');

/*Table structure for table `tb_support` */

DROP TABLE IF EXISTS `tb_support`;

CREATE TABLE `tb_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '赞助记录ID',
  `sid` int(11) NOT NULL COMMENT '赞助商ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `money` decimal(19,2) DEFAULT NULL COMMENT '赞助金额',
  `left_money` decimal(19,2) DEFAULT NULL COMMENT '剩余金额',
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `tb_support_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `tb_sponsor` (`sid`),
  CONSTRAINT `tb_support_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `tb_activity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tb_support` */

insert  into `tb_support`(`id`,`sid`,`activity_id`,`money`,`left_money`) values 
(1,1,1,3000.00,3000.00),
(2,1,2,1000.00,1000.00),
(3,2,2,1000.00,1000.00),
(4,2,1,2000.00,2000.00);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
