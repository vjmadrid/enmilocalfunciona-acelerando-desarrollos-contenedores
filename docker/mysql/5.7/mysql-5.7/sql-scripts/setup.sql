-- Create acme data base
DROP DATABASE IF EXISTS `acme`;
CREATE DATABASE `acme` default character set utf8 collate utf8_general_ci;

USE `acme`;


-- Create tables
DROP TABLE IF EXISTS `custom_role`;
CREATE TABLE IF NOT EXISTS `custom_role`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(15) NOT NULL DEFAULT '',
    `created_at` datetime NULL DEFAULT NULL,
    `updated_at` datetime NULL DEFAULT NULL,
    `deleted_at` datetime NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `custom_user`;
CREATE TABLE IF NOT EXISTS `custom_user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(15) NOT NULL DEFAULT '',
    `role_id` INT(11) NOT NULL DEFAULT 0,
    `created_at` datetime NULL DEFAULT NULL,
    `updated_at` datetime NULL DEFAULT NULL,
    `deleted_at` datetime NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`role_id`)
    REFERENCES `custom_role` (`id`)
);

-- Insert data
INSERT INTO `custom_role` (`name`, `created_at`, `updated_at`, `deleted_at`) VALUES ('ADMIN', CURDATE(),null, null);
INSERT INTO `custom_role` (`name`, `created_at`, `updated_at`, `deleted_at`) VALUES ('OPERATOR', CURDATE(),null, null);
INSERT INTO `custom_role` (`name`, `created_at`, `updated_at`, `deleted_at`) VALUES ('VIEWER', CURDATE(),null, null);

INSERT INTO `custom_user` (`name`,  `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES ('admin', 1, CURDATE(),null, null);
INSERT INTO `custom_user` (`name`,  `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES ('opera1', 2, CURDATE(),null, null);
INSERT INTO `custom_user` (`name`,  `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES ('opera2', 2, CURDATE(),null, null);
INSERT INTO `custom_user` (`name`,  `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES ('viewer', 3, CURDATE(),null, null);
