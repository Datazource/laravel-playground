/*
MySQL - 5.7.19 : Database - laravel_playground
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`laravel_playground` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `laravel_playground`;

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assets` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_type_id_foreign` (`type_id`),
  KEY `history_user_id_foreign` (`user_id`),
  CONSTRAINT `history_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `history_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `history_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `history` */

/*Table structure for table `history_types` */

DROP TABLE IF EXISTS `history_types`;

CREATE TABLE `history_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `history_types` */

insert  into `history_types`(`id`,`name`,`created_at`,`updated_at`) values (1,'User','2017-08-01 18:54:02','2017-08-01 18:54:02'),(2,'Role','2017-08-01 18:54:02','2017-08-01 18:54:02');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values (343,'2014_10_12_000000_create_users_table',1),(344,'2014_10_12_100000_create_password_resets_table',1),(345,'2015_12_28_171741_create_social_logins_table',1),(346,'2015_12_29_015055_setup_access_tables',1),(347,'2016_07_03_062439_create_history_tables',1),(348,'2017_04_04_131153_create_sessions_table',1);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `permission_role` */

DROP TABLE IF EXISTS `permission_role`;

CREATE TABLE `permission_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_role_permission_id_foreign` (`permission_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permission_role` */

insert  into `permission_role`(`id`,`permission_id`,`role_id`) values (1,1,2);

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permissions` */

insert  into `permissions`(`id`,`name`,`display_name`,`created_at`,`updated_at`) values (1,'view-backend','View Backend','2017-08-01 18:54:02','2017-08-01 18:54:02');

/*Table structure for table `role_user` */

DROP TABLE IF EXISTS `role_user`;

CREATE TABLE `role_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_user_id_foreign` (`user_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_user` */

insert  into `role_user`(`id`,`user_id`,`role_id`) values (1,1,1),(2,2,2),(3,3,3);

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `all` tinyint(1) NOT NULL DEFAULT '0',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`id`,`name`,`all`,`sort`,`created_at`,`updated_at`) values (1,'Administrator',1,1,'2017-08-01 18:54:02','2017-08-01 18:54:02'),(2,'Executive',0,2,'2017-08-01 18:54:02','2017-08-01 18:54:02'),(3,'User',0,3,'2017-08-01 18:54:02','2017-08-01 18:54:02'),(4,'Elisa Thompson',0,64,'2017-08-01 18:54:02','2017-08-01 18:54:02');

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sessions` */

insert  into `sessions`(`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) values ('vm1BvjcDGC4dynnDql6L1pp6Nxc5mBQRPtOX3lab',1,'127.0.0.1','Symfony/3.X','ZXlKcGRpSTZJalJpV200M2NWZ3dYQzl4VFZ3dk5qQkhjVXQ0U21wV1p6MDlJaXdpZG1Gc2RXVWlPaUpGZURsM1dEZHVkMjlsU1hZM0t6WkRSbGRjTDBnclFWTlVWakpHVFZWNVEycE1aRzFMYjFSUWFuSjZPRXd5VEcxWFNrVlNTWGt4UVc1cE4wOUVObmRvZEdsV04wTk9RVkYzUTNCTVVWVnRTRnB5TlVKc1ZHRkVOR3A2UWxCY0wxbzNUV3hEY1ZOcU4ydG1PSEZ3TVZVelYzSkxkRGxSTUdSY0wweGlSVWxJZDI5cVdtNVdkRTljTHpONlFUaEVNblZvVEhSRWRWaEJNM1IxU1V0VFRVeENTSE50WEM5NFVWYzBUVFZzY1Z3dmNFVTlJaXdpYldGaklqb2lPV1k0WW1Rek9HRTJNV1UwT0dRMU5UWmtPVGM1WkdGbU56WTJNV015TlRVM01ERTFPV1l5WVRsak1EUTBNbVJsTURZMU1tWTRNRE5qWldWaE5HSmpaU0o5',1501613642),('YsYi5QHYvyDcErNrf687ojDGsWzqCGKNdj8KlzWf',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.78 Safari/537.36','ZXlKcGRpSTZJbFZrZW0xbU4zbFlSbHBaYm1aamVtSlFjRzVPUTJjOVBTSXNJblpoYkhWbElqb2lUM1Z3V0RNMlZWQTVUekJPTm10TE1GUjZZVmRwYTJ4VlozVnVlRzV4ZGxVNVYzZGpSbGd6TmtGNU0yMDFWQ3RzVVVGQldIUjVZemxNYlRWc1hDOXJVMkpwWjNKSU5FdzFRbmRJY0V4MVJGVkJTWE5FV0hCaFpHUlFWWFoyZVdrMmJDczVObFJ2Um5OcFZGcFdibXRCVkRaWlJUaEpOMGcxZDNGRU0ya3hPRFJPWVdwRlRFZDRWWEJJWjBjeFNGRm1ha2N5V0d4S1ExUlBiVXBtYnpGVlRrbDNTelZUYzNaTWNFZEVaREI2TUZ3dlMyZzJjRnBoWmx3dlVIZHlXVVU0VlVKc1VEaEZSbWxyVTJaRWFUQlZWMWxaVmpGRVFrWXlUMlpLTkZ3dk5sd3ZlbWxEU0hVM2IyOTRORk16YkV0YWJXTmtXRlJoZG05VFoxWkVXRWt6VGt4dk1FOUNLMnhCTlcxVlkwWkZPWEJUWnpWS1prdHlkbWQzVTBSb2RuQjBlbVp5ZUVWRVVESktkMVZuUjB0R01EMGlMQ0p0WVdNaU9pSXpNV1l6WVdabU5qazVOemN5TVRVeU5UaGhOR1F6WWpBMU5UazFaRGRrTWpReU5qTXlOR1ZtTlRrME9UYzJOemRqTW1aall6WTRZbUUyWVdSaE5XWTNJbjA9',1501613827);

/*Table structure for table `social_logins` */

DROP TABLE IF EXISTS `social_logins`;

CREATE TABLE `social_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `provider` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `social_logins_user_id_foreign` (`user_id`),
  CONSTRAINT `social_logins_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `social_logins` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `confirmation_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`first_name`,`last_name`,`email`,`password`,`status`,`confirmation_code`,`confirmed`,`remember_token`,`created_at`,`updated_at`,`deleted_at`) values (1,'Admin','Istrator','admin@admin.com','$2y$10$CDkUIoKcrTsW2ytiHQUK2OLEiHeOqcof/cs9AnT3kRD1Zj8oIQYoG',1,'fa49b0c5fbb8906f1e654989a09b8d12',1,NULL,'2017-08-01 18:54:01','2017-08-01 18:54:01',NULL),(2,'Backend','User','executive@executive.com','$2y$10$TFKxe28awHfz9NjGYWAVQ.2l9vaJ4yK.I9.tyC7GPvgK/F6bqqknm',1,'e2f7ce2d5ba11cdb436d15e1f3582d7d',1,NULL,'2017-08-01 18:54:01','2017-08-01 18:54:01',NULL),(3,'Default','User','user@user.com','$2y$10$Mk47MMyC7nc1HDL0mh8aIey43wcXTB4os4xKFQjwSyoycccfeVjf.',1,'9d2d4832d284876d6aa773a8d5259ffd',1,NULL,'2017-08-01 18:54:02','2017-08-01 18:54:02',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
