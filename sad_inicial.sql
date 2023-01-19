-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for sad
CREATE DATABASE IF NOT EXISTS `sad` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `sad`;

-- Dumping structure for table sad.allergies
CREATE TABLE IF NOT EXISTS `allergies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table sad.allergies: ~3 rows (approximately)
INSERT INTO `allergies` (`id`, `name`) VALUES
	(1, 'Tomate'),
	(2, 'Ovo'),
	(3, 'Amendoim');

-- Dumping structure for table sad.allergies_meals
CREATE TABLE IF NOT EXISTS `allergies_meals` (
  `allergies_id` int(11) NOT NULL,
  `meals_id` int(11) NOT NULL,
  PRIMARY KEY (`allergies_id`,`meals_id`),
  KEY `FK__meals` (`meals_id`),
  CONSTRAINT `FK__allergies` FOREIGN KEY (`allergies_id`) REFERENCES `allergies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__meals` FOREIGN KEY (`meals_id`) REFERENCES `meals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.allergies_meals: ~0 rows (approximately)

-- Dumping structure for table sad.building
CREATE TABLE IF NOT EXISTS `building` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_building_location` (`location_id`),
  CONSTRAINT `FK_building_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.building: ~5 rows (approximately)
INSERT INTO `building` (`id`, `name`, `location_id`) VALUES
	(1, 'Bar', 2),
	(2, 'Cantina', 2),
	(3, 'Bar', 1),
	(9, 'Cantina', 1),
	(10, 'Bar2', 1);

