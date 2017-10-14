SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `customers`;
DROP TABLE IF EXISTS `administrators`;
DROP TABLE IF EXISTS `administrator_roles`;
DROP TABLE IF EXISTS `goods`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `orders_goods`;
DROP TABLE IF EXISTS `statuses`;
SET foreign_key_checks = 1;

CREATE TABLE `administrator_roles`
(
  `id` SMALLINT(6) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(32) NOT NULL
)
  ENGINE InnoDB;

CREATE TABLE `administrators`
(
  `id` SMALLINT(6) UNSIGNED NOT NULL AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `chat_id` VARCHAR(128) NOT NULL,
  `role_id` SMALLINT(6) UNSIGNED DEFAULT '1' NOT NULL,
  FOREIGN KEY (`role_id`) REFERENCES `administrator_roles` (`id`)
)
  ENGINE InnoDB;

CREATE TABLE `customers`
(
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `account` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  `chat_id` VARCHAR(128) UNIQUE NOT NULL,
  `registration_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  KEY `_client_chat_id` (`chat_id`)
)
  ENGINE InnoDB;


CREATE TABLE `goods`
(
  `id` SMALLINT(6) UNSIGNED NOT NULL AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `price` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  `time_to_make` SMALLINT(6) DEFAULT '60' NOT NULL
)
  ENGINE InnoDB;

CREATE TABLE `statuses`
(
  `id` SMALLINT(4) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(32) NOT NULL,
  `readiness` SMALLINT(3) DEFAULT '0' NOT NULL
)
  ENGINE InnoDB;

CREATE TABLE `orders`
(
  `id` INT UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `customer_id`  INT UNSIGNED NOT NULL,
  `status_id` SMALLINT(6) UNSIGNED NOT NULL DEFAULT 0,
  `creation_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `administrator_id` SMALLINT(6) UNSIGNED NOT NULL REFERENCES `administrators`(`id`),
  `total` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`)
)
  ENGINE InnoDB;

CREATE TABLE `orders_goods`
(
  `order_id` INT UNSIGNED NOT NULL PRIMARY KEY,
  `good_id` SMALLINT(6) UNSIGNED NOT NULL,
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`)

)
  ENGINE InnoDB;