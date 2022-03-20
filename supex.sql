/*
 Navicat MySQL Data Transfer

 Source Server         : Supex
 Source Server Type    : MySQL
 Source Server Version : 100421
 Source Host           : localhost:3306
 Source Schema         : supex

 Target Server Type    : MySQL
 Target Server Version : 100421
 File Encoding         : 65001

 Date: 28/02/2022 02:24:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answers
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_id` bigint UNSIGNED NOT NULL,
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `isCorrect` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `answers_question_id_foreign`(`question_id` ASC) USING BTREE,
  CONSTRAINT `answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answers
-- ----------------------------
INSERT INTO `answers` VALUES (1, 1, 'ngOnInit', 'Call when component inits.', 0, '2022-02-27 14:20:01', '2022-02-27 14:20:01');
INSERT INTO `answers` VALUES (2, 1, 'ngOnChange', 'Call when component state has changed.', 0, '2022-02-27 14:20:01', '2022-02-27 14:20:01');
INSERT INTO `answers` VALUES (3, 1, 'ngAfterViewInit', 'Call when component view init.', 0, '2022-02-27 14:20:01', '2022-02-27 14:20:01');
INSERT INTO `answers` VALUES (4, 1, 'ngOnDestroy', 'Call when component destroys', 0, '2022-02-27 14:20:01', '2022-02-27 14:20:01');
INSERT INTO `answers` VALUES (5, 1, 'componentDidUpdate', 'Call when component updated.', 0, '2022-02-27 14:20:01', '2022-02-27 14:20:01');
INSERT INTO `answers` VALUES (6, 2, 'imports', 'import modules', 1, '2022-02-27 14:21:45', '2022-02-27 14:21:45');
INSERT INTO `answers` VALUES (7, 2, 'exports', 'export comonents of current module', 1, '2022-02-27 14:21:46', '2022-02-27 14:21:46');
INSERT INTO `answers` VALUES (8, 2, 'declarations', 'declaration of components', 1, '2022-02-27 14:21:46', '2022-02-27 14:21:46');
INSERT INTO `answers` VALUES (9, 2, 'providers', 'List of services that will be used in this module.', 1, '2022-02-27 14:21:46', '2022-02-27 14:21:46');
INSERT INTO `answers` VALUES (10, 2, 'services', 'Injectables', 0, '2022-02-27 14:21:46', '2022-02-27 14:21:46');
INSERT INTO `answers` VALUES (11, 3, 'Two way binding.', 'Using ngModel', 1, '2022-02-27 14:24:07', '2022-02-27 14:24:07');
INSERT INTO `answers` VALUES (12, 3, 'Show/Hide', 'Using display:block and display:none', 0, '2022-02-27 14:24:07', '2022-02-27 14:24:07');
INSERT INTO `answers` VALUES (13, 3, 'decorate', 'same as annotation', 0, '2022-02-27 14:24:07', '2022-02-27 14:24:07');
INSERT INTO `answers` VALUES (14, 3, 'pipe', 'transformation feature', 1, '2022-02-27 14:24:07', '2022-02-27 14:24:07');
INSERT INTO `answers` VALUES (15, 3, 'service', 'injectable', 0, '2022-02-27 14:24:07', '2022-02-27 14:24:07');
INSERT INTO `answers` VALUES (16, 4, 'component-based framework', 'Angular is a completely revived component-based framework in which an application is a tree of individual components', 1, '2022-02-27 14:27:20', '2022-02-27 14:27:20');
INSERT INTO `answers` VALUES (17, 4, 'architecture', 'AngularJS is based on MSV and Angualr is based on Service/Controller.', 1, '2022-02-27 14:27:20', '2022-02-27 14:27:20');
INSERT INTO `answers` VALUES (18, 4, 'Language', 'AngularJs uses Javascript and Angular uses Typescript.', 1, '2022-02-27 14:27:20', '2022-02-27 14:27:20');
INSERT INTO `answers` VALUES (19, 4, 'mobile friendly', 'For AngularJS no, but for angular yes.', 1, '2022-02-27 14:27:20', '2022-02-27 14:27:20');
INSERT INTO `answers` VALUES (20, 4, 'SEO', 'Difficulty in Angular but easy in AngularJS.', 0, '2022-02-27 14:27:20', '2022-02-27 14:27:20');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, NULL, 'Javascript', NULL, NULL);
INSERT INTO `categories` VALUES (2, NULL, 'PHP', NULL, NULL);
INSERT INTO `categories` VALUES (3, 1, 'React.js', NULL, NULL);
INSERT INTO `categories` VALUES (4, 1, 'Angular 2+', NULL, NULL);
INSERT INTO `categories` VALUES (5, 1, 'Angular.js', NULL, NULL);
INSERT INTO `categories` VALUES (6, 1, 'Vue.js', NULL, NULL);
INSERT INTO `categories` VALUES (7, 2, 'Laravel', NULL, NULL);
INSERT INTO `categories` VALUES (8, 2, 'WordPress', NULL, NULL);
INSERT INTO `categories` VALUES (9, 2, 'CodeIgnitor', NULL, NULL);
INSERT INTO `categories` VALUES (10, 2, 'Magento', NULL, NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (5, '2022_02_23_140347_create_categories_table', 1);
INSERT INTO `migrations` VALUES (6, '2022_02_23_141151_create_questions_table', 1);
INSERT INTO `migrations` VALUES (7, '2022_02_23_141152_create_answers_table', 1);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint UNSIGNED NOT NULL,
  `subcategory_id` bigint UNSIGNED NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `completed` binary(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `questions_category_id_foreign`(`category_id` ASC) USING BTREE,
  INDEX `questions_subcategory_id_foreign`(`subcategory_id` ASC) USING BTREE,
  CONSTRAINT `questions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `questions_subcategory_id_foreign` FOREIGN KEY (`subcategory_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES (1, 1, 4, 'Select correct Angular Lifecycle functions.', 'S', '2022-02-27 14:20:01', '2022-02-27 14:20:01', 0x30);
INSERT INTO `questions` VALUES (2, 1, 4, 'Select correct properties of NgModule.', 'S', '2022-02-27 14:21:45', '2022-02-27 14:21:45', 0x30);
INSERT INTO `questions` VALUES (3, 1, 4, 'Select correct features of Angular', 'S', '2022-02-27 14:24:07', '2022-02-27 14:24:07', 0x30);
INSERT INTO `questions` VALUES (4, 1, 4, 'What is the difference between AngularJS and Angular?', 'S', '2022-02-27 14:27:20', '2022-02-27 14:27:20', 0x30);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
