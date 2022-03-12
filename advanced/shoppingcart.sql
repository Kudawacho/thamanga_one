CREATE DATABASE IF NOT EXISTS `shoppingcart_advanced` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `shoppingcart_advanced`;

CREATE TABLE IF NOT EXISTS `accounts` (
`id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address_street` varchar(255) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_zip` varchar(50) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `accounts` (`id`, `email`, `password`, `first_name`, `last_name`, `address_street`, `address_city`, `address_state`, `address_zip`, `address_country`, `admin`) VALUES
(1, 'admin@codeshack.io', '$2y$10$pEHRAE4Ia0mE9BdLmbS.ueQsv/.WlTUSW7/cqF/T36iW.zDzSkx4y', 'John', 'Doe', '98 High Street', 'New York', 'NY', '10001', 'United States', 1);

CREATE TABLE IF NOT EXISTS `categories` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Sale'),
(2, 'Watches'),
(3, 'Accessories');

CREATE TABLE IF NOT EXISTS `products` (
`id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `rrp` decimal(7,2) NOT NULL DEFAULT '0.00',
  `quantity` int(11) NOT NULL,
  `img` text NOT NULL,
  `date_added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO `products` (`id`, `name`, `description`, `price`, `rrp`, `quantity`, `img`, `date_added`) VALUES
(1, 'Smart Watch', '<p>Unique watch made with stainless steel, ideal for those that prefer interative watches.</p>\r\n<h3>Features</h3>\r\n<ul>\r\n<li>Powered by Android with built-in apps.</li>\r\n<li>Adjustable to fit most.</li>\r\n<li>Long battery life, continuous wear for up to 2 days.</li>\r\n<li>Lightweight design, comfort on your wrist.</li>\r\n</ul>', '29.99', '0.00', 0, 'watch.jpg', '2020-03-13 17:55:22'),
(2, 'Wallet', '', '14.99', '19.99', -1, 'wallet.jpg', '2020-03-13 18:52:49'),
(3, 'Headphones', '', '19.99', '0.00', -1, 'headphones.jpg', '2020-03-13 18:47:56'),
(4, 'Digital Camera', '', '269.99', '0.00', 43773, 'camera.jpg', '2020-03-14 17:42:04');

CREATE TABLE IF NOT EXISTS `products_categories` (
`id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `products_categories` (`id`, `product_id`, `category_id`) VALUES
(4, 1, 1),
(2, 1, 2),
(1, 2, 1);

CREATE TABLE IF NOT EXISTS `products_images` (
`id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

INSERT INTO `products_images` (`id`, `product_id`, `img`) VALUES
(1, 1, 'watch-2.jpg'),
(2, 1, 'watch-3.jpg'),
(3, 1, 'watch.jpg'),
(4, 2, 'wallet.jpg'),
(5, 3, 'headphones.jpg'),
(6, 4, 'camera.jpg');

CREATE TABLE IF NOT EXISTS `products_options` (
`id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

INSERT INTO `products_options` (`id`, `title`, `name`, `price`, `product_id`) VALUES
(1, 'Color', 'Blue', '0.00', 2),
(2, 'Color', 'Red', '0.00', 2),
(3, 'Color', 'Black', '29.99', 1),
(4, 'Color', 'White', '32.99', 1),
(5, 'Color', 'Blue', '29.99', 1),
(6, 'Color', 'Black', '0.00', 2);

CREATE TABLE IF NOT EXISTS `shipping` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price_from` decimal(7,2) NOT NULL,
  `price_to` decimal(7,2) NOT NULL,
  `price` decimal(7,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `shipping` (`id`, `name`, `price_from`, `price_to`, `price`) VALUES
(1, 'Standard', '0.00', '49.99', '3.99'),
(2, 'Standard', '50.00', '999.00', '7.99'),
(3, 'International', '0.00', '49.99', '14.99'),
(4, 'International', '50.00', '999.00', '29.99');

CREATE TABLE IF NOT EXISTS `transactions` (
`id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `payment_amount` decimal(7,2) NOT NULL,
  `payment_status` varchar(30) NOT NULL,
  `created` datetime NOT NULL,
  `payer_email` varchar(255) NOT NULL DEFAULT '',
  `first_name` varchar(100) NOT NULL DEFAULT '',
  `last_name` varchar(100) NOT NULL DEFAULT '',
  `address_street` varchar(255) NOT NULL DEFAULT '',
  `address_city` varchar(100) NOT NULL DEFAULT '',
  `address_state` varchar(100) NOT NULL DEFAULT '',
  `address_zip` varchar(50) NOT NULL DEFAULT '',
  `address_country` varchar(100) NOT NULL DEFAULT '',
  `account_id` int(11) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'website'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `transactions_items` (
`id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_price` decimal(7,2) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `item_options` varchar(255) NOT NULL,
  `item_shipping_price` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `accounts`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `email` (`email`);

ALTER TABLE `categories`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `products`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `products_categories`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `product_id` (`product_id`,`category_id`);

ALTER TABLE `products_images`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `product_id` (`product_id`,`img`);

ALTER TABLE `products_options`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `shipping`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `transactions`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `txn_id` (`txn_id`);

ALTER TABLE `transactions_items`
 ADD PRIMARY KEY (`id`);


ALTER TABLE `accounts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
ALTER TABLE `categories`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
ALTER TABLE `products`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
ALTER TABLE `products_categories`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
ALTER TABLE `products_images`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
ALTER TABLE `products_options`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
ALTER TABLE `shipping`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
ALTER TABLE `transactions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `transactions_items`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
