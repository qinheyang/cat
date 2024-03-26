/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : cat

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 26/03/2024 10:46:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单父级id',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件地址',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单类型（M目录 C菜单 A按钮）',
  `is_frame` bit(1) NULL DEFAULT b'1' COMMENT '是否是内联地址（0是，1不是）',
  `create_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建者用户名',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '修改者用户名',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', NULL, 'system', 'el-icon-setting', '', 'M', b'1', NULL, NULL, 'admin', '2023-10-10 22:11:16', b'0');
INSERT INTO `sys_menu` VALUES (2, '用户管理', 1, 'user', 'el-icon-user-solid', '/system/user/user', 'C', b'0', NULL, NULL, 'admin', '2023-10-10 22:12:47', b'0');
INSERT INTO `sys_menu` VALUES (3, '角色管理', 1, 'role', 'el-icon-s-custom', '/system/role/role', 'C', b'0', NULL, NULL, 'admin', '2023-10-10 22:12:36', b'0');
INSERT INTO `sys_menu` VALUES (4, '用户删除', 2, '', NULL, '', 'A', NULL, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_menu` VALUES (5, '菜单管理', 1, 'menu', 'el-icon-s-operation', '/system/menu/menu', 'C', b'0', NULL, NULL, 'admin', '2023-10-10 22:13:06', b'0');
INSERT INTO `sys_menu` VALUES (9, '校园流浪猫', NULL, 'cat-manage', 'el-icon-ali-cat-in-black-silhoue', '', 'M', b'0', 'admin', '2023-10-11 19:44:09', 'admin', '2023-10-11 20:19:51', b'0');
INSERT INTO `sys_menu` VALUES (10, '猫咪图鉴', 9, 'cat', 'el-icon-ali-label-cat', '/cat-manage/cat/cat', 'C', b'0', 'admin', '2023-10-11 20:19:43', 'admin', '2023-10-11 21:03:00', b'0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色名称',
  `create_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '修改人',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', NULL, '2023-09-12 13:48:51', NULL, '2023-10-08 21:39:16', b'0');
INSERT INTO `sys_role` VALUES (2, '普通用户', NULL, '2023-09-12 13:52:01', NULL, '2023-10-08 21:39:14', b'0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 5);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `create_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人的用户名',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新人的用户名',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '无敌大番茄', '$2a$10$Uf4yc3vfrC4CiM/F7ay/iOZYqAvQE4BmmsPy3ue/DIUDtePN1bdti', 'test@qq.com', '15244422222', '/profile/115d638ee05c42c8932b158d99305d00.jpg', 'zsd', '2023-09-17 10:40:20', 'admin', '2023-09-21 14:18:13', b'0');
INSERT INTO `sys_user` VALUES (50, 'common', 'common', '$2a$10$nUozfeXWa/7Owzmax9mzA.8V/KjZZqFPKorglc6MeU/w/kVrWZjmm', '', '', NULL, 'admin', '2023-10-07 20:58:06', 'admin', '2023-10-08 22:11:35', b'0');
INSERT INTO `sys_user` VALUES (51, 'test', '测试人员', '$2a$10$nrc2m941kw.lbUYX.Hb0UOnkkPRJ9dWDFISRTwZy8U3Sp3CEg/8wi', '', '', NULL, 'admin', '2023-10-08 17:32:05', '', NULL, b'1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (51, 2);
INSERT INTO `sys_user_role` VALUES (50, 2);

-- ----------------------------
-- Table structure for t_cat
-- ----------------------------
DROP TABLE IF EXISTS `t_cat`;
CREATE TABLE `t_cat`  (
  `cat_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '猫咪id',
  `cat_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '猫咪名称',
  `state` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '猫咪状况：0：健康，1：送养，2：失踪，3：离世',
  `color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '毛色',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '性别：0：公，1：母，2：未知',
  `is_sterile` bit(1) NULL DEFAULT b'0' COMMENT '是否绝育0：未绝育，1：绝育',
  `sterile_time` timestamp NULL DEFAULT NULL COMMENT '绝育时间',
  `first_witness` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '第一次目击',
  `disposition` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '性格',
  `appearance` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '外貌',
  `picture` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '图片相对路径',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像相对路径',
  `create_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '修改人',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`cat_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '流浪猫图鉴表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_cat
-- ----------------------------
INSERT INTO `t_cat` VALUES (11, '冒菜妈', '1', '三花', '1', b'1', '2018-10-17 00:00:00', '2018', '薛定谔亲人', '头小身子肥的三花猫', '/profile/35c56b01a4344395a681e7776cfd9b0b.jpg', '/profile/3bcfda1da8ef43adb9170e225dd98671.jpg', 'admin', '2023-10-19 14:56:54', '', '2023-10-19 14:57:08', b'0');
INSERT INTO `t_cat` VALUES (12, '大威', '2', '长毛三花', '1', b'1', '2011-06-30 00:00:00', '2011春', '薛定谔亲人', '长毛三花 白肚皮白四肢 背部和尾巴黑黄分明的花色 绿眼睛 左耳耳缺', '/profile/ffc1dc0516224fb1b34e053aa4479af9.png', '/profile/367e1671638848ffa5f361cc9ab58b66.jpg', 'admin', '2023-10-19 20:16:38', '', '2023-10-19 20:48:52', b'0');
INSERT INTO `t_cat` VALUES (13, '焦糖', '0', '玳瑁', '1', b'1', '2016-01-01 00:00:00', '2016夏', '吃东西时可以摸一下', '黄黑相间 黄多 阴阳脸', '/profile/b5ca775aca9241559b820137760f2a37.png', '/profile/5832ee7573824632a5e57636050b84e2.jpg', 'admin', '2023-10-19 20:18:53', '', NULL, b'0');
INSERT INTO `t_cat` VALUES (14, '麒麟', '3', '长毛玳瑁', '1', b'1', '2021-10-10 00:00:00', '2021春', '亲人不可抱 可摸', '长毛浅玳瑁 浅橘色多 右耳耳缺', '/profile/d33489a724bc4c6d9ef8b6198c01b68a.jpg', '/profile/08619ad158284309ab7e6a3ac25fcf04.jpg', 'admin', '2023-10-19 20:21:56', '', '2023-10-19 20:42:43', b'0');
INSERT INTO `t_cat` VALUES (15, '山花', '0', '三花', '1', b'0', NULL, '2019-05-24', '怕人 安全距离1m以外', '非常好看的 三花 脸部和耳朵橘 左前腿黑狸 右前腿橘狸的花臂少女 日渐圆润', '/profile/de62683f6b364434ac9d6a06862bb5e4.png', '/profile/1d923ebdff5b4db78abd2145920c697c.jpg', 'admin', '2023-10-19 20:24:17', '', '2023-10-19 20:27:08', b'0');
INSERT INTO `t_cat` VALUES (16, '砂糖橘', '0', '橘色', '1', b'1', '2019-05-20 00:00:00', '2018秋', '怕人 安全距离 1m以外', '短毛纯橘 黄眼睛 粉鼻头 脸小 圆眼睛', '/profile/1f84233aa08741fb9d97c8bce50a3348.png', '/profile/be3f85018c9746218913298767150b15.jpg', 'admin', '2023-10-19 20:37:25', '', '2023-10-19 20:46:28', b'0');
INSERT INTO `t_cat` VALUES (17, '左智', '0', '橘白', '0', b'1', '2020-11-05 00:00:00', '2020秋', '怕人 安全距离 1m以外', '腮大身肥的短毛橘白 白多 橘尾巴 左媒婆痣', '/profile/95485f19934a421ba094e71be017d012.png', '/profile/590e5ac037214ff8809826a6f51cc7f7.jpg', 'admin', '2023-10-19 20:39:38', '', '2023-10-19 20:45:26', b'0');
INSERT INTO `t_cat` VALUES (18, '冬笋', '0', '橘', '2', b'1', '2018-04-10 00:00:00', '2018-04-05', '', '短毛纯橘 浅绿色的眼睛 右耳有耳缺', '/profile/d4f5084880714aa2a7c95b6640357464.png', '/profile/b310a55d7a6a400abb8ed5296c93ab06.jpg', 'admin', '2023-10-19 20:41:17', '', '2023-10-19 20:44:04', b'0');
INSERT INTO `t_cat` VALUES (19, '薏米', '0', '长白毛', '0', b'1', '2019-03-13 00:00:00', '2019寒假', '薛定谔亲人', '异瞳小白猫 蓝黄异瞳 右耳耳缺', '/profile/6cbdcf4bd8bb41c5aaf97e249e7d860e.png', '/profile/28a4736bf90f44b89a7f11c13f5e4265.jpg', 'admin', '2023-10-19 21:16:02', '', '2023-10-19 21:23:57', b'0');
INSERT INTO `t_cat` VALUES (20, '棉花糖', '0', '白', '0', b'0', NULL, '2011-09', '薛定谔亲人', '又白又软好像棉花糖', '/profile/9f9851feb8f74d7d88637de8531b4732.png', '/profile/8b8dede1f39047b592d34e94f414fdbd.jpg', 'admin', '2023-10-19 21:17:24', '', '2023-10-19 21:24:32', b'0');
INSERT INTO `t_cat` VALUES (21, '藕黑', '0', '黑', '0', b'1', '2020-12-10 00:00:00', '2018', '亲人不可抱 可摸', '短毛黑 脸圆 有鼻梁处似乎有疤/泪痕/眼屎', '/profile/0bd840d0eb354ece877be888ddb82a5e.png', '/profile/2a70869aa25147dca50146af1736e2ac.jpg', 'admin', '2023-10-19 21:19:35', '', '2023-10-19 21:25:02', b'0');
INSERT INTO `t_cat` VALUES (22, '墨方', '0', '奶牛', '0', b'1', '2020-06-01 00:00:00', '2017年11月', '怕人 安全距离 1m以外', '脸方，总体黑毛，胸口白，嘴边对称的三角形白，黑鼻头', '/profile/371e015c3b724a05bd7f369f9eecfc57.png', '/profile/49effbc943b5482495372209646d064a.jpg', 'admin', '2023-10-19 21:28:09', '', '2023-10-19 21:33:32', b'0');
INSERT INTO `t_cat` VALUES (23, '仙草', '0', '奶牛', '0', b'1', '2020-10-02 00:00:00', '2019年11月', '怕人 安全距离 1m以内', '右眉处和头上各有一块三角黑毛 黑尾巴 身白', '/profile/ab1d84034d8542aba4ccbce9f1b38698.png', '/profile/661c936c3ead4b40ae35c3dd047fda5b.jpg', 'admin', '2023-10-19 21:30:18', '', '2023-10-19 21:34:24', b'0');
INSERT INTO `t_cat` VALUES (24, '奶牛鸡', '0', '奶牛', '0', b'1', '2023-07-17 00:00:00', '2022-1202', '怕人 安全距离 1m以外', '短毛奶牛 黑多 对称眼罩 对眼', '/profile/0cb9bc20397b4dabb91025e6ca534704.png', '/profile/94dab9aed6ca4ae58e371f595991dfe3.jpg', 'admin', '2023-10-19 21:32:53', '', '2023-10-19 21:34:54', b'0');
INSERT INTO `t_cat` VALUES (25, '麻糖', '0', '长毛黑狸', '0', b'1', '2021-10-06 00:00:00', '2017秋', '怕人 安全距离 1m 以内', '长毛黑狸 黄眼睛', '/profile/74a45ec2deaa47c3af4f42df4c6fd049.png', '/profile/d3fb382de9424c34bad844dd09fbc2da.jpg', 'admin', '2023-10-19 21:38:31', '', '2023-10-19 21:45:35', b'0');
INSERT INTO `t_cat` VALUES (26, '黑米粥', '0', '黑狸', '0', b'1', '2020-10-14 00:00:00', '2019-09-01', '亲人不可抱 可摸', '短毛黑狸 实际上长得和芝麻糊没有区别 不过胆子稍微大一点', '/profile/177d78730a7f41d4bbdc14bfda88f8a7.png', '/profile/d0ae78843f84422bb6d4d1bfc169bb7d.jpg', 'admin', '2023-10-19 21:39:51', '', '2023-10-19 21:47:47', b'0');
INSERT INTO `t_cat` VALUES (27, '竹妹', '0', '狸花加白', '1', b'1', '2020-11-18 00:00:00', '2018年', '薛定谔亲人', '神似出竹的小脸狸花 总是一脸委屈', '/profile/5c9cec53f43b433aa846dc27042b5193.png', '/profile/21b10a4f6f534498ab2f12a010523af3.jpg', 'admin', '2023-10-19 21:41:31', '', '2023-10-19 21:47:15', b'0');
INSERT INTO `t_cat` VALUES (28, '银元', '0', '狸花加白', '0', b'1', '2023-01-11 00:00:00', '2023-01-01', '亲人不可抱 可摸', '短毛狸花加白 踏雪 狸花斗篷 口皇右侧白色连到下巴', '/profile/118c3407d22b41f68987fb16e2a2491a.png', '/profile/0866e91c84374446adfc8b9d75baa5a7.jpg', 'admin', '2023-10-19 21:42:38', '', '2023-10-19 21:44:40', b'0');
INSERT INTO `t_cat` VALUES (29, 'test', '0', '白色', '0', b'0', NULL, '2019', '好', '', '/profile/fc4627dfe0d641368642686c0ce056f1.jpg', '/profile/fc4627dfe0d641368642686c0ce056f1.jpg', 'admin', '2023-12-12 09:31:34', 'admin', '2023-12-13 10:39:31', b'0');
INSERT INTO `t_cat` VALUES (30, '1', '1', '白', '0', b'1', '2023-12-13 00:00:00', '1', '好', '', '/profile/b4dac23b5f7a4c22b3998f82e3cc2357.jpg', '/profile/b4dac23b5f7a4c22b3998f82e3cc2357.jpg', 'admin', '2023-12-13 15:55:55', 'admin', '2023-12-13 15:56:26', b'0');
INSERT INTO `t_cat` VALUES (31, 'mk', '3', '灰不溜秋', '0', b'1', '2023-01-01 00:00:00', '2022.12.31', '傻逼', '脑袋有点不灵光', '/profile/eaacac560fe242ec9bb7b4478f3c7fab.jpg', '/profile/eaacac560fe242ec9bb7b4478f3c7fab.jpg', 'admin', '2023-12-14 09:00:49', 'admin', '2023-12-14 09:08:06', b'0');
INSERT INTO `t_cat` VALUES (32, '花花', '0', '白色', '0', b'0', NULL, '2021', 'test', '', NULL, NULL, 'admin', '2023-12-15 09:20:14', 'admin', '2023-12-15 14:18:36', b'0');

SET FOREIGN_KEY_CHECKS = 1;
