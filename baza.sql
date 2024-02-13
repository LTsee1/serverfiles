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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_calls: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_darkchat_channels
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_identifier` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `darkchat_channels_channel_identifier_uindex` (`channel_identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_channels: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_darkchat_channel_members
CREATE TABLE IF NOT EXISTS `npwd_darkchat_channel_members` (
  `channel_id` int(11) NOT NULL,
  `user_identifier` varchar(255) NOT NULL,
  `is_owner` tinyint(4) NOT NULL DEFAULT 0,
  KEY `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` (`channel_id`) USING BTREE,
  CONSTRAINT `npwd_darkchat_channel_members_npwd_darkchat_channels_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `npwd_darkchat_channels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_channel_members: ~0 rows (około)

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_darkchat_messages: ~0 rows (około)

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_match_views: ~0 rows (około)

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages: ~0 rows (około)
INSERT IGNORE INTO `npwd_messages` (`id`, `message`, `user_identifier`, `conversation_id`, `isRead`, `createdAt`, `updatedAt`, `visible`, `author`, `is_embed`, `embed`) VALUES
	(1, 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp', 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', '1', 0, '2024-01-25 22:29:25', '2024-01-25 22:29:25', 1, '273-479-2675', 0, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages_conversations: ~0 rows (około)
INSERT IGNORE INTO `npwd_messages_conversations` (`id`, `conversation_list`, `label`, `createdAt`, `updatedAt`, `last_message_id`, `is_group_chat`) VALUES
	(1, '112+273-479-2675', '', '2024-01-25 22:29:22', '2024-01-25 22:29:25', NULL, 0);

-- Zrzut struktury tabela es_extended.npwd_messages_participants
CREATE TABLE IF NOT EXISTS `npwd_messages_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) NOT NULL,
  `participant` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unread_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `message_participants_npwd_messages_conversations_id_fk` (`conversation_id`) USING BTREE,
  CONSTRAINT `message_participants_npwd_messages_conversations_id_fk` FOREIGN KEY (`conversation_id`) REFERENCES `npwd_messages_conversations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_messages_participants: ~2 rows (około)
INSERT IGNORE INTO `npwd_messages_participants` (`id`, `conversation_id`, `participant`, `unread_count`) VALUES
	(1, 1, '112', 0),
	(2, 1, '273-479-2675', 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_phone_contacts: ~0 rows (około)

-- Zrzut struktury tabela es_extended.npwd_phone_gallery
CREATE TABLE IF NOT EXISTS `npwd_phone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_phone_gallery: ~2 rows (około)
INSERT IGNORE INTO `npwd_phone_gallery` (`id`, `identifier`, `image`) VALUES
	(1, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp'),
	(2, 'char1:9413a13c333cece1f4485f63f4322549dc1966ec', 'https://r2.fivemanage.com/images/eNavfTgtfJL3.webp');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_likes: ~0 rows (około)

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.npwd_twitter_tweets: ~0 rows (około)

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Zrzucanie danych dla tabeli es_extended.owned_vehicles: ~0 rows (około)

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
	('char1:9413a13c333cece1f4485f63f4322549dc1966ec', '{"bank":60200,"money":2085,"black_money":0}', 'admin', 0000, 200, 0, '[{"count":2085,"name":"money","slot":1},{"count":1,"metadata":{"components":[],"durability":95.40000000000016},"name":"WEAPON_BAT","slot":3},{"count":1,"metadata":{"ammo":3,"components":[],"registered":"Hango Bango","serial":"578199MPB235325","durability":75.10000000000011},"name":"WEAPON_PISTOL","slot":4},{"count":1,"metadata":{"durability":0,"degrade":2},"name":"phone","slot":5}]', 'unemployed', 0, '[]', '{"armor":0,"health":200}', '{"x":-52.61538314819336,"y":-1108.4967041015626,"z":26.4322509765625}', '{"bracelets_1":5,"age_1":0,"chain_2":0,"arms":11,"chest_3":0,"bracelets_2":0,"nose_2":0,"bproof_2":0,"chin_3":0,"glasses_2":0,"eyebrows_2":0,"eye_color":6,"eye_squint":0,"hair_color_2":0,"torso_1":282,"blush_2":0,"makeup_4":0,"helmet_1":-1,"beard_3":0,"chin_1":0,"complexion_2":0,"hair_2":0,"chest_2":0,"pants_2":0,"age_2":0,"sun_1":0,"makeup_2":0,"decals_2":0,"bags_2":0,"dad":11,"neck_thickness":0,"eyebrows_4":0,"chin_4":0,"beard_2":0,"glasses_1":0,"eyebrows_6":0,"nose_3":0,"bodyb_3":-1,"blemishes_1":0,"lipstick_1":0,"cheeks_2":0,"shoes_2":0,"blush_3":0,"bproof_1":0,"tshirt_2":0,"bodyb_2":0,"mask_2":0,"chain_1":0,"makeup_3":0,"watches_1":17,"cheeks_3":0,"beard_4":0,"hair_color_1":0,"watches_2":0,"decals_1":0,"beard_1":0,"lip_thickness":0,"complexion_1":0,"eyebrows_5":0,"eyebrows_1":0,"lipstick_2":0,"moles_1":0,"skin_md_weight":0,"mask_1":0,"shoes_1":8,"cheeks_1":0,"nose_1":0,"ears_1":-1,"sun_2":0,"bodyb_1":-1,"bodyb_4":0,"lipstick_4":0,"sex":0,"lipstick_3":0,"blemishes_2":0,"blush_1":0,"nose_5":0,"ears_2":0,"nose_4":0,"face_md_weight":0,"moles_2":0,"chin_2":0,"eyebrows_3":0,"pants_1":69,"torso_2":0,"chest_1":0,"nose_6":0,"helmet_2":0,"tshirt_1":15,"hair_1":1,"mom":23,"arms_2":0,"jaw_1":0,"jaw_2":0,"bags_1":82,"makeup_1":0}', 'Hango', 'Bango', '19/05/2015', 'm', '180', 0, '[{"percent":65.35,"name":"hunger","val":653500},{"percent":66.5125,"name":"thirst","val":665125}]', '273-479-2675');

-- Zrzut struktury tabela es_extended.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Zrzucanie danych dla tabeli es_extended.user_licenses: ~0 rows (około)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
