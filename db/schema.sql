CREATE TABLE `administrator_roles`
(
  `id` SMALLINT(6) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(32) NOT NULL
);

CREATE TABLE `administrators`
(
  `id` SMALLINT(6) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `chat_id` VARCHAR(128) NOT NULL,
  `role_id` SMALLINT(6) UNSIGNED DEFAULT '1' NOT NULL,
  CONSTRAINT `administrators_ibfk_1`
  FOREIGN KEY (`role_id`) REFERENCES `administrator_roles` (`id`)
);

CREATE INDEX `role_id`
  ON `administrators` (`role_id`);

CREATE TABLE `customers`
(
  `id` INT(10) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `account` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  `chat_id` VARCHAR(128) NOT NULL,
  `registration_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT `chat_id`
  UNIQUE (`chat_id`)
);

CREATE INDEX `_client_chat_id`
  ON `customers` (`chat_id`);

CREATE TABLE `goods`
(
  `id` SMALLINT(6) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(128) NOT NULL,
  `price` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  `time_to_make` SMALLINT(6) DEFAULT '60' NOT NULL
);

CREATE TABLE `orders`
(
  `id` INT(10) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `customer_id` INT(10) UNSIGNED NOT NULL,
  `status_id` SMALLINT(6) UNSIGNED DEFAULT '0' NOT NULL,
  `creation_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `administrator_id` SMALLINT(6) UNSIGNED NOT NULL,
  `total` DOUBLE(10, 2) DEFAULT '0.00' NOT NULL,
  CONSTRAINT `orders_ibfk_1`
  FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
);

CREATE INDEX `customer_id`
  ON `orders` (`customer_id`);

CREATE INDEX `status_id`
  ON `orders` (`status_id`);

CREATE TABLE `orders_goods`
(
  `order_id` INT(10) UNSIGNED NOT NULL
    PRIMARY KEY,
  `good_id` SMALLINT(6) UNSIGNED NOT NULL,
  CONSTRAINT `orders_goods_ibfk_1`
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `orders_goods_ibfk_2`
  FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`)
);

CREATE INDEX `good_id`
  ON `orders_goods` (`good_id`);

CREATE TABLE `statuses`
(
  `id` SMALLINT(4) UNSIGNED AUTO_INCREMENT
    PRIMARY KEY,
  `name` VARCHAR(32) NOT NULL,
  `readiness` SMALLINT(3) DEFAULT '0' NOT NULL
);

ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2`
FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`);

