-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.4.32-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win64
-- HeidiSQL Wersja:              12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Zrzut struktury bazy danych es_extended
CREATE DATABASE IF NOT EXISTS `es_extended` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `es_extended`;

-- Zrzut struktury tabela es_extended.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `height` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.characters: ~0 rows (około)

-- Zrzut struktury tabela es_extended.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.items: ~0 rows (około)

-- Zrzut struktury tabela es_extended.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.jobs: ~1 rows (około)
INSERT IGNORE INTO `jobs` (`name`, `label`) VALUES
	('unemployed', 'Unemployed');

-- Zrzut struktury tabela es_extended.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.job_grades: ~1 rows (około)
INSERT IGNORE INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}');

-- Zrzut struktury tabela es_extended.licenses
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.licenses: ~1 rows (około)
INSERT IGNORE INTO `licenses` (`type`, `label`) VALUES
	('weapon', 'Weapon License');

-- Zrzut struktury tabela es_extended.multichars_slots
CREATE TABLE IF NOT EXISTS `multichars_slots` (
  `identifier` varchar(60) NOT NULL,
  `slots` int(11) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `slots` (`slots`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.multichars_slots: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_calls
CREATE TABLE IF NOT EXISTS `npwd_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transmitter` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `is_accepted` tinyint(4) DEFAULT 0,
  `isAnonymous` tinyint(4) NOT NULL DEFAULT 0,
  `start` varchar(255) DEFAULT NULL,
  `end` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_calls: ~2 rows (około)
INSERT IGNORE INTO `npwd_calls` (`id`, `identifier`, `transmitter`, `receiver`, `is_accepted`, `isAnonymous`, `start`, `end`) VALUES
	(1, '004cac32-7d55-488d-8463-b6a1b19d6eff', '273-479-2675', '', 0, 0, '1706573092', NULL),
	(2, '3410972c-6221-42df-90f0-4dcec6368bb4', '273-479-2675', '112', 0, 0, '1706573264', NULL),
	(3, '3e54c2e1-42d6-4854-a447-8e1864d5004f', '273-479-2675', '', 0, 0, '1706695519', NULL);

-- Zrzut struktury tabela es_extended.npwd_darkchat_channels
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_identifier` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `darkchat_channels_channel_identifier_uindex` (`channel_identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_channels: ~0 rows (około)
INSERT IGNORE INTO `npwd_darkchat_channels` (`id`, `channel_identifier`, `label`) VALUES
	(20, 'fsda', 'fsda');

-- Zrzut struktury tabela es_extended.npwd_darkchat_channel_members
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channel_members` (
  `channel_id` int(11) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `is_owner` tinyint(4) NOT NULL DEFAULT 0,
  KEY `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_channel_members: ~0 rows (około)
INSERT IGNORE INTO `npwd_darkchat_channel_members` (`channel_id`, `user_identifier`, `is_owner`) VALUES
	(20, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1);

-- Zrzut struktury tabela es_extended.npwd_darkchat_messages
CREATE TABLE IF NOT EXISTS `npwd_darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_image` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `darkchat_messages_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `darkchat_messages_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_messages: ~0 rows (około)
INSERT IGNORE INTO `npwd_darkchat_messages` (`id`, `channel_id`, `message`, `user_identifier`, `createdAt`, `is_image`) VALUES
	(31, 20, 'ewz', 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', '2024-01-30 00:04:10', 0);

-- Zrzut struktury tabela es_extended.npwd_marketplace_listings
CREATE TABLE IF NOT EXISTS `npwd_marketplace_listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reported` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_marketplace_listings: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_match_profiles
CREATE TABLE IF NOT EXISTS `npwd_match_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(90) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bio` varchar(512) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `job` varchar(45) DEFAULT NULL,
  `tags` varchar(255) NOT NULL DEFAULT '',
  `voiceMessage` varchar(512) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier_UNIQUE` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_match_profiles: ~2 rows (około)
INSERT IGNORE INTO `npwd_match_profiles` (`id`, `identifier`, `name`, `image`, `bio`, `location`, `job`, `tags`, `voiceMessage`, `createdAt`, `updatedAt`) VALUES
	(1, '9413a13c333cece1f4485f63f4322549dc1966ec', '6922447673', 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg', '', '', '', '', NULL, '2024-01-25 22:25:38', '2024-01-25 22:25:38'),
	(2, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'Hango Bango', 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg', '', '', '', '', NULL, '2024-01-25 22:27:55', '2024-01-25 22:27:55');

-- Zrzut struktury tabela es_extended.npwd_match_views
CREATE TABLE IF NOT EXISTS `npwd_match_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `profile` int(11) NOT NULL,
  `liked` tinyint(4) DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `match_profile_idx` (`profile`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `match_profile` FOREIGN KEY (`profile`) REFERENCES `npwd_match_profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_match_views: ~0 rows (około)
INSERT IGNORE INTO `npwd_match_views` (`id`, `identifier`, `profile`, `liked`, `createdAt`, `updatedAt`) VALUES
	(1, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, 1, '2024-01-26 22:48:44', '2024-01-26 22:48:44');

-- Zrzut struktury tabela es_extended.npwd_messages
CREATE TABLE IF NOT EXISTS `npwd_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `conversation_id` varchar(512) NOT NULL,
  `isRead` tinyint(4) NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `author` varchar(255) NOT NULL,
  `is_embed` tinyint(4) NOT NULL DEFAULT 0,
  `embed` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_identifier` (`user_identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages: ~0 rows (około)
INSERT IGNORE INTO `npwd_messages` (`id`, `message`, `user_identifier`, `conversation_id`, `isRead`, `createdAt`, `updatedAt`, `visible`, `author`, `is_embed`, `embed`) VALUES
	(1, 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp', 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', '1', 0, '2024-01-25 22:29:25', '2024-01-25 22:29:25', 1, '273-479-2675', 0, ''),
	(2, 'ez', 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', '2', 0, '2024-01-30 00:08:06', '2024-01-30 00:08:06', 1, '273-479-2675', 0, '');

-- Zrzut struktury tabela es_extended.npwd_messages_conversations
CREATE TABLE IF NOT EXISTS `npwd_messages_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_list` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_message_id` int(11) DEFAULT NULL,
  `is_group_chat` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages_conversations: ~0 rows (około)
INSERT IGNORE INTO `npwd_messages_conversations` (`id`, `conversation_list`, `label`, `createdAt`, `updatedAt`, `last_message_id`, `is_group_chat`) VALUES
	(1, '112+273-479-2675', '', '2024-01-25 22:29:22', '2024-01-25 22:29:25', NULL, 0),
	(2, '+273-479-2675', '', '2024-01-30 00:08:03', '2024-01-30 00:08:06', NULL, 0);

-- Zrzut struktury tabela es_extended.npwd_messages_participants
CREATE TABLE IF NOT EXISTS `npwd_messages_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) NOT NULL,
  `participant` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unread_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_participants_npwd_messages_conversations_id_fk` (`conversation_id`) USING BTREE,
  CONSTRAINT `message_participants_npwd_messages_conversations_id_fk` FOREIGN KEY (`conversation_id`) REFERENCES `npwd_messages_conversations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages_participants: ~4 rows (około)
INSERT IGNORE INTO `npwd_messages_participants` (`id`, `conversation_id`, `participant`, `unread_count`) VALUES
	(1, 1, '112', 0),
	(2, 1, '273-479-2675', 0),
	(3, 2, '', 0),
	(4, 2, '273-479-2675', 0);

-- Zrzut struktury tabela es_extended.npwd_notes
CREATE TABLE IF NOT EXISTS `npwd_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_notes: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_phone_contacts
CREATE TABLE IF NOT EXISTS `npwd_phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `display` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_phone_contacts: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_phone_gallery
CREATE TABLE IF NOT EXISTS `npwd_phone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_phone_gallery: ~2 rows (około)
INSERT IGNORE INTO `npwd_phone_gallery` (`id`, `identifier`, `image`) VALUES
	(1, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp'),
	(2, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp'),
	(3, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/Sfsj7ELitAB9.webp'),
	(4, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/phPcDesBB1Ey.webp');

-- Zrzut struktury tabela es_extended.npwd_twitter_likes
CREATE TABLE IF NOT EXISTS `npwd_twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_likes: ~1 rows (około)

-- Zrzut struktury tabela es_extended.npwd_twitter_profiles
CREATE TABLE IF NOT EXISTS `npwd_twitter_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(90) NOT NULL,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar_url` varchar(255) DEFAULT 'https://i.fivemanage.com/images/3ClWwmpwkFhL.png',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_name_UNIQUE` (`profile_name`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_profiles: ~2 rows (około)
INSERT IGNORE INTO `npwd_twitter_profiles` (`id`, `profile_name`, `identifier`, `avatar_url`, `createdAt`, `updatedAt`) VALUES
	(1, '6922447673', '9413a13c333cece1f4485f63f4322549dc1966ec', 'https://i.fivemanage.com/images/3ClWwmpwkFhL.png', '2024-01-25 22:25:38', '2024-01-25 22:25:38'),
	(2, 'Hango_Bango', 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp', '2024-01-25 22:27:55', '2024-01-25 22:29:42');

-- Zrzut struktury tabela es_extended.npwd_twitter_reports
CREATE TABLE IF NOT EXISTS `npwd_twitter_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`profile_id`,`tweet_id`),
  KEY `profile_idx` (`profile_id`),
  KEY `tweet_idx` (`tweet_id`),
  CONSTRAINT `report_profile` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`),
  CONSTRAINT `report_tweet` FOREIGN KEY (`tweet_id`) REFERENCES `npwd_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_reports: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_twitter_tweets
CREATE TABLE IF NOT EXISTS `npwd_twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `retweet` int(11) DEFAULT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` (`profile_id`) USING BTREE,
  CONSTRAINT `npwd_twitter_tweets_npwd_twitter_profiles_id_fk` FOREIGN KEY (`profile_id`) REFERENCES `npwd_twitter_profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_tweets: ~6 rows (około)
INSERT IGNORE INTO `npwd_twitter_tweets` (`id`, `message`, `createdAt`, `updatedAt`, `likes`, `identifier`, `visible`, `images`, `retweet`, `profile_id`) VALUES
	(6, 'x', '2024-01-31 14:29:47', '2024-01-31 14:29:47', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2),
	(7, 'a', '2024-01-31 14:29:49', '2024-01-31 14:29:49', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2),
	(8, 'w', '2024-01-31 14:29:50', '2024-01-31 14:29:50', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2),
	(9, 'f', '2024-01-31 14:29:51', '2024-01-31 14:29:51', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2),
	(10, 'g', '2024-01-31 14:29:53', '2024-01-31 14:29:53', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2),
	(11, 'h', '2024-01-31 14:29:54', '2024-01-31 14:29:54', 0, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 1, '', NULL, 2);

-- Zrzut struktury tabela es_extended.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `id` int(55) NOT NULL AUTO_INCREMENT,
  `owner` varchar(22) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `owner_type` int(2) NOT NULL DEFAULT 1,
  `state` int(4) NOT NULL DEFAULT 0,
  `plate` varchar(12) NOT NULL,
  `vehicleid` int(11) DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli es_extended.owned_vehicles: ~0 rows (około)
INSERT IGNORE INTO `owned_vehicles` (`id`, `owner`, `vehicle`, `owner_type`, `state`, `plate`, `vehicleid`, `glovebox`, `trunk`) VALUES
	(8, 'char1:9413a13c333cece1', '{"modSeats":-1,"modLivery":-1,"modVanityPlate":-1,"doorsBroken":[],"model":-2128233223,"modTrunk":-1,"modBrakes":-1,"modFrontWheels":-1,"dashboardColor":0,"modSteeringWheel":-1,"modSuspension":-1,"modDoorSpeaker":-1,"dirtLevel":9.0,"modDashboard":-1,"plateIndex":0,"modHydrolic":-1,"tyreSmokeColor":[255,255,255],"modHorns":-1,"modTrimB":-1,"modCustomFrontWheels":false,"extras":[],"tankHealth":1000.0,"pearlescentColor":0,"modAerials":-1,"modFender":-1,"modArchCover":-1,"modBackWheels":-1,"modEngineBlock":-1,"modWindows":-1,"modRightFender":-1,"modRoof":-1,"modTurbo":false,"modLightbar":-1,"modShifterLeavers":-1,"modSpoilers":-1,"windowsBroken":{"7":true,"6":true,"1":true,"0":true,"3":true,"2":true,"5":true,"4":true},"modRearBumper":-1,"neonColor":[255,0,255],"modSideSkirt":-1,"modTrimA":-1,"tyreBurst":{"5":false,"4":false,"1":false,"0":false},"modAPlate":-1,"modArmor":-1,"windowTint":-1,"modSmokeEnabled":false,"modExhaust":-1,"tyresCanBurst":1,"wheelColor":156,"modTank":-1,"modSpeakers":-1,"color2":0,"modHood":-1,"modGrille":-1,"modPlateHolder":-1,"color1":27,"modFrontBumper":-1,"plate":"RYN 4135","neonEnabled":[false,false,false,false],"modDial":-1,"xenonColor":255,"modOrnaments":-1,"engineHealth":1000.0,"modCustomBackWheels":false,"modFrame":-1,"modXenon":false,"wheels":4,"modTransmission":-1,"modEngine":-1,"bodyHealth":1000.0,"interiorColor":0,"fuelLevel":10.0,"modAirFilter":-1,"modStruts":-1,"modRoofLivery":-1}', 1, 0, 'RYN 4135', NULL, NULL, NULL);

-- Zrzut struktury tabela es_extended.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.ox_doorlock: ~0 rows (około)

-- Zrzut struktury tabela es_extended.ox_inventory
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(60) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.ox_inventory: ~0 rows (około)

-- Zrzut struktury tabela es_extended.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(60) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `isDead` tinyint(4) unsigned zerofill DEFAULT 0000,
  `health` int(11) DEFAULT 100,
  `armour` int(11) DEFAULT 0,
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `firstname` varchar(50) DEFAULT '',
  `lastname` varchar(50) DEFAULT '',
  `dateofbirth` varchar(25) DEFAULT '',
  `sex` varchar(10) DEFAULT '',
  `height` varchar(5) DEFAULT '',
  `disabled` tinyint(1) DEFAULT 0,
  `status` longtext DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.users: ~2 rows (około)
INSERT IGNORE INTO `users` (`identifier`, `accounts`, `group`, `isDead`, `health`, `armour`, `inventory`, `job`, `job_grade`, `loadout`, `metadata`, `position`, `skin`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `disabled`, `status`, `phone_number`) VALUES
	('9413a13c333cece1f4485f63f4322549dc1966ec', '{"bank":50000,"black_money":0,"money":0}', 'admin', 0000, 100, 100, '[]', 'unemployed', 0, '[]', '{"armor":0,"health":200}', '{"x":237.77142333984376,"z":30.4761962890625,"y":-883.92529296875}', NULL, '', '', '', '', '', 0, NULL, '692-244-7673'),
	('char1:9413a13c333cece1f4485f63f4322549dc1966ec', '{"bank":27700,"black_money":0,"money":4051907}', 'admin', 0000, 200, 0, '[{"count":4051907,"name":"money","slot":1},{"metadata":{"durability":0,"degrade":2},"count":1,"name":"phone","slot":2},{"metadata":{"durability":95.40000000000016,"components":[]},"count":1,"name":"WEAPON_BAT","slot":3},{"metadata":{"ammo":0,"serial":"578199MPB235325","components":[],"durability":74.70000000000012,"registered":"Hango Bango"},"count":1,"name":"WEAPON_PISTOL","slot":4},{"metadata":{"durability":97.80000000000008,"components":[]},"count":1,"name":"WEAPON_KNIFE","slot":5},{"count":100,"name":"ammo-9","slot":6}]', 'unemployed', 0, '[]', '{"armor":0,"health":200}', '{"y":1377.6527099609376,"z":106.6541748046875,"x":1429.068115234375}', '{"hair_color_1":0,"bodyb_4":0,"sex":0,"moles_1":0,"mask_1":0,"face_md_weight":0,"chain_1":0,"eyebrows_6":0,"moles_2":0,"lipstick_3":0,"makeup_3":0,"complexion_1":0,"eye_squint":0,"jaw_2":0,"hair_2":0,"dad":11,"lip_thickness":0,"tshirt_2":0,"helmet_2":0,"chin_3":0,"arms":11,"glasses_2":0,"mom":23,"blemishes_2":0,"skin_md_weight":0,"cheeks_2":0,"blemishes_1":0,"nose_1":0,"ears_2":0,"nose_4":0,"bproof_2":0,"hair_color_2":3,"blush_3":24,"tshirt_1":15,"watches_1":17,"decals_1":0,"makeup_1":62,"jaw_1":0,"chain_2":0,"nose_5":0,"sun_1":0,"beard_2":0,"lipstick_2":0,"eyebrows_4":0,"bodyb_3":-1,"nose_2":0,"bracelets_2":0,"cheeks_1":0,"eyebrows_5":0,"nose_3":0,"blush_2":0,"helmet_1":-1,"nose_6":0,"eye_color":6,"age_2":0,"hair_1":1,"sun_2":0,"chest_3":0,"makeup_4":0,"eyebrows_2":0,"chin_4":0,"pants_1":69,"bodyb_1":-1,"makeup_2":10,"torso_2":0,"chin_2":0,"eyebrows_3":0,"decals_2":0,"age_1":0,"cheeks_3":0,"ears_1":-1,"bags_2":0,"blush_1":0,"bodyb_2":0,"pants_2":0,"neck_thickness":0,"glasses_1":0,"lipstick_1":0,"shoes_1":8,"chin_1":0,"shoes_2":0,"beard_1":0,"chest_1":0,"torso_1":322,"chest_2":0,"bags_1":0,"lipstick_4":0,"eyebrows_1":0,"mask_2":0,"arms_2":0,"watches_2":0,"bracelets_1":5,"complexion_2":0,"beard_4":0,"bproof_1":0,"beard_3":0}', 'Hango', 'Bango', '19/05/2015', 'm', '180', 0, '[{"name":"hunger","percent":49.89,"val":498900},{"name":"thirst","percent":49.9175,"val":499175}]', '273-479-2675');

-- Zrzut struktury tabela es_extended.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.user_licenses: ~0 rows (około)

-- Zrzut struktury tabela es_extended.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `blocked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.vehicles: ~124 rows (około)
INSERT IGNORE INTO `vehicles` (`name`, `model`, `price`, `category`, `blocked`) VALUES
	('Adder', 'adder', 650000, 'superpojazdy', 0),
	('Akuma', 'akuma', 2500, 'motocykle', 0),
	('Asea', 'asea', 8000, 'sedany', 0),
	('Asterope', 'asterope', 12500, 'sedany', 0),
	('Baller', 'baller', 20000, 'suvy', 0),
	('Baller 2', 'baller2', 21500, 'suvy', 0),
	('Baller 3', 'baller3', 32500, 'suvy', 0),
	('Baller 4', 'baller4', 37500, 'suvy', 0),
	('Banshee', 'banshee', 175000, 'sportowe', 0),
	('Bati', 'bati', 2750, 'motocykle', 0),
	('Bifta', 'bifta', 25000, 'offroady', 0),
	('Blade', 'blade', 7500, 'muscle', 0),
	('Blazer', 'blazer', 2500, 'quady', 0),
	('Blazer 2', 'blazer2', 2750, 'quady', 0),
	('Blazer 3', 'blazer3', 2950, 'quady', 0),
	('Blista', 'blista', 9000, 'kompaktowe', 0),
	('Blista 2', 'blista2', 11500, 'kompaktowe', 0),
	('BMX', 'bmx', 250, 'rowery', 0),
	('Brawler', 'brawler', 75000, 'offroady', 0),
	('Brioso', 'brioso', 17500, 'kompaktowe', 0),
	('Buccaneer', 'buccaneer', 9500, 'muscle', 0),
	('Buccaneer 2', 'buccaneer2', 10500, 'muscle', 0),
	('Buffalo', 'buffalo', 32500, 'sedany', 0),
	('Buffalo 2', 'buffalo2', 35500, 'sedany', 0),
	('Camper', 'camper', 22500, 'vany', 0),
	('Caracara', 'caracara2', 225000, 'offroady', 0),
	('Carbonizzare', 'carbonizzare', 275000, 'sportowe', 0),
	('Casco', 'casco', 145000, 'sportoweklasyki', 0),
	('Cheetah', 'cheetah', 465000, 'superpojazdy', 0),
	('Chino', 'chino', 6500, 'muscle', 0),
	('Chino 2', 'chino2', 7750, 'muscle', 0),
	('Cog55', 'cog55', 35000, 'sedany', 0),
	('Cog Cabrio', 'cogcabrio', 13500, 'coupe', 0),
	('Coquette', 'coquette', 275000, 'sportoweklasyki', 0),
	('Coquette 3', 'coquette3', 315000, 'sportoweklasyki', 0),
	('Cruiser', 'cruiser', 200, 'rowery', 0),
	('Daemon', 'daemon', 2000, 'motocykle', 0),
	('Dodge Challenger Demon', 'demon', 388000, 'muscle', 0),
	('Dominator', 'dominator', 87500, 'muscle', 0),
	('Dubsta', 'dubsta', 57500, 'suvy', 0),
	('Dukes', 'dukes', 8850, 'muscle', 0),
	('Dune', 'dune', 17500, 'offroady', 0),
	('Emperor', 'emperor', 7500, 'sedany', 0),
	('Everon', 'everon', 95000, 'offroady', 0),
	('Exemplar', 'exemplar', 22500, 'coupe', 0),
	('F620', 'f620', 22500, 'coupe', 0),
	('Faction', 'faction', 17500, 'muscle', 0),
	('Felon', 'felon', 15000, 'coupe', 0),
	('Feltzer 2', 'feltzer2', 315000, 'sportowe', 0),
	('Fixter', 'fixter', 400, 'rowery', 0),
	('Fugitive', 'fugitive', 22500, 'sedany', 0),
	('Futo', 'futo', 95000, 'sportowe', 0),
	('GBuritto', 'gburitto', 20000, 'vany', 0),
	('Gresley', 'gresley', 32500, 'suvy', 0),
	('Hummer H2', 'h2m', 950000, 'offroady', 0),
	('Tiyita Hillux 6x6', 'hillux6x6', 665000, 'offroady', 0),
	('Infernus 2', 'infernus2', 400000, 'sportowe', 0),
	('Issi 2', 'issi2', 12500, 'kompaktowe', 0),
	('Jester', 'jester', 225000, 'sportowe', 0),
	('Kalahari', 'kalahari', 10000, 'offroady', 0),
	('Landstalker', 'landstalker', 22500, 'suvy', 0),
	('Lexus LX570s', 'lx570s', 375000, 'suvy', 0),
	('Lynx', 'lynx', 500000, 'sportowe', 0),
	('Mamba', 'mamba', 175000, 'sportoweklasyki', 0),
	('4444', 'Mercedes Brabus 700', 570000, 'offroady', 0),
	('Mesa', 'mesa', 65000, 'offroady', 0),
	('Minivan', 'minivan2', 10500, 'vany', 0),
	('Monroe', 'monroe', 225000, 'sportoweklasyki', 0),
	('Nemesis', 'nemesis', 3100, 'motocykle', 0),
	('Nero', 'nero', 400000, 'superpojazdy', 0),
	('Nissan Titan 2017', 'nissantitan17', 795000, 'offroady', 0),
	('Oracle', 'oracle', 17500, 'coupe', 0),
	('Oracle 2', 'oracle2', 18500, 'coupe', 0),
	('Osiris', 'osiris', 520000, 'superpojazdy', 0),
	('Panto', 'panto', 7500, 'kompaktowe', 0),
	('Paradise', 'paradise', 12500, 'vany', 0),
	('Prairie', 'prairie', 18500, 'kompaktowe', 0),
	('Primo', 'primo', 23500, 'sedany', 0),
	('Primo Custom', 'primo2', 32500, 'sedany', 0),
	('Rebel', 'rebel', 12500, 'offroady', 0),
	('Rebla', 'rebla', 95000, 'suvy', 0),
	('Rhapsody', 'rhapsody', 10000, 'kompaktowe', 0),
	('Riata', 'riata', 75000, 'offroady', 0),
	('Dodge Charger 1969', 'rmodcharger69', 235000, 'muscle', 0),
	('Rocoto', 'rocoto', 49500, 'suvy', 0),
	('Romero', 'romero', 22500, 'sedany', 0),
	('Ruiner', 'ruiner', 9750, 'muscle', 0),
	('Rumpo', 'rumpo', 13500, 'vany', 0),
	('Sadler', 'sadler', 55000, 'offroady', 0),
	('Sandking', 'sandking', 57500, 'offroady', 0),
	('Schafter 3', 'schafter3', 55000, 'sedany', 0),
	('Schafter 4', 'schafter4', 60500, 'sedany', 0),
	('Schwarzer', 'schwarzer', 27500, 'coupe', 0),
	('Scorcher', 'scorcher', 550, 'rowery', 0),
	('Sentinel', 'sentinel', 27500, 'coupe', 0),
	('Stanier', 'stanier', 7500, 'sedany', 0),
	('Stinger', 'stinger', 235000, 'sportoweklasyki', 0),
	('Stinger GT', 'stingergt', 245000, 'sportoweklasyki', 0),
	('Stratum', 'stratum', 8000, 'sedany', 0),
	('Sultan RS', 'sultanrs', 275000, 'sportowe', 0),
	('Surano', 'surano', 315000, 'sportowe', 0),
	('Surfer', 'surfer', 12500, 'vany', 0),
	('Surge', 'surge', 18500, 'sedany', 0),
	('Range Rover Sport SVR 2014', 'svr14', 570000, 'suvy', 0),
	('T20', 't20', 420000, 'superpojazdy', 0),
	('Tailgater', 'tailgater', 23500, 'sedany', 0),
	('Tempesta', 'tempesta', 775000, 'superpojazdy', 0),
	('TriBike', 'tribike', 650, 'rowery', 0),
	('TriBike 2', 'tribike2', 650, 'rowery', 0),
	('Virgo', 'virgo', 10500, 'muscle', 0),
	('Voodoo', 'voodoo', 15000, 'muscle', 0),
	('Zentorno', 'zentorno', 565000, 'superpojazdy', 0),
	('Zion', 'zion', 28500, 'coupe', 0),
	('Zion 2', 'zion2', 29500, 'coupe', 0),
	('ZType', 'ztype', 415000, 'sportoweklasyki', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
