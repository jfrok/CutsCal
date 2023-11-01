-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2023 at 04:07 AM
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
(25, 4, 'test', 'tset', 'Text', NULL, NULL, '2023-05-17 03:10:13', '2023-05-17 03:10:05', '2023-05-17 03:10:13'),
(62, 15, 'test', 'tset', 'Text', NULL, '1', NULL, '2023-08-26 20:05:08', '2023-09-25 06:43:29'),
(63, 15, 'test', 'test', 'Text', NULL, '5', NULL, '2023-08-26 20:05:19', '2023-09-25 06:43:25'),
(64, 15, 'test3', 'test3', 'Text', NULL, '0', NULL, '2023-08-26 20:05:30', '2023-09-25 06:43:25'),
(69, 15, NULL, NULL, 'Foto', 'p7.jpg', '2', NULL, '2023-08-30 18:54:30', '2023-09-25 06:43:29'),
(70, 15, NULL, NULL, 'Foto', 'p8.jpg', '3', NULL, '2023-08-30 18:54:30', '2023-09-25 06:43:29'),
(71, 15, NULL, NULL, 'Foto', 'p9.jpg', '4', NULL, '2023-08-30 18:54:30', '2023-09-25 06:43:29');

-- --------------------------------------------------------

--
-- Table structure for table `employers`
--

CREATE TABLE `employers` (
  `employer_id` int(11) NOT NULL,
  `belong_to` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employers`
--

INSERT INTO `employers` (`employer_id`, `belong_to`, `user_id`, `updated_at`, `created_at`) VALUES
(18, 20, 70, '2023-09-25 06:38:47', '2023-09-25 06:38:47');

-- --------------------------------------------------------

--
-- Table structure for table `employer_schedules`
--

CREATE TABLE `employer_schedules` (
  `schedule_id` int(11) NOT NULL,
  `employer_id` int(11) NOT NULL,
  `day_of_week` text NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `dateFrom` varchar(255) DEFAULT NULL,
  `dateTo` varchar(255) DEFAULT NULL,
  `timeFrom` varchar(255) DEFAULT NULL,
  `timeTo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `userId`, `title`, `dateFrom`, `dateTo`, `timeFrom`, `timeTo`, `created_at`, `updated_at`) VALUES
