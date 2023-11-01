-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2023 at 12:11 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hk`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `employer_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `appointment_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `client_name` text NOT NULL,
  `client_email` text DEFAULT NULL,
  `client_phone` text NOT NULL,
  `client_notes` text DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `client_name`, `client_email`, `client_phone`, `client_notes`, `userId`, `updated_at`, `created_at`) VALUES
(24, 'abdulrahman', 'test@gmail.com', '0666666666', NULL, 20, '2023-10-23 05:35:07', '2023-10-19 20:06:44');

-- --------------------------------------------------------

--
-- Table structure for table `contents`
--

CREATE TABLE `contents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `sort` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contents`
--

INSERT INTO `contents` (`id`, `project_id`, `title`, `description`, `type`, `foto`, `sort`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'test', 'test', 'Text', NULL, NULL, '2023-05-11 12:25:21', '2023-05-11 12:14:45', '2023-05-11 12:25:21'),
(2, 1, 'tset', 'tsert', 'Text', NULL, NULL, '2023-05-11 12:25:21', '2023-05-11 12:14:56', '2023-05-11 12:25:21'),
(6, 3, 'test', 'test', 'Text', NULL, NULL, '2023-05-17 03:10:15', '2023-05-11 18:13:21', '2023-05-17 03:10:15'),
(7, 3, 'test', 'tesy', 'Text', NULL, NULL, '2023-05-17 03:10:15', '2023-05-11 18:13:51', '2023-05-17 03:10:15'),
(25, 4, 'test', 'tset', 'Text', NULL, NULL, '2023-05-17 03:10:13', '2023-05-17 03:10:05', '2023-05-17 03:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `employers`
--

CREATE TABLE `employers` (
  `employer_id` int(11) NOT NULL,
  `belong_to` int(11) NOT NULL,
  `mark` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employers`
--

INSERT INTO `employers` (`employer_id`, `belong_to`, `mark`, `user_id`, `updated_at`, `created_at`) VALUES
(18, 20, NULL, 70, '2023-09-25 06:38:47', '2023-09-25 06:38:47'),
(19, 20, NULL, 73, '2023-10-06 04:03:51', '2023-10-06 04:03:51'),
(22, 20, NULL, 76, '2023-10-06 07:04:12', '2023-10-06 07:04:12'),
(23, 20, NULL, 78, '2023-10-14 16:21:54', '2023-10-14 16:21:54'),
(24, 20, NULL, 79, '2023-10-16 10:03:13', '2023-10-16 10:03:13'),
(26, 20, NULL, 81, '2023-10-16 10:06:42', '2023-10-16 10:06:42'),
(28, 20, NULL, 84, '2023-10-20 10:34:27', '2023-10-20 10:34:27'),
(29, 20, NULL, 87, '2023-10-24 06:02:54', '2023-10-24 06:02:54'),
(30, 20, NULL, 88, '2023-10-24 06:25:54', '2023-10-24 06:25:54'),
(31, 20, NULL, 90, '2023-10-24 09:35:32', '2023-10-24 09:35:32'),
(32, 20, NULL, 91, '2023-10-24 10:22:17', '2023-10-24 10:22:17'),
(36, 99, NULL, 100, '2023-10-29 16:25:26', '2023-10-29 16:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `employer_schedules`
--

CREATE TABLE `employer_schedules` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `days_times` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employer_schedules`
--

INSERT INTO `employer_schedules` (`id`, `userId`, `days_times`) VALUES
(1, 20, 'a:2:{i:0;a:4:{s:2:\"id\";i:6;s:5:\"label\";s:8:\"Saturday\";s:11:\"openingTime\";s:5:\"14:00\";s:11:\"closingTime\";s:5:\"22:00\";}i:1;a:4:{s:2:\"id\";i:7;s:5:\"label\";s:6:\"Sunday\";s:11:\"openingTime\";s:5:\"12:00\";s:11:\"closingTime\";s:5:\"15:00\";}}'),
(2, 86, 'a:1:{i:0;a:4:{s:2:\"id\";i:1;s:5:\"label\";s:6:\"Monday\";s:11:\"openingTime\";s:5:\"12:00\";s:11:\"closingTime\";s:5:\"16:00\";}}');

-- --------------------------------------------------------

--
-- Table structure for table `employer_services`
--

CREATE TABLE `employer_services` (
  `employer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `dateFrom` varchar(255) DEFAULT NULL,
  `dateTo` varchar(255) DEFAULT NULL,
  `timeFrom` varchar(255) DEFAULT NULL,
  `timeTo` varchar(255) DEFAULT NULL,
  `color` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `userId`, `title`, `description`, `dateFrom`, `dateTo`, `timeFrom`, `timeTo`, `color`, `created_at`, `updated_at`) VALUES