-- Dumping structure for table sad.building_stock
CREATE TABLE IF NOT EXISTS `building_stock` (
  `building_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  PRIMARY KEY (`building_id`,`stock_id`),
  KEY `stock_id` (`stock_id`),
  CONSTRAINT `FK_building_stock_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_building_stock_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.building_stock: ~5 rows (approximately)
INSERT INTO `building_stock` (`building_id`, `stock_id`) VALUES
	(1, 2),
	(1, 3),
	(2, 2),
	(9, 4),
	(10, 5);

-- Dumping structure for table sad.employee
CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.employee: ~3 rows (approximately)
INSERT INTO `employee` (`id`, `name`) VALUES
	(1, 'Joao'),
	(2, 'Paulo'),
	(3, 'Maria');

-- Dumping structure for table sad.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.invoice: ~5 rows (approximately)
INSERT INTO `invoice` (`id`, `order_id`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5);

-- Dumping structure for table sad.location
CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.location: ~2 rows (approximately)
INSERT INTO `location` (`id`, `name`) VALUES
	(1, 'Braga'),
	(2, 'Barcelos');

-- Dumping structure for table sad.meals
CREATE TABLE IF NOT EXISTS `meals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.meals: ~5 rows (approximately)
INSERT INTO `meals` (`id`, `name`, `price`, `description`, `type`) VALUES
	(1, 'Prego', 4.99, '', NULL),
	(2, 'Bifes', 3.99, 'Bifinhos com cogumelos feito à portuguesa', 'Carne'),
	(3, 'Wrap', 2.5, 'Wrap feito à nossa maneira, utiliza molho da casa', 'Dieta'),
	(4, 'Batatas XL', 1.2, NULL, NULL),
	(5, 'Salada', 2.99, 'Salada vegan ?', 'Vegetariano');

-- Dumping structure for table sad.meals_stock
CREATE TABLE IF NOT EXISTS `meals_stock` (
  `meals_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  PRIMARY KEY (`meals_id`,`stock_id`),
  KEY `stock_id` (`stock_id`),
  CONSTRAINT `FK_meals_stock_meals` FOREIGN KEY (`meals_id`) REFERENCES `meals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_meals_stock_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.meals_stock: ~0 rows (approximately)

-- Dumping structure for table sad.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weekday_id` int(11) NOT NULL DEFAULT 0,
  `building_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_menu_week_day` (`weekday_id`),
  KEY `FK_menu_building` (`building_id`),
  CONSTRAINT `FK_menu_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_menu_week_day` FOREIGN KEY (`weekday_id`) REFERENCES `week_day` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table sad.menu: ~25 rows (approximately)
INSERT INTO `menu` (`id`, `weekday_id`, `building_id`) VALUES
	(2, 5, 1),
	(3, 2, 2),
	(4, 3, 2),
	(5, 4, 2),
	(6, 5, 2),
	(7, 1, 2),
	(8, 3, 9),
	(9, 1, 1),
	(10, 1, 3),
	(11, 1, 9),
	(12, 1, 10),
	(13, 2, 1),
	(14, 2, 3),
	(15, 2, 9),
	(16, 2, 10),
	(17, 3, 1),
	(18, 3, 3),
	(19, 3, 10),
	(20, 4, 1),
	(21, 4, 3),
	(22, 4, 9),
	(23, 4, 10),
	(24, 5, 3),
	(25, 5, 9),
	(26, 5, 10);

-- Dumping structure for table sad.menu_meals
CREATE TABLE IF NOT EXISTS `menu_meals` (
  `meals_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`meals_id`,`menu_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `FK_meals_menu_meals` FOREIGN KEY (`meals_id`) REFERENCES `meals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_meals_menu_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.menu_meals: ~75 rows (approximately)
INSERT INTO `menu_meals` (`meals_id`, `menu_id`) VALUES
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 15),
	(2, 16),
	(2, 17),
	(2, 18),
	(2, 19),
	(2, 20),
	(2, 21),
	(2, 22),
	(2, 23),
	(2, 24),
	(2, 25),
	(2, 26),
	(3, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(3, 7),
	(3, 8),
	(3, 9),
	(3, 10),
	(3, 11),
	(3, 12),
	(3, 13),
	(3, 14),
	(3, 15),
	(3, 16),
	(3, 17),
	(3, 18),
	(3, 19),
	(3, 20),
	(3, 21),
	(3, 22),
	(3, 23),
	(3, 24),
	(3, 25),
	(3, 26),
	(5, 2),
	(5, 3),
	(5, 4),
	(5, 5),
	(5, 6),
	(5, 7),
	(5, 8),
	(5, 9),
	(5, 10),
	(5, 11),
	(5, 12),
	(5, 13),
	(5, 14),
	(5, 15),
	(5, 16),
	(5, 17),
	(5, 18),
	(5, 19),
	(5, 20),
	(5, 21),
	(5, 22),
	(5, 23),
	(5, 24),
	(5, 25),
	(5, 26);

-- Dumping structure for table sad.order
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `date_order` date NOT NULL,
  `date_delivery` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_menu` (`menu_id`),
  KEY `FK_order_user` (`user_id`),
  CONSTRAINT `FK_order_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.order: ~7 rows (approximately)
INSERT INTO `order` (`id`, `menu_id`, `user_id`, `date_order`, `date_delivery`) VALUES
	(1, 2, 1, '2022-12-22', '2022-12-28'),
	(2, 2, 2, '2022-12-28', '2022-12-28'),
	(3, 2, 3, '2022-12-25', '2022-12-28'),
	(4, 5, 4, '2022-12-27', '2022-12-28'),
	(5, 6, 3, '2022-12-29', '2022-12-29'),
	(6, 8, 4, '2022-12-28', '2022-12-28'),
	(9, 7, 6, '2023-01-19', '2023-01-20');

-- Dumping structure for table sad.receipt
CREATE TABLE IF NOT EXISTS `receipt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `employee_id` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_receipt_invoice` (`invoice_id`),
  KEY `FK_receipt_employee` (`employee_id`),
  CONSTRAINT `FK_receipt_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_receipt_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.receipt: ~5 rows (approximately)
INSERT INTO `receipt` (`id`, `invoice_id`, `employee_id`, `date`) VALUES
	(2, 1, 1, '2022-12-28'),
	(3, 2, 3, '2022-12-28'),
	(5, 3, 3, '2022-12-28'),
	(6, 4, 3, '2022-12-28'),
	(7, 5, 1, '2022-12-28');

-- Dumping structure for table sad.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.stock: ~5 rows (approximately)
INSERT INTO `stock` (`id`, `name`) VALUES
	(1, 'Tomate'),
	(2, 'Cenoura'),
	(3, 'Batata(1KG)'),
	(4, 'Leite(1L)'),
	(5, 'Manteiga de Amendoim');

-- Dumping structure for table sad.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pin` int(4) NOT NULL,
  `nif` int(9) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.user: ~5 rows (approximately)
INSERT INTO `user` (`id`, `name`, `email`, `pin`, `nif`) VALUES
	(1, 'Joao', 'joao@gmail.com', 1111, NULL),
	(2, 'Maria', 'maria@gmail.com', 1111, NULL),
	(3, 'Pedro', 'pedro@gmail.com', 1111, NULL),
	(4, 'Diana', 'diana@gmail.com', 1111, NULL),
	(6, 'Nicolae Malai', 'cutthisname@hotmail.com', 1111, 0);

-- Dumping structure for table sad.user_allergies
CREATE TABLE IF NOT EXISTS `user_allergies` (
  `user_id` int(11) NOT NULL,
  `allergies_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`allergies_id`) USING BTREE,
  KEY `allergies_id` (`allergies_id`) USING BTREE,
  CONSTRAINT `allergies_id` FOREIGN KEY (`allergies_id`) REFERENCES `allergies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.user_allergies: ~5 rows (approximately)
INSERT INTO `user_allergies` (`user_id`, `allergies_id`) VALUES
	(1, 3),
	(2, 2),
	(3, 1),
	(4, 2),
	(4, 3);

-- Dumping structure for table sad.week_day
CREATE TABLE IF NOT EXISTS `week_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table sad.week_day: ~5 rows (approximately)
INSERT INTO `week_day` (`id`, `name`) VALUES
	(1, 'Segunda'),
	(2, 'Terca'),
	(3, 'Quarta'),
	(4, 'Quinta'),
	(5, 'Sexta');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