(37, 20, 'طبيب اسنان', '2023-06-13', NULL, '08:30', '09:30', '2023-05-23 15:30:00', '2023-06-10 08:35:38'),
(46, 32, 'test', '2023-05-28', NULL, NULL, NULL, '2023-05-27 14:56:10', '2023-05-27 14:56:10'),
(47, 20, 'موعد تسليم مخطط المشروع', '2023-06-15', NULL, '09:30', '11:00', '2023-06-01 14:21:03', '2023-06-10 01:59:25'),
(79, 20, 'test', '2023-06-05', NULL, NULL, NULL, '2023-06-11 00:08:04', '2023-06-11 00:08:04'),
(80, 20, 'wayyo', '2023-05-28', NULL, NULL, NULL, '2023-06-11 00:08:24', '2023-06-11 00:08:24'),
(99, 20, 'tt', '2024-02-13', NULL, NULL, NULL, '2023-07-06 20:42:57', '2023-07-06 20:42:57'),
(101, 20, 'rwar', '2023-07-04', NULL, NULL, NULL, '2023-07-07 00:04:41', '2023-07-13 06:40:30'),
(104, 20, 'trdt', '2023-07-03', NULL, NULL, NULL, '2023-07-08 04:35:11', '2023-07-13 06:40:29'),
(105, 20, 'rtst', '2023-07-24', NULL, NULL, NULL, '2023-07-08 04:35:17', '2023-07-13 06:16:47'),
(106, 20, 'tt', '2023-07-26', NULL, NULL, NULL, '2023-07-08 04:47:18', '2023-07-13 06:16:50'),
(107, 20, 'test', '2023-06-29', NULL, NULL, NULL, '2023-07-09 01:09:38', '2023-07-13 06:08:17'),
(108, 20, 'test', '2023-09-04', NULL, NULL, NULL, '2023-07-09 02:17:21', '2023-09-02 22:10:03'),
(109, 20, 'test', '2023-09-20', NULL, NULL, NULL, '2023-07-09 02:17:25', '2023-09-14 11:37:27'),
(111, 20, 'etst', '2023-09-30', NULL, NULL, NULL, '2023-07-09 02:17:33', '2023-07-09 02:17:33'),
(112, 20, 'test', '2023-10-06', NULL, NULL, NULL, '2023-07-09 02:17:36', '2023-07-09 02:17:36'),
(113, 20, 'test', '2023-09-06', NULL, NULL, NULL, '2023-07-09 02:20:06', '2023-09-03 18:07:03'),
(114, 20, 'test', '2023-09-01', NULL, NULL, NULL, '2023-07-09 02:20:10', '2023-09-03 16:46:42'),
(115, 20, 'test', '2023-09-01', NULL, NULL, NULL, '2023-07-12 01:51:05', '2023-09-03 16:46:20'),
(116, 20, 'test', '2023-07-01', NULL, NULL, NULL, '2023-07-12 01:51:32', '2023-07-13 06:40:35'),
(120, 20, 'test', '2023-07-05', NULL, NULL, NULL, '2023-07-13 06:07:43', '2023-07-13 06:40:27'),
(121, 20, 'test', '2023-06-28', NULL, NULL, NULL, '2023-07-13 06:08:52', '2023-07-13 06:08:52'),
(122, 20, 'test', '2023-06-27', NULL, NULL, NULL, '2023-07-13 06:08:58', '2023-07-13 06:08:58'),
(123, 20, 'ccc', '2023-07-27', NULL, '11:00', '12:00', '2023-07-13 06:42:32', '2023-07-28 18:50:26'),
(131, 20, 'test', '2023-08-26', NULL, NULL, NULL, '2023-08-12 13:29:32', '2023-08-12 13:29:32'),
(132, 20, 'Ali hiarcut', '2023-09-27', NULL, '13:00', '14:00', '2023-09-15 19:30:32', '2023-09-21 12:39:53'),
(134, 20, 'from belonged user', '2023-09-17', NULL, NULL, NULL, '2023-09-17 00:33:00', '2023-09-25 09:38:07'),
(136, 20, 'yayeet', '2023-09-17', NULL, NULL, NULL, '2023-09-17 00:57:52', '2023-09-17 00:57:52'),
(137, 51, 'user', '2023-09-19', NULL, NULL, NULL, '2023-09-18 22:12:27', '2023-09-18 22:12:27'),
(138, 51, 'user.user', '2023-09-20', NULL, NULL, NULL, '2023-09-18 22:16:45', '2023-09-18 22:16:45');

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
(22, '2023_07_29_224734_create_permission_tables', 13);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(10, 'App\\Models\\User', 42),
(10, 'App\\Models\\User', 43),
(15, 'App\\Models\\User', 48),
(16, 'App\\Models\\User', 51);

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
(87, 65, 'System', 'Your subscription will expire in 2023 Oct 20.', 20, '2023-09-20 03:32:35', '2023-09-20 03:32:35');

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
('jfroosama10@gmail.com', '$2y$10$dKX.weIHD9PE8I9z6SwIZ.EQ8yhh3jtxTwMC2loJv9UApqDVuCi2m', '2023-06-21 19:36:09');

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
(53, 'send-reminders', 'web', NULL, NULL);

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
(15, 20, 'rwar', 'rerser', '/img/cases/p4.jpg', NULL, 'rwar', NULL, NULL, NULL, '2023-08-18 01:02:05', '2023-08-18 01:02:05'),
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
(16, 20, 'client', NULL, 'web', '2023-09-18 21:29:49', '2023-09-18 21:29:49');

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
(30, 6),
(30, 16),
(31, 6),
(31, 16),
(32, 6),
(32, 10),
(32, 16),
(33, 6),
(34, 6),
(34, 10),
(35, 6),
(35, 10),
(36, 6),
(37, 6),
(37, 15),
(37, 16),
(38, 6),
(38, 15),
(38, 16),
(39, 6),
(39, 15),
(39, 16),
(40, 6),
(40, 15),
(40, 16),
(41, 6),
(41, 15),
(41, 16),
(42, 6),
(43, 6),
(44, 6),
(45, 6),
(46, 6),
(47, 6),
(48, 6),
(49, 6),
(50, 6),
(51, 6),
(52, 6),
(53, 6),
(53, 15);

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_tasks`
--

CREATE TABLE `scheduled_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userId` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scheduled_tasks`
--

INSERT INTO `scheduled_tasks` (`id`, `userId`, `created_at`, `updated_at`) VALUES
(1, 40, '2023-06-09 20:16:33', '2023-06-09 20:16:33'),
(2, 20, NULL, NULL),
(3, 38, NULL, NULL),
(4, 22, NULL, NULL),
(5, 32, NULL, NULL),
(6, 39, NULL, NULL),
(10, 41, '2023-07-12 01:14:24', '2023-07-12 01:14:24'),
(11, 43, '2023-08-18 00:25:23', '2023-08-18 00:25:23'),
(12, 50, '2023-09-17 11:52:19', '2023-09-17 11:52:19'),
(13, 51, '2023-09-18 21:28:40', '2023-09-18 21:28:40'),
(14, 63, '2023-09-20 03:30:34', '2023-09-20 03:30:34'),
(15, 64, '2023-09-20 03:32:18', '2023-09-20 03:32:18'),
(16, 65, '2023-09-20 03:32:35', '2023-09-20 03:32:35');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `service_name` text NOT NULL,
  `price` int(11) NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `api_token`, `sendRemainders`, `sendBefore`, `sendAt`, `created_at`, `updated_at`, `userId`) VALUES
