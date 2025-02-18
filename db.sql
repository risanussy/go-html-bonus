-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
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

-- Dumping structure for table order_bonus_api.criterions
CREATE TABLE IF NOT EXISTS `criterions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` longtext,
  `description` longtext,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_criterions_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table order_bonus_api.criterions: ~0 rows (approximately)

-- Dumping structure for table order_bonus_api.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` longtext,
  `email` varchar(191) DEFAULT NULL,
  `password` longtext,
  `role` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_employees_email` (`email`),
  KEY `idx_employees_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table order_bonus_api.employees: ~1 rows (approximately)
INSERT INTO `employees` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `email`, `password`, `role`) VALUES
	(1, '2025-02-17 20:21:45.000', '2025-02-17 20:21:47.000', NULL, 'admin', 'admin@admin.com', '$2y$12$OiNxaQx1qcy9d9isFyykGeGa7QcSxfGWqMDqt64aOrpS4eFAM7S96', 'admin');

-- Dumping structure for table order_bonus_api.evaluations
CREATE TABLE IF NOT EXISTS `evaluations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `employee_id` bigint unsigned DEFAULT NULL,
  `criterion_id` bigint unsigned DEFAULT NULL,
  `score` double DEFAULT NULL,
  `comments` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_evaluations_deleted_at` (`deleted_at`),
  KEY `fk_evaluations_employee` (`employee_id`),
  KEY `fk_evaluations_criterion` (`criterion_id`),
  CONSTRAINT `fk_evaluations_criterion` FOREIGN KEY (`criterion_id`) REFERENCES `criterions` (`id`),
  CONSTRAINT `fk_evaluations_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table order_bonus_api.evaluations: ~0 rows (approximately)

-- Dumping structure for table order_bonus_api.kpis
CREATE TABLE IF NOT EXISTS `kpis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `title` longtext,
  `description` longtext,
  `score` double DEFAULT NULL,
  `validated` tinyint(1) DEFAULT NULL,
  `employee_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_kpis_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table order_bonus_api.kpis: ~1 rows (approximately)
INSERT INTO `kpis` (`id`, `created_at`, `updated_at`, `deleted_at`, `title`, `description`, `score`, `validated`, `employee_id`) VALUES
	(1, '2025-02-18 22:33:17.496', '2025-02-18 22:33:17.496', NULL, 'qwe', 'Kategori: Individu, Bobot: 123%, Target: 100000, Skala: poor 123, fair 123, good 31, outstanding 123, exceptional 123', 0, 0, 0);

-- Dumping structure for table order_bonus_api.kpi_evaluations
CREATE TABLE IF NOT EXISTS `kpi_evaluations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `employee_id` bigint unsigned DEFAULT NULL,
  `kpi_id` bigint unsigned DEFAULT NULL,
  `achievement` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_kpi_evaluations_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table order_bonus_api.kpi_evaluations: ~1 rows (approximately)
INSERT INTO `kpi_evaluations` (`id`, `created_at`, `updated_at`, `deleted_at`, `employee_id`, `kpi_id`, `achievement`) VALUES
	(1, '2025-02-18 22:49:41.474', '2025-02-18 22:49:41.474', NULL, 1, 1, '12');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
