/*
 Navicat Premium Data Transfer

 Source Server         : [Xampp]
 Source Server Type    : MySQL
 Source Server Version : 110006
 Source Host           : localhost:33306
 Source Schema         : i-architecture

 Target Server Type    : MySQL
 Target Server Version : 110006
 File Encoding         : 65001

 Date: 30/01/2026 22:19:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'img_about', 'about.png', '2026-01-27 22:12:45');

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int UNSIGNED NOT NULL,
  `ordering` int UNSIGNED NOT NULL,
  `type` enum('image_pair','image_text_left','image_text_right','large_image','large_text','text_pair') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `timecreated` int UNSIGNED NOT NULL,
  `timemodified` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_modules_project_visible_ordering`(`project_id` ASC, `visible` ASC, `ordering` ASC) USING BTREE,
  CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of modules
-- ----------------------------

-- ----------------------------
-- Table structure for project_section_items
-- ----------------------------
DROP TABLE IF EXISTS `project_section_items`;
CREATE TABLE `project_section_items`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_id` int UNSIGNED NOT NULL,
  `type` enum('text','image','video','button','html','gallery','slider') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `media_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `order` int UNSIGNED NULL DEFAULT 0,
  `timecreated` int NULL DEFAULT NULL,
  `timeupdated` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `section_id`(`section_id` ASC) USING BTREE,
  CONSTRAINT `project_section_items_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `project_sections` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of project_section_items
-- ----------------------------
INSERT INTO `project_section_items` VALUES (1, 1, 'text', 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.', NULL, '{\"align-self\": \"center\", \"margin-top\": \"4rem\", \"margin-bottom\": \"4rem\"}', 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (2, 1, 'image', '', 'proyects/p-2/img_69427eda1fe652.72219394.png', '{\"width\":\"100% !important;\"}', 2, NULL, 1765965530);
INSERT INTO `project_section_items` VALUES (3, 2, 'image', '', 'proyects/p-2/img_6942cf6f90d318.29456320.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, NULL, 1765986159);
INSERT INTO `project_section_items` VALUES (4, 2, 'image', '', 'proyects/p-2/img_6942cf6f911729.55445410.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, NULL, 1765986159);
INSERT INTO `project_section_items` VALUES (5, 3, 'image', NULL, 'proyects/p-2/s3.png', '{\"width\": \"100%\"}', 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (6, 4, 'text', 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.', NULL, '{\"margin\": \"auto auto 6rem\"}', 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (7, 4, 'image', NULL, 'proyects/p-2/s4.png', NULL, 2, NULL, NULL);
INSERT INTO `project_section_items` VALUES (8, 5, 'image', NULL, 'proyects/p-2/s5-1.png', '{\"width\": \"100%\", \"height\": \"100%\"}', 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (9, 5, 'image', NULL, 'proyects/p-2/s5-2.gif', '{\"width\": \"100%\", \"height\": \"100%\"}', 2, NULL, NULL);
INSERT INTO `project_section_items` VALUES (10, 6, 'image', NULL, 'proyects/p-2/s6.png', '{\"width\": \"100%\", \"margin-top\": \"3rem\", \"margin-bottom\": \"6rem\"}', 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (11, 7, 'image', '', 'proyects/p-2/img_69441b08c3f6b4.69648177.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, NULL, 1766071048);
INSERT INTO `project_section_items` VALUES (12, 7, 'image', '', 'proyects/p-2/img_69441b08c43301.45638862.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, NULL, 1766071048);
INSERT INTO `project_section_items` VALUES (13, 8, 'image', '', 'proyects/p-2/img_696f747a0546c4.99957114.jpg', '{\"width\":\"100% !important;\"}', 1, NULL, 1768911994);
INSERT INTO `project_section_items` VALUES (14, 9, 'image', '', 'proyects/p-2/img_69441a3f475ca6.76038335.jpg', '[]', 1, NULL, 1766070847);
INSERT INTO `project_section_items` VALUES (15, 9, 'image', '', 'proyects/p-2/img_694418063532b0.09587691.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, NULL, 1766070278);
INSERT INTO `project_section_items` VALUES (16, 10, 'image', '', 'proyects/p-2/img_69441dd47ee566.20433891.jpg', '{\"width\":\"100% !important;\"}', 1, NULL, 1766071764);
INSERT INTO `project_section_items` VALUES (17, 11, 'image', NULL, 'proyects/p-2/s1.png', NULL, 1, NULL, NULL);
INSERT INTO `project_section_items` VALUES (18, 11, 'text', 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.', NULL, NULL, 2, NULL, NULL);
INSERT INTO `project_section_items` VALUES (26, 16, 'image', '', 'proyects/p-1/img_696a23d8e8e412.84743574.jpg', '{\"width\":\"100% !important;\"}', 1, 1763976851, 1768563672);
INSERT INTO `project_section_items` VALUES (27, 17, 'text', 'En una tradicional finca de labranza mallorquina con siglos de explotación. Se esconde una vivienda mimetizándose con los muros de marés otorgando al paisaje rural mallorquín el protagonismo que se merece.', '', '[]', 1, 1764168997, 1764168997);
INSERT INTO `project_section_items` VALUES (28, 17, 'image', '', 'proyects/p-1/img_692715250626a8.55978426.png', '[]', 2, 1764168997, 1764168997);
INSERT INTO `project_section_items` VALUES (29, 18, 'image', '', 'proyects/p-1/img_692717106f2ba6.62361647.png', '[]', 1, 1764169488, 1764169488);
INSERT INTO `project_section_items` VALUES (30, 19, 'text', '', '', '[]', 1, 1764170047, 1764170047);
INSERT INTO `project_section_items` VALUES (31, 19, 'image', '', 'proyects/p-1/img_6927193f7baec9.32081849.jpeg', '[]', 2, 1764170047, 1764170047);
INSERT INTO `project_section_items` VALUES (32, 20, 'text', '', '', '[]', 1, 1764170486, 1764170486);
INSERT INTO `project_section_items` VALUES (33, 20, 'image', '', 'proyects/p-1/img_69271af6572349.59813077.jpeg', '[]', 2, 1764170486, 1764170486);
INSERT INTO `project_section_items` VALUES (34, 21, 'video', '', 'proyects/p-1/img_69493540735080.46093171.mp4', '{\"align-self\":\"center !important;\"}', 1, 1764861732, 1766405440);
INSERT INTO `project_section_items` VALUES (35, 21, 'text', 'La piscina enclavada en la piedra ayuda a suavizar las inclemencias del tiempo: refresca en verano y protege contra el viento en invierno.', '', '{\"align-self\":\"center !important;\"}', 2, 1764861732, 1766405440);
INSERT INTO `project_section_items` VALUES (36, 22, 'image', '', 'proyects/p-1/img_6931a794781c06.22085813.jpeg', '{\"width\":\"100% !important;\"}', 1, 1764861844, 1764861844);
INSERT INTO `project_section_items` VALUES (37, 23, 'image', '', 'proyects/p-1/img_6931a7dc883f38.00413746.png', '{\"width\":\"100% !important;\"}', 1, 1764861916, 1764861916);
INSERT INTO `project_section_items` VALUES (38, 24, 'image', '', 'proyects/p-1/img_6931a8dfec8b62.97707435.png', '[]', 1, 1764862175, 1764862175);
INSERT INTO `project_section_items` VALUES (39, 25, 'text', 'En Entre Muros, los tres dormitorios dobles miran al este para capturar los primeros rayos de sol, mientras que, por el oeste, la jornada se despide  con espectaculares atardeceres enmarcados en las montañas, que reflejan sus últimas luces en la lámina de agua de la piscina, con forma de cala privada y protegida por piedra y vegetación. “El color”, es fundamental para potenciar ese imaginario rural. Los materiales se presentan en bruto, encuadrando cada mirada. ', '', '{\"align-self\":\"center !important;\"}', 1, 1764862353, 1766482837);
INSERT INTO `project_section_items` VALUES (40, 25, 'image', '', 'proyects/p-1/img_694a63958c4be7.79347761.jpeg', '{\"align-self\":\"center !important;\"}', 2, 1764862353, 1766482837);
INSERT INTO `project_section_items` VALUES (41, 26, 'image', '', 'proyects/p-1/img_6931a9fade5ed1.37230068.jpeg', '{\"width\":\"100% !important;\"}', 1, 1764862458, 1764862458);
INSERT INTO `project_section_items` VALUES (42, 27, 'image', '', 'proyects/p-1/img_6931aa74aadad9.93853822.jpeg', '[]', 1, 1764862580, 1764862580);
INSERT INTO `project_section_items` VALUES (43, 27, 'text', '', '', '[]', 2, 1764862580, 1764862580);
INSERT INTO `project_section_items` VALUES (44, 28, 'text', '', '', '[]', 1, 1764862657, 1764862657);
INSERT INTO `project_section_items` VALUES (45, 28, 'image', '', 'proyects/p-1/img_6931aac1b4ee19.66355283.jpeg', '[]', 2, 1764862657, 1764862657);
INSERT INTO `project_section_items` VALUES (46, 29, 'image', '', 'proyects/p-1/img_6931aafab71e27.89698708.pdf', '[]', 1, 1764862714, 1764862714);
INSERT INTO `project_section_items` VALUES (47, 30, 'image', '', 'proyects/p-1/img_6931ab1646bdb2.80441396.png', '[]', 1, 1764862742, 1764862742);
INSERT INTO `project_section_items` VALUES (48, 31, 'video', '', 'proyects/p-1/img_6931ab585b6ae9.30886099.mov', '[]', 1, 1764862808, 1764862808);
INSERT INTO `project_section_items` VALUES (49, 31, 'text', '', '', '[]', 2, 1764862808, 1764862808);
INSERT INTO `project_section_items` VALUES (50, 32, 'video', '', 'proyects/p-1/img_6931ab93881af8.82968719.mp4', '[]', 1, 1764862867, 1764862867);
INSERT INTO `project_section_items` VALUES (51, 32, 'text', '', '', '[]', 2, 1764862867, 1764862867);
INSERT INTO `project_section_items` VALUES (52, 33, 'text', '', '', '[]', 1, 1764862969, 1764862969);
INSERT INTO `project_section_items` VALUES (53, 33, 'image', '', 'proyects/p-1/img_6931abf9948318.50538458.jpeg', '[]', 2, 1764862969, 1764862969);
INSERT INTO `project_section_items` VALUES (54, 34, 'image', '', 'proyects/p-1/img_6931ac4b63c661.56619400.jpeg', '[]', 1, 1764863051, 1764863051);
INSERT INTO `project_section_items` VALUES (55, 35, 'image', '', 'proyects/p-1/img_6931ac953ab4b1.49865777.png', '[]', 1, 1764863125, 1764863125);
INSERT INTO `project_section_items` VALUES (56, 36, 'image', '', 'proyects/p-1/img_6931ace4a245e7.93230374.jpeg', '{\"width\":\"100% !important;\"}', 1, 1764863204, 1764863204);
INSERT INTO `project_section_items` VALUES (57, 37, 'video', '', 'proyects/p-1/img_6968b9979e8c95.29684691.mp4', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1764863283, 1768470935);
INSERT INTO `project_section_items` VALUES (58, 37, 'text', '', '', '[]', 2, 1764863283, 1768470102);
INSERT INTO `project_section_items` VALUES (59, 38, 'image', '', 'proyects/p-1/img_6931adabe39640.02454531.jpeg', '[]', 1, 1764863403, 1764863403);
INSERT INTO `project_section_items` VALUES (60, 38, 'text', '', '', '[]', 2, 1764863403, 1764863403);
INSERT INTO `project_section_items` VALUES (61, 39, 'image', '', 'proyects/p-1/img_6931adeee49344.08593704.jpeg', '[]', 1, 1764863470, 1764863470);
INSERT INTO `project_section_items` VALUES (62, 39, 'text', '', '', '[]', 2, 1764863470, 1764863470);
INSERT INTO `project_section_items` VALUES (63, 40, 'text', '', '', '[]', 1, 1764863542, 1764863542);
INSERT INTO `project_section_items` VALUES (64, 40, 'image', '', 'proyects/p-1/img_6931ae365840f3.57281048.jpeg', '[]', 2, 1764863542, 1764863542);
INSERT INTO `project_section_items` VALUES (65, 41, 'image', '', 'proyects/p-1/img_6931aead39e4e1.06080998.jpeg', '[]', 1, 1764863661, 1764863661);
INSERT INTO `project_section_items` VALUES (66, 41, 'text', '', '', '[]', 2, 1764863661, 1764863661);
INSERT INTO `project_section_items` VALUES (67, 42, 'video', '', 'proyects/p-1/img_6931afb854d7f6.48679854.mp4', '[]', 1, 1764863928, 1764863928);
INSERT INTO `project_section_items` VALUES (68, 42, 'text', '', '', '[]', 2, 1764863928, 1764863928);
INSERT INTO `project_section_items` VALUES (69, 43, 'video', '', 'proyects/p-1/img_6931b0c64980c1.86713867.mov', '[]', 1, 1764864198, 1764864198);
INSERT INTO `project_section_items` VALUES (70, 43, 'text', '', '', '[]', 2, 1764864198, 1764864198);
INSERT INTO `project_section_items` VALUES (71, 44, 'video', '', 'proyects/p-1/img_6931b2ca6392f0.44487157.mp4', '[]', 1, 1764864714, 1764864714);
INSERT INTO `project_section_items` VALUES (72, 44, 'text', '', '', '[]', 2, 1764864714, 1764864714);
INSERT INTO `project_section_items` VALUES (73, 45, 'image', '', 'proyects/p-1/img_6931b466b65e70.88580411.jpg', '{\"width\":\"100% !important;\"}', 1, 1764865126, 1764865126);
INSERT INTO `project_section_items` VALUES (74, 46, 'text', 'UN TEMPLO EN LA COCINA, esta belleza monumental, acompañada por una encimera de acero inoxidable, es un ancla al mismísimo corazón de la isla. Antaño, la cocina era un lugar de reunión en lugares como Mallorca, esa costumbre se perdió y fue reducida a la condición de espacio escondido, privado y sucio, hasta que la cultura popular la rescató. ', '', '{\"align-self\":\"center !important;\"}', 1, 1764865361, 1766481102);
INSERT INTO `project_section_items` VALUES (75, 46, 'image', '', 'proyects/p-1/img_694a5ccee77411.54978698.jpg', '{\"align-self\":\"center !important;\"}', 2, 1764865361, 1766481102);
INSERT INTO `project_section_items` VALUES (76, 47, 'video', '', 'proyects/p-4/img_693a8b8812d870.20217755.mp4', '[]', 1, 1765444488, 1765444488);
INSERT INTO `project_section_items` VALUES (77, 47, 'text', '', '', '[]', 2, 1765444488, 1765444488);
INSERT INTO `project_section_items` VALUES (78, 48, 'video', '', 'proyects/p-4/img_6960e29ba1aef9.28348612.mp4', '{\"align-self\":\"center !important;\"}', 1, 1765444537, 1768836510);
INSERT INTO `project_section_items` VALUES (79, 48, 'text', 'ORTZIMUGA ETXEA, vivienda unifamiliar en proceso de construcción.', '', '{\"align-self\":\"center !important;\"}', 2, 1765444537, 1768836510);
INSERT INTO `project_section_items` VALUES (80, 49, 'video', '', 'proyects/p-4/img_693a8bdd874df3.00097813.mp4', '[]', 1, 1765444573, 1765444573);
INSERT INTO `project_section_items` VALUES (81, 49, 'text', 'HORTZIMUGA', '', '[]', 2, 1765444573, 1765444573);
INSERT INTO `project_section_items` VALUES (82, 50, 'image', '', '', '[]', 1, 1765444691, 1765444691);
INSERT INTO `project_section_items` VALUES (83, 51, 'image', '', 'proyects/p-4/img_693a8c813dd8f0.64548706.jpg', '[]', 1, 1765444737, 1765444737);
INSERT INTO `project_section_items` VALUES (84, 52, 'image', '', 'proyects/p-4/img_693a8cd250d5c0.68188991.gif', '[]', 1, 1765444818, 1765444818);
INSERT INTO `project_section_items` VALUES (85, 53, 'image', '', 'proyects/p-4/img_693a8d05d14253.38815415.gif', '[]', 1, 1765444869, 1765444869);
INSERT INTO `project_section_items` VALUES (86, 55, 'image', '', '', '{\"margin-top\":\"-10rem !important;\",\"margin-bottom\":\"-10rem !important;\"}', 1, 1765445006, 1765445006);
INSERT INTO `project_section_items` VALUES (87, 56, 'image', '', '', '{\"margin-top\":\"-10rem !important;\",\"margin-bottom\":\"-30rem !important;\"}', 1, 1765445074, 1765445074);
INSERT INTO `project_section_items` VALUES (88, 57, 'image', '', 'proyects/p-4/img_693a8e376dbff9.64715893.gif', '{\"margin-top\":\"-10rem !important;\",\"margin-bottom\":\"-10rem !important;\"}', 1, 1765445175, 1765445175);
INSERT INTO `project_section_items` VALUES (89, 57, 'text', '', '', '{\"margin-top\":\"-10rem !important;\",\"margin-bottom\":\"-10rem !important;\"}', 2, 1765445175, 1765445175);
INSERT INTO `project_section_items` VALUES (90, 58, 'image', '', 'proyects/p-4/img_693a8e75a95003.31587989.gif', '{\"margin-bottom\":\"-10rem !important;\"}', 1, 1765445237, 1765445237);
INSERT INTO `project_section_items` VALUES (91, 58, 'image', '', '', '{\"margin-bottom\":\"-10rem !important;\"}', 2, 1765445237, 1765445237);
INSERT INTO `project_section_items` VALUES (92, 59, 'image', '', '', '{\"margin-bottom\":\"-10rem !important;\",\"width\":\"100% !important;\"}', 1, 1765445272, 1765445272);
INSERT INTO `project_section_items` VALUES (93, 60, 'image', '', 'proyects/p-4/img_693a8ebec2a912.07476198.gif', '[]', 1, 1765445310, 1765445310);
INSERT INTO `project_section_items` VALUES (94, 61, 'image', '', 'proyects/p-4/img_693a8eddbb78e4.96692999.png', '[]', 1, 1765445341, 1765445341);
INSERT INTO `project_section_items` VALUES (95, 62, 'image', '', '', '{\"margin-top\":\"20rem !important;\",\"margin-bottom\":\"20rem !important;\"}', 1, 1765445447, 1765445447);
INSERT INTO `project_section_items` VALUES (96, 63, 'image', '', 'proyects/p-4/img_693a8fc2c0c104.76140803.png', '[]', 1, 1765445570, 1765445570);
INSERT INTO `project_section_items` VALUES (97, 64, 'image', '', 'proyects/p-4/img_693a90568ee048.71577861.jpg', '[]', 1, 1765445718, 1765445718);
INSERT INTO `project_section_items` VALUES (98, 65, 'image', '', 'proyects/p-4/img_693a90830ec842.71414127.jpg', '[]', 1, 1765445763, 1765445763);
INSERT INTO `project_section_items` VALUES (99, 66, 'image', '', 'proyects/p-4/img_693a90e2d682d1.22222611.jpg', '[]', 1, 1765445858, 1765445858);
INSERT INTO `project_section_items` VALUES (100, 67, 'image', '', 'proyects/p-4/img_693a915acb6bd3.65631405.jpg', '[]', 1, 1765445978, 1765445978);
INSERT INTO `project_section_items` VALUES (101, 68, 'image', '', '', '[]', 1, 1765446025, 1765446025);
INSERT INTO `project_section_items` VALUES (102, 68, 'image', '', 'proyects/p-4/img_693a9189ba02d6.14821766.jpg', '[]', 2, 1765446025, 1765446025);
INSERT INTO `project_section_items` VALUES (103, 69, 'image', '', 'proyects/p-4/img_693a91ca503bf3.90166827.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1765446090, 1765905955);
INSERT INTO `project_section_items` VALUES (104, 69, 'image', '', 'proyects/p-4/img_693a91ca505f50.51819308.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1765446090, 1765905955);
INSERT INTO `project_section_items` VALUES (105, 70, 'image', '', '', '[]', 1, 1765446371, 1765446371);
INSERT INTO `project_section_items` VALUES (106, 70, 'image', '', '', '[]', 2, 1765446371, 1765446371);
INSERT INTO `project_section_items` VALUES (107, 71, 'image', '', 'proyects/p-4/img_693a9329767ef8.93369925.jpg', '[]', 1, 1765446441, 1765446441);
INSERT INTO `project_section_items` VALUES (108, 71, 'image', '', 'proyects/p-4/img_693a932976a496.64024619.jpg', '[]', 2, 1765446441, 1765446441);
INSERT INTO `project_section_items` VALUES (109, 72, 'image', '', '', '[]', 1, 1765446655, 1765446655);
INSERT INTO `project_section_items` VALUES (110, 72, 'image', '', '', '[]', 2, 1765446655, 1765446655);
INSERT INTO `project_section_items` VALUES (111, 73, 'image', '', 'proyects/p-4/img_693d517e1c2805.24126599.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1765626238, 1765626238);
INSERT INTO `project_section_items` VALUES (112, 73, 'image', '', 'proyects/p-4/img_693d517e1c6d93.17413452.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1765626238, 1765626238);
INSERT INTO `project_section_items` VALUES (113, 74, 'image', '', 'proyects/p-3/img_6979e594c16744.15976792.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765901117, 1769596308);
INSERT INTO `project_section_items` VALUES (114, 74, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1765901117, 1769596308);
INSERT INTO `project_section_items` VALUES (115, 77, 'image', '', 'proyects/p-8/img_69427a4bbbaf62.99419493.png', '[]', 1, 1765901885, 1765964363);
INSERT INTO `project_section_items` VALUES (116, 78, 'video', '', 'proyects/p-8/img_69418709bcbd49.17974368.mov', '[]', 1, 1765902089, 1765902089);
INSERT INTO `project_section_items` VALUES (117, 78, 'text', '', '', '[]', 2, 1765902089, 1765902089);
INSERT INTO `project_section_items` VALUES (118, 79, 'video', '', 'proyects/p-8/img_6968fb578a9258.17896381.mp4', '[]', 1, 1765902095, 1768487767);
INSERT INTO `project_section_items` VALUES (119, 79, 'text', '', '', '[]', 2, 1765902095, 1768487767);
INSERT INTO `project_section_items` VALUES (120, 80, 'image', '', 'proyects/p-8/img_694187e71eead7.05442395.png', '[]', 1, 1765902311, 1765902311);
INSERT INTO `project_section_items` VALUES (121, 81, 'image', '', 'proyects/p-3/img_6979f6c0090407.69167685.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765902479, 1769600704);
INSERT INTO `project_section_items` VALUES (122, 81, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1765902479, 1769600704);
INSERT INTO `project_section_items` VALUES (123, 82, 'text', 'Cada detalle del diseño interior ha sido concebido para potenciar la regeneración celular y el equilibrio emocional. Los colores suaves, inspirados en la naturaleza, envuelven el ambiente en una atmósfera de calma y sofisticación. Pinceladas de tonos vibrantes, estratégicamente ubicadas, estimulan la vitalidad y la creatividad, recordando que el rejuvenecimiento no es solo físico, sino también un estado del alma.', '', '{\"align-self\":\"center !important;\"}', 1, 1765961916, 1767871648);
INSERT INTO `project_section_items` VALUES (124, 82, 'image', '', 'proyects/p-8/img_695f94a02f1aa8.96193509.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765961916, 1767871648);
INSERT INTO `project_section_items` VALUES (125, 83, 'image', '', 'proyects/p-8/img_695f94b5196161.08433781.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765962337, 1767871669);
INSERT INTO `project_section_items` VALUES (126, 83, 'text', 'El arte, cuidadosamente seleccionado, no solo embellece, sino que actúa como terapia visual. Obras contemporáneas, instalaciones interactivas y murales envolventes invitan a la introspección y a la inspiración, convirtiendo cada estancia en un viaje multisensorial. En la sala de espera, esculturas orgánicas evocan la fluidez del tiempo, mientras que en las salas de tratamiento, la iluminación cálida y la tecnología de cromoterapia acompañan la experiencia con un efecto sanador.', '', '{\"align-self\":\"center !important;\"}', 2, 1765962337, 1767871669);
INSERT INTO `project_section_items` VALUES (127, 84, 'text', 'Aquí, la innovación se expresa no solo en los tratamientos más avanzados, sino en un diseño que entiende que la belleza comienza desde el interior. Porque rejuvenecer no es solo desafiar el tiempo, sino redescubrir el placer de habitar un cuerpo y un espíritu en armonía.', '', '{\"align-self\":\"center !important;\"}', 1, 1765962639, 1767871691);
INSERT INTO `project_section_items` VALUES (128, 84, 'image', '', 'proyects/p-8/img_695f94cb8b8d61.71228168.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765962639, 1767871691);
INSERT INTO `project_section_items` VALUES (129, 85, 'image', '', 'proyects/p-8/img_695f94faeedb76.13988952.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765962844, 1767871738);
INSERT INTO `project_section_items` VALUES (130, 85, 'text', 'Bienvenid@s a un espacio donde la ciencia y el arte convergen para crear el futuro del bienestar.', '', '{\"align-self\":\"center !important;\"}', 2, 1765962844, 1767871738);
INSERT INTO `project_section_items` VALUES (131, 86, 'image', '', 'proyects/p-8/img_69427536f14671.61904298.png', '[]', 1, 1765963062, 1765963062);
INSERT INTO `project_section_items` VALUES (132, 87, 'image', '', 'proyects/p-8/img_69427576c3c1d7.05963250.jpg', '[]', 1, 1765963126, 1765963126);
INSERT INTO `project_section_items` VALUES (133, 87, 'text', '', '', '[]', 2, 1765963126, 1765963126);
INSERT INTO `project_section_items` VALUES (134, 88, 'text', '', '', '[]', 1, 1765963218, 1765963218);
INSERT INTO `project_section_items` VALUES (135, 88, 'image', '', 'proyects/p-8/img_694275d2ea9333.96256104.jpg', '[]', 2, 1765963218, 1765963218);
INSERT INTO `project_section_items` VALUES (136, 89, 'image', '', 'proyects/p-8/img_69427612c3dd72.42853532.jpg', '[]', 1, 1765963282, 1765963282);
INSERT INTO `project_section_items` VALUES (137, 89, 'text', '', '', '[]', 2, 1765963282, 1765963282);
INSERT INTO `project_section_items` VALUES (138, 90, 'text', '', '', '[]', 1, 1765963386, 1765963386);
INSERT INTO `project_section_items` VALUES (139, 90, 'image', '', 'proyects/p-8/img_6942767a326492.50284311.jpg', '[]', 2, 1765963386, 1765963386);
INSERT INTO `project_section_items` VALUES (140, 91, 'image', '', 'proyects/p-3/img_6979f70846cd64.23749394.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765963430, 1769600776);
INSERT INTO `project_section_items` VALUES (141, 91, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1765963430, 1769600776);
INSERT INTO `project_section_items` VALUES (142, 92, 'text', '', '', '[]', 1, 1765963477, 1765963477);
INSERT INTO `project_section_items` VALUES (143, 92, 'image', '', 'proyects/p-8/img_694276d552fb80.38510255.jpg', '[]', 2, 1765963477, 1765963477);
INSERT INTO `project_section_items` VALUES (144, 93, 'image', '', 'proyects/p-11/img_69428b2621a0d2.11264472.jpg', '[]', 1, 1765965972, 1765968678);
INSERT INTO `project_section_items` VALUES (145, 93, 'text', 'CH APARTMENT, truth through materials', '', '[]', 2, 1765965972, 1765968678);
INSERT INTO `project_section_items` VALUES (146, 94, 'image', '', 'proyects/p-11/img_694280fabfcaf6.46353964.png', '{\"width\":\"100% !important;\"}', 1, 1765966074, 1765966074);
INSERT INTO `project_section_items` VALUES (147, 95, 'image', '', 'proyects/p-11/img_694281889eeba9.67217883.png', '[]', 1, 1765966150, 1766484844);
INSERT INTO `project_section_items` VALUES (148, 96, 'image', '', 'proyects/p-8/img_6979e2135a8e43.94275498.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1765966968, 1769595411);
INSERT INTO `project_section_items` VALUES (149, 96, 'image', '', 'proyects/p-8/img_6979e2135aae70.97933449.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1765966968, 1769595411);
INSERT INTO `project_section_items` VALUES (150, 97, 'image', '', 'proyects/p-11/img_696a15d49690e4.92828264.png', '{\"width\":\"100% !important;\"}', 1, 1765967052, 1768560084);
INSERT INTO `project_section_items` VALUES (151, 98, 'image', '', 'proyects/p-11/img_69428649eab710.34757082.jpg', '{\"width\":\"100% !important;\"}', 1, 1765967433, 1765967433);
INSERT INTO `project_section_items` VALUES (152, 99, 'text', 'El interés por los materiales naturales se usa como elemento expresivo, se ensalza la belleza de la autentico, colaborando con las texturas y cromatismos de los propios elementos sin edulcorar. Cada imperfección es un regalo.', '', '{\"align-self\":\"center !important;\"}', 1, 1765967699, 1766484247);
INSERT INTO `project_section_items` VALUES (153, 99, 'image', '', 'proyects/p-11/img_694a6917213436.11543601.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765967699, 1766484247);
INSERT INTO `project_section_items` VALUES (154, 100, 'image', '', 'proyects/p-11/img_696a1603325976.00080700.png', '[]', 1, 1765967983, 1768560131);
INSERT INTO `project_section_items` VALUES (155, 101, 'image', '', 'proyects/p-11/img_694a69f4a8c6e3.88042659.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765968086, 1766484468);
INSERT INTO `project_section_items` VALUES (156, 101, 'text', 'Las paredes a la cal resaltan el sucinto interiorismo industrial manufacturado en acero natural, que nos recuerda a los cada vez menos recurrentes telúricos paisajes de la austera poesía industrial que se asentaba a orillas del rio Nervión.', '', '{\"align-self\":\"center !important;\"}', 2, 1765968086, 1766484468);
INSERT INTO `project_section_items` VALUES (157, 102, 'text', 'Como resultado se obtiene un espacio trasfronterizo que aprovecha cada oportunidad para tamizar la luz y poner en valor los materiales en su estado natural. Dibujando atmosferas discretas y diáfanas, la perfección e imperfección se contraponen como una síntesis.', '', '{\"align-self\":\"center !important;\"}', 1, 1765968214, 1766484335);
INSERT INTO `project_section_items` VALUES (158, 102, 'image', '', 'proyects/p-11/img_694289563fd018.67691793.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765968214, 1766484335);
INSERT INTO `project_section_items` VALUES (159, 103, 'image', '', 'proyects/p-11/img_69428a3c474204.75796107.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765968444, 1766484357);
INSERT INTO `project_section_items` VALUES (160, 103, 'text', 'El paisaje resultante se modifica cada día imposibilitando el dar por concluido y fijado el proyecto. Las etiquetas quedan prohibidas en favor de trabajar en la cocina, comer en el salón o descansar en el comedor. Los espacios y se abren y mezclan, integrándose unos con otros, los usos fluyen entre las habitaciones. No hay fronteras entre el salón, comedor, cocina, recibidor, habitación o espacio de trabajo, el despiste es bienvenido.', '', '{\"align-self\":\"center !important;\"}', 2, 1765968444, 1766484357);
INSERT INTO `project_section_items` VALUES (161, 104, 'text', '', '', '[]', 1, 1765968561, 1765968561);
INSERT INTO `project_section_items` VALUES (162, 104, 'image', '', 'proyects/p-11/img_69428ab125aaf1.62606170.jpg', '[]', 2, 1765968561, 1765968561);
INSERT INTO `project_section_items` VALUES (163, 105, 'image', '', 'proyects/p-11/img_69428bae64b122.36390665.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765968747, 1766484710);
INSERT INTO `project_section_items` VALUES (164, 105, 'text', 'Como resultado se obtiene un espacio trasfronterizo que aprovecha cada oportunidad para tamizar la luz y poner en valor los materiales en su estado natural. Dibujando atmosferas discretas y diáfanas, la perfección e imperfección se contraponen como una síntesis.', '', '{\"align-self\":\"center !important;\"}', 2, 1765968747, 1766484710);
INSERT INTO `project_section_items` VALUES (165, 106, 'text', '', '', '[]', 1, 1765968945, 1765968945);
INSERT INTO `project_section_items` VALUES (166, 106, 'image', '', 'proyects/p-11/img_69428c31e8dc22.72183819.jpg', '[]', 2, 1765968945, 1765968945);
INSERT INTO `project_section_items` VALUES (167, 107, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1765969161, 1769595720);
INSERT INTO `project_section_items` VALUES (168, 107, 'image', '', 'proyects/p-8/img_6979e3489bda58.97555558.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765969161, 1769595720);
INSERT INTO `project_section_items` VALUES (169, 108, 'image', '', 'proyects/p-15/img_6979eda8205a75.28079108.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765970339, 1769598376);
INSERT INTO `project_section_items` VALUES (170, 108, 'text', 'Se construye una relación pausada con su entorno, abriéndose a las vistas y protegiéndose a su vez. Se trata de habitar el límite entre la tierra y el mar, donde el espacio se convierte en una prolongación del paisaje.', '', '{\"align-self\":\"center !important;\"}', 2, 1765970339, 1769598376);
INSERT INTO `project_section_items` VALUES (171, 109, 'image', '', 'proyects/p-5/img_6942920e968013.22687929.png', '[]', 1, 1765970446, 1765970446);
INSERT INTO `project_section_items` VALUES (172, 110, 'text', 'Desde la vivienda, la mirada se extiende sin límites hacia el mar, abrazando las vistas abiertas de la playa de Zierbena, donde el horizonte se convierte en parte del espacio habitable.', '', '{\"align-self\":\"center !important;\"}', 1, 1765970528, 1768833631);
INSERT INTO `project_section_items` VALUES (173, 110, 'image', '', 'proyects/p-5/img_69429260b73351.61536670.jpeg', '{\"align-self\":\"center !important;\"}', 2, 1765970528, 1768833631);
INSERT INTO `project_section_items` VALUES (174, 111, 'image', '', 'proyects/p-5/img_694293000cad48.35895603.jpg', '[]', 1, 1765970688, 1765970688);
INSERT INTO `project_section_items` VALUES (175, 111, 'text', '', '', '[]', 2, 1765970688, 1765970688);
INSERT INTO `project_section_items` VALUES (176, 112, 'image', '', 'proyects/p-5/img_6942932fb82878.78722955.png', '{\"width\":\"100% !important;\"}', 1, 1765970735, 1765970735);
INSERT INTO `project_section_items` VALUES (177, 113, 'video', '', 'proyects/p-5/img_696e40e870fc79.10035484.mp4', '{\"align-self\":\"center !important;\"}', 1, 1765971085, 1768833256);
INSERT INTO `project_section_items` VALUES (178, 113, 'text', 'Vivienda realizada mediante técnicas industrializas de paneles de entramado ligero de madera.', '', '{\"align-self\":\"center !important;\"}', 2, 1765971085, 1768833256);
INSERT INTO `project_section_items` VALUES (179, 114, 'image', '', 'proyects/p-5/img_694295091ac426.43295384.png', '{\"width\":\"100% !important;\"}', 1, 1765971209, 1765971209);
INSERT INTO `project_section_items` VALUES (180, 115, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1765971306, 1768553912);
INSERT INTO `project_section_items` VALUES (181, 115, 'image', '', 'proyects/p-5/img_6969fdb8b4f699.75062125.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765971306, 1768553912);
INSERT INTO `project_section_items` VALUES (182, 116, 'image', '', 'proyects/p-5/img_694295c05d23e8.19552557.jpg', '[]', 1, 1765971392, 1765971392);
INSERT INTO `project_section_items` VALUES (183, 116, 'text', '', '', '[]', 2, 1765971392, 1765971392);
INSERT INTO `project_section_items` VALUES (184, 117, 'image', '', 'proyects/p-5/img_6942962f3fa709.50892688.png', '{\"width\":\"100% !important;\"}', 1, 1765971503, 1765971503);
INSERT INTO `project_section_items` VALUES (185, 118, 'text', '', '', '[]', 1, 1765971578, 1765971578);
INSERT INTO `project_section_items` VALUES (186, 118, 'image', '', 'proyects/p-5/img_6942967a4f4a61.49539693.jpg', '[]', 2, 1765971578, 1765971578);
INSERT INTO `project_section_items` VALUES (187, 119, 'image', '', 'proyects/p-5/img_6942981e985c04.17288596.jpeg', '[]', 1, 1765971998, 1765971998);
INSERT INTO `project_section_items` VALUES (188, 119, 'text', '', '', '[]', 2, 1765971998, 1765971998);
INSERT INTO `project_section_items` VALUES (189, 120, 'image', '', 'proyects/p-5/img_694298cb00bb36.10508924.png', '{\"width\":\"100% !important;\"}', 1, 1765972098, 1765972171);
INSERT INTO `project_section_items` VALUES (190, 121, 'image', '', 'proyects/p-5/img_69429971c79d40.39655479.jpg', '[]', 1, 1765972337, 1765972337);
INSERT INTO `project_section_items` VALUES (191, 121, 'text', '', '', '[]', 2, 1765972337, 1765972337);
INSERT INTO `project_section_items` VALUES (192, 122, 'text', '', '', '[]', 1, 1765972515, 1765972543);
INSERT INTO `project_section_items` VALUES (193, 122, 'image', '', 'proyects/p-5/img_69429a3f2628f4.36861102.jpg', '[]', 2, 1765972515, 1765972543);
INSERT INTO `project_section_items` VALUES (194, 123, 'text', '', '', '[]', 1, 1765972612, 1765972612);
INSERT INTO `project_section_items` VALUES (195, 123, 'image', '', 'proyects/p-5/img_69429a84ccfaf7.50298613.jpg', '[]', 2, 1765972612, 1765972612);
INSERT INTO `project_section_items` VALUES (196, 124, 'image', '', 'proyects/p-5/img_69429ca49f9971.64376261.png', '{\"width\":\"100% !important;\"}', 1, 1765973156, 1765973156);
INSERT INTO `project_section_items` VALUES (197, 125, 'video', '', 'proyects/p-5/img_69429d2dd7ae48.90297441.mp4', '[]', 1, 1765973293, 1765973293);
INSERT INTO `project_section_items` VALUES (198, 125, 'text', '', '', '[]', 2, 1765973293, 1765973293);
INSERT INTO `project_section_items` VALUES (199, 126, 'text', '', '', '[]', 1, 1765973481, 1765973481);
INSERT INTO `project_section_items` VALUES (200, 126, 'image', '', 'proyects/p-5/img_69429de957f9a1.60316268.jpg', '[]', 2, 1765973481, 1765973481);
INSERT INTO `project_section_items` VALUES (201, 127, 'image', '', 'proyects/p-7/img_6979eb7cb91356.02561553.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765982408, 1769597820);
INSERT INTO `project_section_items` VALUES (202, 127, 'text', 'Redefinir el espacio de trabajo. Una revolución en la forma de habitar y percibir el espacio de trabajo. Los muros no encierran, sino que inspiran. La oficina se transforma en un ecosistema dinámico donde la luz, la textura y la materia dialogan para dar vida a un entorno fluido y estimulante.', '', '{\"align-self\":\"center !important;\"}', 2, 1765982408, 1769597820);
INSERT INTO `project_section_items` VALUES (203, 128, 'image', '', 'proyects/p-3/img_6942c1a62a34c0.29462870.png', '{\"width\":\"100% !important;\"}', 1, 1765982630, 1765982630);
INSERT INTO `project_section_items` VALUES (204, 129, 'text', 'El ladrillo, material atemporal, se reinventa en un sistema de aparejos que rompen la rigidez de la arquitectura convencional. Paredes que no solo delimitan, sino que sugieren. Tramas de ladrillo calado que dejan filtrar la luz y generan transparencias cambiantes a medida que se recorre el espacio. Superficies que juegan con el vacío y la densidad, creando patrones que transforman cada perspectiva en una experiencia única. Aquí, los límites se diluyen y la oficina se convierte en un organismo vivo. Espacios abiertos conviven con áreas de introspección, zonas colaborativas emergen entre muros que, más que dividir, conectan. Cada textura y cada sombra cuentan una historia de creatividad, innovación y movimiento. Este proyecto es más que una reforma: es una nueva forma de entender el trabajo, donde la arquitectura no solo responde a la función, sino que la inspira. Un lugar donde los materiales cobran voz, y donde cada pared, cada filtro de luz y cada transición espacial invitan a descubrir, pensar y crear.', '', '{\"align-self\":\"center !important;\"}', 1, 1765982728, 1767869568);
INSERT INTO `project_section_items` VALUES (205, 129, 'image', '', 'proyects/p-3/img_695f8c80f02a37.18765545.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765982728, 1767869568);
INSERT INTO `project_section_items` VALUES (206, 130, 'image', '', 'proyects/p-3/img_6942c2de2fd392.34827864.gif', '[]', 1, 1765982839, 1765982942);
INSERT INTO `project_section_items` VALUES (207, 131, 'image', '', 'proyects/p-3/img_6967a89561ce52.46251796.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765983064, 1768824061);
INSERT INTO `project_section_items` VALUES (208, 131, 'text', 'El diseño del proyecto situado en Bilbao refleja los valores fundamentales de la empresa, especializada en el sector de la construcción y la innovación. Estos principios se ven plasmados en la solución constructiva adoptada. El uso de ladrillo cerámico hueco dispuesto en diferentes patrones y texturas permite regular la entrada de luz según las necesidades de privacidad de cada espacio creando interesantes juegos de luz y sombra en las superficies. Esta técnica no solo responde a las necesidades funcionales del espacio, sino que también añade un valor estético al proyecto.La organización espacial se diseñó en torno al aprovechamiento máximo de la luz natural, un recurso esencial para crear un entorno de trabajo eficiente y saludable.', '', '{\"align-self\":\"center !important;\"}', 2, 1765983064, 1768824061);
INSERT INTO `project_section_items` VALUES (209, 132, 'image', '', 'proyects/p-3/img_6942c3ab5af899.26891965.png', '{\"width\":\"100% !important;\"}', 1, 1765983147, 1765983147);
INSERT INTO `project_section_items` VALUES (210, 133, 'text', 'La distribución del programa funcional coloca los espacios de mayor privacidad en el núcleo central de la planta, mientras que las áreas comunes y los espacios de trabajo abiertos se orientan hacia las fuentes de luz natural, resolviendo la particular geometría alargada del espacio. Además, grandes superficies acristaladas en puntos estratégicos permiten que la luz fluya desde las fachadas hasta el interior, mejorando la luminosidad y la calidad ambiental de todos los espacios. Aunque “Oficinas Enbi” es un proyecto reciente, su diseño, que integra innovación y sostenibilidad, está alineado con los valores de la empresa, augurando un impacto positivo en la experiencia laboral y en la percepción del espacio por parte de sus usuarios.', '', '{\"align-self\":\"center !important;\"}', 1, 1765983239, 1767868508);
INSERT INTO `project_section_items` VALUES (211, 133, 'image', '', 'proyects/p-3/img_695f885c7d3a25.17867169.jpg', '{\"align-self\":\"center !important;\"}', 2, 1765983239, 1767868508);
INSERT INTO `project_section_items` VALUES (212, 134, 'image', '', 'proyects/p-3/img_695f8bc9ed67b9.47063034.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765983326, 1767869385);
INSERT INTO `project_section_items` VALUES (213, 134, 'text', 'El ladrillo cerámico hueco se reinventa mediante aparejos permeables y patrones que rompen la rigidez de la arquitectura convencional. Muros que no solo delimitan, sino que regulan la entrada de luz y crean transparencias cambiantes, generando atmósferas que invitan a descubrir. Las tramas caladas actúan como filtros que equilibran privacidad y apertura, añadiendo textura y sombra a cada perspectiva.', '', '{\"align-self\":\"center !important;\"}', 2, 1765983326, 1767869385);
INSERT INTO `project_section_items` VALUES (214, 135, 'image', '', 'proyects/p-3/img_6942c5091459b7.52171853.png', '{\"width\":\"100% !important;\"}', 1, 1765983497, 1765983497);
INSERT INTO `project_section_items` VALUES (215, 136, 'text', '', '', '[]', 1, 1765983573, 1765983573);
INSERT INTO `project_section_items` VALUES (216, 136, 'image', '', 'proyects/p-3/img_6942c55520ee53.07199376.jpg', '[]', 2, 1765983573, 1765983573);
INSERT INTO `project_section_items` VALUES (217, 137, 'image', '', 'proyects/p-3/img_695f8f86a8b427.94740719.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765983639, 1767870342);
INSERT INTO `project_section_items` VALUES (218, 137, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1765983639, 1767870342);
INSERT INTO `project_section_items` VALUES (219, 138, 'text', '', '', '[]', 1, 1765983680, 1765983680);
INSERT INTO `project_section_items` VALUES (220, 138, 'image', '', 'proyects/p-3/img_6942c5c03294b3.62530326.jpg', '[]', 2, 1765983680, 1765983680);
INSERT INTO `project_section_items` VALUES (221, 139, 'image', '', 'proyects/p-3/img_695f8c44a61842.38240617.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765983750, 1767869508);
INSERT INTO `project_section_items` VALUES (222, 139, 'text', 'La elección del ladrillo responde a criterios de sostenibilidad material, durabilidad y baja huella: un material local, modular y de bajo mantenimiento, que aporta inercia térmica y contribuye a un ambiente de trabajo saludable. Cada muro es un filtro activo que respira y conecta, potenciando la interacción y el bienestar de quienes habitan el espacio.', '', '{\"align-self\":\"center !important;\"}', 2, 1765983750, 1767869508);
INSERT INTO `project_section_items` VALUES (223, 140, 'image', '', 'proyects/p-3/img_6942c6a9cceb56.54581814.jpg', '{\"width\":\"100% !important;\"}', 1, 1765983844, 1765983913);
INSERT INTO `project_section_items` VALUES (224, 141, 'image', '', 'proyects/p-2/img_69441d42e47a05.19014113.jpg', '{\"width\":\"100% !important;\"}', 1, 1765984117, 1766071618);
INSERT INTO `project_section_items` VALUES (225, 142, 'image', '', 'proyects/p-2/img_6942c96203be29.38020633.png', '[]', 1, 1765984610, 1765984610);
INSERT INTO `project_section_items` VALUES (226, 143, 'video', '', 'proyects/p-2/img_6942cb9f3a9ce5.78267244.mp4', '[]', 1, 1765985183, 1765985183);
INSERT INTO `project_section_items` VALUES (227, 143, 'text', '', '', '[]', 2, 1765985183, 1765985183);
INSERT INTO `project_section_items` VALUES (228, 144, 'image', '', 'proyects/p-2/img_6942cc37dc6036.88788339.gif', '{\"width\":\"100% !important;\"}', 1, 1765985335, 1765985335);
INSERT INTO `project_section_items` VALUES (229, 145, 'text', '', '', '[]', 1, 1765985929, 1766069327);
INSERT INTO `project_section_items` VALUES (230, 145, 'image', '', 'proyects/p-2/img_6944144fd55228.95860453.jpg', '[]', 2, 1765985929, 1766069327);
INSERT INTO `project_section_items` VALUES (231, 146, 'image', '', 'proyects/p-2/img_69490a7ba6f898.09082381.jpg', '{\"align-self\":\"center !important;\"}', 1, 1765986056, 1766394491);
INSERT INTO `project_section_items` VALUES (232, 146, 'text', 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.', '', '{\"align-self\":\"center !important;\"}', 2, 1765986056, 1766394491);
INSERT INTO `project_section_items` VALUES (233, 147, 'image', '', 'proyects/p-2/img_6942cfca868f42.49730589.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1765986250, 1765986250);
INSERT INTO `project_section_items` VALUES (234, 147, 'image', '', 'proyects/p-2/img_6942cfca86cb60.27169846.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1765986250, 1765986250);
INSERT INTO `project_section_items` VALUES (235, 148, 'image', '', 'proyects/p-2/img_6942d0b5b39e85.72357580.png', '{\"width\":\"100% !important;\"}', 1, 1765986485, 1765986485);
INSERT INTO `project_section_items` VALUES (236, 149, 'image', '', 'proyects/p-2/img_6944187a7ae3f8.89650064.jpg', '{\"width\":\"100% !important;\"}', 1, 1765988578, 1766070394);
INSERT INTO `project_section_items` VALUES (237, 150, 'image', '', 'proyects/p-9/img_6979f2993379c9.99057300.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766048946, 1769599641);
INSERT INTO `project_section_items` VALUES (238, 150, 'text', 'Encuentro entre pasado y presente, una arquitectura que cuida, transforma y permanece.', '', '{\"align-self\":\"center !important;\"}', 2, 1766048946, 1769599641);
INSERT INTO `project_section_items` VALUES (239, 151, 'image', '', 'proyects/p-12/img_6943c8ebbbcbb8.43572915.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1766049066, 1766050027);
INSERT INTO `project_section_items` VALUES (240, 152, 'image', '', 'proyects/p-12/img_6943c5ef732156.82228433.png', '{\"width\":\"100% !important;\"}', 1, 1766049183, 1766049263);
INSERT INTO `project_section_items` VALUES (241, 153, 'video', '', 'proyects/p-12/img_6943c6629b2da3.77704301.mp4', '[]', 1, 1766049378, 1766049378);
INSERT INTO `project_section_items` VALUES (242, 153, 'text', '', '', '[]', 2, 1766049378, 1766049378);
INSERT INTO `project_section_items` VALUES (243, 154, 'video', '', 'proyects/p-12/img_6943c6bf7fdc29.98412528.mp4', '[]', 1, 1766049471, 1766049471);
INSERT INTO `project_section_items` VALUES (244, 154, 'text', '', '', '[]', 2, 1766049471, 1766049471);
INSERT INTO `project_section_items` VALUES (245, 155, 'video', '', 'proyects/p-12/img_6943c71dbe2911.03698308.mp4', '[]', 1, 1766049565, 1766049565);
INSERT INTO `project_section_items` VALUES (246, 155, 'text', '', '', '[]', 2, 1766049565, 1766049565);
INSERT INTO `project_section_items` VALUES (247, 156, 'text', '', '', '[]', 1, 1766049613, 1766050342);
INSERT INTO `project_section_items` VALUES (248, 156, 'video', '', 'proyects/p-12/img_6943ca264083c9.56229619.mp4', '[]', 2, 1766049613, 1766050342);
INSERT INTO `project_section_items` VALUES (249, 157, 'image', '', 'proyects/p-12/img_6943c7c6f27526.43727603.jpg', '[]', 1, 1766049734, 1766049734);
INSERT INTO `project_section_items` VALUES (250, 157, 'text', '', '', '[]', 2, 1766049734, 1766049734);
INSERT INTO `project_section_items` VALUES (251, 158, 'text', 'En el corazón de Arrazua-Ubarrundia, Araba,  Artzainenea renace sin perder la memoria. Este caserío vasco, de sólida fachada de piedra, se mantiene fiel a su origen, conservando la huella del tiempo como parte esencial de su identidad.', '', '{\"align-self\":\"center !important;\"}', 1, 1766049784, 1768824521);
INSERT INTO `project_section_items` VALUES (252, 158, 'image', '', 'proyects/p-12/img_696df7d7bb8919.31070960.jpeg', '{\"align-self\":\"center !important;\"}', 2, 1766049784, 1768824521);
INSERT INTO `project_section_items` VALUES (253, 159, 'image', '', 'proyects/p-12/img_6943c834df2246.13006135.png', '{\"width\":\"100% !important;\"}', 1, 1766049844, 1766049844);
INSERT INTO `project_section_items` VALUES (254, 160, 'image', '', 'proyects/p-12/img_6943cb64ca6b98.75022560.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1766050073, 1766050660);
INSERT INTO `project_section_items` VALUES (255, 160, 'image', '', 'proyects/p-12/img_6943cb64ca8f22.28999435.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1766050073, 1766050660);
INSERT INTO `project_section_items` VALUES (256, 161, 'video', '', 'proyects/p-12/img_6943ca44e236a0.37564355.mp4', '[]', 1, 1766050372, 1766050372);
INSERT INTO `project_section_items` VALUES (257, 161, 'text', '', '', '[]', 2, 1766050372, 1766050372);
INSERT INTO `project_section_items` VALUES (258, 162, 'text', '', '', '[]', 1, 1766051278, 1766051278);
INSERT INTO `project_section_items` VALUES (259, 162, 'image', '', 'proyects/p-12/img_6943cdce81c4b9.46699485.jpg', '[]', 2, 1766051278, 1766051278);
INSERT INTO `project_section_items` VALUES (260, 163, 'image', '', 'proyects/p-9/img_697b36568e8373.28701135.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1766051318, 1769682518);
INSERT INTO `project_section_items` VALUES (261, 163, 'text', 'Se busca respetar lo existente y acompañarlo con una nueva vida. La piedra continúa contando su historia, ahora en equilibrio con espacios pensados para el habitar contemporáneo.', '', '{\"align-self\":\"center !important;\"}', 2, 1766051318, 1769682518);
INSERT INTO `project_section_items` VALUES (262, 164, 'image', '', 'proyects/p-13/img_695f9c776e6cf4.91587753.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766051936, 1767873655);
INSERT INTO `project_section_items` VALUES (263, 164, 'text', 'SHELTER es un espacio de 15m2 realizado en madera contra laminada en su interior y exterior a excepción de una apertura triangular de vidrio laminado a modo de ventana. Este minúsculo espacio se ha concebido para responder a la necesidad de un habitar no estático, con la única premisa de ser realizado íntegramente en madera.', '', '{\"align-self\":\"center !important;\"}', 2, 1766051936, 1767873655);
INSERT INTO `project_section_items` VALUES (264, 165, 'image', '', 'proyects/p-13/img_6943d0d0734223.38588655.png', '{\"width\":\"100% !important;\"}', 1, 1766052048, 1766052048);
INSERT INTO `project_section_items` VALUES (265, 166, 'text', 'SHELTER es un espacio realizado en madera contra laminada en su interior y exterior. Este minúsculo espacio se ha concebido para responder a la necesidad de un habitar no estático, con la única premisa de ser realizado íntegramente en madera. ', '', '{\"align-self\":\"center !important;\"}', 1, 1766052192, 1768834744);
INSERT INTO `project_section_items` VALUES (266, 166, 'video', '', 'proyects/p-13/img_69651b5c19e5b6.64765615.mp4', '{\"align-self\":\"center !important;\"}', 2, 1766052192, 1768834744);
INSERT INTO `project_section_items` VALUES (267, 167, 'image', '', 'proyects/p-13/img_6943d1c59e5168.97152370.jpg', '[]', 1, 1766052293, 1766052293);
INSERT INTO `project_section_items` VALUES (268, 167, 'text', '', '', '[]', 2, 1766052293, 1766052293);
INSERT INTO `project_section_items` VALUES (269, 168, 'text', 'Este sistema posee un tratamiento exterior preparado para resistir la intemperie, lo que le confiere la capacidad de resolver la fachada y cubierta de forma continua, respondiendo en su interior con una atmosfera cálida.', '', '{\"align-self\":\"center !important;\"}', 1, 1766052396, 1768834783);
INSERT INTO `project_section_items` VALUES (270, 168, 'image', '', 'proyects/p-13/img_696e46df039685.44177765.jpg', '{\"align-self\":\"center !important;\"}', 2, 1766052396, 1768834783);
INSERT INTO `project_section_items` VALUES (271, 169, 'image', '', 'proyects/p-13/img_6943d2f354c104.68425488.png', '{\"width\":\"100% !important;\"}', 1, 1766052595, 1766052595);
INSERT INTO `project_section_items` VALUES (272, 170, 'image', '', 'proyects/p-13/img_696e4673f11fe0.23834064.png', '{\"align-self\":\"center !important;\"}', 1, 1766052651, 1768834675);
INSERT INTO `project_section_items` VALUES (273, 170, 'text', 'Su fabricación y montaje completo, ha sido realizado en taller y posteriormente transportado por carretera al lugar de destino, permitiendo su instalación en cuestión de minutos.', '', '{\"align-self\":\"center !important;\"}', 2, 1766052651, 1768834675);
INSERT INTO `project_section_items` VALUES (274, 171, 'text', '', '', '[]', 1, 1766052849, 1766052849);
INSERT INTO `project_section_items` VALUES (275, 171, 'image', '', 'proyects/p-13/img_6943d3f1371358.88786014.png', '[]', 2, 1766052849, 1766052849);
INSERT INTO `project_section_items` VALUES (276, 172, 'image', '', 'proyects/p-13/img_6943d41d703cc4.75580694.png', '{\"width\":\"100% !important;\"}', 1, 1766052893, 1766052893);
INSERT INTO `project_section_items` VALUES (277, 173, 'image', '', 'proyects/p-13/img_6943d4a9942b79.87619099.jpg', '[]', 1, 1766053033, 1766053033);
INSERT INTO `project_section_items` VALUES (278, 173, 'text', '', '', '[]', 2, 1766053033, 1766053033);
INSERT INTO `project_section_items` VALUES (279, 174, 'image', '', 'proyects/p-13/img_6943d5295cf962.66748975.png', '{\"width\":\"100% !important;\"}', 1, 1766053161, 1766053161);
INSERT INTO `project_section_items` VALUES (280, 175, 'text', '', '', '[]', 1, 1766053383, 1766053558);
INSERT INTO `project_section_items` VALUES (281, 175, 'video', '', 'proyects/p-13/img_6943d6b6acb5a1.62773672.mp4', '[]', 2, 1766053383, 1766053558);
INSERT INTO `project_section_items` VALUES (282, 176, 'image', '', 'proyects/p-9/img_695f9b451d7d92.59044984.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766058187, 1768835475);
INSERT INTO `project_section_items` VALUES (283, 176, 'text', 'TOPAGUNE, un espacio pensado para el encuentro cotidiano, donde las trayectorias se cruzan y el tiempo se detiene. ', '', '{\"align-self\":\"center !important;\"}', 2, 1766058187, 1768835475);
INSERT INTO `project_section_items` VALUES (284, 177, 'image', '', 'proyects/p-9/img_6943e94d4176f8.74365963.png', '{\"width\":\"100% !important;\"}', 1, 1766058317, 1766058317);
INSERT INTO `project_section_items` VALUES (285, 178, 'text', '', '', '[]', 1, 1766058429, 1766058429);
INSERT INTO `project_section_items` VALUES (286, 178, 'image', '', 'proyects/p-9/img_6943e9bda0a068.44103618.jpg', '[]', 2, 1766058429, 1766058429);
INSERT INTO `project_section_items` VALUES (287, 179, 'image', '', 'proyects/p-9/img_6943ea018e5905.46760135.gif', '{\"width\":\"100% !important;\"}', 1, 1766058497, 1766058497);
INSERT INTO `project_section_items` VALUES (288, 180, 'image', '', 'proyects/p-9/img_696e49f01ce4b4.74093153.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766058569, 1768836684);
INSERT INTO `project_section_items` VALUES (289, 180, 'text', 'En el tejido urbano de Trapagaran (Bizkaia), la plaza se abre como un claro donde la ciudad respira.', '', '{\"align-self\":\"center !important;\"}', 2, 1766058569, 1768836684);
INSERT INTO `project_section_items` VALUES (290, 181, 'image', '', 'proyects/p-9/img_6943ead2044044.91109612.png', '{\"width\":\"100% !important;\"}', 1, 1766058706, 1766058706);
INSERT INTO `project_section_items` VALUES (291, 182, 'image', '', 'proyects/p-9/img_6943ebbcdb1288.76692686.jpg', '[]', 1, 1766058940, 1766058940);
INSERT INTO `project_section_items` VALUES (292, 182, 'text', '', '', '[]', 2, 1766058940, 1766058940);
INSERT INTO `project_section_items` VALUES (293, 183, 'image', '', 'proyects/p-9/img_6943ec29796822.39062980.png', '{\"width\":\"100% !important;\"}', 1, 1766059049, 1766059049);
INSERT INTO `project_section_items` VALUES (294, 184, 'text', '', '', '[]', 1, 1766059079, 1766059079);
INSERT INTO `project_section_items` VALUES (295, 184, 'image', '', 'proyects/p-9/img_6943ec47ed2a10.15116369.jpg', '[]', 2, 1766059079, 1766059079);
INSERT INTO `project_section_items` VALUES (296, 185, 'image', '', 'proyects/p-9/img_6943ed1e212c80.34373765.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1766059266, 1766059294);
INSERT INTO `project_section_items` VALUES (297, 185, 'image', '', 'proyects/p-9/img_6943ed1e214ed1.51920649.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1766059266, 1766059294);
INSERT INTO `project_section_items` VALUES (298, 186, 'image', '', 'proyects/p-9/img_6943ed3bec2859.61628596.jpg', '[]', 1, 1766059323, 1766059323);
INSERT INTO `project_section_items` VALUES (299, 186, 'text', '', '', '[]', 2, 1766059323, 1766059323);
INSERT INTO `project_section_items` VALUES (300, 187, 'text', 'La intervención acompaña su presencia con un paisaje cuidadosamente construido: vegetación diversa, flores y texturas que dibujan recorridos suaves y estancias informales. La plaza se convierte en un pequeño ecosistema urbano donde naturaleza y vida vecinal conviven, transformando lo cotidiano en un espacio compartido y vivo.', '', '{\"align-self\":\"center !important;\"}', 1, 1766059414, 1768835667);
INSERT INTO `project_section_items` VALUES (301, 187, 'image', '', 'proyects/p-9/img_6943ed967311d7.87556947.jpg', '{\"align-self\":\"center !important;\"}', 2, 1766059414, 1768835667);
INSERT INTO `project_section_items` VALUES (302, 188, 'image', '', 'proyects/p-9/img_6943edf55472f9.72546247.png', '{\"width\":\"100% !important;\"}', 1, 1766059509, 1766059509);
INSERT INTO `project_section_items` VALUES (303, 189, 'image', '', 'proyects/p-9/img_6943ee7e467ca5.77787215.jpg', '[]', 1, 1766059646, 1766059646);
INSERT INTO `project_section_items` VALUES (304, 189, 'text', '', '', '[]', 2, 1766059646, 1766059646);
INSERT INTO `project_section_items` VALUES (305, 190, 'text', '', '', '[]', 1, 1766059703, 1766059703);
INSERT INTO `project_section_items` VALUES (306, 190, 'image', '', 'proyects/p-9/img_6943eeb7c5e071.79640113.jpg', '[]', 2, 1766059703, 1766059703);
INSERT INTO `project_section_items` VALUES (307, 191, 'image', '', 'proyects/p-9/img_6943eefa0df4e8.61627512.png', '{\"width\":\"100% !important;\"}', 1, 1766059770, 1766059770);
INSERT INTO `project_section_items` VALUES (308, 192, 'image', '', 'proyects/p-9/img_6943ef36588e23.74791141.jpg', '[]', 1, 1766059830, 1766059830);
INSERT INTO `project_section_items` VALUES (309, 192, 'text', '', '', '[]', 2, 1766059830, 1766059830);
INSERT INTO `project_section_items` VALUES (310, 193, 'text', '', '', '[]', 1, 1766060172, 1766060172);
INSERT INTO `project_section_items` VALUES (311, 193, 'image', '', 'proyects/p-9/img_6943f08c2ef1f8.33638051.jpg', '[]', 2, 1766060172, 1766060172);
INSERT INTO `project_section_items` VALUES (312, 194, 'image', '', 'proyects/p-9/img_6943f0f2c1a195.82405322.png', '{\"width\":\"100% !important;\"}', 1, 1766060274, 1766060274);
INSERT INTO `project_section_items` VALUES (313, 195, 'image', '', 'proyects/p-2/img_6944152e477003.23247030.png', '{\"width\":\"100% !important;\"}', 1, 1766069550, 1766069550);
INSERT INTO `project_section_items` VALUES (314, 196, 'video', '', 'proyects/p-2/img_69490ac7a72ed0.85684650.mp4', '{\"margin-left\":\"auto !important;\",\"margin-right\":\"auto !important;\"}', 1, 1766070137, 1766394567);
INSERT INTO `project_section_items` VALUES (315, 196, 'text', '', '', '[]', 2, 1766070137, 1766070137);
INSERT INTO `project_section_items` VALUES (316, 197, 'image', '', 'proyects/p-2/img_69441a76f10328.69173612.jpg', '{\"width\":\"100% !important;\"}', 1, 1766070902, 1766070902);
INSERT INTO `project_section_items` VALUES (317, 198, 'image', '', 'proyects/p-2/img_69441c5f3c8a71.86412925.jpg', '[]', 1, 1766071391, 1766071391);
INSERT INTO `project_section_items` VALUES (318, 198, 'text', '', '', '[]', 2, 1766071391, 1766071391);
INSERT INTO `project_section_items` VALUES (319, 199, 'image', '', 'proyects/p-2/img_69441e322910b4.54337311.jpg', '{\"width\":\"100% !important;\"}', 1, 1766071680, 1766071858);
INSERT INTO `project_section_items` VALUES (320, 199, 'image', '', 'proyects/p-2/img_69441e322944b3.31123113.png', '{\"width\":\"100% !important;\"}', 2, 1766071680, 1766071858);
INSERT INTO `project_section_items` VALUES (321, 200, 'image', '', 'proyects/p-2/img_69441e54035c09.13529707.png', '[]', 1, 1766071892, 1766071892);
INSERT INTO `project_section_items` VALUES (322, 201, 'image', '', 'proyects/p-2/img_69441eee5d0706.06873371.jpg', '{\"width\":\"100% !important;\"}', 1, 1766072046, 1766072046);
INSERT INTO `project_section_items` VALUES (323, 201, 'image', '', 'proyects/p-2/img_69441eee5d5088.36719269.png', '{\"width\":\"100% !important;\"}', 2, 1766072046, 1766072046);
INSERT INTO `project_section_items` VALUES (324, 202, 'image', '', 'proyects/p-1/img_694519b291d2e9.30833868.png', '{\"width\":\"100% !important;\"}', 1, 1766136242, 1766136242);
INSERT INTO `project_section_items` VALUES (325, 203, 'image', '', 'proyects/p-1/img_69451a00607f86.96029977.png', '{\"width\":\"100% !important;\"}', 1, 1766136320, 1766136320);
INSERT INTO `project_section_items` VALUES (326, 204, 'text', '', '', '[]', 1, 1766136400, 1766136400);
INSERT INTO `project_section_items` VALUES (327, 204, 'video', '', 'proyects/p-1/img_69451a50e09a15.34824004.mp4', '[]', 2, 1766136400, 1766136400);
INSERT INTO `project_section_items` VALUES (328, 205, 'image', '', 'proyects/p-1/img_69451adb5a3070.94498742.png', '{\"width\":\"100% !important;\"}', 1, 1766136539, 1766136539);
INSERT INTO `project_section_items` VALUES (329, 206, 'image', '', 'proyects/p-1/img_694520f39e45f9.55147660.png', '{\"width\":\"100% !important;\"}', 1, 1766138099, 1766138099);
INSERT INTO `project_section_items` VALUES (330, 207, 'image', '', 'proyects/p-1/img_694a654bb52e69.99708454.png', '[]', 1, 1766138165, 1766483275);
INSERT INTO `project_section_items` VALUES (331, 208, 'image', '', 'proyects/p-4/img_6945257696d321.91652435.png', '[]', 1, 1766139035, 1766139254);
INSERT INTO `project_section_items` VALUES (332, 209, 'video', '', 'proyects/p-1/img_69452e160c70c4.68962067.mp4', '[]', 1, 1766141462, 1766141462);
INSERT INTO `project_section_items` VALUES (333, 209, 'text', '', '', '[]', 2, 1766141462, 1766141462);
INSERT INTO `project_section_items` VALUES (334, 210, 'video', '', 'proyects/p-5/img_694533bc9fdfa4.34764329.mp4', '[]', 1, 1766142908, 1766142908);
INSERT INTO `project_section_items` VALUES (335, 210, 'text', '', '', '[]', 2, 1766142908, 1766142908);
INSERT INTO `project_section_items` VALUES (336, 211, 'video', '', 'proyects/p-5/img_69453423a0ea59.41835923.mp4', '[]', 1, 1766143011, 1766143011);
INSERT INTO `project_section_items` VALUES (337, 211, 'text', '', '', '[]', 2, 1766143011, 1766143011);
INSERT INTO `project_section_items` VALUES (338, 212, 'video', '', 'proyects/p-8/img_694909808b70a1.61659924.mp4', '{\"width\":\"100% !important;\"}', 1, 1766394240, 1766394240);
INSERT INTO `project_section_items` VALUES (339, 213, 'video', '', 'proyects/p-2/img_69490d6d7d64f1.19704108.mp4', '{\"margin-left\":\"auto !important;\",\"margin-right\":\"auto !important;\"}', 1, 1766395245, 1766395245);
INSERT INTO `project_section_items` VALUES (340, 214, 'video', '', 'proyects/p-5/img_696e1217858737.40706453.mp4', '[]', 1, 1766396888, 1768821300);
INSERT INTO `project_section_items` VALUES (341, 215, 'image', '', 'proyects/p-5/img_694914138a29f9.73555085.jpg', '{\"display\":\"block\",\"margin-left\":\"auto !important;\"}', 1, 1766396947, 1766396996);
INSERT INTO `project_section_items` VALUES (342, 216, 'text', 'El espíritu de la región también se deja ver en las rocas y guijarros de diferentes texturas que interrumpen la continuidad del suelo para dar la sensación de estar al aire libre. Se diseñaron los maceteros y las huellas de mortero del jardín de grava intentando reproducir un edén en el interior, desdibujando las fronteras con lo que hay fuera.  Las piezas blancas de cerámica evocan una naturaleza que emerge desde el manto de grava conectado a la calle. Junto con el abandono de las viviendas y de las actividades agrícolas, una generación y un modo de vida quedó en el olvido. Dar una segunda oportunidad al campo es fundamental, no solo para no perder las tradiciones locales vivas desde hace siglos, sino para sostener en el tiempo una relación equilibrada con el territorio. Entre las llanuras del terreno emerge una de esas cercas propias del paisaje mallorquín, de 200 metros de largo, que envuelve la construcción de manera casi utópica, colándose hasta su interior.', '', '{\"align-self\":\"center !important;\"}', 1, 1766406229, 1768471121);
INSERT INTO `project_section_items` VALUES (343, 216, 'image', '', 'proyects/p-1/img_694a62a4559707.42228370.jpeg', '{\"align-self\":\"center !important;\"}', 2, 1766406229, 1768471121);
INSERT INTO `project_section_items` VALUES (344, 217, 'image', '', 'proyects/p-1/img_6949392d2645b9.00485577.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1766406445, 1768823069);
INSERT INTO `project_section_items` VALUES (345, 217, 'text', 'ENTRE MUROS trata de evocar la poesía del paisaje a través de una típica casa de labranza en el pueblo de Santa Margalida (Mallorca). La idea del proyecto original era hacer desaparecer la vivienda entre los tradicionales muros de piedra seca que pautan la isla desde  el mar a la montaña. De ahí su nombre, Entre Muros, un término que encapsula la esencia del hogar soñado y que ejemplifica, además, la conciliación en todas sus formas. ', '', '{\"align-self\":\"center !important;\"}', 2, 1766406445, 1768823069);
INSERT INTO `project_section_items` VALUES (346, 218, 'text', 'En el baño, la ducha se convierte en una cascada bajo un cielo protegido por vidrio y paredes de hormigón.', '', '{\"align-self\":\"center !important;\"}', 1, 1766406544, 1766406544);
INSERT INTO `project_section_items` VALUES (347, 218, 'image', '', 'proyects/p-1/img_694939905bf760.13667966.jpeg', '{\"align-self\":\"center !important;\"}', 2, 1766406544, 1766406544);
INSERT INTO `project_section_items` VALUES (348, 219, 'text', 'De la misma forma que la zona de estar se vuelca en el jardín, todo el diseño de la casa está pensado para mirar hacia fuera. Esta casa está fuera del circuito más turístico de Mallorca, es una vivienda rural y está vinculada a la naturaleza. En este oasis privadísimo, el hilo conductor no es otro que su entorno, desde el momento en que el visitante pone un pie en la finca, le inunda el olor a lavanda y el romero y le acompaña hasta la puerta. En el diseño de interior, se ha apostado por tonos neutros para poner en valor lo que se ve por la ventana, que es completamente verde. La vivienda se ha salpicado de arte contemporáneo pero el paisaje es el mejor de los cuadros.', '', '{\"align-self\":\"center !important;\"}', 1, 1766480510, 1766480510);
INSERT INTO `project_section_items` VALUES (349, 219, 'image', '', 'proyects/p-2/img_694a5a7e6ddc56.84771092.jpg', '{\"align-self\":\"center !important;\"}', 2, 1766480510, 1766480510);
INSERT INTO `project_section_items` VALUES (350, 220, 'image', '', 'proyects/p-2/img_694a5b526ac410.41896981.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766480722, 1766480722);
INSERT INTO `project_section_items` VALUES (351, 220, 'text', 'Se vuelve a las raíces, intentado borrar esa etapa que se ha venido dando desde los años 70 hasta ahora y regresando a la casa rural que se creaba cuando el mallorquín vivía y trabajaba en el campo. Ese estilo tradicional en que cada familia poseía una finca y subsistía con lo que salía de ella, vinculado a artistas y artesanos locales, que pone de manifiesto lo que tendría que ser no solo la arquitectura, sino la forma de vivir la isla de Mallorca.', '', '{\"align-self\":\"center !important;\"}', 2, 1766480722, 1766480722);
INSERT INTO `project_section_items` VALUES (352, 221, 'video', '', 'proyects/p-1/img_6968b6c790d3d2.31404385.mp4', '{\"align-self\":\"center !important;\"}', 1, 1766481696, 1768470215);
INSERT INTO `project_section_items` VALUES (353, 221, 'text', 'Junto con el abandono de las viviendas y de las actividades agrícolas, una generación y un modo de vida quedó en el olvido. Dar una segunda oportunidad al campo es fundamental, no solo para no perder las tradiciones locales vivas desde hace siglos, sino para sostener en el tiempo una relación equilibrada con el territorio. Entre las llanuras del terreno emerge una de esas cercas propias del paisaje mallorquín, de 200 metros de largo, que envuelve la construcción de manera casi utópica, colándose hasta su interior.', '', '{\"align-self\":\"center !important;\"}', 2, 1766481696, 1768470215);
INSERT INTO `project_section_items` VALUES (354, 222, 'image', '', 'proyects/p-1/img_694a62d8bdf284.81741972.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1766481916, 1768823361);
INSERT INTO `project_section_items` VALUES (355, 222, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1766481916, 1768823361);
INSERT INTO `project_section_items` VALUES (356, 223, 'image', '', 'proyects/p-1/img_694a63c37c3b26.12473360.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1766482068, 1766482883);
INSERT INTO `project_section_items` VALUES (357, 223, 'text', 'La piedra de marés es una extensión de la propia casa, conectando el interior con el paisaje mallorquín. El interior recoge la calidez de los morteros con base de cal, los linos naturales, el marés y las maderas, generando una atmósfera acogedora que resalta entre el verde, el rojo, el amarillo y el azul del horizonte, como lienzo que cambia con cada estación.', '', '{\"align-self\":\"center !important;\"}', 2, 1766482068, 1766482883);
INSERT INTO `project_section_items` VALUES (358, 224, 'text', ' En la piscina se aprovechan las horadaciones del terreno para transformar una antigua cantera de marés en un remanso de paz protegido por masivos de piedra y vegetación. ', '', '{\"align-self\":\"center !important;\"}', 1, 1766482297, 1768815807);
INSERT INTO `project_section_items` VALUES (359, 224, 'video', '', 'proyects/p-1/img_696dfcbfd85294.37342948.mp4', '{\"align-self\":\"center !important;\"}', 2, 1766482297, 1768815807);
INSERT INTO `project_section_items` VALUES (360, 225, 'image', '', 'proyects/p-2/img_694a6585392834.27869139.png', '[]', 1, 1766483333, 1766483333);
INSERT INTO `project_section_items` VALUES (361, 226, 'image', '', 'proyects/p-2/img_6979f7e7e5fe39.07256828.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766483620, 1769600999);
INSERT INTO `project_section_items` VALUES (362, 226, 'text', 'Se materializa como una arquitectura silenciosa, que no se impone, sino que acompaña y enmarca la vida de quienes la habitan, construyendo un modo de vivir ligado al lugar, al clima y a la memoria colectiva.', '', '{\"align-self\":\"center !important;\"}', 2, 1766483620, 1769600999);
INSERT INTO `project_section_items` VALUES (363, 227, 'image', '', 'proyects/p-11/img_694a679f3caee0.62697412.jpg', '{\"width\":\"100% !important;\"}', 1, 1766483871, 1766483871);
INSERT INTO `project_section_items` VALUES (364, 228, 'image', '', 'proyects/p-8/img_6979e12c36bf41.03976282.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766484026, 1769595180);
INSERT INTO `project_section_items` VALUES (365, 228, 'text', 'Se trata de evitar la clasificación de los diferentes usos en espacios definidos, buscando promover nuevas sinergias y tensiones en función de la necesidad de cada día. Como resultado se obtiene un espacio trasfronterizo que aprovecha cada oportunidad para tamizar la luz y poner en valor los materiales en su estado natural. Dibujando atmosferas discretas y diáfanas, la perfección e imperfección se contraponen como una síntesis.', '', '{\"align-self\":\"center !important;\"}', 2, 1766484026, 1769595180);
INSERT INTO `project_section_items` VALUES (366, 229, 'image', '', 'proyects/p-11/img_694a6a6b550a67.91252746.jpg', '{\"align-self\":\"center !important;\"}', 1, 1766484587, 1766484587);
INSERT INTO `project_section_items` VALUES (367, 229, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1766484587, 1766484587);
INSERT INTO `project_section_items` VALUES (368, 230, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1767870415, 1767870415);
INSERT INTO `project_section_items` VALUES (369, 230, 'image', '', 'proyects/p-3/img_695f8fcf919c61.85043111.jpg', '{\"align-self\":\"center !important;\"}', 2, 1767870415, 1767870415);
INSERT INTO `project_section_items` VALUES (370, 231, 'image', '', 'proyects/p-4/img_695f91621cccc9.43659486.jpg', '{\"align-self\":\"center !important;\"}', 1, 1767870818, 1767870818);
INSERT INTO `project_section_items` VALUES (371, 231, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1767870818, 1767870818);
INSERT INTO `project_section_items` VALUES (372, 232, 'text', '', '', '[]', 1, 1767870861, 1767870861);
INSERT INTO `project_section_items` VALUES (373, 232, 'image', '', 'proyects/p-4/img_695f918d5a2e21.00845942.jpg', '[]', 2, 1767870861, 1767870861);
INSERT INTO `project_section_items` VALUES (374, 233, 'image', '', 'proyects/p-4/img_695f92285a1199.12301794.png', '[]', 1, 1767871016, 1767871016);
INSERT INTO `project_section_items` VALUES (375, 234, 'image', '', 'proyects/p-4/img_695f9273c8d9c8.16022348.png', '[]', 1, 1767871091, 1767871091);
INSERT INTO `project_section_items` VALUES (376, 235, 'video', '', 'proyects/p-6/img_695fc83a5d41c1.09514385.mp4', '{\"margin-left\":\"auto !important;\",\"margin-right\":\"auto !important;\"}', 1, 1767884858, 1767884858);
INSERT INTO `project_section_items` VALUES (377, 236, 'image', '', 'proyects/p-6/img_695fc940a84591.90424250.png', '{\"width\":\"100% !important;\"}', 1, 1767885040, 1767885120);
INSERT INTO `project_section_items` VALUES (378, 237, 'text', 'ORTZIMUGA ETXEA', '', '{\"align-self\":\"center !important;\"}', 1, 1767955928, 1767956628);
INSERT INTO `project_section_items` VALUES (379, 237, 'image', '', 'proyects/p-4/img_6960e2c49d0a43.56689415.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1767955928, 1767957188);
INSERT INTO `project_section_items` VALUES (380, 238, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1767956171, 1767956171);
INSERT INTO `project_section_items` VALUES (381, 238, 'image', '', 'proyects/p-4/img_6960decb485f88.97818937.png', '{\"align-self\":\"center !important;\"}', 2, 1767956171, 1767956171);
INSERT INTO `project_section_items` VALUES (382, 239, 'image', '', 'proyects/p-4/img_6960e2fc240e08.70169999.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1767957244, 1767957244);
INSERT INTO `project_section_items` VALUES (383, 239, 'image', '', 'proyects/p-4/img_6960e2fc244d81.76279866.png', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1767957244, 1767957244);
INSERT INTO `project_section_items` VALUES (384, 240, 'video', '', 'proyects/p-6/img_6964c363a806d6.69829396.mp4', '{\"width\":\"100% !important;\"}', 1, 1768211299, 1768211299);
INSERT INTO `project_section_items` VALUES (385, 241, 'image', '', 'proyects/p-14/img_6964d38fdec541.54245782.jpg', '{\"width\":\"100% !important;\"}', 1, 1768215439, 1768215439);
INSERT INTO `project_section_items` VALUES (386, 242, 'image', '', 'proyects/p-14/img_6964d3fc8a9bd5.62828623.png', '[]', 1, 1768215548, 1768215548);
INSERT INTO `project_section_items` VALUES (387, 243, 'image', '', 'proyects/p-14/img_6964d526622117.77236399.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768215846, 1768215846);
INSERT INTO `project_section_items` VALUES (388, 243, 'text', 'BIL 2, truth through materials. Se trata de evitar la clasificación de los diferentes usos en espacios definidos, buscando promover nuevas sinergias y tensiones en función de la necesidad de cada día. Como resultado se obtiene un espacio trasfronterizo que aprovecha cada oportunidad para tamizar la luz y poner en valor los materiales en su estado natural. Dibujando atmosferas discretas y diáfanas, la perfección e imperfección se contraponen como una síntesis.', '', '{\"align-self\":\"center !important;\"}', 2, 1768215846, 1768215846);
INSERT INTO `project_section_items` VALUES (389, 244, 'image', '', 'proyects/p-14/img_6964d59f5eab15.42445045.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 1, 1768215967, 1768215967);
INSERT INTO `project_section_items` VALUES (390, 244, 'image', '', 'proyects/p-14/img_6964d59f5ed224.68213436.jpg', '{\"width\":\"100% !important;\",\"height\":\"100% !important;\"}', 2, 1768215967, 1768215967);
INSERT INTO `project_section_items` VALUES (391, 245, 'image', '', 'proyects/p-13/img_69651bbf7a5cf2.78364870.jpg', '[]', 1, 1768233919, 1768233919);
INSERT INTO `project_section_items` VALUES (392, 245, 'image', '', 'proyects/p-13/img_69651bbf7a93f5.50967737.png', '[]', 2, 1768233919, 1768233919);
INSERT INTO `project_section_items` VALUES (393, 246, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1768302892, 1768302892);
INSERT INTO `project_section_items` VALUES (394, 246, 'image', '', 'proyects/p-12/img_6966292cb74b62.38511108.jpg', '{\"align-self\":\"center !important;\"}', 2, 1768302892, 1768302892);
INSERT INTO `project_section_items` VALUES (395, 247, 'image', '', 'proyects/p-4/img_6967596696a705.91529607.png', '[]', 1, 1768380774, 1768380774);
INSERT INTO `project_section_items` VALUES (396, 248, 'image', '', 'proyects/p-2/img_696782b31a9722.52625743.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768390852, 1768391347);
INSERT INTO `project_section_items` VALUES (397, 248, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1768390852, 1768391347);
INSERT INTO `project_section_items` VALUES (398, 249, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1768391376, 1768391376);
INSERT INTO `project_section_items` VALUES (399, 249, 'image', '', 'proyects/p-2/img_696782d054e424.52998547.jpg', '{\"align-self\":\"center !important;\"}', 2, 1768391376, 1768391376);
INSERT INTO `project_section_items` VALUES (400, 250, 'video', '', 'proyects/p-1/img_6968b9def119d0.27757615.mp4', '{\"width\":\"100% !important;\"}', 1, 1768471006, 1768471006);
INSERT INTO `project_section_items` VALUES (401, 251, 'video', '', 'proyects/p-1/img_6968bab07734d2.88278686.mp4', '{\"width\":\"100% !important;\"}', 1, 1768471216, 1768471216);
INSERT INTO `project_section_items` VALUES (402, 252, 'video', '', 'proyects/p-1/img_6968d6c7e67ef1.16367219.mp4', '{\"width\":\"100% !important;\"}', 1, 1768478407, 1768478407);
INSERT INTO `project_section_items` VALUES (403, 253, 'video', '', 'proyects/p-2/img_6968f8088cf509.84788130.mp4', '{\"width\":\"100% !important;\"}', 1, 1768486920, 1768486920);
INSERT INTO `project_section_items` VALUES (404, 254, 'video', '', 'proyects/p-8/img_6968fb03590b28.62165530.mp4', '{\"width\":\"100% !important;\"}', 1, 1768487683, 1768487683);
INSERT INTO `project_section_items` VALUES (405, 255, 'text', 'Entrar en esta clínica de antiaging situada en el corazón de Bilbao, es sumergirse en un oasis de bienestar donde la vanguardia médica se encuentra con la belleza del arte y la armonía del color. No es solo un espacio de tratamientos revolucionarios, sino un santuario diseñado para despertar los sentidos, restaurar la energía y reavivar la esencia de cada paciente.', '', '{\"align-self\":\"center !important;\"}', 1, 1768487850, 1769600653);
INSERT INTO `project_section_items` VALUES (406, 255, 'video', '', 'proyects/p-3/img_6979f68d3c6a98.46756784.mp4', '{\"align-self\":\"center !important;\"}', 2, 1768487850, 1769600653);
INSERT INTO `project_section_items` VALUES (407, 256, 'image', '', 'proyects/p-5/img_696901f32fa878.10789730.jpg', '[]', 1, 1768489459, 1768489459);
INSERT INTO `project_section_items` VALUES (408, 257, 'video', '', 'proyects/p-5/img_6969026fec67b2.94116883.mp4', '{\"width\":\"100% !important;\"}', 1, 1768489583, 1768489583);
INSERT INTO `project_section_items` VALUES (409, 258, 'image', '', 'proyects/p-9/img_696903d102d5e6.20065043.jpg', '{\"width\":\"100% !important;\"}', 1, 1768489937, 1768489937);
INSERT INTO `project_section_items` VALUES (410, 259, 'image', '', 'proyects/p-9/img_696904953b26e6.92869781.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768490133, 1768490133);
INSERT INTO `project_section_items` VALUES (411, 259, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1768490133, 1768490133);
INSERT INTO `project_section_items` VALUES (412, 260, 'image', '', 'proyects/p-9/img_69690535a409f0.91984280.png', '[]', 1, 1768490293, 1768490293);
INSERT INTO `project_section_items` VALUES (413, 261, 'image', '', 'proyects/p-9/img_696906640de967.41120350.jpg', '{\"width\":\"100% !important;\"}', 1, 1768490596, 1768490596);
INSERT INTO `project_section_items` VALUES (414, 262, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1768491394, 1768491394);
INSERT INTO `project_section_items` VALUES (415, 262, 'image', '', 'proyects/p-9/img_696909820e7806.26611951.jpg', '{\"align-self\":\"center !important;\"}', 2, 1768491394, 1768491394);
INSERT INTO `project_section_items` VALUES (416, 263, 'video', '', 'proyects/p-13/img_696a1ccf2cbe07.79195245.mp4', '{\"width\":\"100% !important;\"}', 1, 1768561871, 1768561871);
INSERT INTO `project_section_items` VALUES (417, 264, 'video', '', 'proyects/p-1/img_696a1de4eab788.60700383.mp4', '{\"width\":\"100% !important;\"}', 1, 1768562148, 1768562148);
INSERT INTO `project_section_items` VALUES (418, 265, 'video', '', 'proyects/p-1/img_696a1f52385036.86244702.mp4', '{\"width\":\"100% !important;\"}', 1, 1768562514, 1768562514);
INSERT INTO `project_section_items` VALUES (419, 266, 'video', '', 'proyects/p-1/img_696a2052068d80.88564887.mp4', '{\"width\":\"100% !important;\"}', 1, 1768562770, 1768562770);
INSERT INTO `project_section_items` VALUES (420, 267, 'video', '', 'proyects/p-1/img_696a2083bb1b34.70209593.mp4', '{\"width\":\"100% !important;\"}', 1, 1768562819, 1768562819);
INSERT INTO `project_section_items` VALUES (421, 268, 'image', '', 'proyects/p-1/img_696a236a4155e9.68968550.jpg', '{\"width\":\"100% !important;\"}', 1, 1768563562, 1768563562);
INSERT INTO `project_section_items` VALUES (422, 269, 'text', 'Parte del suelo de la plaza sigue un patrón fractal.', '', '{\"align-self\":\"center !important;\"}', 1, 1768575133, 1768836805);
INSERT INTO `project_section_items` VALUES (423, 269, 'image', '', 'proyects/p-9/img_696e4ec51708e9.88693487.jpg', '{\"align-self\":\"center !important;\"}', 2, 1768575133, 1768836805);
INSERT INTO `project_section_items` VALUES (424, 270, 'image', '', 'proyects/p-12/img_696a5a08bd6b71.66852030.jpg', '{\"width\":\"100% !important;\"}', 1, 1768577544, 1768577544);
INSERT INTO `project_section_items` VALUES (425, 271, 'image', '', 'proyects/p-1/img_696e19b601eac2.05591540.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1768823221, 1768823290);
INSERT INTO `project_section_items` VALUES (426, 271, 'text', 'Se trata de evocar la poesía del paisaje a través de una típica casa de labranza en el pueblo de Santa Margalida (Mallorca). La idea del proyecto original era hacer desaparecer la vivienda entre los tradicionales muros de piedra seca que pautan la isla desde  el mar a la montaña. De ahí su nombre, ENTRE MUROS, un término que encapsula la esencia del hogar soñado y que ejemplifica, además, la conciliación en todas sus formas. ', '', '{\"align-self\":\"center !important;\"}', 2, 1768823221, 1768823290);
INSERT INTO `project_section_items` VALUES (427, 272, 'image', '', 'proyects/p-2/img_696e1b6065ff33.46143748.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768823648, 1768823648);
INSERT INTO `project_section_items` VALUES (428, 272, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1768823648, 1768823648);
INSERT INTO `project_section_items` VALUES (429, 273, 'text', 'Vivienda unifamiliar en proceso de construcción.', '', '{\"align-self\":\"center !important;\"}', 1, 1768824249, 1769597311);
INSERT INTO `project_section_items` VALUES (430, 273, 'video', '', 'proyects/p-6/img_6979e97f903746.55561890.mp4', '{\"align-self\":\"center !important;\"}', 2, 1768824249, 1769597311);
INSERT INTO `project_section_items` VALUES (431, 274, 'image', '', 'proyects/p-9/img_696e4f0551c2f4.69583486.png', '{\"width\":\"100% !important;\"}', 1, 1768836869, 1768836869);
INSERT INTO `project_section_items` VALUES (432, 275, 'image', '', 'proyects/p-2/img_696f8dec164943.69193004.jpg', '[]', 1, 1768918508, 1768918508);
INSERT INTO `project_section_items` VALUES (433, 276, 'video', '', 'proyects/p-6/img_696fa14bb7f4c4.14950715.mp4', '{\"width\":\"100% !important;\"}', 1, 1768923467, 1768923467);
INSERT INTO `project_section_items` VALUES (434, 277, 'text', 'SHELTER es un espacio realizado en madera contra laminada en su interior y exterior. Este minúsculo espacio se ha concebido para responder a la necesidad de un habitar no estático, con la única premisa de ser realizado íntegramente en madera.', '', '{\"align-self\":\"center !important;\"}', 1, 1768925730, 1768926030);
INSERT INTO `project_section_items` VALUES (435, 277, 'image', '', 'proyects/p-13/img_696fab4e6e2022.75172527.jpg', '{\"align-self\":\"center !important;\"}', 2, 1768925730, 1768926030);
INSERT INTO `project_section_items` VALUES (436, 278, 'image', '', 'proyects/p-13/img_696faa8ad712c9.35772146.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768925834, 1768925834);
INSERT INTO `project_section_items` VALUES (437, 278, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1768925834, 1768925834);
INSERT INTO `project_section_items` VALUES (438, 279, 'image', '', 'proyects/p-13/img_696fab0a34fe01.45867791.png', '[]', 1, 1768925962, 1768925962);
INSERT INTO `project_section_items` VALUES (439, 280, 'image', '', 'proyects/p-13/img_696fabb055e6b5.80558424.jpg', '{\"align-self\":\"center !important;\"}', 1, 1768926128, 1768926128);
INSERT INTO `project_section_items` VALUES (440, 280, 'text', 'SHELTER es un espacio realizado en madera contra laminada en su interior y exterior. Este minúsculo espacio se ha concebido para responder a la necesidad de un habitar no estático, con la única premisa de ser realizado íntegramente en madera.', '', '{\"align-self\":\"center !important;\"}', 2, 1768926128, 1768926128);
INSERT INTO `project_section_items` VALUES (441, 281, 'video', '', 'proyects/p-1/img_697737761a4e21.31214280.mp4', '{\"width\":\"100% !important;\"}', 1, 1769420662, 1769420662);
INSERT INTO `project_section_items` VALUES (442, 282, 'video', '', 'proyects/p-1/img_697737c7e83f99.98631613.mp4', '{\"width\":\"100% !important;\"}', 1, 1769420743, 1769420743);
INSERT INTO `project_section_items` VALUES (443, 283, 'video', '', 'proyects/p-1/img_69773805db9848.21936898.mp4', '{\"width\":\"100% !important;\"}', 1, 1769420805, 1769420805);
INSERT INTO `project_section_items` VALUES (444, 284, 'image', '', 'proyects/p-4/img_6979e8a8dcc5e7.39909158.png', '{\"align-self\":\"center !important;\"}', 1, 1769504622, 1769597096);
INSERT INTO `project_section_items` VALUES (445, 284, 'text', 'Vivienda unifamiliar en proceso de construcción.', '', '{\"align-self\":\"center !important;\"}', 2, 1769504622, 1769597096);
INSERT INTO `project_section_items` VALUES (446, 285, 'image', '', 'proyects/p-11/img_6979efa80d0354.62682835.png', '{\"align-self\":\"center !important;\"}', 1, 1769505833, 1769598888);
INSERT INTO `project_section_items` VALUES (447, 285, 'text', 'Un jardín urbano.', '', '{\"align-self\":\"center !important;\"}', 2, 1769505833, 1769598888);
INSERT INTO `project_section_items` VALUES (448, 286, 'text', 'Pensado para el encuentro cotidiano, donde las trayectorias se cruzan y el tiempo se detiene.', '', '{\"align-self\":\"center !important;\"}', 1, 1769505945, 1769598833);
INSERT INTO `project_section_items` VALUES (449, 286, 'image', '', 'proyects/p-11/img_6979ef718d1b80.85736241.jpg', '{\"align-self\":\"center !important;\"}', 2, 1769505945, 1769598833);
INSERT INTO `project_section_items` VALUES (450, 287, 'image', '', 'proyects/p-8/img_6979e06f276e80.35171689.png', '{\"align-self\":\"center !important;\"}', 1, 1769594914, 1769594991);
INSERT INTO `project_section_items` VALUES (451, 287, 'text', 'La honestidad de los materiales', '', '{\"align-self\":\"center !important;\"}', 2, 1769594914, 1769594991);
INSERT INTO `project_section_items` VALUES (452, 288, 'text', 'La honestidad de los materiales.', '', '{\"align-self\":\"center !important;\"}', 1, 1769595034, 1769595133);
INSERT INTO `project_section_items` VALUES (453, 288, 'image', '', 'proyects/p-8/img_6979e0fde0e798.21852997.png', '{\"align-self\":\"center !important;\"}', 2, 1769595034, 1769595133);
INSERT INTO `project_section_items` VALUES (454, 289, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1769595481, 1769595516);
INSERT INTO `project_section_items` VALUES (455, 289, 'image', '', 'proyects/p-8/img_6979e27cc018f5.71468330.png', '{\"align-self\":\"center !important;\"}', 2, 1769595481, 1769595516);
INSERT INTO `project_section_items` VALUES (456, 290, 'image', '', 'proyects/p-8/img_6979e2a259e5a5.62917009.png', '{\"align-self\":\"center !important;\"}', 1, 1769595554, 1769595554);
INSERT INTO `project_section_items` VALUES (457, 290, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1769595554, 1769595554);
INSERT INTO `project_section_items` VALUES (458, 291, 'text', 'Las paredes a la cal resaltan el sucinto interiorismo industrial manufacturado en acero natural, que nos recuerda a los cada vez menos recurrentes telúricos paisajes de la austera poesía industrial que se asentaba a orillas del rio Nervión.', '', '{\"align-self\":\"center !important;\"}', 1, 1769595803, 1769595803);
INSERT INTO `project_section_items` VALUES (459, 291, 'image', '', 'proyects/p-8/img_6979e39b1cddf3.24868254.jpg', '{\"align-self\":\"center !important;\"}', 2, 1769595803, 1769595803);
INSERT INTO `project_section_items` VALUES (460, 292, 'text', 'Las paredes a la cal resaltan el sucinto interiorismo industrial manufacturado en acero natural, que nos recuerda a los cada vez menos recurrentes telúricos paisajes de la austera poesía industrial que se asentaba a orillas del rio Nervión.', '', '{\"align-self\":\"center !important;\"}', 1, 1769595898, 1769595898);
INSERT INTO `project_section_items` VALUES (461, 292, 'image', '', 'proyects/p-8/img_6979e3fa6c58c1.06112804.jpg', '{\"align-self\":\"center !important;\"}', 2, 1769595898, 1769595898);
INSERT INTO `project_section_items` VALUES (462, 293, 'image', '', 'proyects/p-8/img_6979e439574353.83060927.jpg', '{\"align-self\":\"center !important;\"}', 1, 1769595961, 1769595961);
INSERT INTO `project_section_items` VALUES (463, 293, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1769595961, 1769595961);
INSERT INTO `project_section_items` VALUES (464, 294, 'text', 'El arte de rejuvenecer, un espacio donde la ciencia y el diseño sanan.', '', '{\"align-self\":\"center !important;\"}', 1, 1769596217, 1769596217);
INSERT INTO `project_section_items` VALUES (465, 294, 'image', '', 'proyects/p-3/img_6979e539f1f526.55675783.png', '{\"align-self\":\"center !important;\"}', 2, 1769596217, 1769596217);
INSERT INTO `project_section_items` VALUES (466, 295, 'text', 'Reinterpretación contemporánea de la arquitectura rural mallorquina.', '', '{\"align-self\":\"center !important;\"}', 1, 1769596521, 1769617106);
INSERT INTO `project_section_items` VALUES (467, 295, 'image', '', 'proyects/p-2/img_697a36d2d75fc4.80400926.png', '{\"align-self\":\"center !important;\"}', 2, 1769596521, 1769617106);
INSERT INTO `project_section_items` VALUES (468, 296, 'image', '', 'proyects/p-1/img_697b20d3e0ba82.29081492.png', '{\"align-self\":\"center !important;\"}', 1, 1769596909, 1769677011);
INSERT INTO `project_section_items` VALUES (469, 296, 'text', 'Desdibujar la frontera entre la arquitectura y el paisaje.', '', '{\"align-self\":\"center !important;\"}', 2, 1769596909, 1769677011);
INSERT INTO `project_section_items` VALUES (470, 297, 'text', 'El ladrillo como leitmotiv.', '', '{\"align-self\":\"center !important;\"}', 1, 1769597393, 1769598022);
INSERT INTO `project_section_items` VALUES (471, 297, 'image', '', 'proyects/p-7/img_6979ec46ad4fe9.25335816.png', '{\"align-self\":\"center !important;\"}', 2, 1769597393, 1769598022);
INSERT INTO `project_section_items` VALUES (472, 298, 'text', 'Habitar nómada.', '', '{\"align-self\":\"center !important;\"}', 1, 1769598094, 1769599397);
INSERT INTO `project_section_items` VALUES (473, 298, 'image', '', 'proyects/p-13/img_6979f1a599f5d5.26492664.png', '{\"align-self\":\"center !important;\"}', 2, 1769598094, 1769599397);
INSERT INTO `project_section_items` VALUES (474, 299, 'text', 'Industrializar con alma.', '', '{\"align-self\":\"center !important;\"}', 1, 1769598309, 1769599501);
INSERT INTO `project_section_items` VALUES (475, 299, 'image', '', 'proyects/p-15/img_6979f20d264ce1.09006440.png', '{\"align-self\":\"center !important;\"}', 2, 1769598309, 1769599501);
INSERT INTO `project_section_items` VALUES (476, 300, 'text', 'Volver a lo rural.', '', '{\"align-self\":\"center !important;\"}', 1, 1769599593, 1769599593);
INSERT INTO `project_section_items` VALUES (477, 300, 'image', '', 'proyects/p-9/img_6979f2696b36a8.83328994.png', '{\"align-self\":\"center !important;\"}', 2, 1769599593, 1769599593);
INSERT INTO `project_section_items` VALUES (478, 301, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1769600829, 1769600829);
INSERT INTO `project_section_items` VALUES (479, 301, 'image', '', 'proyects/p-3/img_6979f73d91a863.47795806.jpg', '{\"align-self\":\"center !important;\"}', 2, 1769600829, 1769600829);
INSERT INTO `project_section_items` VALUES (480, 302, 'image', '', 'proyects/p-15/img_6979f94421fea2.64198712.png', '{\"width\":\"100% !important;\"}', 1, 1769601348, 1769601348);
INSERT INTO `project_section_items` VALUES (481, 302, 'image', '', 'proyects/p-15/img_6979f9442230f2.05723700.png', '{\"width\":\"100% !important;\"}', 2, 1769601348, 1769601348);
INSERT INTO `project_section_items` VALUES (482, 303, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1769611158, 1769611158);
INSERT INTO `project_section_items` VALUES (483, 303, 'image', '', 'proyects/p-3/img_697a1f96411482.90679962.png', '{\"align-self\":\"center !important;\"}', 2, 1769611158, 1769611158);
INSERT INTO `project_section_items` VALUES (484, 304, 'video', '', 'proyects/p-9/img_697b2763ac5f02.51798891.mp4', '{\"margin-left\":\"auto !important;\"}', 1, 1769678691, 1769678856);
INSERT INTO `project_section_items` VALUES (485, 305, 'video', '', 'proyects/p-9/img_697b28dc6f2103.31471055.mp4', '{\"margin-left\":\"auto !important;\"}', 1, 1769679068, 1769679484);
INSERT INTO `project_section_items` VALUES (486, 306, 'image', '', 'proyects/p-9/img_697b35da1fb861.43951112.jpeg', '{\"align-self\":\"center !important;\"}', 1, 1769679288, 1769682394);
INSERT INTO `project_section_items` VALUES (487, 306, 'text', 'En el corazón de Arrazua-Ubarrundia(Araba), Artzainenea renace sin perder la memoria. Este caserío vasco, de sólida fachada de piedra, se mantiene fiel a su origen, conservando la huella del tiempo como parte esencial de su identidad.', '', '{\"align-self\":\"center !important;\"}', 2, 1769679288, 1769682394);
INSERT INTO `project_section_items` VALUES (488, 307, 'image', '', 'proyects/p-8/img_697b2f30372051.87157971.png', '{\"width\":\"100% !important;\"}', 1, 1769680688, 1769680688);
INSERT INTO `project_section_items` VALUES (489, 307, 'image', '', 'proyects/p-8/img_697b2f30376da8.20483739.png', '{\"width\":\"100% !important;\"}', 2, 1769680688, 1769680688);
INSERT INTO `project_section_items` VALUES (490, 308, 'image', '', 'proyects/p-15/img_697b2fb674c9e2.38645064.png', '[]', 1, 1769680822, 1769680822);
INSERT INTO `project_section_items` VALUES (491, 309, 'image', '', 'proyects/p-15/img_697b2ffb401297.87105008.png', '{\"width\":\"100% !important;\"}', 1, 1769680891, 1769680891);
INSERT INTO `project_section_items` VALUES (492, 309, 'image', '', 'proyects/p-15/img_697b2ffb4053b6.50660009.jpg', '{\"width\":\"100% !important;\"}', 2, 1769680891, 1769680891);
INSERT INTO `project_section_items` VALUES (493, 310, 'image', '', 'proyects/p-15/img_697b302a44c207.63936281.png', '{\"align-self\":\"center !important;\"}', 1, 1769680938, 1769680938);
INSERT INTO `project_section_items` VALUES (494, 310, 'text', '', '', '{\"align-self\":\"center !important;\"}', 2, 1769680938, 1769680938);
INSERT INTO `project_section_items` VALUES (495, 311, 'image', '', 'proyects/p-2/img_697b37234053e1.71189655.png', '[]', 1, 1769682723, 1769682723);
INSERT INTO `project_section_items` VALUES (496, 312, 'text', '', '', '{\"align-self\":\"center !important;\"}', 1, 1769682792, 1769682792);
INSERT INTO `project_section_items` VALUES (497, 312, 'image', '', 'proyects/p-2/img_697b376894d898.23185158.jpg', '{\"align-self\":\"center !important;\"}', 2, 1769682792, 1769682792);
INSERT INTO `project_section_items` VALUES (498, 313, 'video', '', 'proyects/p-15/img_697c88bd69f380.03507821.mp4', '[]', 1, 1769768915, 1769769149);
INSERT INTO `project_section_items` VALUES (499, 314, 'video', '', 'proyects/p-15/img_697c8e5c8cc031.39296384.mp4', '[]', 1, 1769770445, 1769770588);
INSERT INTO `project_section_items` VALUES (500, 314, 'text', '', '', '[]', 2, 1769770445, 1769770588);

-- ----------------------------
-- Table structure for project_sections
-- ----------------------------
DROP TABLE IF EXISTS `project_sections`;
CREATE TABLE `project_sections`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED NULL DEFAULT 0,
  `layout_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom_css` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `custom_settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `timecreated` int NULL DEFAULT NULL,
  `timeupdated` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id` ASC) USING BTREE,
  CONSTRAINT `project_sections_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `proyects` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 315 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of project_sections
-- ----------------------------
INSERT INTO `project_sections` VALUES (1, 2, 247, 'text_left_image_right', '', NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (2, 2, 274, 'two_images_left_large_right_small', NULL, NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (3, 2, 283, 'one_image', NULL, NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (4, 2, 298, 'text_left_image_right', NULL, NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (5, 2, 302, 'two_images', NULL, NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (6, 2, 302, 'one_image', '{\"background\": \"#ffffff\"}', NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (7, 2, 305, 'two_images', NULL, NULL, 1, NULL, NULL);
INSERT INTO `project_sections` VALUES (8, 2, 304, 'one_image', NULL, NULL, 1, NULL, NULL);
INSERT INTO `project_sections` VALUES (9, 2, 308, 'two_images', NULL, NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (10, 2, 309, 'one_image', NULL, NULL, 1, NULL, NULL);
INSERT INTO `project_sections` VALUES (11, 1, 214, 'image_left_text_right', '{\"padding\": \"4rem 0 !important\", \"align-items\": \"center\"}', NULL, 0, NULL, NULL);
INSERT INTO `project_sections` VALUES (16, 1, 299, 'one_image', '{\"background\":\"#ffffff\"}', '{}', 1, 1763976851, 1763976851);
INSERT INTO `project_sections` VALUES (17, 1, 246, 'text_left_image_right', '{\"background\":\"#ffffff\"}', '{}', 0, 1764168997, 1764168997);
INSERT INTO `project_sections` VALUES (18, 1, 224, 'one_image', '{\"background\":\"#fffff\"}', '{}', 0, 1764169488, 1764169488);
INSERT INTO `project_sections` VALUES (19, 1, 232, 'text_left_image_right', '{\"background\":\"#ffffff\"}', '{}', 0, 1764170047, 1764170047);
INSERT INTO `project_sections` VALUES (20, 1, 233, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764170486, 1764170486);
INSERT INTO `project_sections` VALUES (21, 1, 225, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764861732, 1764861732);
INSERT INTO `project_sections` VALUES (22, 1, 225, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764861844, 1764861844);
INSERT INTO `project_sections` VALUES (23, 1, 233, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764861916, 1764861916);
INSERT INTO `project_sections` VALUES (24, 1, 214, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862175, 1764862175);
INSERT INTO `project_sections` VALUES (25, 1, 227, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764862353, 1764862353);
INSERT INTO `project_sections` VALUES (26, 1, 230, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764862458, 1764862458);
INSERT INTO `project_sections` VALUES (27, 1, 234, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862580, 1764862580);
INSERT INTO `project_sections` VALUES (28, 1, 236, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862657, 1764862657);
INSERT INTO `project_sections` VALUES (29, 1, 244, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862714, 1764862714);
INSERT INTO `project_sections` VALUES (30, 1, 239, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862742, 1764862742);
INSERT INTO `project_sections` VALUES (31, 1, 243, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862808, 1764862808);
INSERT INTO `project_sections` VALUES (32, 1, 242, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862867, 1764862867);
INSERT INTO `project_sections` VALUES (33, 1, 275, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764862969, 1764862969);
INSERT INTO `project_sections` VALUES (34, 1, 280, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863051, 1764863051);
INSERT INTO `project_sections` VALUES (35, 1, 283, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863125, 1764863125);
INSERT INTO `project_sections` VALUES (36, 1, 284, 'one_image', '{\"background\":\"#ffffff\"}', '{}', 1, 1764863204, 1764863204);
INSERT INTO `project_sections` VALUES (37, 1, 239, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863283, 1764863283);
INSERT INTO `project_sections` VALUES (38, 1, 287, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863403, 1764863403);
INSERT INTO `project_sections` VALUES (39, 1, 288, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863470, 1764863470);
INSERT INTO `project_sections` VALUES (40, 1, 289, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764863542, 1764863542);
INSERT INTO `project_sections` VALUES (41, 1, 293, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863661, 1764863661);
INSERT INTO `project_sections` VALUES (42, 1, 297, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764863928, 1764863928);
INSERT INTO `project_sections` VALUES (43, 1, 295, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764864198, 1764864198);
INSERT INTO `project_sections` VALUES (44, 1, 281, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764864714, 1764864714);
INSERT INTO `project_sections` VALUES (45, 1, 296, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1764865126, 1764865126);
INSERT INTO `project_sections` VALUES (46, 1, 221, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1764865361, 1764865361);
INSERT INTO `project_sections` VALUES (47, 4, 211, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444488, 1765444488);
INSERT INTO `project_sections` VALUES (48, 4, 188, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444537, 1765444537);
INSERT INTO `project_sections` VALUES (49, 4, 0, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444573, 1765444573);
INSERT INTO `project_sections` VALUES (50, 4, 210, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444691, 1765444691);
INSERT INTO `project_sections` VALUES (51, 4, 187, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765444737, 1765444737);
INSERT INTO `project_sections` VALUES (52, 4, 209, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444818, 1765444818);
INSERT INTO `project_sections` VALUES (53, 4, 207, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765444869, 1765444869);
INSERT INTO `project_sections` VALUES (54, 4, 206, '', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765444928, 1765444928);
INSERT INTO `project_sections` VALUES (55, 4, 182, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445006, 1765445006);
INSERT INTO `project_sections` VALUES (56, 4, 181, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445074, 1765445074);
INSERT INTO `project_sections` VALUES (57, 4, 208, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445175, 1765445175);
INSERT INTO `project_sections` VALUES (58, 4, 205, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445237, 1765445237);
INSERT INTO `project_sections` VALUES (59, 4, 180, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445272, 1765445272);
INSERT INTO `project_sections` VALUES (60, 4, 192, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765445310, 1765445310);
INSERT INTO `project_sections` VALUES (61, 4, 183, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445341, 1765445341);
INSERT INTO `project_sections` VALUES (62, 4, 179, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445447, 1765445447);
INSERT INTO `project_sections` VALUES (63, 4, 184, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445570, 1765445570);
INSERT INTO `project_sections` VALUES (64, 4, 195, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765445718, 1765445718);
INSERT INTO `project_sections` VALUES (65, 4, 193, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765445763, 1765445763);
INSERT INTO `project_sections` VALUES (66, 4, 200, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765445858, 1765445858);
INSERT INTO `project_sections` VALUES (67, 4, 200, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765445978, 1765445978);
INSERT INTO `project_sections` VALUES (68, 4, 178, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765446025, 1765446025);
INSERT INTO `project_sections` VALUES (69, 4, 201, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765446090, 1765446090);
INSERT INTO `project_sections` VALUES (70, 4, 177, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765446371, 1765446371);
INSERT INTO `project_sections` VALUES (71, 4, 204, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765446441, 1765446441);
INSERT INTO `project_sections` VALUES (72, 4, 176, 'two_images_left_large_right_small', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765446655, 1765446655);
INSERT INTO `project_sections` VALUES (73, 4, 203, 'two_images', '[]', '{}', 0, 1765626238, 1765626238);
INSERT INTO `project_sections` VALUES (74, 3, 156, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765901117, 1765901117);
INSERT INTO `project_sections` VALUES (75, 3, 152, '', '[]', '{}', 1, 1765901258, 1765901258);
INSERT INTO `project_sections` VALUES (76, 3, 151, '', '[]', '{}', 1, 1765901262, 1765901262);
INSERT INTO `project_sections` VALUES (77, 3, 157, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765901885, 1765901885);
INSERT INTO `project_sections` VALUES (78, 3, 175, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765902089, 1765902089);
INSERT INTO `project_sections` VALUES (79, 3, 159, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765902095, 1765902095);
INSERT INTO `project_sections` VALUES (80, 3, 160, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765902311, 1765902311);
INSERT INTO `project_sections` VALUES (81, 3, 161, 'image_left_text_right', '[]', '{}', 1, 1765902479, 1765902479);
INSERT INTO `project_sections` VALUES (82, 3, 162, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765961916, 1765961916);
INSERT INTO `project_sections` VALUES (83, 3, 163, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765962337, 1765962337);
INSERT INTO `project_sections` VALUES (84, 3, 164, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765962639, 1765962639);
INSERT INTO `project_sections` VALUES (85, 3, 165, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765962844, 1765962844);
INSERT INTO `project_sections` VALUES (86, 3, 167, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765963062, 1765963062);
INSERT INTO `project_sections` VALUES (87, 3, 168, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765963126, 1765963126);
INSERT INTO `project_sections` VALUES (88, 3, 169, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765963218, 1765963218);
INSERT INTO `project_sections` VALUES (89, 3, 172, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765963282, 1765963282);
INSERT INTO `project_sections` VALUES (90, 3, 171, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765963386, 1765963386);
INSERT INTO `project_sections` VALUES (91, 3, 174, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765963430, 1765963430);
INSERT INTO `project_sections` VALUES (92, 3, 170, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765963477, 1765963477);
INSERT INTO `project_sections` VALUES (93, 8, 127, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765965972, 1765965972);
INSERT INTO `project_sections` VALUES (94, 8, 150, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765966074, 1765966074);
INSERT INTO `project_sections` VALUES (95, 8, 127, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765966150, 1765966150);
INSERT INTO `project_sections` VALUES (96, 8, 131, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765966968, 1765966968);
INSERT INTO `project_sections` VALUES (97, 8, 132, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765967052, 1765967052);
INSERT INTO `project_sections` VALUES (98, 8, 134, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765967433, 1765967433);
INSERT INTO `project_sections` VALUES (99, 8, 135, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765967699, 1765967699);
INSERT INTO `project_sections` VALUES (100, 8, 138, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765967983, 1765967983);
INSERT INTO `project_sections` VALUES (101, 8, 144, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765968086, 1765968086);
INSERT INTO `project_sections` VALUES (102, 8, 140, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765968214, 1765968214);
INSERT INTO `project_sections` VALUES (103, 8, 141, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765968444, 1765968444);
INSERT INTO `project_sections` VALUES (104, 8, 148, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765968561, 1765968561);
INSERT INTO `project_sections` VALUES (105, 8, 148, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765968747, 1765968747);
INSERT INTO `project_sections` VALUES (106, 8, 148, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765968945, 1765968945);
INSERT INTO `project_sections` VALUES (107, 8, 144, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765969161, 1765969161);
INSERT INTO `project_sections` VALUES (108, 15, 94, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765970339, 1765970339);
INSERT INTO `project_sections` VALUES (109, 15, 96, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765970446, 1765970446);
INSERT INTO `project_sections` VALUES (110, 15, 98, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765970528, 1765970528);
INSERT INTO `project_sections` VALUES (111, 15, 98, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765970688, 1765970688);
INSERT INTO `project_sections` VALUES (112, 15, 102, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765970735, 1765970735);
INSERT INTO `project_sections` VALUES (113, 15, 104, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765971085, 1765971085);
INSERT INTO `project_sections` VALUES (114, 15, 107, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765971209, 1765971209);
INSERT INTO `project_sections` VALUES (115, 15, 108, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765971306, 1765971306);
INSERT INTO `project_sections` VALUES (116, 15, 109, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765971392, 1765971392);
INSERT INTO `project_sections` VALUES (117, 15, 112, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765971503, 1765971503);
INSERT INTO `project_sections` VALUES (118, 15, 110, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765971578, 1765971578);
INSERT INTO `project_sections` VALUES (119, 15, 112, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765971998, 1765971998);
INSERT INTO `project_sections` VALUES (120, 15, 112, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765972098, 1765972098);
INSERT INTO `project_sections` VALUES (121, 15, 118, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765972337, 1765972337);
INSERT INTO `project_sections` VALUES (122, 15, 123, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765972515, 1765972515);
INSERT INTO `project_sections` VALUES (123, 15, 119, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765972612, 1765972612);
INSERT INTO `project_sections` VALUES (124, 15, 120, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765973156, 1765973156);
INSERT INTO `project_sections` VALUES (125, 15, 122, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765973293, 1765973293);
INSERT INTO `project_sections` VALUES (126, 15, 121, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765973481, 1765973481);
INSERT INTO `project_sections` VALUES (127, 7, 78, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765982408, 1765982408);
INSERT INTO `project_sections` VALUES (128, 7, 79, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765982630, 1765982630);
INSERT INTO `project_sections` VALUES (129, 7, 80, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765982728, 1765982728);
INSERT INTO `project_sections` VALUES (130, 7, 81, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765982839, 1765982839);
INSERT INTO `project_sections` VALUES (131, 7, 82, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983064, 1765983064);
INSERT INTO `project_sections` VALUES (132, 7, 83, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983147, 1765983147);
INSERT INTO `project_sections` VALUES (133, 7, 84, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983239, 1765983239);
INSERT INTO `project_sections` VALUES (134, 7, 85, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983326, 1765983326);
INSERT INTO `project_sections` VALUES (135, 7, 86, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983497, 1765983497);
INSERT INTO `project_sections` VALUES (136, 7, 88, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765983573, 1765983573);
INSERT INTO `project_sections` VALUES (137, 7, 89, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765983639, 1765983639);
INSERT INTO `project_sections` VALUES (138, 7, 90, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765983680, 1765983680);
INSERT INTO `project_sections` VALUES (139, 7, 91, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983750, 1765983750);
INSERT INTO `project_sections` VALUES (140, 7, 92, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765983844, 1765983844);
INSERT INTO `project_sections` VALUES (141, 2, 248, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765984117, 1765984117);
INSERT INTO `project_sections` VALUES (142, 2, 255, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765984610, 1765984610);
INSERT INTO `project_sections` VALUES (143, 2, 272, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765985183, 1765985183);
INSERT INTO `project_sections` VALUES (144, 2, 256, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765985335, 1765985335);
INSERT INTO `project_sections` VALUES (145, 2, 262, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765985929, 1765985929);
INSERT INTO `project_sections` VALUES (146, 2, 263, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765986056, 1765986056);
INSERT INTO `project_sections` VALUES (147, 2, 264, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1765986250, 1765986250);
INSERT INTO `project_sections` VALUES (148, 2, 266, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765986485, 1765986485);
INSERT INTO `project_sections` VALUES (149, 2, 267, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1765988578, 1765988578);
INSERT INTO `project_sections` VALUES (150, 9, 59, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766048946, 1766048946);
INSERT INTO `project_sections` VALUES (151, 9, 63, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049066, 1766049066);
INSERT INTO `project_sections` VALUES (152, 9, 64, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766049183, 1766049183);
INSERT INTO `project_sections` VALUES (153, 9, 76, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049378, 1766049378);
INSERT INTO `project_sections` VALUES (154, 9, 75, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049471, 1766049471);
INSERT INTO `project_sections` VALUES (155, 9, 74, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049565, 1766049565);
INSERT INTO `project_sections` VALUES (156, 9, 67, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049613, 1766049613);
INSERT INTO `project_sections` VALUES (157, 9, 71, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766049734, 1766049734);
INSERT INTO `project_sections` VALUES (158, 9, 67, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766049784, 1766049784);
INSERT INTO `project_sections` VALUES (159, 9, 68, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766049844, 1766049844);
INSERT INTO `project_sections` VALUES (160, 9, 61, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766050073, 1766050073);
INSERT INTO `project_sections` VALUES (161, 9, 62, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766050372, 1766050372);
INSERT INTO `project_sections` VALUES (162, 9, 72, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766051278, 1766051278);
INSERT INTO `project_sections` VALUES (163, 9, 73, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766051318, 1766051318);
INSERT INTO `project_sections` VALUES (164, 13, 38, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766051936, 1766051936);
INSERT INTO `project_sections` VALUES (165, 13, 45, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766052048, 1766052048);
INSERT INTO `project_sections` VALUES (166, 13, 45, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766052192, 1766052192);
INSERT INTO `project_sections` VALUES (167, 13, 48, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766052293, 1766052293);
INSERT INTO `project_sections` VALUES (168, 13, 47, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766052396, 1766052396);
INSERT INTO `project_sections` VALUES (169, 13, 49, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766052595, 1766052595);
INSERT INTO `project_sections` VALUES (170, 13, 50, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766052651, 1766052651);
INSERT INTO `project_sections` VALUES (171, 13, 51, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766052849, 1766052849);
INSERT INTO `project_sections` VALUES (172, 13, 52, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766052893, 1766052893);
INSERT INTO `project_sections` VALUES (173, 13, 53, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766053033, 1766053033);
INSERT INTO `project_sections` VALUES (174, 13, 54, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766053161, 1766053161);
INSERT INTO `project_sections` VALUES (175, 13, 56, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766053383, 1766053383);
INSERT INTO `project_sections` VALUES (176, 11, 12, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766058187, 1766058187);
INSERT INTO `project_sections` VALUES (177, 11, 14, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766058317, 1766058317);
INSERT INTO `project_sections` VALUES (178, 11, 16, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766058429, 1766058429);
INSERT INTO `project_sections` VALUES (179, 11, 17, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766058497, 1766058497);
INSERT INTO `project_sections` VALUES (180, 11, 19, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766058569, 1766058569);
INSERT INTO `project_sections` VALUES (181, 11, 25, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766058706, 1766058706);
INSERT INTO `project_sections` VALUES (182, 11, 28, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766058940, 1766058940);
INSERT INTO `project_sections` VALUES (183, 11, 28, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059049, 1766059049);
INSERT INTO `project_sections` VALUES (184, 11, 25, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766059079, 1766059079);
INSERT INTO `project_sections` VALUES (185, 11, 26, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766059266, 1766059266);
INSERT INTO `project_sections` VALUES (186, 11, 28, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059323, 1766059323);
INSERT INTO `project_sections` VALUES (187, 11, 27, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059414, 1766059414);
INSERT INTO `project_sections` VALUES (188, 11, 32, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059509, 1766059509);
INSERT INTO `project_sections` VALUES (189, 11, 31, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766059646, 1766059646);
INSERT INTO `project_sections` VALUES (190, 11, 32, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059703, 1766059703);
INSERT INTO `project_sections` VALUES (191, 11, 33, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766059770, 1766059770);
INSERT INTO `project_sections` VALUES (192, 11, 35, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766059830, 1766059830);
INSERT INTO `project_sections` VALUES (193, 11, 36, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766060172, 1766060172);
INSERT INTO `project_sections` VALUES (194, 11, 22, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766060274, 1766060274);
INSERT INTO `project_sections` VALUES (195, 2, 296, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766069550, 1766069550);
INSERT INTO `project_sections` VALUES (196, 2, 306, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766070137, 1766070137);
INSERT INTO `project_sections` VALUES (197, 2, 301, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766070902, 1766070902);
INSERT INTO `project_sections` VALUES (198, 2, 266, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766071391, 1766071391);
INSERT INTO `project_sections` VALUES (199, 2, 254, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766071680, 1766071680);
INSERT INTO `project_sections` VALUES (200, 2, 249, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766071892, 1766071892);
INSERT INTO `project_sections` VALUES (201, 2, 267, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766072046, 1766072046);
INSERT INTO `project_sections` VALUES (202, 1, 239, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766136242, 1766136242);
INSERT INTO `project_sections` VALUES (203, 1, 282, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766136320, 1766136320);
INSERT INTO `project_sections` VALUES (204, 1, 294, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766136400, 1766136400);
INSERT INTO `project_sections` VALUES (205, 1, 214, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766136539, 1766136539);
INSERT INTO `project_sections` VALUES (206, 1, 226, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766138099, 1766138099);
INSERT INTO `project_sections` VALUES (207, 1, 230, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766138165, 1766138165);
INSERT INTO `project_sections` VALUES (208, 4, 185, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766139035, 1766139035);
INSERT INTO `project_sections` VALUES (209, 1, 300, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766141462, 1766141462);
INSERT INTO `project_sections` VALUES (210, 15, 114, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766142908, 1766142908);
INSERT INTO `project_sections` VALUES (211, 15, 117, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766143011, 1766143011);
INSERT INTO `project_sections` VALUES (212, 3, 153, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766394240, 1766394240);
INSERT INTO `project_sections` VALUES (213, 2, 306, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766395245, 1766395245);
INSERT INTO `project_sections` VALUES (214, 15, 115, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766396888, 1766396888);
INSERT INTO `project_sections` VALUES (215, 15, 116, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766396947, 1766396947);
INSERT INTO `project_sections` VALUES (216, 1, 237, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766406229, 1766406229);
INSERT INTO `project_sections` VALUES (217, 1, 221, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766406445, 1766406445);
INSERT INTO `project_sections` VALUES (218, 1, 277, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766406544, 1766406544);
INSERT INTO `project_sections` VALUES (219, 2, 257, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766480510, 1766480510);
INSERT INTO `project_sections` VALUES (220, 2, 258, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766480722, 1766480722);
INSERT INTO `project_sections` VALUES (221, 1, 277, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766481696, 1766481696);
INSERT INTO `project_sections` VALUES (222, 1, 285, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766481916, 1766481916);
INSERT INTO `project_sections` VALUES (223, 1, 290, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766482068, 1766482068);
INSERT INTO `project_sections` VALUES (224, 1, 291, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766482297, 1766482297);
INSERT INTO `project_sections` VALUES (225, 2, 251, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766483333, 1766483333);
INSERT INTO `project_sections` VALUES (226, 2, 252, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766483620, 1766483620);
INSERT INTO `project_sections` VALUES (227, 8, 125, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766483871, 1766483871);
INSERT INTO `project_sections` VALUES (228, 8, 129, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1766484026, 1766484026);
INSERT INTO `project_sections` VALUES (229, 8, 140, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1766484587, 1766484587);
INSERT INTO `project_sections` VALUES (230, 7, 87, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767870415, 1767870415);
INSERT INTO `project_sections` VALUES (231, 4, 199, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767870818, 1767870818);
INSERT INTO `project_sections` VALUES (232, 4, 200, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767870861, 1767870861);
INSERT INTO `project_sections` VALUES (233, 4, 194, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767871016, 1767871016);
INSERT INTO `project_sections` VALUES (234, 4, 197, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1767871091, 1767871091);
INSERT INTO `project_sections` VALUES (235, 6, 7, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1767884858, 1767884858);
INSERT INTO `project_sections` VALUES (236, 6, 13, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767885040, 1767885040);
INSERT INTO `project_sections` VALUES (237, 4, 191, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1767955928, 1767955928);
INSERT INTO `project_sections` VALUES (238, 4, 196, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1767956171, 1767956171);
INSERT INTO `project_sections` VALUES (239, 4, 190, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1767957244, 1767957244);
INSERT INTO `project_sections` VALUES (240, 6, 6, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768211299, 1768211299);
INSERT INTO `project_sections` VALUES (241, 14, 1, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768215439, 1768215439);
INSERT INTO `project_sections` VALUES (242, 14, 2, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768215548, 1768215548);
INSERT INTO `project_sections` VALUES (243, 14, 3, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768215846, 1768215846);
INSERT INTO `project_sections` VALUES (244, 14, 4, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768215967, 1768215967);
INSERT INTO `project_sections` VALUES (245, 13, 45, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768233919, 1768233919);
INSERT INTO `project_sections` VALUES (246, 9, 60, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768302892, 1768302892);
INSERT INTO `project_sections` VALUES (247, 4, 189, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768380774, 1768380774);
INSERT INTO `project_sections` VALUES (248, 2, 270, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768390852, 1768390852);
INSERT INTO `project_sections` VALUES (249, 2, 271, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768391376, 1768391376);
INSERT INTO `project_sections` VALUES (250, 1, 226, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768471006, 1768471006);
INSERT INTO `project_sections` VALUES (251, 1, 275, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768471216, 1768471216);
INSERT INTO `project_sections` VALUES (252, 1, 240, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768478407, 1768478407);
INSERT INTO `project_sections` VALUES (253, 2, 253, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768486920, 1768486920);
INSERT INTO `project_sections` VALUES (254, 3, 154, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768487683, 1768487683);
INSERT INTO `project_sections` VALUES (255, 3, 158, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768487850, 1768487850);
INSERT INTO `project_sections` VALUES (256, 15, 98, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768489459, 1768489459);
INSERT INTO `project_sections` VALUES (257, 15, 113, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768489583, 1768489583);
INSERT INTO `project_sections` VALUES (258, 11, 23, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768489937, 1768489937);
INSERT INTO `project_sections` VALUES (259, 11, 37, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768490133, 1768490133);
INSERT INTO `project_sections` VALUES (260, 11, 13, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768490293, 1768490293);
INSERT INTO `project_sections` VALUES (261, 11, 17, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768490596, 1768490596);
INSERT INTO `project_sections` VALUES (262, 11, 19, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768491394, 1768491394);
INSERT INTO `project_sections` VALUES (263, 13, 55, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768561871, 1768561871);
INSERT INTO `project_sections` VALUES (264, 1, 231, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768562148, 1768562148);
INSERT INTO `project_sections` VALUES (265, 1, 286, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768562514, 1768562514);
INSERT INTO `project_sections` VALUES (266, 1, 227, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768562770, 1768562770);
INSERT INTO `project_sections` VALUES (267, 1, 222, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768562819, 1768562819);
INSERT INTO `project_sections` VALUES (268, 1, 292, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768563562, 1768563562);
INSERT INTO `project_sections` VALUES (269, 11, 22, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768575133, 1768575133);
INSERT INTO `project_sections` VALUES (270, 9, 57, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768577544, 1768577544);
INSERT INTO `project_sections` VALUES (271, 1, 217, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768823221, 1768823221);
INSERT INTO `project_sections` VALUES (272, 2, 268, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768823648, 1768823648);
INSERT INTO `project_sections` VALUES (273, 6, 7, 'text_left_video_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768824249, 1768824249);
INSERT INTO `project_sections` VALUES (274, 11, 20, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768836869, 1768836869);
INSERT INTO `project_sections` VALUES (275, 2, 259, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768918508, 1768918508);
INSERT INTO `project_sections` VALUES (276, 6, 4, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768923467, 1768923467);
INSERT INTO `project_sections` VALUES (277, 13, 43, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768925730, 1768925730);
INSERT INTO `project_sections` VALUES (278, 13, 44, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768925834, 1768925834);
INSERT INTO `project_sections` VALUES (279, 13, 41, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1768925962, 1768925962);
INSERT INTO `project_sections` VALUES (280, 13, 42, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1768926128, 1768926128);
INSERT INTO `project_sections` VALUES (281, 1, 216, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769420662, 1769420662);
INSERT INTO `project_sections` VALUES (282, 1, 215, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769420743, 1769420743);
INSERT INTO `project_sections` VALUES (283, 1, 218, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769420805, 1769420805);
INSERT INTO `project_sections` VALUES (284, 4, 186, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769504622, 1769504622);
INSERT INTO `project_sections` VALUES (285, 11, 10, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769505833, 1769505833);
INSERT INTO `project_sections` VALUES (286, 11, 11, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769505945, 1769505945);
INSERT INTO `project_sections` VALUES (287, 8, 127, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769594914, 1769594914);
INSERT INTO `project_sections` VALUES (288, 8, 128, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769595034, 1769595034);
INSERT INTO `project_sections` VALUES (289, 8, 137, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769595481, 1769595481);
INSERT INTO `project_sections` VALUES (290, 8, 136, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769595554, 1769595554);
INSERT INTO `project_sections` VALUES (291, 8, 145, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769595803, 1769595803);
INSERT INTO `project_sections` VALUES (292, 8, 142, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769595898, 1769595898);
INSERT INTO `project_sections` VALUES (293, 8, 143, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769595961, 1769595961);
INSERT INTO `project_sections` VALUES (294, 3, 155, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769596217, 1769596217);
INSERT INTO `project_sections` VALUES (295, 2, 250, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769596521, 1769596521);
INSERT INTO `project_sections` VALUES (296, 1, 213, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769596909, 1769596909);
INSERT INTO `project_sections` VALUES (297, 7, 77, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769597393, 1769597393);
INSERT INTO `project_sections` VALUES (298, 13, 40, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769598094, 1769598094);
INSERT INTO `project_sections` VALUES (299, 15, 93, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769598309, 1769598309);
INSERT INTO `project_sections` VALUES (300, 9, 58, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769599593, 1769599593);
INSERT INTO `project_sections` VALUES (301, 3, 173, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769600829, 1769600829);
INSERT INTO `project_sections` VALUES (302, 15, 103, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769601348, 1769601348);
INSERT INTO `project_sections` VALUES (303, 3, 166, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769611158, 1769611158);
INSERT INTO `project_sections` VALUES (304, 9, 68, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769678691, 1769678691);
INSERT INTO `project_sections` VALUES (305, 9, 69, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769679068, 1769679068);
INSERT INTO `project_sections` VALUES (306, 9, 65, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769679288, 1769679288);
INSERT INTO `project_sections` VALUES (307, 8, 133, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769680688, 1769680688);
INSERT INTO `project_sections` VALUES (308, 15, 100, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769680822, 1769680822);
INSERT INTO `project_sections` VALUES (309, 15, 106, 'two_images', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769680891, 1769680891);
INSERT INTO `project_sections` VALUES (310, 15, 105, 'image_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769680938, 1769680938);
INSERT INTO `project_sections` VALUES (311, 2, 260, 'one_image', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769682723, 1769682723);
INSERT INTO `project_sections` VALUES (312, 2, 261, 'text_left_image_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769682792, 1769682792);
INSERT INTO `project_sections` VALUES (313, 15, 95, 'one_video', '{\"background\":\"#f6f6f6\"}', '{}', 0, 1769768915, 1769768915);
INSERT INTO `project_sections` VALUES (314, 15, 99, 'video_left_text_right', '{\"background\":\"#f6f6f6\"}', '{}', 1, 1769770445, 1769770445);

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_header` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `timecreated` int UNSIGNED NOT NULL,
  `timemodified` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shortname`(`shortname` ASC) USING BTREE,
  INDEX `idx_projects_visible`(`visible` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of projects
-- ----------------------------

-- ----------------------------
-- Table structure for proyects
-- ----------------------------
DROP TABLE IF EXISTS `proyects`;
CREATE TABLE `proyects`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `source_type` enum('image','video') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'image',
  `header_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cover_project_id` int UNSIGNED NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `timecreated` int NULL DEFAULT NULL,
  `timeupdated` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_proyects_cover`(`cover_project_id` ASC) USING BTREE,
  CONSTRAINT `fk_proyects_cover` FOREIGN KEY (`cover_project_id`) REFERENCES `proyects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of proyects
-- ----------------------------
INSERT INTO `proyects` VALUES (1, 'ENTRE MUROS', 'proyects/proyect-1.png', 'image', 'proyects/p-1/header.mp4', NULL, 1, NULL, 1768908223);
INSERT INTO `proyects` VALUES (2, 'SA CALMA', 'proyects/proyect-2.png', 'image', 'proyects/p-2/header.mp4', NULL, 1, NULL, 1768212696);
INSERT INTO `proyects` VALUES (3, 'LONGEVITY X', 'proyects/proyect-3.png', 'image', 'proyects/p-3/header.mp4', NULL, 1, NULL, 1769011467);
INSERT INTO `proyects` VALUES (4, 'ORTZIMUGA', 'proyects/proyect-4.mp4', 'video', 'proyects/p-4/header.mp4', NULL, 1, NULL, 1768297471);
INSERT INTO `proyects` VALUES (5, 'ENTRE MUROS', 'proyects/proyect-5.mp4', 'video', NULL, 1, 1, NULL, 1768899930);
INSERT INTO `proyects` VALUES (6, 'LA TEULADA', 'proyects/proyect-6.mp4', 'video', 'proyects/p-6/header.mp4', NULL, 1, NULL, 1768294390);
INSERT INTO `proyects` VALUES (7, 'ENBI', 'proyects/proyect-7.png', 'image', 'proyects/p-7/header.mp4', 7, 1, NULL, 1769158527);
INSERT INTO `proyects` VALUES (8, 'BIL 2', 'proyects/proyect-8.png', 'image', 'proyects/p-8/header.mp4', 8, 1, NULL, 1768919902);
INSERT INTO `proyects` VALUES (9, 'ARTZAINENEA', 'proyects/proyect-9.png', 'image', 'proyects/p-9/header.mp4', 9, 1, NULL, 1769180302);
INSERT INTO `proyects` VALUES (10, 'LONGEVITY X', 'proyects/proyect10.mp4', 'video', NULL, 3, 1, NULL, 1768920085);
INSERT INTO `proyects` VALUES (11, 'TOPAGUNE', 'proyects/proyect-11.png', 'image', 'proyects/p-11/header.mp4', 11, 1, NULL, 1768920188);
INSERT INTO `proyects` VALUES (12, 'ENTRE MUROS', 'proyects/proyect-12.png', 'image', NULL, 1, 1, NULL, 1768900494);
INSERT INTO `proyects` VALUES (13, 'SHELTER', 'proyects/proyect-13.png', 'image', 'proyects/p-13/header.mp4', 13, 1, NULL, 1768919270);
INSERT INTO `proyects` VALUES (14, 'SA CALMA', 'proyects/proyect-14.mp4', 'video', NULL, 2, 1, 1768213430, 1768900775);
INSERT INTO `proyects` VALUES (15, 'ITSAS HEGI', 'proyects/proyect-15.png', 'image', 'proyects/p-15/header.MP4', 15, 1, 1768213524, 1768921800);
INSERT INTO `proyects` VALUES (16, 'LONGEVITY X', 'proyects/proyect-16.png', 'image', NULL, 3, 1, 1768213771, 1768919621);
INSERT INTO `proyects` VALUES (17, 'ENTRE MUROS', 'proyects/proyect-17.mp4', 'video', NULL, 1, 1, 1768214088, 1768902053);
INSERT INTO `proyects` VALUES (18, 'ARTZAINENEA', 'proyects/proyect-18.png', 'image', NULL, 9, 1, 1768214968, 1768921863);
INSERT INTO `proyects` VALUES (19, 'ENBI', 'proyects/proyect-19.png', 'image', NULL, 7, 1, 1768217818, 1769439930);
INSERT INTO `proyects` VALUES (20, 'TOPAGUNE', 'proyects/proyect-20.png', 'image', NULL, 11, 1, 1768217935, 1769179935);
INSERT INTO `proyects` VALUES (21, 'BIL 2', 'proyects/proyect-21.png', 'image', NULL, 8, 1, 1768218077, 1768921953);
INSERT INTO `proyects` VALUES (22, 'SHELTER', 'proyects/proyect-22.png', 'image', NULL, 13, 1, 1768218296, 1768899281);
INSERT INTO `proyects` VALUES (23, 'ENTRE MUROS', 'proyects/proyect-23.png', 'image', NULL, 1, 1, 1768218420, 1768902803);
INSERT INTO `proyects` VALUES (24, 'ITSAS HEGI', 'proyects/proyect-24.mp4', 'video', NULL, 15, 1, 1768218548, 1768903057);
INSERT INTO `proyects` VALUES (25, 'ORTZIMUGA', 'proyects/proyect-25.png', 'image', NULL, 4, 1, 1768218650, 1768304020);
INSERT INTO `proyects` VALUES (26, 'SHELTER', 'proyects/proyect-26.mp4', 'video', NULL, 13, 1, 1768218971, 1768903152);
INSERT INTO `proyects` VALUES (27, 'ENTRE MUROS', 'proyects/proyect-27.png', 'image', NULL, 1, 1, 1768219115, 1768903247);
INSERT INTO `proyects` VALUES (28, 'ENBI', 'proyects/proyect-28.MP4', 'video', NULL, 7, 1, 1768219427, 1768903589);
INSERT INTO `proyects` VALUES (29, 'LONGEVITY X', 'proyects/proyect-29.png', 'image', NULL, 3, 1, 1768220202, 1768903513);
INSERT INTO `proyects` VALUES (30, 'BIL 2', 'proyects/proyect-30.png', 'image', NULL, 11, 1, 1768220693, 1768305728);
INSERT INTO `proyects` VALUES (31, 'ENTRE MUROS', 'proyects/proyect-31.mp4', 'video', NULL, 1, 1, 1768220970, 1768903638);
INSERT INTO `proyects` VALUES (32, 'ARTZAINENEA', 'proyects/proyect-32.png', 'image', NULL, 9, 1, 1768228765, 1768904270);
INSERT INTO `proyects` VALUES (33, 'SA CALMA', 'proyects/proyect-33.MP4', 'video', NULL, 2, 1, 1768230273, 1768904184);
INSERT INTO `proyects` VALUES (34, 'SA CALMA', 'proyects/proyect-34.mp4', 'video', NULL, 2, 1, 1768230649, 1768904428);
INSERT INTO `proyects` VALUES (35, 'ITSAS HEGI', 'proyects/proyect-35.png', 'image', NULL, 15, 1, 1768230755, 1768904340);
INSERT INTO `proyects` VALUES (36, 'SHELTER', 'proyects/proyect-36.png', 'image', NULL, 13, 1, 1768316048, 1768904539);
INSERT INTO `proyects` VALUES (37, 'TOPAGUNE', 'proyects/proyect-37.png', 'image', NULL, 9, 1, 1768316413, 1768316874);
INSERT INTO `proyects` VALUES (38, 'BIL 2', 'proyects/proyect-38.png', 'image', NULL, 11, 1, 1768316945, 1768905197);
INSERT INTO `proyects` VALUES (39, 'LONGEVITY X', 'proyects/proyect-39.png', 'image', NULL, 3, 1, 1768317052, 1768905589);
INSERT INTO `proyects` VALUES (40, 'TOPAGUNE', 'proyects/proyect-40.png', 'image', NULL, 11, 1, 1768317540, 1768905757);
INSERT INTO `proyects` VALUES (41, 'ORTZIMUGA', 'proyects/proyect-41.png', 'image', NULL, 4, 1, 1768318028, 1768905805);
INSERT INTO `proyects` VALUES (42, 'SA CALMA', 'proyects/proyect-42.png', 'image', NULL, 2, 1, 1768319115, 1768906378);
INSERT INTO `proyects` VALUES (43, 'ITSAS HEGI', 'proyects/proyect-43.png', 'image', NULL, 5, 1, 1768319787, 1768906630);
INSERT INTO `proyects` VALUES (44, 'BIL 2', 'proyects/proyect-44.png', 'image', NULL, 8, 1, 1768320004, 1768906236);
INSERT INTO `proyects` VALUES (45, 'SA CALMA', 'proyects/proyect-45.png', 'image', NULL, 2, 1, 1768322269, 1769179655);
INSERT INTO `proyects` VALUES (46, 'ENTRE MUROS', 'proyects/proyect-46.mp4', 'video', NULL, 1, 1, 1768322570, 1768906957);
INSERT INTO `proyects` VALUES (47, 'ARTZAINENEA', 'proyects/proyect-47.png', 'image', NULL, 9, 1, 1768381674, 1768907584);
INSERT INTO `proyects` VALUES (48, 'ITSAS HEGI', 'proyects/proyect-48.MP4', 'video', NULL, 15, 1, 1768382098, 1768907903);
INSERT INTO `proyects` VALUES (49, 'LONGEVITY X', 'proyects/proyect-49.png', 'image', NULL, 3, 1, 1768382164, 1769179717);
INSERT INTO `proyects` VALUES (50, 'SA CALMA', 'proyects/proyect-50.png', 'image', NULL, 2, 1, 1768383316, 1768909363);
INSERT INTO `proyects` VALUES (51, 'TOPAGUNE', 'proyects/proyect-51.png', 'image', NULL, 11, 1, 1768388379, 1768908704);
INSERT INTO `proyects` VALUES (52, 'ENBI', 'proyects/proyect-52.png', 'image', NULL, 7, 1, 1768405479, 1769440205);
INSERT INTO `proyects` VALUES (53, 'ITSAS HEGI', 'proyects/proyect-53.png', 'image', NULL, 15, 1, 1768469029, 1769179841);
INSERT INTO `proyects` VALUES (54, 'SA CALMA', 'proyects/proyect-54.mp4', 'video', NULL, 2, 1, 1768474784, 1768909619);
INSERT INTO `proyects` VALUES (55, 'ENTRE MUROS', 'proyects/proyect-55.mp4', 'video', NULL, 1, 1, 1768491063, 1768910056);
INSERT INTO `proyects` VALUES (56, 'TOPAUNE', 'proyects/proyect-56.mp4', 'video', NULL, 11, 1, 1768557378, 1768910298);
INSERT INTO `proyects` VALUES (57, 'BIL 2', 'proyects/proyect-57.png', 'image', NULL, 8, 1, 1768558617, 1768910799);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'manager', '$2y$10$PsWklhjYyrmkj9is54nqnOJWetb/vMVCSGYgeH3gZNKhCJlzZRElm', 'manager', '2025-12-19 21:28:52');

SET FOREIGN_KEY_CHECKS = 1;