(1, 'HenKRnOk4q9gTR$i5AbE', 0, '3', '07:30:00', NULL, '2023-07-20 16:00:13', 20),
(3, '5mv1SnfcbSKjxpMoxCV1', NULL, NULL, NULL, '2023-05-27 13:04:48', '2023-05-27 13:04:48', 32),
(4, 'MbVSmvxS51CKno1fxpcj', NULL, NULL, NULL, '2023-05-27 13:57:15', '2023-05-27 13:57:15', 33),
(5, 'Mnx1Sv1boSmfKxCVpjc5', NULL, NULL, NULL, '2023-05-27 17:27:08', '2023-05-27 17:27:08', 35),
(6, 'KfxSmj1Co15McpVSxvbn', NULL, NULL, NULL, '2023-05-27 17:28:32', '2023-05-27 17:28:32', 36),
(7, 'n5S1MxKvp1bVxCjmocSf', NULL, NULL, NULL, '2023-05-27 17:31:03', '2023-05-27 17:31:03', 37),
(8, 'kJIVQiUiPWwC54v5frxs', NULL, NULL, NULL, '2023-05-27 19:31:24', '2023-05-27 19:37:17', 38),
(9, '1pxS1xb5MncvmVfCoKSj', NULL, NULL, NULL, '2023-06-04 01:37:40', '2023-06-04 01:37:40', 39),
(10, '5v1fbM1SpKxVCnmcSjox', NULL, NULL, NULL, '2023-06-09 20:16:33', '2023-06-09 20:16:33', 40),
(11, 'MxKc1V1fbm5CjSnoxpSv', NULL, NULL, NULL, '2023-07-12 01:14:24', '2023-07-12 01:14:24', 41),
(12, 'xj5Mpfc1V1KbSCoxnSvm', NULL, NULL, NULL, '2023-08-18 00:25:23', '2023-08-18 00:25:23', 43),
(13, '5mCf1jcSvM1VbSKxoxnp', NULL, NULL, NULL, '2023-09-17 11:52:18', '2023-09-17 11:52:18', 50),
(14, 'cbSvpM1xCnKf5S1xmojV', NULL, NULL, NULL, '2023-09-18 21:28:40', '2023-09-18 21:28:40', 51),
(15, 'jKCSVSvnf1p5bmxMocx1', NULL, NULL, NULL, '2023-09-20 03:30:34', '2023-09-20 03:30:34', 63),
(16, 'pC1ocvnSb5KxV1xmSjMf', NULL, NULL, NULL, '2023-09-20 03:32:18', '2023-09-20 03:32:18', 64),
(17, 'jxKMVcvfmon1pxS15CbS', NULL, NULL, NULL, '2023-09-20 03:32:35', '2023-09-20 03:32:35', 65);

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

INSERT INTO `users` (`id`, `name`, `email`, `job`, `city`, `address`, `description`, `avatar`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `subscription_end_date`, `lang`, `last_login_ip`) VALUES
(20, 'Hkaleefah', 'jfroosama10@gmail.com', 'front-end developer', 'Netherlands', 'Amsterdam', 'goood', NULL, NULL, '$2a$12$HaPkwZu.ANedITbO948k8Ou2ugmDe6f8Mx6ishwRoNZrN6YgWQNAi', 'zyqih57mV2CVxEHNrBxPrYg7NygSYmI2xBVkH9x6Uma5vi08XvmJ2g17osuz', '2023-05-25 13:04:48', '2023-06-06 17:11:08', '2023-10-26', 'english', '127.0.0.1'),
(70, 'test2', 'test2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$3LemmmDVhPZ3O38Ucd1aL.K4.Y.WPPYpQWYEGBLA/r2T7iw47Crry', NULL, '2023-09-25 06:38:47', '2023-09-25 06:38:47', '2023-10-26', 'english', NULL);

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
  ADD PRIMARY KEY (`schedule_id`);

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
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
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
  ADD PRIMARY KEY (`service_id`);

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
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `contents`
--
ALTER TABLE `contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `employers`
--
ALTER TABLE `employers`
  MODIFY `employer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `employer_schedules`
--
ALTER TABLE `employer_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `scheduled_tasks`
--
ALTER TABLE `scheduled_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_fk0` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `appointments_fk1` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`employer_id`),
  ADD CONSTRAINT `appointments_fk2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`);

--
-- Constraints for table `employer_services`
--
ALTER TABLE `employer_services`
  ADD CONSTRAINT `employer_services_fk0` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`employer_id`),
  ADD CONSTRAINT `employer_services_fk1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`);

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