(37, 20, 'طبيب اسنان', NULL, '2023-06-13', NULL, '08:30', '09:30', NULL, '2023-05-23 15:30:00', '2023-06-10 08:35:38'),
(46, 32, 'test', NULL, '2023-05-28', NULL, NULL, NULL, NULL, '2023-05-27 14:56:10', '2023-05-27 14:56:10'),
(47, 20, 'موعد تسليم مخطط المشروع', NULL, '2023-06-15', NULL, '09:30', '11:00', NULL, '2023-06-01 14:21:03', '2023-06-10 01:59:25'),
(79, 20, 'test', NULL, '2023-06-05', NULL, NULL, NULL, NULL, '2023-06-11 00:08:04', '2023-06-11 00:08:04'),
(80, 20, 'wayyo', NULL, '2023-05-28', NULL, NULL, NULL, NULL, '2023-06-11 00:08:24', '2023-06-11 00:08:24'),
(101, 20, 'rwar', NULL, '2023-07-04', NULL, NULL, NULL, NULL, '2023-07-07 00:04:41', '2023-07-13 06:40:30'),
(104, 20, 'trdt', NULL, '2023-07-03', NULL, NULL, NULL, NULL, '2023-07-08 04:35:11', '2023-07-13 06:40:29'),
(105, 20, 'rtst', NULL, '2023-07-24', NULL, NULL, NULL, NULL, '2023-07-08 04:35:17', '2023-07-13 06:16:47'),
(106, 20, 'tt', NULL, '2023-07-26', NULL, NULL, NULL, NULL, '2023-07-08 04:47:18', '2023-07-13 06:16:50'),
(107, 20, 'test', NULL, '2023-06-29', NULL, NULL, NULL, NULL, '2023-07-09 01:09:38', '2023-07-13 06:08:17'),
(116, 20, 'test', NULL, '2023-07-01', NULL, NULL, NULL, NULL, '2023-07-12 01:51:32', '2023-07-13 06:40:35'),
(120, 20, 'test', NULL, '2023-07-05', NULL, NULL, NULL, NULL, '2023-07-13 06:07:43', '2023-07-13 06:40:27'),
(121, 20, 'test', NULL, '2023-06-28', NULL, NULL, NULL, NULL, '2023-07-13 06:08:52', '2023-07-13 06:08:52'),
(122, 20, 'test', NULL, '2023-06-27', NULL, NULL, NULL, NULL, '2023-07-13 06:08:58', '2023-07-13 06:08:58'),
(123, 20, 'ccc', NULL, '2023-07-27', NULL, '11:00', '12:00', NULL, '2023-07-13 06:42:32', '2023-07-28 18:50:26'),
(132, 20, 'Ali hiarcut', NULL, '2023-09-27', NULL, '13:00', '14:00', NULL, '2023-09-15 19:30:32', '2023-09-21 12:39:53'),
(134, 20, 'from belonged user', NULL, '2023-09-17', NULL, NULL, NULL, NULL, '2023-09-17 00:33:00', '2023-09-25 09:38:07'),
(137, 51, 'user', NULL, '2023-09-19', NULL, NULL, NULL, NULL, '2023-09-18 22:12:27', '2023-09-18 22:12:27'),
(138, 51, 'user.user', NULL, '2023-09-20', NULL, NULL, NULL, NULL, '2023-09-18 22:16:45', '2023-09-18 22:16:45'),
(139, 20, 'new dialog yayt', NULL, '2023-11-01', '2023-11-02', NULL, NULL, '#ff0000', '2023-10-03 21:20:04', '2023-10-26 09:53:12'),
(143, 20, 'test time', NULL, '2023-10-19', NULL, '12:00', '16:00', 'null', '2023-10-03 22:24:35', '2023-10-18 12:38:30'),
(146, 20, 'tset from jfro', NULL, '2023-10-02', NULL, NULL, NULL, '#ff1900', '2023-10-06 07:15:54', '2023-10-19 20:00:42'),
(147, 20, 'good', NULL, '2023-11-08', NULL, NULL, NULL, 'null', '2023-10-06 07:16:21', '2023-10-26 09:53:06'),
(148, 20, 'satamxq', NULL, '2023-10-26', NULL, NULL, NULL, '#ff0095', '2023-10-06 19:13:09', '2023-10-25 06:19:09'),
(149, 20, 'naar doctor', NULL, '2023-10-13', NULL, '12:00', '13:00', 'null', '2023-10-08 22:56:46', '2023-10-19 19:59:30'),
(150, 20, 'yay', NULL, '2023-11-03', NULL, NULL, NULL, 'null', '2023-10-18 11:40:02', '2023-10-26 09:53:11'),
(151, 20, 'اجتماع', NULL, '2023-10-10', NULL, '12:00', '14:15', 'null', '2023-10-19 19:59:09', '2023-10-19 19:59:53'),
(153, 77, 'test', NULL, '2023-10-26', NULL, NULL, NULL, 'null', '2023-10-23 05:54:14', '2023-10-23 05:54:16');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_04_09_023730_create_projects_table', 1),
(6, '2023_04_11_232123_create_events_table', 1),
(7, '2023_04_16_193715_create_contents_table', 1),
(8, '2023_05_14_030703_create_settings_table', 2),
(9, '2023_05_20_155905_create_skills_table', 3),
(10, '2023_05_26_130919_add_subscription_end_date_to_users', 4),
(11, '2023_05_26_131625_role', 5),
(12, '2023_05_26_170918_create_notifications_table', 6),
(13, '2023_05_27_145645_user_id_to_settings', 7),
(14, '2023_06_02_170805_last_login_ip_to_users', 8),
(15, '2023_06_09_220733_scheduled_tasks', 9),
(16, '2023_06_23_221557_send_reminders', 10),
(17, '2023_07_10_014306_agree_privacy_policy', 11),
(20, '2023_07_28_210937_subscription_table', 12),
(21, '2023_07_29_213938_create_user_relations_table', 13),
(22, '2023_07_29_224734_create_permission_tables', 13),
(23, '2023_10_03_014430_create_notes_table', 14),
(24, '2023_10_20_085649_create_orders_table', 15);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(52, 'App\\Models\\User', 77),
(52, 'App\\Models\\User', 87),
(53, 'App\\Models\\User', 77),
(53, 'App\\Models\\User', 86),
(53, 'App\\Models\\User', 87),
(53, 'App\\Models\\User', 89),
(53, 'App\\Models\\User', 91),
(55, 'App\\Models\\User', 87),
(55, 'App\\Models\\User', 99),
(55, 'App\\Models\\User', 100),
(55, 'App\\Models\\User', 101),
(56, 'App\\Models\\User', 87),
(56, 'App\\Models\\User', 99),
(56, 'App\\Models\\User', 100),
(56, 'App\\Models\\User', 101),
(57, 'App\\Models\\User', 87),
(57, 'App\\Models\\User', 90),
(57, 'App\\Models\\User', 101),
(58, 'App\\Models\\User', 87),
(58, 'App\\Models\\User', 91),
(59, 'App\\Models\\User', 87),
(59, 'App\\Models\\User', 91),
(60, 'App\\Models\\User', 87),
(60, 'App\\Models\\User', 91),
(61, 'App\\Models\\User', 87),
(61, 'App\\Models\\User', 91),
(62, 'App\\Models\\User', 87),
(63, 'App\\Models\\User', 87),
(64, 'App\\Models\\User', 87),
(65, 'App\\Models\\User', 87),
(66, 'App\\Models\\User', 86),
(66, 'App\\Models\\User', 87),
(67, 'App\\Models\\User', 87),
(68, 'App\\Models\\User', 86),
(68, 'App\\Models\\User', 87),
(68, 'App\\Models\\User', 90),
(69, 'App\\Models\\User', 86),
(69, 'App\\Models\\User', 87),
(69, 'App\\Models\\User', 90),
(70, 'App\\Models\\User', 86),
(70, 'App\\Models\\User', 87),
(70, 'App\\Models\\User', 90),
(71, 'App\\Models\\User', 87),
(72, 'App\\Models\\User', 77),
(72, 'App\\Models\\User', 87),
(72, 'App\\Models\\User', 91);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(6, 'App\\Models\\User', 20),
(6, 'App\\Models\\User', 99),
(10, 'App\\Models\\User', 42),
(10, 'App\\Models\\User', 43),
(15, 'App\\Models\\User', 48),
(15, 'App\\Models\\User', 85),
(15, 'App\\Models\\User', 88),
(15, 'App\\Models\\User', 90),
(16, 'App\\Models\\User', 51),
(16, 'App\\Models\\User', 74),
(16, 'App\\Models\\User', 77),
(28, 'App\\Models\\User', 83);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `notes` varchar(10000) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sendedBy` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `userId`, `title`, `message`, `sendedBy`, `created_at`, `updated_at`) VALUES
(15, 32, 'test', 'test', 20, NULL, NULL),
(16, 39, 'System', 'Your subscription will expire in 2023 Jul 04.', 20, '2023-06-04 01:37:40', '2023-06-04 01:37:40'),
(19, 32, 'System', 'Your subscription will expire in 2023-06-27.', 20, '2023-06-09 10:16:16', '2023-06-09 10:16:16'),
(22, 32, 'System', 'Your subscription will expire in 2023-06-27.', 20, '2023-06-09 10:16:41', '2023-06-09 10:16:41'),
(27, 32, 'System', 'Your subscription will expire in 2023-06-27.', 20, '2023-06-09 10:19:33', '2023-06-09 10:19:33'),
(33, 32, 'System', 'Your subscription will expire in 2023-06-27.', 20, '2023-06-09 10:19:47', '2023-06-09 10:19:47'),
(40, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 20:53:21', '2023-06-09 20:53:21'),
(44, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:00:36', '2023-06-09 21:00:36'),
(45, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:00:36', '2023-06-09 21:00:36'),
(46, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-09 21:00:36', '2023-06-09 21:00:36'),
(47, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:00:36', '2023-06-09 21:00:36'),
(50, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:01:57', '2023-06-09 21:01:57'),
(51, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:01:57', '2023-06-09 21:01:57'),
(52, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-09 21:01:57', '2023-06-09 21:01:57'),
(53, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:01:57', '2023-06-09 21:01:57'),
(54, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:02:30', '2023-06-09 21:02:30'),
(55, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:05:00', '2023-06-09 21:05:00'),
(56, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:05:05', '2023-06-09 21:05:05'),
(59, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:05:24', '2023-06-09 21:05:24'),
(60, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-09 21:05:24', '2023-06-09 21:05:24'),
(61, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-09 21:05:24', '2023-06-09 21:05:24'),
(62, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-09 21:05:24', '2023-06-09 21:05:24'),
(63, 40, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:09', '2023-06-24 20:05:09'),
(65, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:09', '2023-06-24 20:05:09'),
(66, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-24 20:05:09', '2023-06-24 20:05:09'),
(67, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-24 20:05:09', '2023-06-24 20:05:09'),
(68, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:09', '2023-06-24 20:05:09'),
(69, 40, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:32', '2023-06-24 20:05:32'),
(71, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:32', '2023-06-24 20:05:32'),
(72, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-24 20:05:32', '2023-06-24 20:05:32'),
(73, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-24 20:05:32', '2023-06-24 20:05:32'),
(74, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-24 20:05:32', '2023-06-24 20:05:32'),
(75, 40, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-25 15:21:51', '2023-06-25 15:21:51'),
(77, 38, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-25 15:21:51', '2023-06-25 15:21:51'),
(78, 22, 'System', 'Your subscription will expire on .', 20, '2023-06-25 15:21:51', '2023-06-25 15:21:51'),
(79, 32, 'System', 'Your subscription will expire on 2023-06-27.', 20, '2023-06-25 15:21:51', '2023-06-25 15:21:51'),
(80, 39, 'System', 'Your subscription will expire on 2023-07-09.', 20, '2023-06-25 15:21:51', '2023-06-25 15:21:51'),
(81, 41, 'System', 'Your subscription will expire in 2023 Aug 12.', 20, '2023-07-12 01:14:24', '2023-07-12 01:14:24'),
(82, 43, 'System', 'Your subscription will expire in 2023 Sep 18.', 20, '2023-08-18 00:25:23', '2023-08-18 00:25:23'),
(83, 50, 'System', 'Your subscription will expire in 2023 Oct 17.', 20, '2023-09-17 11:52:19', '2023-09-17 11:52:19'),
(84, 51, 'System', 'Your subscription will expire in 2023 Oct 18.', 20, '2023-09-18 21:28:40', '2023-09-18 21:28:40'),
(85, 63, 'System', 'Your subscription will expire in 2023 Oct 20.', 20, '2023-09-20 03:30:34', '2023-09-20 03:30:34'),
(86, 64, 'System', 'Your subscription will expire in 2023 Oct 20.', 20, '2023-09-20 03:32:18', '2023-09-20 03:32:18'),
(87, 65, 'System', 'Your subscription will expire in 2023 Oct 20.', 20, '2023-09-20 03:32:35', '2023-09-20 03:32:35'),
(88, 71, 'System', 'Your subscription will expire in 2023 Nov 04.', 20, '2023-10-04 00:42:03', '2023-10-04 00:42:03'),
(89, 72, 'System', 'Your subscription will expire in 2023 Nov 06.', 20, '2023-10-06 03:47:34', '2023-10-06 03:47:34'),
(90, 77, 'System', 'Your subscription will expire in 2023 Nov 06.', 20, '2023-10-06 19:25:47', '2023-10-06 19:25:47'),
(91, 83, 'System', 'Your subscription will expire in 2023 Nov 19.', 20, '2023-10-19 20:15:16', '2023-10-19 20:15:16'),
(92, 85, 'System', 'Your subscription will expire in 2023 Nov 23.', 20, '2023-10-23 06:12:08', '2023-10-23 06:12:08'),
(93, 86, 'System', 'Your subscription will expire in 2023 Nov 23.', 20, '2023-10-23 06:28:52', '2023-10-23 06:28:52'),
(94, 89, 'System', 'Your subscription will expire in 2023 Nov 24.', 20, '2023-10-24 09:33:45', '2023-10-24 09:33:45'),
(95, 95, 'System', 'Your subscription will expire in 2023 Nov 25.', 20, '2023-10-25 07:00:50', '2023-10-25 07:00:50'),
(96, 99, 'System', 'Your subscription will expire in 2023 Nov 29.', 20, '2023-10-29 14:12:04', '2023-10-29 14:12:04'),
(97, 101, 'System', 'Your subscription will expire in 2023 Nov 29.', 20, '2023-10-29 21:07:55', '2023-10-29 21:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `service_id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `status` enum('open','failed','paid') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('jfroosama10@gmail.com', '$2y$10$gOEHzT.ZhGBoBb80d1x/UuXr6tegAyAIIYZhwhEMzHlhMFwdhLDNy', '2023-10-20 12:56:58');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(29, 'role-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(30, 'role-create', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(31, 'role-edit', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(32, 'role-delete', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(33, 'user-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(34, 'user-create', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(35, 'user-edit', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(36, 'user-delete', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(37, 'event-calendar', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(38, 'event-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(39, 'event-create', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(40, 'event-edit', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(41, 'event-delete', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(42, 'project-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(43, 'project-create', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(44, 'project-edit', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(45, 'project-api', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(46, 'content-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(47, 'content-create', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(48, 'content-edit', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(49, 'content-delete', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(50, 'trash-list', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(51, 'trash-restore', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(52, 'trash-force-delete', 'web', '2023-08-17 00:14:51', '2023-08-17 00:14:51'),
(53, 'send-reminders', 'web', NULL, NULL),
(55, 'schedule-list', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(56, 'schedule-edit', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(57, 'frame', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(58, 'client-list', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(59, 'client-create', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(60, 'client-edit', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(61, 'client-delete', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(62, 'employer-list', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(63, 'employer-create', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(64, 'employer-edit', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(65, 'employer-delete', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(66, 'employer-set-schedule', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(67, 'project-delete', 'web', '2023-10-06 03:36:35', '2023-10-06 03:36:35'),
(68, 'note-list', 'web', '2023-10-06 06:50:52', '2023-10-06 06:50:52'),
(69, 'note-create', 'web', '2023-10-06 06:50:52', '2023-10-06 06:50:52'),
(70, 'note-delete', 'web', '2023-10-06 06:50:52', '2023-10-06 06:50:52'),
(71, 'role-access-all', 'web', '2023-10-23 05:44:21', '2023-10-23 05:44:21'),
(72, 'UI-edit', 'web', '2023-10-23 05:44:21', '2023-10-23 05:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `slug` varchar(500) NOT NULL,
  `sourceUrl` varchar(400) DEFAULT NULL,
  `demoUrl` varchar(400) DEFAULT NULL,
  `deleted_at` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `userId`, `title`, `description`, `path`, `type`, `slug`, `sourceUrl`, `demoUrl`, `deleted_at`, `created_at`, `updated_at`) VALUES
(12, 32, 'account mangment', 'testing', '/img/cases/system2.webp', NULL, 'account-mangment', NULL, NULL, NULL, '2023-05-27 16:11:37', '2023-05-27 16:11:37'),
(13, 38, 'test', 'test', '/img/cases/system2.webp', NULL, 'test', NULL, NULL, NULL, '2023-05-27 19:38:47', '2023-05-27 19:38:47'),
(16, 43, 'test', 'trrt', '/img/cases/2.jpg', NULL, 'test', NULL, NULL, NULL, '2023-08-18 03:41:43', '2023-08-18 03:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `sort` text DEFAULT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `userId`, `name`, `sort`, `guard_name`, `created_at`, `updated_at`) VALUES
(6, 20, 'Founder', NULL, 'web', '2023-08-17 00:17:35', '2023-08-17 00:17:35'),
(10, 20, 'User', NULL, 'web', '2023-08-18 00:36:25', '2023-08-21 01:30:44'),
(15, 20, 'barber', NULL, 'web', '2023-09-17 00:18:01', '2023-09-17 00:18:01'),
(16, 20, 'client', NULL, 'web', '2023-09-18 21:29:49', '2023-09-18 21:29:49'),
(28, 20, 'laex', NULL, 'web', '2023-10-19 20:24:40', '2023-10-19 20:24:40');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(29, 6),
(29, 16),
(29, 28),
(30, 6),
(30, 16),
(30, 28),
(31, 6),
(31, 16),
(31, 28),
(32, 6),
(32, 16),
(32, 28),
(33, 6),
(34, 6),
(35, 6),
(36, 6),
(37, 6),
(37, 15),
(37, 16),
(37, 28),
(38, 6),
(38, 15),
(38, 16),
(38, 28),
(39, 6),
(39, 15),
(39, 16),
(39, 28),
(40, 6),
(40, 15),
(40, 16),
(40, 28),
(41, 6),
(41, 15),
(41, 16),
(41, 28),
(43, 6),
(44, 6),
(45, 6),
(50, 6),
(51, 6),
(52, 6),
(53, 6),
(53, 15),
(55, 6),
(56, 6),
(57, 6),
(58, 6),
(58, 28),
(59, 6),
(59, 10),
(59, 28),
(60, 6),
(60, 28),
(61, 6),
(61, 28),
(62, 6),
(62, 28),
(63, 6),
(63, 28),
(64, 6),
(64, 28),
(65, 6),
(65, 28),
(66, 6),
(67, 6),
(68, 6),
(68, 28),
(69, 6),
(69, 28),
(70, 6),
(70, 28),
(71, 6),
(72, 6);

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_tasks`
--

CREATE TABLE `scheduled_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `days_times` varchar(7000) DEFAULT NULL,
  `interval` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scheduled_tasks`
--

INSERT INTO `scheduled_tasks` (`id`, `userId`, `days_times`, `interval`, `created_at`, `updated_at`) VALUES
(2, 20, 'a:5:{i:0;a:4:{s:2:\"id\";i:0;s:5:\"label\";s:6:\"Sunday\";s:11:\"openingTime\";s:5:\"10:00\";s:11:\"closingTime\";s:5:\"17:00\";}i:1;a:4:{s:2:\"id\";i:1;s:5:\"label\";s:6:\"Monday\";s:11:\"openingTime\";s:5:\"12:00\";s:11:\"closingTime\";s:5:\"18:00\";}i:2;a:4:{s:2:\"id\";i:2;s:5:\"label\";s:7:\"Tuesday\";s:11:\"openingTime\";s:5:\"15:00\";s:11:\"closingTime\";s:5:\"20:00\";}i:3;a:4:{s:2:\"id\";i:5;s:5:\"label\";s:6:\"Friday\";s:11:\"openingTime\";s:5:\"12:00\";s:11:\"closingTime\";s:5:\"18:00\";}i:4;a:4:{s:2:\"id\";i:6;s:5:\"label\";s:8:\"Saturday\";s:11:\"openingTime\";s:5:\"10:00\";s:11:\"closingTime\";s:5:\"20:00\";}}', 30, NULL, NULL),
(33, 99, 'a:3:{i:0;a:4:{s:2:\"id\";i:0;s:5:\"label\";s:6:\"Sunday\";s:11:\"openingTime\";s:5:\"10:00\";s:11:\"closingTime\";s:5:\"16:00\";}i:1;a:4:{s:2:\"id\";i:1;s:5:\"label\";s:6:\"Monday\";s:11:\"openingTime\";s:5:\"10:00\";s:11:\"closingTime\";s:5:\"23:00\";}i:2;a:4:{s:2:\"id\";i:2;s:5:\"label\";s:7:\"Tuesday\";s:11:\"openingTime\";N;s:11:\"closingTime\";N;}}', 30, '2023-10-29 14:12:04', '2023-10-29 14:12:04'),
(34, 100, NULL, NULL, '2023-10-29 16:25:26', '2023-10-29 16:25:26'),
(35, 101, 'a:2:{i:0;a:4:{s:2:\"id\";i:0;s:5:\"label\";s:6:\"Sunday\";s:11:\"openingTime\";s:5:\"12:00\";s:11:\"closingTime\";s:5:\"19:00\";}i:1;a:4:{s:2:\"id\";i:1;s:5:\"label\";s:6:\"Monday\";s:11:\"openingTime\";s:5:\"13:00\";s:11:\"closingTime\";s:5:\"00:00\";}}', 30, '2023-10-29 21:07:55', '2023-10-29 21:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `name` text NOT NULL,
  `price` int(11) NOT NULL,
  `duration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `userId`, `name`, `price`, `duration`) VALUES
(1, 20, 'Haircut', 60, NULL),
(2, 20, 'Trim beard', 30, NULL),
(3, 99, 'Haircut', 32, NULL),
(4, 99, 'Trim Beard', 22, NULL),
(5, 99, 'Oil Shave', 72, NULL),
(6, 99, 'ray', 90, 50),
(7, 101, 'HiarCut', 30, 30),
(8, 101, 'Trim beard', 100, NULL),
(9, 101, 'Hot shave towel', 81, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `api_token` varchar(255) NOT NULL,
  `sendRemainders` tinyint(1) DEFAULT NULL,
  `sendBefore` text DEFAULT NULL,
  `sendAt` time DEFAULT NULL,
  `frame_token` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `api_token`, `sendRemainders`, `sendBefore`, `sendAt`, `frame_token`, `created_at`, `updated_at`, `userId`) VALUES
(1, 'HenKRnOk4q9gTR$i5AbE', 0, '3', '07:30:00', 'U1QvHbd8rgE4KUXge7CEP8TWk5uwEdLKaOeTbeIsQ83ZnjSrUXFL3nlkdsfB8payI', NULL, '2023-10-20 12:29:12', 20),
(3, '5mv1SnfcbSKjxpMoxCV1', NULL, NULL, NULL, NULL, '2023-05-27 13:04:48', '2023-05-27 13:04:48', 32),
(26, 'oK1CMjp5vcV1xSxbnSmf', NULL, NULL, NULL, NULL, '2023-10-24 10:22:17', '2023-10-24 10:22:17', 91),
(27, 'vxKMC5fb1xjcmnoV1SSp', NULL, NULL, NULL, 'SXjBgcdgYdEbQHNbwz8Y3Ld5TJAjNUyJU82EhVzh9yqnkvAOthyHa6QaTJB4', '2023-10-25 07:00:50', '2023-10-25 07:00:50', 95),
(28, 'Sfp1oxnCmcM1j5vVbKxS', NULL, NULL, NULL, NULL, '2023-10-25 10:24:08', '2023-10-25 10:24:08', 96),
(29, '5VpjSSnx1Cmf1bcMoKxv', NULL, NULL, NULL, NULL, '2023-10-26 09:13:21', '2023-10-26 09:13:21', 97),
(30, 'CSKxxjM5Vv1bnfm1cSpo', NULL, NULL, NULL, NULL, '2023-10-27 21:40:13', '2023-10-27 21:40:13', 98),
(31, '5xSfvS1cVpCxom1bjnMK', NULL, NULL, NULL, '6IxyGB8KP28tryAso5IxXjdvTkGNCVOFZlH9nNtOBeifvi2DEdLxWsKWgCXy', '2023-10-29 14:12:04', '2023-10-29 14:12:04', 99),
(32, '5SMxcbmKvnCp1o1jSxfV', NULL, NULL, NULL, NULL, '2023-10-29 16:25:26', '2023-10-29 16:25:26', 100),
(33, 'v1KofSS5xp1mxjVnbcCM', NULL, NULL, NULL, 'U1QvHbd8rgE4KUXge7CEP8TWk5uwEdLKaOeTbeIsQ83ZnjSrUXFL3pB8payI', '2023-10-29 21:07:55', '2023-10-29 21:07:55', 101);

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `userId`, `name`, `created_at`, `updated_at`) VALUES
(36, 20, 'PHP', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(37, 20, 'MYSQL', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(38, 20, 'LARAVEL', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(39, 20, 'VUE JS', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(40, 20, 'INERTIA', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(41, 20, 'JAVASCRIPT', '2023-06-06 17:12:05', '2023-06-06 17:12:05'),
(42, 20, 'NODE JS', '2023-06-06 17:12:05', '2023-06-06 17:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `method` varchar(255) NOT NULL,
  `package_type` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `status` enum('paid','open','pending','failed') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `avatar` varchar(333) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `mark` int(11) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscription_end_date` date DEFAULT NULL,
  `lang` text DEFAULT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `job`, `city`, `address`, `description`, `avatar`, `email_verified_at`, `password`, `mark`, `remember_token`, `created_at`, `updated_at`, `subscription_end_date`, `lang`, `last_login_ip`) VALUES
(20, 'Jaafar Osamah', 'jfroosama10@gmail.com', 'software engineer', 'Netherland', 'Groningen', 'goood', '/img/avatar/JK.jpeg', '2023-10-23 05:24:37', '$2a$12$HaPkwZu.ANedITbO948k8Ou2ugmDe6f8Mx6ishwRoNZrN6YgWQNAi', 0, 'yqJXDCS6vmJJN1OIVIg92lWu1hEc2IcivrWwA5LvsryzoaZMxSkTLhSO6gac', '2023-05-25 13:04:48', '2023-10-29 16:26:10', '2030-10-18', 'english', '127.0.0.1'),
(101, 'jfro', 'jfro@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$mcHNdLUZYfpTIOvmf4Xhve0nc44vEM2hHielTeA3Wg7.dYXMy6qO.', NULL, NULL, '2023-10-29 21:07:55', '2023-10-29 21:07:55', '2023-11-29', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `appointments_fk0` (`client_id`),
  ADD KEY `appointments_fk1` (`employer_id`),
  ADD KEY `appointments_fk2` (`service_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `contents`
--
ALTER TABLE `contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employers`
--
ALTER TABLE `employers`
  ADD PRIMARY KEY (`employer_id`);

--
-- Indexes for table `employer_schedules`
--
ALTER TABLE `employer_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employer_services`
--
ALTER TABLE `employer_services`
  ADD KEY `employer_services_fk0` (`employer_id`),
  ADD KEY `employer_services_fk1` (`service_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `scheduled_tasks`
--
ALTER TABLE `scheduled_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `idx_users_id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `contents`
--
ALTER TABLE `contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `employers`
--
ALTER TABLE `employers`
  MODIFY `employer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `employer_schedules`
--
ALTER TABLE `employer_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `scheduled_tasks`
--
ALTER TABLE `scheduled_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_fk0` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `appointments_fk1` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`employer_id`),
  ADD CONSTRAINT `appointments_fk2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `employer_services`
--
ALTER TABLE `employer_services`
  ADD CONSTRAINT `employer_services_fk0` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`employer_id`),
  ADD CONSTRAINT `employer_services_fk1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
