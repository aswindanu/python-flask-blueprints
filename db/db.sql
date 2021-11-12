-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 25, 2021 at 06:03 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `budi_family`
--

-- --------------------------------------------------------

--
-- Table structure for table `myfamily`
--

CREATE TABLE IF NOT EXISTS `myfamily` (
`id` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `kelamin` enum('L','P') DEFAULT NULL,
  `orang_tua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `myfamily`
--

INSERT INTO `myfamily` (`id`, `nama`, `kelamin`, `orang_tua_id`) VALUES
(1, 'budi', 'L', NULL),
(2, 'dedi', 'L', 1),
(3, 'dodi', 'L', 1),
(4, 'dede', 'L', 1),
(5, 'dewi', 'P', 1),
(6, 'feri', 'L', 2),
(7, 'farah', 'P', 2),
(8, 'gugus', 'L', 3),
(9, 'gandi', 'L', 3),
(10, 'hani', 'P', 4),
(11, 'hana', 'P', 4),
(19, 'tono', 'L', 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `myfamily`
--
ALTER TABLE `myfamily`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `myfamily`
--
ALTER TABLE `myfamily`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;--
-- Database: `cdcol`
--

-- --------------------------------------------------------

--
-- Table structure for table `cds`
--

CREATE TABLE IF NOT EXISTS `cds` (
  `titel` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `interpret` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `jahr` int(11) DEFAULT NULL,
`id` bigint(20) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `cds`
--

INSERT INTO `cds` (`titel`, `interpret`, `jahr`, `id`) VALUES
('Beauty', 'Ryuichi Sakamoto', 1990, 1),
('Goodbye Country (Hello Nightclub)', 'Groove Armada', 2001, 4),
('Glee', 'Bran Van 3000', 1997, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cds`
--
ALTER TABLE `cds`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cds`
--
ALTER TABLE `cds`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;--
-- Database: `perkuliahan`
--

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE IF NOT EXISTS `jurusan` (
`id` int(11) NOT NULL,
  `nm_jurusan` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`id`, `nm_jurusan`) VALUES
(1, 'Jurusan'),
(2, 'Tes');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE IF NOT EXISTS `mahasiswa` (
`id` int(11) NOT NULL,
  `nama` varchar(20) NOT NULL,
  `id_jurusan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
 ADD PRIMARY KEY (`id`), ADD KEY `id_jurusan` (`id_jurusan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jurusan`
--
ALTER TABLE `jurusan`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id`) ON UPDATE CASCADE;
--
-- Database: `phpmyadmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `pma_bookmark`
--

CREATE TABLE IF NOT EXISTS `pma_bookmark` (
`id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma_column_info`
--

CREATE TABLE IF NOT EXISTS `pma_column_info` (
`id` int(5) unsigned NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_designer_coords`
--

CREATE TABLE IF NOT EXISTS `pma_designer_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `v` tinyint(4) DEFAULT NULL,
  `h` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma_history`
--

CREATE TABLE IF NOT EXISTS `pma_history` (
`id` bigint(20) unsigned NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_navigationhiding`
--

CREATE TABLE IF NOT EXISTS `pma_navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma_pdf_pages`
--

CREATE TABLE IF NOT EXISTS `pma_pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
`page_nr` int(10) unsigned NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_recent`
--

CREATE TABLE IF NOT EXISTS `pma_recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma_recent`
--

INSERT INTO `pma_recent` (`username`, `tables`) VALUES
('root', '[{"db":"budi_family","table":"myfamily"},{"db":"perkuliahan","table":"jurusan"},{"db":"webauth","table":"user_pwd"},{"db":"phpmyadmin","table":"pma_column_info"},{"db":"phpmyadmin","table":"pma_designer_coords"},{"db":"phpmyadmin","table":"pma_history"},{"db":"phpmyadmin","table":"pma_pdf_pages"},{"db":"phpmyadmin","table":"pma_recent"},{"db":"phpmyadmin","table":"pma_relation"},{"db":"cdcol","table":"cds"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma_relation`
--

CREATE TABLE IF NOT EXISTS `pma_relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma_savedsearches`
--

CREATE TABLE IF NOT EXISTS `pma_savedsearches` (
`id` int(5) unsigned NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_coords`
--

CREATE TABLE IF NOT EXISTS `pma_table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float unsigned NOT NULL DEFAULT '0',
  `y` float unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_info`
--

CREATE TABLE IF NOT EXISTS `pma_table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_uiprefs`
--

CREATE TABLE IF NOT EXISTS `pma_table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma_tracking`
--

CREATE TABLE IF NOT EXISTS `pma_tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_userconfig`
--

CREATE TABLE IF NOT EXISTS `pma_userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma_userconfig`
--

INSERT INTO `pma_userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2021-03-30 12:01:22', '{"collation_connection":"utf8mb4_general_ci"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma_usergroups`
--

CREATE TABLE IF NOT EXISTS `pma_usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma_users`
--

CREATE TABLE IF NOT EXISTS `pma_users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma_bookmark`
--
ALTER TABLE `pma_bookmark`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma_column_info`
--
ALTER TABLE `pma_column_info`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma_designer_coords`
--
ALTER TABLE `pma_designer_coords`
 ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma_history`
--
ALTER TABLE `pma_history`
 ADD PRIMARY KEY (`id`), ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma_navigationhiding`
--
ALTER TABLE `pma_navigationhiding`
 ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma_pdf_pages`
--
ALTER TABLE `pma_pdf_pages`
 ADD PRIMARY KEY (`page_nr`), ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma_recent`
--
ALTER TABLE `pma_recent`
 ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma_relation`
--
ALTER TABLE `pma_relation`
 ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`), ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma_savedsearches`
--
ALTER TABLE `pma_savedsearches`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma_table_coords`
--
ALTER TABLE `pma_table_coords`
 ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma_table_info`
--
ALTER TABLE `pma_table_info`
 ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma_table_uiprefs`
--
ALTER TABLE `pma_table_uiprefs`
 ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma_tracking`
--
ALTER TABLE `pma_tracking`
 ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma_userconfig`
--
ALTER TABLE `pma_userconfig`
 ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma_usergroups`
--
ALTER TABLE `pma_usergroups`
 ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma_users`
--
ALTER TABLE `pma_users`
 ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma_bookmark`
--
ALTER TABLE `pma_bookmark`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_column_info`
--
ALTER TABLE `pma_column_info`
MODIFY `id` int(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_history`
--
ALTER TABLE `pma_history`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_pdf_pages`
--
ALTER TABLE `pma_pdf_pages`
MODIFY `page_nr` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_savedsearches`
--
ALTER TABLE `pma_savedsearches`
MODIFY `id` int(5) unsigned NOT NULL AUTO_INCREMENT;--
-- Database: `skripsi`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_halte`
--

CREATE TABLE IF NOT EXISTS `detail_halte` (
`id` int(11) NOT NULL,
  `id_halte` int(11) NOT NULL,
  `id_trayek` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_halte`
--

INSERT INTO `detail_halte` (`id`, `id_halte`, `id_trayek`) VALUES
(10, 18, 1),
(11, 19, 1),
(12, 93, 1),
(13, 23, 1),
(14, 24, 1),
(15, 103, 1),
(16, 99, 1),
(17, 102, 1),
(18, 34, 1),
(19, 59, 1),
(21, 46, 1),
(22, 64, 1),
(23, 67, 1),
(24, 69, 1),
(25, 71, 1),
(26, 84, 1),
(27, 88, 1),
(28, 20, 1),
(29, 21, 1),
(30, 92, 1),
(31, 5, 2),
(33, 45, 2),
(34, 42, 2),
(35, 40, 2),
(36, 39, 2),
(37, 37, 2),
(38, 38, 2),
(39, 36, 2),
(40, 60, 2),
(41, 57, 2),
(42, 55, 2),
(43, 111, 2),
(44, 114, 2),
(45, 98, 2),
(46, 103, 2),
(48, 104, 2),
(49, 81, 2),
(50, 63, 2),
(51, 67, 2),
(52, 69, 2),
(53, 71, 2),
(54, 75, 2),
(55, 73, 2),
(56, 8, 2),
(57, 76, 2),
(58, 44, 2),
(59, 5, 3),
(60, 45, 3),
(61, 7, 3),
(62, 8, 3),
(63, 74, 3),
(64, 72, 3),
(65, 70, 3),
(66, 68, 3),
(67, 66, 3),
(68, 81, 3),
(69, 105, 3),
(70, 100, 3),
(71, 28, 3),
(72, 97, 3),
(73, 113, 3),
(74, 112, 3),
(75, 56, 3),
(76, 58, 3),
(77, 59, 3),
(78, 62, 3),
(79, 51, 3),
(80, 49, 3),
(81, 50, 3),
(82, 46, 3),
(83, 41, 3),
(84, 43, 3),
(85, 44, 3),
(91, 16, 0),
(93, 90, 0),
(94, 18, 0),
(95, 89, 0),
(96, 91, 0),
(97, 92, 0),
(98, 93, 0),
(99, 21, 0),
(100, 20, 0),
(101, 87, 0),
(102, 86, 0),
(103, 82, 0),
(104, 63, 0),
(105, 65, 0),
(106, 40, 0),
(107, 39, 0),
(108, 37, 0),
(109, 38, 0),
(110, 36, 0),
(111, 60, 0),
(112, 33, 0),
(113, 101, 0),
(114, 100, 0),
(115, 28, 0),
(116, 25, 0),
(117, 18, 4),
(118, 15, 4),
(119, 12, 4),
(120, 11, 4),
(121, 8, 4),
(122, 76, 4),
(123, 79, 4),
(124, 77, 4),
(125, 66, 4),
(126, 81, 4),
(127, 48, 4),
(128, 37, 4),
(129, 38, 4),
(130, 36, 4),
(131, 62, 4),
(132, 51, 4),
(133, 53, 4),
(134, 55, 4),
(135, 110, 4),
(136, 107, 4),
(137, 120, 4),
(138, 119, 4),
(139, 98, 4),
(140, 25, 4),
(141, 20, 4),
(142, 21, 4),
(143, 92, 4),
(144, 18, 5),
(145, 93, 5),
(146, 22, 5),
(147, 23, 5),
(148, 24, 5),
(149, 97, 5),
(150, 118, 5),
(151, 120, 5),
(152, 116, 5),
(153, 108, 5),
(154, 109, 5),
(155, 56, 5),
(156, 54, 5),
(157, 52, 5),
(158, 51, 5),
(159, 61, 5),
(160, 46, 5),
(161, 64, 5),
(162, 67, 5),
(163, 80, 5),
(164, 78, 5),
(165, 7, 5),
(166, 8, 5),
(167, 9, 5),
(168, 10, 5),
(169, 13, 5),
(170, 14, 5),
(171, 92, 5),
(172, 120, 6),
(173, 117, 6),
(174, 115, 6),
(175, 96, 6),
(176, 33, 6),
(177, 34, 6),
(178, 106, 6),
(179, 81, 6),
(180, 120, 7),
(181, 115, 7),
(182, 117, 7),
(183, 112, 7),
(184, 100, 7),
(185, 99, 7),
(186, 29, 7),
(187, 30, 7),
(188, 94, 7),
(189, 95, 7),
(190, 83, 7),
(191, 85, 7),
(192, 86, 7),
(193, 84, 7),
(194, 82, 7),
(195, 63, 7),
(196, 81, 7);

-- --------------------------------------------------------

--
-- Table structure for table `halte`
--

CREATE TABLE IF NOT EXISTS `halte` (
`id_halte` int(11) NOT NULL,
  `nama_halte` varchar(100) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `lat` varchar(100) NOT NULL,
  `lng` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `halte`
--

INSERT INTO `halte` (`id_halte`, `nama_halte`, `deskripsi`, `lat`, `lng`) VALUES
(5, 'Halte Terminal Jombor', 'Terminal Jombor', '-7.746726053875613', '110.36211518448636'),
(7, 'Halte Kentungan', '(Utara Jalan) Perempatan Kentungan ', '-7.755241335023562', '110.38390545052334'),
(8, 'Halte Terminal Condong Catur', 'Terminal Condong Catur', '-7.756752885728521', '110.395911018074'),
(9, 'Halte JIH', '(Utara Jalan) R.S Jogja International Hospital', '-7.7586803541545315', '110.40305910509869'),
(10, 'Halte Stikes Guna Bangsa', '(Utara Jalan) UPN, Amikom, UII Ekonomi, Stikes Guna Bangsa', '-7.7606204375474155', '110.40884999436184'),
(11, 'Halte UPN Veteran', '(Selatan Jalan) UPN, Amikom, UII Ekonomi, Stikes Guna Bangsa', '-7.760729400869728', '110.40806410712048'),
(12, 'Halte Instiper 2', '(Selatan Jalan) Instiper', '-7.764713186844341', '110.4236289660339'),
(13, 'Halte Instiper 1', '(Utara Jalan) Instiper', '-7.764192293692761', '110.42354313534543'),
(14, 'Halte Binamarga', '(Timur Jalan) Kantor Bina Marga', '-7.774503731821568', '110.43086556595608'),
(15, 'Halte Disbaker', '(Barat Jalan) Kantor Disnaker', '-7.769438402359625', '110.4309943119888'),
(16, 'Halte Terminal Prambanan', 'Candi Prambanan', '-7.755794131339885', '110.48950401943966'),
(18, 'Halte Bandara Adi Sutjipto Dalam', 'Kompleks Bandara Adi Sucipto', '-7.7845837149721575', '110.43637079995915'),
(19, 'Halte Bandara Adi Sutjipto Stasiun', 'Stasiun Maguwo', '-7.784549167592443', '110.43168632191464'),
(20, 'Halte Jalan Solo Janti', '(Utara Jalan) Jembatan Janti, Alnect Komputer', '-7.7831779000673755', '110.41163949173733'),
(21, 'Halte Jalan Solo(Alfa)', '(Utara Jalan) Alfa, Carefour, Hotel Jayakarta', '-7.7832190913083865', '110.41991544765278'),
(22, 'Halte Janti Fly Over', 'Bawah Jembatan Layang', '-7.785782241535788', '110.41038421791836'),
(23, 'Halte RS.AU Hardjolukito ', '(Timur Jalan) R.S AU Hardjolukito', '-7.797500249063523', '110.41002614301487'),
(24, 'Halte Gedong Kuning Wono Catur', '(Selatan Jalan) JEC, Perpustakaan Pusat', '-7.798718669163813', '110.40613023442074'),
(25, 'Halte Gedong Kuning JEC', '(Utara Jalan) JEC', '-7.798511391839974', '110.40250925225064'),
(28, 'Halte Kusumanegara (Gedung Juang 45)', '(Selatan Jalan)', '-7.802178590863625', '110.40003625553891'),
(29, 'Halte SMK 5', '(Utara Jalan) SMA 8, SMK 5, SGM, SMK Perkebunan ', '-7.800291847555704', '110.39496688050076'),
(30, 'Halte SGM', '(Selatan Jalan) SMA 8, SMK 5, SGM, SMK Perkebunan ', '-7.800344995371034', '110.39450017613217'),
(33, 'Halte Puro Pakualaman', '(Utara Jalan) Pakualaman, Museum Biologi, Museum Sasmitaloka', '-7.801514245599397', '110.37547258538052'),
(34, 'Halte Museum Biologi', '(Selatan Jalan) Pakualaman, Museum Biologi, Museum Sasmitaloka', '-7.801753410016101', '110.3744050661926'),
(36, 'Halte Ahmad Yani', '(Timur Jalan) Benteng Vrederburg, Gedung Agung Yogyakarta, Pasar Bringharjo', '-7.799887923938549', '110.36507097882077'),
(37, 'Halte Malioboro 1', '(Timur Jalan) Stasiun Tugu, Hotel Inna Garuda', '-7.790751705342112', '110.36615995568081'),
(38, 'Halte Malioboro 2', '(Timur Jalan) Maliobor Mall, Hotel Mutiara', '-7.7952534040022305', '110.36560205620572'),
(39, 'Halte Mangkubumi 2', '(Timur Jalan)', '-7.78617023387959', '110.36678491038128'),
(40, 'Halte Mangkubumi 1', '(Timur Jalan) Hotel Arjuna Yogya, Tugu Yogya, Hotel 101', '-7.7847272194420025', '110.36695120734021'),
(41, 'Halte AM Sangaji 1', '(Barat Jalan) SMK 2 Yogya, SMA 11 Yogya, SMP 6 Yogya, SMP Taman Siswa, SD Jetis Yogya, SD Tumbuh', '-7.777294154780497', '110.36767808598324'),
(42, 'Halte AM Sangaji 2', '(Timur Jalan) SD Jetis Yogya, SMP 6, SD Tumbuh, SMA 11 Yogya, SMK 2 Yogya', '-7.7757913150070825', '110.36799056333348'),
(43, 'Halte Karang Jati', '(Barat Jalan) Karang Jati', '-7.764428821785501', '110.36908892792508'),
(44, 'Halte Monjali 2', '(Selatan Jalan) Monumen Yogya Kembali ', '-7.751026239230955', '110.36871878308102'),
(45, 'Halte Monjali 1', '(Utara Jalan) Monumen Yogya Kembali', '-7.750441544172896', '110.3675439755325'),
(46, 'Halte Tentara Pelajar 1', '(Barat Jalan) SMP 12, SMP 14, Kopertis, Samsat', '-7.786715017043613', '110.35975618165776'),
(47, 'Halte Jlagran', '(Utara Jalan) Stasiun Tugu, Malioboro', '-7.789513331106678', '110.36041466397091'),
(48, 'Halte Diponegoro', '(Selatan Jalan) Pasar Kranggan , Bank Mandiri KCP Yogyakarta', '-7.782981245054505', '110.36253360909268'),
(49, 'Halte Cokroaminoto SMA 1', '(Barat Jalan) SMA 1 Yogyakarta, Pasar Klithikan', '-7.799212945444635', '110.3520917693977'),
(50, 'Halte Cokroaminoto SMP 11', '(Barat Jalan) SMP 11', '-7.792882976030704', '110.35335508984372'),
(51, 'Halte Ngabean', '(Barat Jalan) Ngabean', '-7.803884624666448', '110.35628942650601'),
(52, 'Halte Tejokusuman', '(Barat Jalan) Taman Sari, Plaza Pasar Ngasem', '-7.807992895563828', '110.35594073933407'),
(53, 'Halte MT Haryono 1', '(Utara Jalan) SMA 7', '-7.8132357983934755', '110.35741058987423'),
(54, 'Halte MT Haryono 2', '(Selatan Jalan) SMA 7', '-7.813530759546914', '110.35836545628354'),
(55, 'Halte Sugiono 1', '(Utar Jalan) Museum Perjuagan, SD Pujokusuman', '-7.8148115794358315', '110.37007598084256'),
(56, 'Halte Sugiono 2', '(Selatan Jalan) Museum Perjuangan', '-7.815167657296086', '110.37186501425549'),
(57, 'Halte  Katamso 1', '(Timur Jalan) BNNP DIY, Jogja Tronik', '-7.808534992976503', '110.3692015807037'),
(58, 'Halte  Katamso 2', '(Barat Jalan) SMP Maria Immaculata Marsudirini, Vihara Budha Prabha', '-7.802954544795876', '110.36906210583493'),
(59, 'Halte Senopati 1', '(Selatan Jalan) Taman Pintar, KM 0, Alun Alun Utara, Taman Budaya', '-7.801543476813217', '110.36686269444272'),
(60, 'Halte Senopati 2', '(Utara Jalan) Taman Pintar, KM 0, Alun Alun Utara, Taman Budaya', '-7.801405292875316', '110.36771831911847'),
(61, 'Halte KHA Dahlan 2', '(Utara Jalan)', '-7.801158156103301', '110.3606292406921'),
(62, 'Halte KHA Dahlan 1', '(Selatan Jalan)', '-7.801439838864072', '110.36066142720028'),
(63, 'Halte Sudirman 1', '(Selatan Jalan) RS. Bethesda, Galeria Mall, SMA Bopkri 2', '-7.783132722572576', '110.3779536287193'),
(64, 'Halte Sudirman 3', '(Utara Jalan) Hotel Santika Jogja, Tugu Jogja, Galeri Indosat', '-7.78285368499682', '110.36881534260556'),
(65, 'Halte Sudirman 2', '(Selatan Jalan) Hotel Santika Jogja, Tugu Jogja, Galeri Indosat', '-7.783039710067974', '110.36949930590436'),
(66, 'Halte Cik Di Tiro 1', '(Timur Jalan) Pasca Sarjana UII, SMP 8, Gramedia', '-7.7821786790454714', '110.37516681355282'),
(67, 'Halte RS Mata Dr.Yap', '(Barat Jalan) R.S Mata Dr.Yap, SMP 8, SMA 6', '-7.781190085690756', '110.37512926262661'),
(68, 'Halte Jl.Colombo(Panti Rapih)', '(Selatan Jalan) R.S Panti Rapih', '-7.776272330621997', '110.37823928397938'),
(69, 'Halte Jl.Colombo(Kosudgama)', '(Utara Jalan) Depan Kosudgama', '-7.776140782207519', '110.37856517237469'),
(70, 'Halte Jl.Colombo(Samirono)', '(Selatan Jalan) Boulevard UNY, Auditorium UNY', '-7.777714045390708', '110.38751570385739'),
(71, 'Halte Jl.Colombo(UNY)', '(Utara Jalan) GOR UNY, RS. Khusus Bedah An Nur', '-7.777702086486747', '110.38681162399098'),
(72, 'Halte Sanata Dharma', '(Timur Jalan) Sanata Dharma, FIP UNY, Auditorium Driyarkara Sanata Dharma', '-7.7753541484036', '110.38928596180722'),
(73, 'Halte Santren', '(Barat Jalan)', '-7.766297123276736', '110.39186624687954'),
(74, 'Halte Susteran Novisiat', '(Timur Jalan)', '-7.766063253843675', '110.39226857823178'),
(75, 'Halte UNY Gejayan', '(Barat Jalan) Sanata Dharma, FIP UNY, Auditorium Driyarkara Sanata Dharma', '-7.775295682318756', '110.38903651636883'),
(76, 'Halte Manggung', '(Selatan Jalan) Happy Puppy, Calista Studio Photo', '-7.7582896787447355', '110.38648573559567'),
(77, 'Halte Kopma UGM', '(Timur Jalan) Kopma UGM, MIPA UGM, Mirota Kampu, Vokasi UGM', '-7.774410717403351', '110.37510244053647'),
(78, 'Halte RSUD Sardjito', '(Barat Jalan) RSUD Sardjito', '-7.769581912010338', '110.37349311512753'),
(79, 'Halte FK UGM', '(Timur Jalan) FK UGM', '-7.767721597920957', '110.3743165532951'),
(80, 'Halte Pertanian UGM (Vokasi) ', '(Barat Jalan) Kopma UGM, MIPA UGM, Mirota Kampus, Vokasi UGM', '-7.7745515678000565', '110.37488518160626'),
(81, 'Halte Yos Sudarso (SMP 5)', '(Utara Jalan) SMP 5, Lap. Kridosono', '-7.787379385797204', '110.37541625899121'),
(82, 'Halte Urip Sumoharjo', '(Selatan Jalan) Empire XXI ', '-7.783215105059435', '110.38612095516964'),
(83, 'Halte UIN Kalijaga 2', '(Timur Jalan) Sekretariat UIN', '-7.786138344111458', '110.39490787190243'),
(84, 'Halte Jl.Solo (De Britto)', '(UtaraJalan) Gedung Wanita Tama, UIN Kalijaga, SMA De Britto', '-7.78301313506287', '110.3938028017883'),
(85, 'Halte UIN Kalijaga 1', '(Barat Jalan) Sekretariat UIN', '-7.785877910914213', '110.39471475285336'),
(86, 'Halte Jl.Solo(Gedung Wanita)', '(Selatan Jalan) Gedung Wanita Tama, UIN Kalijaga, SMA De Britto', '-7.783204475062046', '110.3927942911987'),
(87, 'Halte Jl.Solo(Jogja Bisnis)', '(Selatan Jalan) Ambarukmo Plaza, Royal Ambarukmo', '-7.783385184981073', '110.40179042023465'),
(88, 'Halte Jl.Solo(Ambarukmo)', '(Utara Jalan) Ambarukmo Plaza, Royal Ambarukmo', '-7.783106147573364', '110.40238855284497'),
(89, 'Halte Jl.Solo(Kalasan)', '(Utara Jalan) Pasar Kalasan, Candi Kalasan', '-7.7698795614998994', '110.46886710327908'),
(90, 'Halte Jl.Solo(KR. 1)', '(Selatan Jalan) Kedaulatan Rakyat', '-7.781838518154204', '110.4507514635925'),
(91, 'Halte Jl.Solo(KR. 2)', '(Utara Jalan) Kedaulatan Rakyat', '-7.782391279462364', '110.44876662892148'),
(92, 'Halte Jl.Solo(Maguwo)', '(Utara Jalan) Pasar Sambilegi', '-7.783419732456713', '110.43082533282086'),
(93, 'Halte Jl.Solo(Jayakarta)', '(Utara Jalan) Alfa, Carefour, Hotel Jayakarta', '-7.783515402374433', '110.41948763531491'),
(94, 'Halte APMD 1', '(Timur Jalan) Sekolah Tinggi APMD', '-7.791113118591762', '110.39338437718197'),
(95, 'Halte APMD 2', '(Barat Jalan) Sekolah Tinggi APMD', '-7.791152980328145', '110.39322880905911'),
(96, 'Halte Taman Siswa', '(Timur Jalan) Fakultas Hukum UII, STSRD VISI', '-7.813671596780907', '110.37657497328564'),
(97, 'Halte Gedong Kuning(Banguntapan)', '(Timur Jalan)', '-7.807270097919564', '110.40231076878354'),
(98, 'Halte Gedong Kuning (Dept Kehutanan)', '(Barat Jalan) Kantor Kehutanan', '-7.819732867425725', '110.40099648636624'),
(99, 'Halte Kusumanegara 4', '(Selatan Jalan) BPN Yogyakarta, Kampus Pusat Universitas Sarjanawiyata Tamansiswa ', '-7.802234395817768', '110.39338437718197'),
(100, 'Halte Kusumanegara 3', '(Utara Jalan) BPN Yogyakarta, Kampus Pusat Universitas Sarjanawiyata Tamansiswa ', '-7.8020457218952215', '110.39318052929684'),
(101, 'Halte Kusumanegara 1', '(Utara Jalan) Taman Makam Pahlawan', '-7.801737465725909', '110.38362113636776'),
(102, 'Halte Kusumanegara 2', '(Selatan Jalan)', '-7.8019660004939', '110.3821512858276'),
(103, 'Halte Kusumanegara (Gembiraloka)', '(Selatan Jalan) Gembira Loka Zoo', '-7.802359292592915', '110.39892045658871'),
(104, 'Halte Kenari 1', '(Selatan Jalan) SMK 6, UAD Kampus 1, Lap. Mandala Krida, SMA 2 Muhamadiyah', '-7.797586614836328', '110.38326172035977'),
(105, 'Halte Kenari 2', '(Utara Jalan) SMK 6, UAD Kampus 1, Lap. Mandala Krida, SMA 2 Muhamadiyah', '-7.7974417860687275', '110.3833743731384'),
(106, 'Halte Hayam Wuruk', '(Barat Jalan) SMP 4Yogya, Dinas Pendidikan Yogyakarta, RS Bethesdha Lempuyangwangi', '-7.795654674673294', '110.37262139719769'),
(107, 'Halte Sorogenen', '(Utara Jalan) RS. Jogja', '-7.8246647263084315', '110.37916866940304'),
(108, 'Halte Sorogenen(Nitikan)', '(Selatan Jalan) RS. Jogja', '-7.824922478105287', '110.37996796768948'),
(109, 'Halte PA Muhamadiyah', '(Barat Jalan) Panti Asuhan Muhamadiyah', '-7.816910840049571', '110.37592856091305'),
(110, 'Halte Lowanu', '(Timur Jalan) Panti Asuhan Muhamadiyah', '-7.81975', '110.376444444444'),
(111, 'Halte RSI Hidayatullah(Jl. Veteran)', '(Utara Jalan) RSI. Hidayatulloh, XT Square', '-7.815544993204594', '110.3878590266113'),
(112, 'Halte Pasar Seni Kerajinan Yogyakarta (Jl. Veteran)', '(Selatan Jalan) XT Square', '-7.816379382664447', '110.38590101403042'),
(113, 'Halte Ngeksigondo (Basen)', '(Selatan Jalan) Balai Diklat VIII Yogyakarta', '-7.819291760826941', '110.39514927071377'),
(114, 'Halte Ngeksigondo(Diklat PU)', '(Utara Jalan) Balai Diklat VIII Yogyakarta', '-7.81896225920788', '110.39509562653348'),
(115, 'Halte SMK Muhamadiyah 3', '(Selatan Jalan) SMK Muhamadiyah 3', '-7.822581448205279', '110.38948980969235'),
(116, 'Halte Tegalturi', '(Selatan Jalan) SD Giwangan', '-7.825573499975433', '110.38716701668545'),
(117, 'Halte UAD', '(Utara Jalan) Universitas Ahmad Dahlan Kampus II', '-7.820386554660223', '110.38848666352078'),
(118, 'Halte Tegal Gendu 2', '(Selatan Jalan)', '-7.826009285475561', '110.39134053391263'),
(119, 'Halte Tegal Gendu 1', '(Utara Jalan)', '-7.825998656566342', '110.39184478920743'),
(120, 'Halte Giwangan', '(Dalam) Terminal Giwangan', '-7.83348055277778', '110.392108333333');

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE IF NOT EXISTS `route` (
`id` int(11) NOT NULL,
  `id_trayek` int(100) NOT NULL,
  `lat` varchar(100) NOT NULL,
  `lng` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1521 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`id`, `id_trayek`, `lat`, `lng`) VALUES
(152, 1, '-7.784688007735897', '110.4378667473793'),
(153, 1, '-7.78357983286976', '110.43800354003906'),
(154, 1, '-7.783571860378677', '110.43505847454071'),
(155, 1, '-7.783611722832579', '110.43034315109253'),
(156, 1, '-7.783497450454591', '110.42641371488571'),
(157, 1, '-7.783457587989823', '110.42236894369125'),
(158, 1, '-7.783420383019289', '110.41961163282394'),
(159, 1, '-7.78342835551326', '110.4152637720108'),
(160, 1, '-7.783399123034648', '110.41222482919693'),
(161, 1, '-7.783380520547192', '110.41095614433289'),
(162, 1, '-7.783640955296357', '110.41054308414459'),
(163, 1, '-7.784507298378569', '110.41048139333725'),
(164, 1, '-7.785937026163359', '110.4104009270668'),
(165, 1, '-7.787138029127933', '110.41029900312424'),
(166, 1, '-7.788294206034928', '110.41028290987015'),
(167, 1, '-7.797324536125533', '110.4099851846695'),
(168, 1, '-7.7986874308903', '110.40993958711624'),
(169, 1, '-7.798634282864365', '110.40891766548157'),
(170, 1, '-7.798615681053693', '110.40765166282654'),
(171, 1, '-7.798631625462889', '110.40599942207336'),
(172, 1, '-7.7986794586868395', '110.40266275405884'),
(173, 1, '-7.798971772714311', '110.40238916873932'),
(174, 1, '-7.799643917085932', '110.40235832333565'),
(175, 1, '-7.80242903494297', '110.40228724479675'),
(176, 1, '-7.802362600503825', '110.40085226297379'),
(177, 1, '-7.802298823432339', '110.398910343647'),
(178, 1, '-7.802227074215254', '110.39633005857468'),
(179, 1, '-7.802193679865629', '110.39452493190765'),
(180, 1, '-7.802167106076287', '110.39329245686531'),
(181, 1, '-7.80217773559223', '110.39176896214485'),
(182, 1, '-7.802135217526842', '110.39060488343239'),
(183, 1, '-7.802041057669235', '110.38999199867249'),
(184, 1, '-7.8019932248297374', '110.3880313038826'),
(185, 1, '-7.801950706745597', '110.38452297449112'),
(186, 1, '-7.801881614849633', '110.3820151090622'),
(187, 1, '-7.801844411516309', '110.380539894104'),
(188, 1, '-7.801801893417042', '110.37862747907639'),
(189, 1, '-7.801738116260012', '110.37590771913528'),
(190, 1, '-7.801653080035523', '110.37554830312729'),
(191, 1, '-7.801618534064374', '110.37186026573181'),
(192, 1, '-7.8015733585593585', '110.36929339170456'),
(193, 1, '-7.801485664918027', '110.366852581501'),
(194, 1, '-7.801419230329', '110.36474704742432'),
(195, 1, '-7.801308771772234', '110.36195620894432'),
(196, 1, '-7.799519196616335', '110.36203533411026'),
(197, 1, '-7.799163105421708', '110.36208897829056'),
(198, 1, '-7.797815802412418', '110.36212384700775'),
(199, 1, '-7.796396744847393', '110.36210507154465'),
(200, 1, '-7.796136318030061', '110.36193609237671'),
(201, 1, '-7.795603328398025', '110.36126017570496'),
(202, 1, '-7.7939490807744765', '110.36126956343651'),
(203, 1, '-7.7935185766958375', '110.36130174994469'),
(204, 1, '-7.7926004322185145', '110.36148011684418'),
(205, 1, '-7.791615849622829', '110.36163970828056'),
(206, 1, '-7.790708330820917', '110.3618448972702'),
(207, 1, '-7.790089144096792', '110.36201119422913'),
(208, 1, '-7.789784865306768', '110.36209031939507'),
(209, 1, '-7.789657307320286', '110.36156594753265'),
(210, 1, '-7.789644197148454', '110.36044210195541'),
(211, 1, '-7.789490064524808', '110.35887569189072'),
(212, 1, '-7.7894076832716745', '110.35741120576859'),
(213, 1, '-7.788605129570726', '110.35742998123169'),
(214, 1, '-7.788171962530289', '110.35758018493652'),
(215, 1, '-7.787826491563482', '110.35874962806702'),
(216, 1, '-7.787241847739873', '110.35948723554611'),
(217, 1, '-7.786755529755941', '110.35986006259918'),
(218, 1, '-7.785519801191842', '110.36053866147995'),
(219, 1, '-7.78502550874585', '110.36068350076675'),
(220, 1, '-7.782761677241004', '110.3607451915741'),
(221, 1, '-7.782857347308898', '110.36401748657227'),
(222, 1, '-7.782793567266062', '110.36705911159515'),
(223, 1, '-7.782910497337182', '110.36867380142212'),
(224, 1, '-7.782985704745458', '110.37146061658859'),
(225, 1, '-7.783020252254035', '110.37227600812912'),
(226, 1, '-7.783006964751063', '110.37486970424652'),
(227, 1, '-7.7811747911835845', '110.37520229816437'),
(228, 1, '-7.7797158144212455', '110.37538200616837'),
(229, 1, '-7.776215844010687', '110.37599623203278'),
(230, 1, '-7.776008378426941', '110.37586346268654'),
(231, 1, '-7.775802418640258', '110.37599757313728'),
(232, 1, '-7.775887460112828', '110.37623628973961'),
(233, 1, '-7.7760389401931285', '110.37627249956131'),
(234, 1, '-7.776104050035394', '110.37671908736229'),
(235, 1, '-7.776105378807579', '110.37716433405876'),
(236, 1, '-7.776213186467002', '110.37934362888336'),
(237, 1, '-7.776521461421218', '110.38004904985428'),
(238, 1, '-7.776707312175125', '110.38154572248459'),
(239, 1, '-7.776917434952478', '110.38285732269287'),
(240, 1, '-7.777169901102807', '110.38406431674957'),
(241, 1, '-7.7778620119572', '110.3861765563488'),
(242, 1, '-7.777612203758238', '110.38752436637878'),
(243, 1, '-7.777885929755682', '110.38869246840477'),
(244, 1, '-7.780234030792447', '110.38827538490295'),
(245, 1, '-7.782157892438573', '110.3879226744175'),
(246, 1, '-7.7831227431361345', '110.3877791762352'),
(247, 1, '-7.783117782383116', '110.39223432540894'),
(248, 1, '-7.783170932378373', '110.39950847625732'),
(249, 1, '-7.783178550630319', '110.4040253162384'),
(250, 1, '-7.783245342360433', '110.41013538837433'),
(266, 2, '-7.746761609424587', '110.36256909370422'),
(267, 2, '-7.749174466886437', '110.36250472068787'),
(268, 2, '-7.749841552736038', '110.36388605833054'),
(269, 2, '-7.750303994099111', '110.36533981561661'),
(270, 2, '-7.750455483400681', '110.36624908447266'),
(271, 2, '-7.750527241471871', '110.36724418401718'),
(272, 2, '-7.75087043977609', '110.36990761756897'),
(273, 2, '-7.75117040577903', '110.37121653556824'),
(274, 2, '-7.75224411603916', '110.37080347537994'),
(275, 2, '-7.75307331614771', '110.37052989006042'),
(276, 2, '-7.753570303891233', '110.3703448176384'),
(277, 2, '-7.754128417769814', '110.37006855010986'),
(278, 2, '-7.7557708628889435', '110.3698942065239'),
(279, 2, '-7.7579262301687715', '110.36971986293793'),
(280, 2, '-7.760517440080982', '110.3694623708725'),
(281, 2, '-7.7619510589037', '110.36934837698936'),
(282, 2, '-7.762146394952884', '110.36941677331924'),
(283, 2, '-7.7635071006951275', '110.3693363070488'),
(284, 2, '-7.764721810285239', '110.36920219659805'),
(285, 2, '-7.766584795264395', '110.36906003952026'),
(286, 2, '-7.7732843859787275', '110.36812528967857'),
(287, 2, '-7.775777171949774', '110.36796033382416'),
(288, 2, '-7.778448176050363', '110.36762773990631'),
(289, 2, '-7.780669687076805', '110.36734744906425'),
(290, 2, '-7.780936767294414', '110.36725893616676'),
(291, 2, '-7.7823361237252175', '110.36712348461151'),
(292, 2, '-7.782902171883992', '110.36711007356644'),
(293, 2, '-7.784092730775016', '110.36699205636978'),
(294, 2, '-7.7856166228986625', '110.36676809191704'),
(295, 2, '-7.788349836367995', '110.36640867590904'),
(296, 2, '-7.789543215009363', '110.36622762680054'),
(297, 2, '-7.789660143196971', '110.36639660596848'),
(298, 2, '-7.789782386267287', '110.367571413517'),
(299, 2, '-7.789734552026628', '110.36883741617203'),
(300, 2, '-7.789864767446721', '110.36900103092194'),
(301, 2, '-7.7905238162988555', '110.3689232468605'),
(302, 2, '-7.790630114403682', '110.36848604679108'),
(303, 2, '-7.790499899221546', '110.36798179149628'),
(304, 2, '-7.790515843939905', '110.36763578653336'),
(305, 2, '-7.790165059995874', '110.36731123924255'),
(306, 2, '-7.790080021419735', '110.36614716053009'),
(307, 2, '-7.791823308779005', '110.3659138083458'),
(308, 2, '-7.793720720003308', '110.36571264266968'),
(309, 2, '-7.795833373642312', '110.36543101072311'),
(310, 2, '-7.797457053656524', '110.36523520946503'),
(311, 2, '-7.799867314029465', '110.36498576402664'),
(312, 2, '-7.801384418340647', '110.36476381123066'),
(313, 2, '-7.8014156426013885', '110.36569520831108'),
(314, 2, '-7.801465556777995', '110.36771893501282'),
(315, 2, '-7.801513389677846', '110.369373857975'),
(316, 2, '-7.803704572829909', '110.36925852298737'),
(317, 2, '-7.803967652302616', '110.36941677331924'),
(318, 2, '-7.805540810946939', '110.36935240030289'),
(319, 2, '-7.8063831924491005', '110.36929875612259'),
(320, 2, '-7.80822739081928', '110.3691565990448'),
(321, 2, '-7.809436478993031', '110.36898761987686'),
(322, 2, '-7.811142306704383', '110.36892995238304'),
(323, 2, '-7.812870891054566', '110.3687971830368'),
(324, 2, '-7.814716389430456', '110.3687059879303'),
(325, 2, '-7.814883799246731', '110.37018656730652'),
(326, 2, '-7.81511250328518', '110.37192463874817'),
(327, 2, '-7.815266626464307', '110.37301629781723'),
(328, 2, '-7.81545795171095', '110.37468194961548'),
(329, 2, '-7.815739624831169', '110.37615180015564'),
(330, 2, '-7.816335210890554', '110.38056135177612'),
(332, 2, '-7.816837086648077', '110.38409382104874'),
(333, 2, '-7.816693416045699', '110.38433253765106'),
(334, 2, '-7.816305452019138', '110.38574069738388'),
(335, 2, '-7.8157341344336615', '110.38761019706726'),
(336, 2, '-7.815157501514005', '110.38922622799873'),
(337, 2, '-7.814684502487547', '110.39072826504707'),
(338, 2, '-7.8145064633893275', '110.39154633879662'),
(343, 2, '-7.814971667915858', '110.39150476455688'),
(344, 2, '-7.816010669976181', '110.39127141237259'),
(345, 2, '-7.817931886840762', '110.39075911045074'),
(346, 2, '-7.819037313329182', '110.39506942033768'),
(347, 2, '-7.82052272556111', '110.40096759796143'),
(348, 2, '-7.817326026931089', '110.40194392204285'),
(349, 2, '-7.816257797962742', '110.40200561285019'),
(350, 2, '-7.814320629420289', '110.40205121040344'),
(351, 2, '-7.812123035112199', '110.40206998586655'),
(352, 2, '-7.811230176079745', '110.40211021900177'),
(353, 2, '-7.810021093097562', '110.40206730365753'),
(354, 2, '-7.807687951648982', '110.40213704109192'),
(355, 2, '-7.804127449853297', '110.40223360061646'),
(356, 2, '-7.802416102286483', '110.40226578712463'),
(357, 2, '-7.802288193919462', '110.39892911911011'),
(358, 2, '-7.802160993974739', '110.39525985717773'),
(359, 2, '-7.802123790666285', '110.39317309856415'),
(360, 2, '-7.802102531631384', '110.39061427116394'),
(361, 2, '-7.802012180721028', '110.3899598121643'),
(362, 2, '-7.801959033117573', '110.38824319839478'),
(363, 2, '-7.801985606920133', '110.38761019706726'),
(364, 2, '-7.801870985326159', '110.38420379161835'),
(365, 2, '-7.80099936348233', '110.38435131311417'),
(366, 2, '-7.800071934586654', '110.38449883460999'),
(367, 2, '-7.7988176435252825', '110.38474828004837'),
(368, 2, '-7.797696219095446', '110.38492530584335'),
(369, 2, '-7.797563348703159', '110.38424670696259'),
(370, 2, '-7.797526144985776', '110.38326233625412'),
(371, 2, '-7.7974517375410475', '110.38252741098404'),
(372, 2, '-7.797475654221143', '110.38138210773468'),
(373, 2, '-7.797510200534443', '110.38060963153839'),
(374, 2, '-7.7974623671768075', '110.379279255867'),
(375, 2, '-7.797389111308058', '110.37855371832848'),
(376, 2, '-7.797321347363532', '110.37759482860565'),
(377, 2, '-7.796083169680079', '110.37766456604004'),
(378, 2, '-7.794944287541869', '110.37779465317726'),
(379, 2, '-7.792280387722256', '110.37790596485138'),
(380, 2, '-7.791052647805999', '110.37792205810547'),
(381, 2, '-7.790462693578783', '110.3779998421669'),
(382, 2, '-7.789205716259933', '110.37829756736755'),
(383, 2, '-7.788352670307137', '110.37833243608475'),
(384, 2, '-7.788214482014205', '110.37793010473251'),
(385, 2, '-7.788488201088611', '110.37718713283539'),
(386, 2, '-7.7885493227992395', '110.37611424922943'),
(387, 2, '-7.788241056689459', '110.37493407726288'),
(388, 2, '-7.78857589745326', '110.37453174591064'),
(389, 2, '-7.788599814640426', '110.37391483783722'),
(390, 2, '-7.7883287531058505', '110.37326037883759'),
(391, 2, '-7.787845095151155', '110.37309944629669'),
(392, 2, '-7.786920294586724', '110.37322014570236'),
(393, 2, '-7.786885747399649', '110.37420451641083'),
(394, 2, '-7.787425214688136', '110.37530690431595'),
(395, 2, '-7.787629840029642', '110.37607133388519'),
(396, 2, '-7.787029251081148', '110.37643074989319'),
(397, 2, '-7.787292341036238', '110.37852555513382'),
(398, 2, '-7.784863225482643', '110.37893861532211'),
(399, 2, '-7.783056306930966', '110.37920415401459'),
(400, 2, '-7.783080224433172', '110.37619739770889'),
(401, 2, '-7.783027429970915', '110.37486433982849'),
(402, 2, '-7.781241585828156', '110.37520229816437'),
(403, 2, '-7.777584833614159', '110.37573873996735'),
(404, 2, '-7.7762211603956075', '110.37599354982376'),
(405, 2, '-7.776068173833597', '110.37586748600006'),
(406, 2, '-7.775854241438481', '110.37590235471725'),
(407, 2, '-7.77578248769146', '110.37609279155731'),
(408, 2, '-7.775886131988761', '110.3762537240982'),
(409, 2, '-7.776038940841949', '110.37629932165146'),
(410, 2, '-7.7761053794564', '110.37668287754059'),
(411, 2, '-7.77611733840588', '110.37716433405876'),
(412, 2, '-7.776182448235995', '110.37856712937355'),
(413, 2, '-7.776202379814609', '110.3793329000473'),
(414, 2, '-7.776317982951968', '110.37957966327667'),
(415, 2, '-7.7764973670675515', '110.38004100322723'),
(416, 2, '-7.776925408867699', '110.38282513618469'),
(417, 2, '-7.7769759021089655', '110.3833669424057'),
(418, 2, '-7.777427683470824', '110.38482069969177'),
(419, 2, '-7.777874149279859', '110.38615375757217'),
(420, 2, '-7.7776190260185905', '110.38750022649765'),
(421, 2, '-7.7778555465473085', '110.3885892033577'),
(422, 2, '-7.77529899174104', '110.3890934586525'),
(423, 2, '-7.773414784933073', '110.38942337036133'),
(424, 2, '-7.771791011772602', '110.38975328207016'),
(425, 2, '-7.770959191010362', '110.38995176553726'),
(426, 2, '-7.769728731078196', '110.39052575826645'),
(427, 2, '-7.7681926442886144', '110.39123117923737'),
(428, 2, '-7.766656551881054', '110.39180517196655'),
(429, 2, '-7.765410133671506', '110.39231479167938'),
(430, 2, '-7.764214206540359', '110.39309531450272'),
(431, 2, '-7.763347821648254', '110.39360493421555'),
(432, 2, '-7.761280184228591', '110.3941735625267'),
(433, 2, '-7.759371993088717', '110.39521157741547'),
(434, 2, '-7.75845244509915', '110.39567023515701'),
(435, 2, '-7.757259155837653', '110.39589554071426'),
(436, 2, '-7.756756857118201', '110.39602965116501'),
(437, 2, '-7.7572883901361775', '110.39598941802979'),
(438, 2, '-7.758492662907992', '110.39574265480042'),
(439, 2, '-7.758726536553418', '110.3945517539978'),
(440, 2, '-7.759305904796614', '110.39236843585968'),
(441, 2, '-7.759733433366441', '110.39087444543839'),
(442, 2, '-7.759919468682389', '110.38954675197601'),
(443, 2, '-7.759587262703304', '110.3880500793457'),
(444, 2, '-7.759061047895301', '110.38734465837479'),
(445, 2, '-7.758239832561023', '110.38652390241623'),
(446, 2, '-7.756714334447739', '110.38495481014252'),
(447, 2, '-7.755855907118607', '110.38411796092987'),
(448, 2, '-7.754973558936159', '110.38332134485245'),
(449, 2, '-7.753689898486973', '110.38168251514435'),
(450, 2, '-7.752605561143477', '110.37962257862091'),
(451, 2, '-7.752095283779804', '110.37797838449478'),
(452, 2, '-7.7520288413692215', '110.3773158788681'),
(453, 2, '-7.752175014658656', '110.37608206272125'),
(454, 2, '-7.752097941476015', '110.37511110305786'),
(455, 2, '-7.751625224262796', '110.3727239370346'),
(456, 2, '-7.7510458454424365', '110.36987006664276'),
(457, 2, '-7.750865121610543', '110.36873281002045'),
(463, 3, '-7.756778119830599', '110.39603501558304'),
(464, 3, '-7.757320283474699', '110.39597868919373'),
(465, 3, '-7.758494968972662', '110.39574801921844'),
(466, 3, '-7.760605142290932', '110.39466440677643'),
(467, 3, '-7.761312074587872', '110.3942808508873'),
(468, 3, '-7.763387684725316', '110.39369612932205'),
(469, 3, '-7.764397935219708', '110.39310872554779'),
(470, 3, '-7.765574904289561', '110.39235770702362'),
(471, 3, '-7.766683126624346', '110.39191246032715'),
(472, 3, '-7.7681607518562075', '110.39137333631516'),
(473, 3, '-7.7693407222291215', '110.39082616567612'),
(474, 3, '-7.770945901827752', '110.39007782936096'),
(475, 3, '-7.775464112731811', '110.38918197154999'),
(476, 3, '-7.777916668510691', '110.3886803984642'),
(477, 3, '-7.7776414366402715', '110.38751900196075'),
(478, 3, '-7.777903203720407', '110.38621544837952'),
(479, 3, '-7.777444779030988', '110.38478717207909'),
(480, 3, '-7.776970320044591', '110.38323014974594'),
(481, 3, '-7.776732558809645', '110.38153633475304'),
(482, 3, '-7.776529256920146', '110.38002088665962'),
(483, 3, '-7.776234269689631', '110.37935703992844'),
(484, 3, '-7.776138598110873', '110.3771536052227'),
(485, 3, '-7.776134611794609', '110.3762349486351'),
(486, 3, '-7.776226297058897', '110.37610486149788'),
(487, 3, '-7.7770076141503734', '110.3759291768074'),
(488, 3, '-7.778041395412564', '110.37577360868454'),
(489, 3, '-7.7797104993782265', '110.37548124790192'),
(490, 3, '-7.780964847663439', '110.37527740001678'),
(491, 3, '-7.782649707886987', '110.37501990795135'),
(492, 3, '-7.784371766228337', '110.37474364042282'),
(493, 3, '-7.78582807060141', '110.37447810173035'),
(494, 3, '-7.786925609538334', '110.37430375814438'),
(495, 3, '-7.787443816996042', '110.37537395954132'),
(496, 3, '-7.787637812443527', '110.37608742713928'),
(497, 3, '-7.787034566031371', '110.37643879652023'),
(498, 3, '-7.787159467342193', '110.37736684083939'),
(499, 3, '-7.787308285876693', '110.37858188152313'),
(500, 3, '-7.78879115338622', '110.37836998701096'),
(501, 3, '-7.790720467771577', '110.37795960903168'),
(502, 3, '-7.7920438766319355', '110.37791401147842'),
(503, 3, '-7.793268956206089', '110.37789791822433'),
(504, 3, '-7.795017545136171', '110.37780940532684'),
(505, 3, '-7.795955614910157', '110.37773430347443'),
(506, 3, '-7.797318868368682', '110.37768334150314'),
(507, 3, '-7.797436945322847', '110.3792779147625'),
(508, 3, '-7.797478312927524', '110.38066327571869'),
(509, 3, '-7.797417014754339', '110.38179516792297'),
(510, 3, '-7.797418343458932', '110.38254484534264'),
(511, 3, '-7.7975259685172285', '110.38337364792824'),
(512, 3, '-7.7975259685172285', '110.38427755236626'),
(513, 3, '-7.797697371330702', '110.38497224450111'),
(514, 3, '-7.798808166156138', '110.38477778434753'),
(515, 3, '-7.800106304218094', '110.38453102111816'),
(516, 3, '-7.801049855119184', '110.38438349962234'),
(517, 3, '-7.801881616147186', '110.38421720266342'),
(518, 3, '-7.801918819477191', '110.3860330581665'),
(519, 3, '-7.801979939226461', '110.3875806927681'),
(520, 3, '-7.801948050662741', '110.38819760084152'),
(521, 3, '-7.801982596606651', '110.3895252943039'),
(522, 3, '-7.802003855647647', '110.39011269807816'),
(523, 3, '-7.802091549180317', '110.3906062245369'),
(524, 3, '-7.802139382008556', '110.39197415113449'),
(525, 3, '-7.8021181229744565', '110.39318382740021'),
(526, 3, '-7.8021659557996665', '110.3952357172966'),
(527, 3, '-7.802240362405784', '110.39709448814392'),
(528, 3, '-7.802298824729878', '110.40016025304794'),
(529, 3, '-7.8023572870457905', '110.40158182382584'),
(530, 3, '-7.802413091976093', '110.40228992700577'),
(531, 3, '-7.803093202287618', '110.4022416472435'),
(532, 3, '-7.806477268935209', '110.40220141410828'),
(533, 3, '-7.808092224550555', '110.4021692276001'),
(534, 3, '-7.8104622107897015', '110.40208876132965'),
(535, 3, '-7.81156765705738', '110.40213704109192'),
(536, 3, '-7.8130344921079615', '110.40210753679276'),
(537, 3, '-7.81691449946845', '110.40201365947723'),
(538, 3, '-7.818041186876798', '110.40178835391998'),
(539, 3, '-7.8195740805683265', '110.40120631456375'),
(540, 3, '-7.820645311225891', '110.40097296237946'),
(541, 3, '-7.819831835511299', '110.39769530296326'),
(542, 3, '-7.8191754901368276', '110.39515256881714'),
(543, 3, '-7.818367679027792', '110.39212435483932'),
(544, 3, '-7.818014261175834', '110.39068669080734'),
(545, 3, '-7.816762681263151', '110.39100855588913'),
(546, 3, '-7.81601598577448', '110.3912204504013'),
(547, 3, '-7.8153862073487534', '110.3913626074791'),
(548, 3, '-7.814543844002839', '110.39152890443802'),
(549, 3, '-7.814723033975928', '110.3907161951065'),
(550, 3, '-7.81518806107019', '110.38922622799873'),
(551, 3, '-7.815767349942643', '110.38761556148529'),
(552, 3, '-7.816127324692638', '110.38642935454845'),
(553, 3, '-7.8163439820198475', '110.3857259452343'),
(554, 3, '-7.816617682680915', '110.38454577326775'),
(555, 3, '-7.816834251523388', '110.38408443331718'),
(556, 3, '-7.816967115788311', '110.38401737809181'),
(557, 3, '-7.816656389802541', '110.38192391395569'),
(558, 3, '-7.816340172547156', '110.37976205348969'),
(559, 3, '-7.815575225573672', '110.37463903427124'),
(560, 3, '-7.815317115079572', '110.37297070026398'),
(561, 3, '-7.815162991919082', '110.37191927433014'),
(562, 3, '-7.814931807071658', '110.37016779184341'),
(563, 3, '-7.8147590826768125', '110.36866575479507'),
(564, 3, '-7.812327647074092', '110.36877572536469'),
(565, 3, '-7.810988361060828', '110.36888837814331'),
(566, 3, '-7.80944179625366', '110.3689393401146'),
(567, 3, '-7.808206134689878', '110.36911368370056'),
(568, 3, '-7.807055504614625', '110.36922097206116'),
(569, 3, '-7.805726828530837', '110.36930412054062'),
(570, 3, '-7.8039596827948925', '110.369373857975'),
(571, 3, '-7.803739121223775', '110.36929607391357'),
(572, 3, '-7.803696603317173', '110.36906808614731'),
(573, 3, '-7.8029536901748395', '110.3691378235817'),
(574, 3, '-7.801552100794032', '110.3692638874054'),
(575, 3, '-7.8014670645317095', '110.36686062812805'),
(576, 3, '-7.801411259475165', '110.36473631858826'),
(577, 3, '-7.801334017572748', '110.3629969060421'),
(578, 3, '-7.80131293626218', '110.36187171936035'),
(579, 3, '-7.801265103339402', '110.36054939031601'),
(580, 3, '-7.801196011330173', '110.3582614660263'),
(581, 3, '-7.801201326100517', '110.35645097494125'),
(582, 3, '-7.803000727508911', '110.35637855529785'),
(583, 3, '-7.803867030444456', '110.35634636878967'),
(584, 3, '-7.803882619126651', '110.35615593194962'),
(586, 3, '-7.802843585685856', '110.35615056753159'),
(587, 3, '-7.802809039813075', '110.35636514425278'),
(588, 3, '-7.801190695262215', '110.35640269517899'),
(589, 3, '-7.801187860761208', '110.35588100552559'),
(590, 3, '-7.801121426124892', '110.35495966672897'),
(591, 3, '-7.8011121252749565', '110.35340934991837'),
(592, 3, '-7.801039224277014', '110.35165518522263'),
(593, 3, '-7.800348657530128', '110.35181879997253'),
(594, 3, '-7.799365067629005', '110.3521379828453'),
(595, 3, '-7.798328681584246', '110.35232841968536'),
(596, 3, '-7.797308237431704', '110.35252153873444'),
(597, 3, '-7.796516328535753', '110.35265296697617'),
(598, 3, '-7.795623436171034', '110.35284340381622'),
(599, 3, '-7.793454975354654', '110.35329133272171'),
(600, 3, '-7.792647114531438', '110.35345762968063'),
(601, 3, '-7.792724180269341', '110.35392701625824'),
(602, 3, '-7.792822505500542', '110.35482287406921'),
(603, 3, '-7.792944747647682', '110.35513401031494'),
(604, 3, '-7.792960692272928', '110.35567849874496'),
(605, 3, '-7.79280656087003', '110.35626858472824'),
(606, 3, '-7.7928411075687105', '110.35684525966644'),
(607, 3, '-7.791942892476346', '110.35703033208847'),
(608, 3, '-7.791342309712428', '110.3573602437973'),
(609, 3, '-7.789524611497107', '110.35745948553085'),
(610, 3, '-7.78889213570663', '110.35745948553085'),
(611, 3, '-7.7885493227992395', '110.35744071006775'),
(612, 3, '-7.788182592401679', '110.35756677389145'),
(613, 3, '-7.7878185191531974', '110.3587281703949'),
(614, 3, '-7.7874730478949115', '110.35927534103394'),
(615, 3, '-7.786970785326662', '110.35970985889435'),
(616, 3, '-7.785419171005896', '110.36059498786926'),
(617, 3, '-7.784536530698789', '110.36069959402084'),
(618, 3, '-7.782756007989471', '110.36077201366425'),
(619, 3, '-7.782795693397416', '110.36341935396194'),
(620, 3, '-7.782856815938348', '110.36437690258026'),
(621, 3, '-7.7828807334519405', '110.36499917507172'),
(622, 3, '-7.782823597167199', '110.36701083183289'),
(623, 3, '-7.782733242096372', '110.36705777049065'),
(624, 3, '-7.781573417831312', '110.36712348461151'),
(625, 3, '-7.7809595326362455', '110.36720663309097'),
(626, 3, '-7.780651260943892', '110.3673005104065'),
(627, 3, '-7.7789796803212905', '110.36750167608261'),
(628, 3, '-7.778086751879044', '110.36763042211533'),
(629, 3, '-7.777285327496489', '110.36773771047592'),
(630, 3, '-7.775739966946683', '110.36791607737541'),
(631, 3, '-7.774079174758983', '110.3680032491684'),
(632, 3, '-7.771509309079217', '110.36829024553299'),
(633, 3, '-7.769399190441019', '110.36858797073364'),
(634, 3, '-7.7674644627749405', '110.36891251802444'),
(635, 3, '-7.76594697096565', '110.36908686161041'),
(636, 3, '-7.764418843201968', '110.36918073892593'),
(637, 3, '-7.763044852276751', '110.36932021379471'),
(638, 3, '-7.762089256494679', '110.36939933896065'),
(639, 3, '-7.761943086650649', '110.36932691931725'),
(640, 3, '-7.760488207304607', '110.36943018436432'),
(641, 3, '-7.758324880184541', '110.36962062120438'),
(642, 3, '-7.757243212451144', '110.36974668502808'),
(643, 3, '-7.754572072874842', '110.36995589733124'),
(644, 3, '-7.753926256000369', '110.37010610103607'),
(645, 3, '-7.753425282145537', '110.3703635931015'),
(646, 3, '-7.752520338471695', '110.37068143486977'),
(647, 3, '-7.751292482270059', '110.37113606929779'),
(648, 3, '-7.751093331114721', '110.37019461393356'),
(649, 3, '-7.7508647686342265', '110.36907345056534'),
(650, 3, '-7.750713279479942', '110.36750167608261'),
(651, 3, '-7.750598998152025', '110.36627858877182'),
(652, 3, '-7.75032791208732', '110.36491066217422'),
(653, 3, '-7.749923940372888', '110.36369562149048'),
(654, 3, '-7.749583753365348', '110.36297410726547'),
(655, 3, '-7.749097391775604', '110.3624752163887'),
(656, 3, '-7.748480801411611', '110.36239743232727'),
(657, 3, '-7.747656907705709', '110.36244034767151'),
(658, 3, '-7.746742649577589', '110.36248862743378'),
(659, 3, '-7.746747965037554', '110.36259323358536'),
(660, 3, '-7.747598437768551', '110.36254227161407'),
(661, 3, '-7.748937928836998', '110.3624564409256'),
(662, 3, '-7.7492302775116375', '110.36255568265915'),
(663, 3, '-7.749799027987999', '110.363789498806'),
(664, 3, '-7.750176422739836', '110.36475777626038'),
(665, 3, '-7.750508636149854', '110.36620885133743'),
(666, 3, '-7.75059368274066', '110.36752313375473'),
(667, 3, '-7.750971076780129', '110.37022948265076'),
(668, 3, '-7.751491986306946', '110.37278831005096'),
(669, 3, '-7.75200261737741', '110.37545442581177'),
(670, 3, '-7.751896309492033', '110.37743926048279'),
(671, 3, '-7.752231179240038', '110.37899494171143'),
(672, 3, '-7.753373986691271', '110.38152694702148'),
(673, 3, '-7.754309491876144', '110.3828090429306'),
(674, 3, '-7.755308779207918', '110.38383901119232'),
(675, 3, '-7.757169148236712', '110.3857272863388'),
(676, 3, '-7.759045454951189', '110.38762092590332'),
(677, 3, '-7.759688606317626', '110.38917660713196'),
(678, 3, '-7.759608876862809', '110.39065718650818'),
(679, 3, '-7.758577707885009', '110.39468586444855'),
(680, 3, '-7.758391319005449', '110.3953805565834'),
(681, 3, '-7.758141499225795', '110.39571851491928'),
(682, 3, '-7.757253840510419', '110.39588749408722'),
(683, 3, '-7.757118299643496', '110.39597868919373'),
(684, 4, '-7.83349634089081', '110.39042115211487'),
(685, 4, '-7.832602819042313', '110.39011538028717'),
(686, 4, '-7.830971304119964', '110.38996517658234'),
(687, 4, '-7.829472288718994', '110.38982033729553'),
(688, 4, '-7.827365119674754', '110.3899410367012'),
(689, 4, '-7.825964763105871', '110.39009124040604'),
(690, 4, '-7.825188851937947', '110.39009928703308'),
(691, 4, '-7.825882389043551', '110.3914001584053'),
(692, 4, '-7.826927032580363', '110.3932535648346'),
(693, 4, '-7.827240584589995', '110.39447665214539'),
(694, 4, '-7.826342443458007', '110.39460003376007'),
(695, 4, '-7.825189206149108', '110.39493262767792'),
(696, 4, '-7.824413293537772', '110.39514720439911'),
(697, 4, '-7.822882721961581', '110.3954690694809'),
(698, 4, '-7.822446933193687', '110.3965312242508'),
(699, 4, '-7.822289801202171', '110.39706498384476'),
(700, 4, '-7.8224412644802', '110.39855360984802'),
(701, 4, '-7.82267775966397', '110.39936363697052'),
(702, 4, '-7.8228292228011', '110.4005840420723'),
(703, 4, '-7.820570910493622', '110.40096759796143'),
(704, 4, '-7.819722888862637', '110.40111780166626'),
(705, 4, '-7.818830046085679', '110.40148258209229'),
(706, 4, '-7.817320712284774', '110.40194392204285'),
(707, 4, '-7.81629765722062', '110.40200561285019'),
(708, 4, '-7.814868033216324', '110.40203511714935'),
(709, 4, '-7.813031836095561', '110.40206462144852'),
(710, 4, '-7.8122027545758375', '110.40206462144852'),
(711, 4, '-7.810762487253365', '110.40210217237473'),
(712, 4, '-7.808971446791676', '110.4020968079567'),
(713, 4, '-7.807408930444088', '110.40213972330093'),
(714, 4, '-7.8058464082538075', '110.40215313434601'),
(715, 4, '-7.804222760809532', '110.4022228717804'),
(716, 4, '-7.802421062810831', '110.40224969387054'),
(717, 4, '-7.80043901139499', '110.40229797363281'),
(718, 4, '-7.798791426350112', '110.40235161781311'),
(719, 4, '-7.798570506521901', '110.40252596139908'),
(720, 4, '-7.7985333028940556', '110.40414601564407'),
(721, 4, '-7.798522673285495', '110.40566146373749'),
(722, 4, '-7.798573163923757', '110.40659487247467'),
(723, 4, '-7.798557219512334', '110.40848314762115'),
(724, 4, '-7.798620997154387', '110.40981620550156'),
(725, 4, '-7.796351570076015', '110.40992081165314'),
(726, 4, '-7.793096222860666', '110.41004419326782'),
(727, 4, '-7.790978240508111', '110.41010588407516'),
(728, 4, '-7.788640033453344', '110.41017830371857'),
(729, 4, '-7.785748701653636', '110.41028559207916'),
(730, 4, '-7.783675859592486', '110.41042506694794'),
(731, 4, '-7.783271919946035', '110.41161596775055'),
(732, 4, '-7.783277234943903', '110.41511356830597'),
(733, 4, '-7.783325069921738', '110.41838049888611'),
(734, 4, '-7.783268906902772', '110.41990667581558'),
(735, 4, '-7.783327371876102', '110.42292952537537'),
(736, 4, '-7.783375206848238', '110.42640030384064'),
(737, 4, '-7.783473889817911', '110.42973697185516'),
(738, 4, '-7.783521724773316', '110.43161451816559'),
(739, 4, '-7.783457944831558', '110.43398022651672'),
(740, 4, '-7.783457944831558', '110.43805181980133'),
(741, 4, '-7.784698638912167', '110.43792307376862'),
(742, 4, '-7.7835585741908', '110.43803304433823'),
(743, 4, '-7.7835642447290985', '110.43383002281189'),
(744, 4, '-7.783574874717367', '110.4297262430191'),
(745, 4, '-7.781363831354268', '110.42991399765015'),
(746, 4, '-7.777707080206176', '110.4302841424942'),
(747, 4, '-7.774454245708693', '110.4305899143219'),
(748, 4, '-7.771142919334649', '110.43087959289551'),
(749, 4, '-7.769420801500539', '110.43108880519867'),
(750, 4, '-7.767618953859592', '110.43133556842804'),
(751, 4, '-7.76620510929557', '110.43060064315796'),
(752, 4, '-7.765599174454369', '110.42877674102783'),
(753, 4, '-7.765147380363701', '110.42648613452911'),
(754, 4, '-7.7645308135267035', '110.42364299297333'),
(755, 4, '-7.763637853055432', '110.4198557138443'),
(756, 4, '-7.762782097490016', '110.4162722826004'),
(757, 4, '-7.761830665343883', '110.4119861125946'),
(758, 4, '-7.760608151603824', '110.40808081626892'),
(759, 4, '-7.759178337545546', '110.40355861186981'),
(760, 4, '-7.758349149470268', '110.40083885192871'),
(761, 4, '-7.758200320668315', '110.39868772029877'),
(762, 4, '-7.758556446642371', '110.3956139087677'),
(763, 4, '-7.75727013946284', '110.3958660364151'),
(764, 4, '-7.756807352783775', '110.39601624011993'),
(765, 4, '-7.75731762443268', '110.39597064256668'),
(766, 4, '-7.758492309938087', '110.39574265480042'),
(767, 4, '-7.759241768206639', '110.39258033037186'),
(768, 4, '-7.759815820445091', '110.39032727479935'),
(769, 4, '-7.759682938052203', '110.38849800825119'),
(770, 4, '-7.758869696892756', '110.38728833198547'),
(771, 4, '-7.758189337067427', '110.38651049137115'),
(772, 4, '-7.756658523436242', '110.38498967885971'),
(773, 4, '-7.754947335127854', '110.38328647613525'),
(774, 4, '-7.756097755243065', '110.38269370794296'),
(775, 4, '-7.756905686430939', '110.38225919008255'),
(776, 4, '-7.757966093759901', '110.38181394338608'),
(777, 4, '-7.759414515490461', '110.38121581077576'),
(778, 4, '-7.760403160118643', '110.3808268904686'),
(779, 4, '-7.761535314821214', '110.3803601861'),
(780, 4, '-7.763892634442235', '110.37938386201859'),
(781, 4, '-7.765901791615838', '110.37852019071579'),
(782, 4, '-7.765237388851774', '110.37679553031921'),
(783, 4, '-7.7649131599214565', '110.37610352039337'),
(784, 4, '-7.7648387466890485', '110.37582188844681'),
(785, 4, '-7.765301171562715', '110.37527471780777'),
(786, 4, '-7.765830036167932', '110.375135242939'),
(787, 4, '-7.766372188137512', '110.37503600120544'),
(788, 4, '-7.76672033437653', '110.37471681833267'),
(789, 4, '-7.7672545123960175', '110.3744325041771'),
(790, 4, '-7.767690358635046', '110.37428230047226'),
(791, 4, '-7.7696091397478275', '110.37358492612839'),
(792, 4, '-7.7706060886818715', '110.37321209907532'),
(793, 4, '-7.770861216206406', '110.37337839603424'),
(794, 4, '-7.771297058702176', '110.37475168704987'),
(795, 4, '-7.7717010098796', '110.37613570690155'),
(796, 4, '-7.772830121016309', '110.3757119178772'),
(797, 4, '-7.773614101991282', '110.37537664175034'),
(798, 4, '-7.774403396612172', '110.3750628232956'),
(799, 4, '-7.77524584074817', '110.37471681833267'),
(800, 4, '-7.776046913476233', '110.37440702319145'),
(801, 4, '-7.776145242620024', '110.37561133503914'),
(802, 4, '-7.776068173833597', '110.37582725286484'),
(803, 4, '-7.77583696738938', '110.37592381238937'),
(804, 4, '-7.775790460330616', '110.37612095475197'),
(805, 4, '-7.775898090944502', '110.37625506520271'),
(806, 4, '-7.776032296979913', '110.37629395723343'),
(807, 4, '-7.776216996305', '110.37612631917'),
(808, 4, '-7.77678438149296', '110.37598013877869'),
(809, 4, '-7.7779857656578635', '110.37576824426651'),
(810, 4, '-7.779745048454283', '110.37548124790192'),
(811, 4, '-7.780893096088291', '110.37528812885284'),
(812, 4, '-7.781754129751035', '110.37520229816437'),
(813, 4, '-7.783003156921167', '110.37496894598007'),
(814, 4, '-7.7843584800658165', '110.37474900484085'),
(815, 4, '-7.786202775501144', '110.3744325041771'),
(816, 4, '-7.786922950764932', '110.37429571151733'),
(817, 4, '-7.787430528335745', '110.37527740001678'),
(818, 4, '-7.788296863502025', '110.37489652633667'),
(819, 4, '-7.788605129570726', '110.374416410923'),
(820, 4, '-7.788602472105589', '110.37392288446426'),
(821, 4, '-7.788227769352055', '110.37318527698517'),
(827, 4, '-7.787927829818976', '110.37312090396881'),
(828, 4, '-7.787999050001704', '110.37234842777252'),
(829, 4, '-7.788666251345399', '110.37104487419128'),
(830, 4, '-7.789463490009893', '110.36977618932724'),
(831, 4, '-7.78903829624433', '110.3693550825119'),
(832, 4, '-7.7887406603516265', '110.3690654039383'),
(833, 4, '-7.7882543441075605', '110.36877036094666'),
(834, 4, '-7.787802574413249', '110.36858528852463'),
(835, 4, '-7.787146178753979', '110.36850482225418'),
(836, 4, '-7.7864392898897385', '110.36871403455734'),
(837, 4, '-7.785822754338292', '110.36932289600372'),
(838, 4, '-7.785325804763728', '110.36990225315094'),
(839, 4, '-7.784714582553717', '110.370634496212'),
(840, 4, '-7.784254836564849', '110.37119776010513'),
(841, 4, '-7.783029730629304', '110.37145525217056'),
(842, 4, '-7.782984553118527', '110.36949723958969'),
(843, 4, '-7.782918115593862', '110.36847531795502'),
(844, 4, '-7.782973923115297', '110.36705642938614'),
(845, 4, '-7.7828888830796785', '110.36341398954391'),
(846, 4, '-7.782849020557037', '110.36085247993469'),
(848, 4, '-7.785309859928935', '110.36071568727493'),
(849, 4, '-7.787130588231884', '110.35972058773041'),
(850, 4, '-7.787380390759037', '110.35965085029602'),
(851, 4, '-7.78765676784958', '110.35964548587799'),
(852, 4, '-7.787678027618222', '110.35930216312408'),
(853, 4, '-7.788257355736292', '110.35764992237091'),
(854, 4, '-7.788602826347767', '110.35751581192017'),
(855, 4, '-7.788883986236202', '110.35755336284637'),
(856, 4, '-7.789394218891047', '110.35754799842834'),
(857, 4, '-7.789464641537909', '110.35895347595215'),
(858, 4, '-7.78959884323017', '110.36002099514008'),
(859, 4, '-7.7896347189228115', '110.36152571439743'),
(860, 4, '-7.789792837679623', '110.36211982369423'),
(861, 4, '-7.789920395624821', '110.36252483725548'),
(862, 4, '-7.789994804408245', '110.36317124962807'),
(863, 4, '-7.78997620221363', '110.36372110247612'),
(864, 4, '-7.789900464698439', '110.36419317126274'),
(865, 4, '-7.789893821056116', '110.36456599831581'),
(866, 4, '-7.789958928746468', '110.36505684256554'),
(867, 4, '-7.790061240810848', '110.3661122918129'),
(868, 4, '-7.791841909593985', '110.3658977150917'),
(869, 4, '-7.793718061273074', '110.36569118499756'),
(870, 4, '-7.79585728911736', '110.36543369293213'),
(871, 4, '-7.797443765314038', '110.365229845047'),
(872, 4, '-7.79911792965147', '110.36503672599792'),
(873, 4, '-7.800701736095193', '110.3648892045021'),
(874, 4, '-7.8014139155614295', '110.36477118730545'),
(875, 4, '-7.801318249733495', '110.36261200904846'),
(876, 4, '-7.801270416811318', '110.36100000143051'),
(877, 4, '-7.801185380491731', '110.35935312509537'),
(878, 4, '-7.8011880378769725', '110.35642683506012'),
(879, 4, '-7.802817011856718', '110.35639196634293'),
(880, 4, '-7.803707231496685', '110.35640269517899'),
(881, 4, '-7.804236047639091', '110.35630881786346'),
(882, 4, '-7.8060988569625485', '110.35615593194962'),
(883, 4, '-7.808753545202671', '110.35601913928986'),
(884, 4, '-7.811966253455971', '110.35592257976532'),
(885, 4, '-7.812962747329303', '110.35584479570389'),
(886, 4, '-7.813180646722375', '110.35629004240036'),
(887, 4, '-7.813302882917476', '110.35738438367844'),
(888, 4, '-7.813486237143038', '110.35883277654648'),
(889, 4, '-7.814017698211487', '110.3627997636795'),
(890, 4, '-7.814416649086674', '110.36519229412079'),
(891, 4, '-7.814847131644828', '110.36841630935669'),
(892, 4, '-7.8147302105001115', '110.36868453025818'),
(893, 4, '-7.814905592204922', '110.37018120288849'),
(894, 4, '-7.815104533990071', '110.37186294794083'),
(895, 4, '-7.815274600946354', '110.37297070026398'),
(896, 4, '-7.815240056101465', '110.37325769662857'),
(897, 4, '-7.815465926189346', '110.37476509809494'),
(898, 4, '-7.81573431284077', '110.37614643573761'),
(899, 4, '-7.816130249268873', '110.37608206272125'),
(900, 4, '-7.817578469917209', '110.37593990564346'),
(901, 4, '-7.818163071323936', '110.3758916258812'),
(902, 4, '-7.819755928243747', '110.37641331553459'),
(903, 4, '-7.821662690798288', '110.3771361708641'),
(904, 4, '-7.823265012466992', '110.37777721881866'),
(905, 4, '-7.824776981994491', '110.37844777107239'),
(906, 4, '-7.824790090415402', '110.37946969270706'),
(907, 4, '-7.824812676912647', '110.38024619221687'),
(908, 4, '-7.824816840519455', '110.38140624761581'),
(909, 4, '-7.8251197651846995', '110.38240671157837'),
(910, 4, '-7.825252626810537', '110.38383901119232'),
(911, 4, '-7.825377516700228', '110.38524448871613'),
(912, 4, '-7.825515514950617', '110.38729906082153'),
(913, 4, '-7.825792044576541', '110.38876086473465'),
(914, 4, '-7.825977872786918', '110.39008721709251'),
(915, 5, '-7.756746227829782', '110.39604842662811'),
(916, 5, '-7.757264472543594', '110.39594113826752'),
(917, 5, '-7.758048482563595', '110.3958311676979'),
(918, 5, '-7.758348797879032', '110.39613157510757'),
(919, 5, '-7.758144158262585', '110.39759069681168'),
(920, 5, '-7.758093662757501', '110.39951115846634'),
(921, 5, '-7.758556449399951', '110.40194928646088'),
(922, 5, '-7.7603849121758355', '110.40764629840851'),
(923, 5, '-7.761708416725204', '110.41190028190613'),
(924, 5, '-7.762697055958823', '110.41639566421509'),
(925, 5, '-7.763807943505876', '110.42107880115509'),
(926, 5, '-7.76487099104053', '110.42539179325104'),
(927, 5, '-7.765790524988686', '110.42991936206818'),
(928, 5, '-7.766943925997274', '110.43131947517395'),
(929, 5, '-7.769420804095835', '110.43127119541168'),
(930, 5, '-7.773157354355014', '110.43083131313324'),
(931, 5, '-7.779434471298181', '110.43022513389587'),
(932, 5, '-7.78356424213388', '110.42986571788788'),
(941, 5, '-7.783518710515349', '110.43160915374756'),
(942, 5, '-7.783452273075336', '110.4380464553833'),
(943, 5, '-7.784695980205747', '110.43791502714157'),
(944, 5, '-7.784573735651348', '110.43657124042511'),
(945, 5, '-7.784519079925079', '110.43658465147018'),
(946, 5, '-7.784677200612565', '110.43787211179733'),
(947, 5, '-7.7835771754538445', '110.43800354003906'),
(948, 5, '-7.78356654546564', '110.43385952711105'),
(949, 5, '-7.783569202962711', '110.42970210313797'),
(950, 5, '-7.783518710515349', '110.42647272348404'),
(951, 5, '-7.783438985586066', '110.4216742515564'),
(952, 5, '-7.783428355594351', '110.41949093341827'),
(953, 5, '-7.783423040598391', '110.41390389204025'),
(954, 5, '-7.78338317812655', '110.41091591119766'),
(955, 5, '-7.783654242860319', '110.41054040193558'),
(956, 5, '-7.785456375961189', '110.41041970252991'),
(957, 5, '-7.789257271071283', '110.41024804115295'),
(958, 5, '-7.79741028169945', '110.40991544723511'),
(980, 5, '-7.798717725326922', '110.40993690490723'),
(981, 5, '-7.798607708929963', '110.40826052427292'),
(982, 5, '-7.798618338536362', '110.40613889694214'),
(983, 5, '-7.798676801366748', '110.40407627820969'),
(984, 5, '-7.798703375377851', '110.40260642766953'),
(985, 5, '-7.798985059791813', '110.4023864865303'),
(986, 5, '-7.799699899575774', '110.40236234664917'),
(987, 5, '-7.801642450506248', '110.40232211351395'),
(988, 5, '-7.802697784199879', '110.4022765159607'),
(989, 5, '-7.8072259277772575', '110.40219068527222'),
(990, 5, '-7.810356270651393', '110.40208339691162'),
(991, 5, '-7.811514863594402', '110.40213704109192'),
(992, 5, '-7.813037150715377', '110.40211021900177'),
(993, 5, '-7.815617744866309', '110.40206730365753'),
(994, 5, '-7.817329038350411', '110.40199220180511'),
(995, 5, '-7.818561661425092', '110.40164351463318'),
(996, 5, '-7.819361500349751', '110.4012867808342'),
(997, 5, '-7.819927498396584', '110.40113389492035'),
(998, 5, '-7.820748592789648', '110.40095686912537'),
(999, 5, '-7.821782620171353', '110.40073692798615'),
(1000, 5, '-7.822847823533449', '110.40058940649033'),
(1001, 5, '-7.822718769907082', '110.39952725172043'),
(1002, 5, '-7.822454373623301', '110.39852946996689'),
(1003, 5, '-7.822309553477192', '110.39739891886711'),
(1004, 5, '-7.822336125984834', '110.39686381816864'),
(1005, 5, '-7.822651187178094', '110.3959572315216'),
(1006, 5, '-7.822887682242808', '110.39549052715302'),
(1007, 5, '-7.823939950792446', '110.39528131484985'),
(1008, 5, '-7.8248513832738675', '110.39508283138275'),
(1009, 5, '-7.8256538673661', '110.39479583501816'),
(1010, 5, '-7.826605154454562', '110.39457589387894'),
(1011, 5, '-7.827282745889181', '110.3945142030716'),
(1012, 5, '-7.826916049484853', '110.39317578077316'),
(1013, 5, '-7.825900989639683', '110.39135724306107'),
(1014, 5, '-7.825212767029763', '110.39011269807816'),
(1015, 5, '-7.825962105878308', '110.390085875988'),
(1016, 5, '-7.827990628210719', '110.38991689682007'),
(1017, 5, '-7.829468036931169', '110.38979887962341'),
(1018, 5, '-7.832571641066009', '110.3900671005249'),
(1019, 5, '-7.834027776131882', '110.39063572883606'),
(1020, 5, '-7.83254436080111', '110.39007246494293'),
(1021, 5, '-7.829462014105626', '110.38978815078735'),
(1022, 5, '-7.827992222798984', '110.38991421461105'),
(1023, 5, '-7.825986375136262', '110.39005100727081'),
(1024, 5, '-7.825629952299587', '110.38807958364487'),
(1025, 5, '-7.825544743835443', '110.38770407438278'),
(1026, 5, '-7.825465026920879', '110.3863388299942'),
(1027, 5, '-7.825383981375448', '110.38524582982063'),
(1028, 5, '-7.825329508131128', '110.384411662817'),
(1029, 5, '-7.825248462559349', '110.38327172398567'),
(1030, 5, '-7.82510497200017', '110.38230881094933'),
(1031, 5, '-7.824815333498794', '110.38139685988426'),
(1032, 5, '-7.824820647968524', '110.37994176149368'),
(1033, 5, '-7.824794075619211', '110.37847191095352'),
(1034, 5, '-7.824010190552591', '110.37806287407875'),
(1035, 5, '-7.823372452462068', '110.3778026998043'),
(1036, 5, '-7.822673596684545', '110.37751972675323'),
(1037, 5, '-7.821655869256245', '110.37713348865509'),
(1038, 5, '-7.820514576666757', '110.37667483091354'),
(1039, 5, '-7.819220487927574', '110.37617862224579'),
(1040, 5, '-7.8183462450491525', '110.37588223814964'),
(1041, 5, '-7.816909187655196', '110.37600696086884'),
(1042, 5, '-7.815856901209759', '110.37613570690155'),
(1043, 5, '-7.815314813301245', '110.37303507328033'),
(1044, 5, '-7.814921533397598', '110.37019729614258'),
(1045, 5, '-7.81474083710142', '110.36868989467621'),
(1046, 5, '-7.814831185259286', '110.36839485168457'),
(1047, 5, '-7.81456014072704', '110.36607205867767'),
(1048, 5, '-7.814257208394508', '110.36389946937561'),
(1049, 5, '-7.813842669056977', '110.36132454872131'),
(1050, 5, '-7.813422814693018', '110.35837948322296'),
(1054, 5, '-7.813135825553376', '110.35607278347015'),
(1055, 5, '-7.812965757725887', '110.35583138465881'),
(1056, 5, '-7.810669835275905', '110.35597085952759'),
(1057, 5, '-7.807954040182415', '110.3560084104538'),
(1058, 5, '-7.805333892530313', '110.35618007183075'),
(1059, 5, '-7.8042284297703635', '110.35630345344543'),
(1060, 5, '-7.803936119417249', '110.35642683506012'),
(1061, 5, '-7.801181217298051', '110.35643622279167'),
(1068, 5, '-7.801151188875708', '110.35849750041962'),
(1069, 5, '-7.80130000243582', '110.36196291446686'),
(1070, 5, '-7.7998703271154755', '110.36205410957336'),
(1071, 5, '-7.798169591745745', '110.36213457584381'),
(1072, 5, '-7.796511368103563', '110.36213994026184'),
(1073, 5, '-7.796091496168858', '110.36190390586853'),
(1074, 5, '-7.795421826394093', '110.3611958026886'),
(1075, 5, '-7.793556312085925', '110.36131381988525'),
(1076, 5, '-7.791579176736282', '110.36166250705719'),
(1077, 5, '-7.789798683956544', '110.36214530467987'),
(1078, 5, '-7.789623291720917', '110.36148011684418'),
(1079, 5, '-7.78961797680353', '110.3603857755661'),
(1080, 5, '-7.789463844170241', '110.35890519618988'),
(1081, 5, '-7.789421324813154', '110.35744607448578'),
(1082, 5, '-7.788214836256714', '110.35758018493652'),
(1083, 5, '-7.787826845806322', '110.35874426364899'),
(1084, 5, '-7.7872687767201265', '110.35945236682892'),
(1085, 5, '-7.785456375798994', '110.36064326763153'),
(1086, 5, '-7.782782937257972', '110.36078810691833'),
(1087, 5, '-7.782841402299098', '110.36336839199066'),
(1088, 5, '-7.782814827281427', '110.36706447601318'),
(1089, 5, '-7.782915812339644', '110.36848604679108'),
(1090, 5, '-7.7830167973735485', '110.37024557590485'),
(1091, 5, '-7.783059317380538', '110.37226796150208'),
(1092, 5, '-7.783043372378422', '110.37488043308258'),
(1093, 5, '-7.781326623602705', '110.37525594234467'),
(1094, 5, '-7.778164173248023', '110.37564218044281'),
(1095, 5, '-7.776224170894249', '110.37599086761475'),
(1096, 5, '-7.776155074754561', '110.37588357925415'),
(1097, 5, '-7.776080663514464', '110.37426888942719'),
(1098, 5, '-7.774560545292961', '110.37496089935303'),
(1099, 5, '-7.771660789442068', '110.37608206272125'),
(1100, 5, '-7.770842256310504', '110.37331402301788'),
(1101, 5, '-7.770539292344188', '110.37319868803024'),
(1102, 5, '-7.769619768792045', '110.37354201078415'),
(1103, 5, '-7.768612542705979', '110.3739121556282'),
(1104, 5, '-7.767289059902115', '110.37440836429596'),
(1105, 5, '-7.7665608768220045', '110.37482142448425'),
(1106, 5, '-7.766257909767206', '110.37510842084885'),
(1107, 5, '-7.7655164368429945', '110.37517547607422'),
(1108, 5, '-7.76496896853946', '110.37545442581177'),
(1109, 5, '-7.764814826849593', '110.375856757164'),
(1110, 5, '-7.764599559912192', '110.37586748600006'),
(1111, 5, '-7.76459424467778', '110.37611424922943'),
(1112, 5, '-7.764724467901644', '110.37617325782776'),
(1113, 5, '-7.765728691439106', '110.37860065698624'),
(1114, 5, '-7.76382619259774', '110.37939459085464'),
(1115, 5, '-7.762159860248455', '110.38007318973541'),
(1116, 5, '-7.760722079840083', '110.38067400455475'),
(1117, 5, '-7.75897069030587', '110.3814223408699'),
(1118, 5, '-7.757963438696133', '110.38179516792297'),
(1119, 5, '-7.756804697712693', '110.38228869438171'),
(1120, 5, '-7.75575757582144', '110.38283586502075'),
(1121, 5, '-7.754814100819211', '110.38333743810654'),
(1122, 5, '-7.755996766330868', '110.38455247879028'),
(1123, 5, '-7.757338888333334', '110.38595259189606'),
(1124, 5, '-7.75846042066261', '110.38709789514542'),
(1125, 5, '-7.759414518085817', '110.38818150758743'),
(1126, 5, '-7.759746724201388', '110.3899222612381'),
(1127, 5, '-7.75913546474591', '110.39247840642929'),
(1128, 5, '-7.758415240508105', '110.39532423019409'),
(1129, 5, '-7.758168078400517', '110.39569973945618'),
(1130, 5, '-7.758040510804281', '110.39582580327988'),
(1131, 6, '-7.833315652644071', '110.39031386375427'),
(1132, 6, '-7.831785113762786', '110.3900134563446'),
(1133, 6, '-7.829521181356512', '110.38979887962341'),
(1134, 6, '-7.8262793784700815', '110.39005637168884'),
(1135, 6, '-7.823611515482803', '110.39021730422974'),
(1136, 6, '-7.822603356699268', '110.38961917161942'),
(1137, 6, '-7.821237528488984', '110.38887351751328'),
(1138, 6, '-7.82021182576416', '110.38828879594803'),
(1139, 6, '-7.819002768795759', '110.38762360811234'),
(1140, 6, '-7.81782293839851', '110.3869691491127'),
(1141, 6, '-7.8172941394576885', '110.38668483495712'),
(1142, 6, '-7.816490044650343', '110.38133382797241'),
(1143, 6, '-7.8158097783902925', '110.3761088848114'),
(1144, 6, '-7.8136247700093895', '110.37649512290955'),
(1145, 6, '-7.8118337418220465', '110.37680089473724'),
(1146, 6, '-7.810271236180371', '110.37703156471252'),
(1147, 6, '-7.808347326647241', '110.37735879421234'),
(1148, 6, '-7.807050542847734', '110.3775680065155'),
(1149, 6, '-7.8056368313339615', '110.3778737783432'),
(1150, 6, '-7.803882972058353', '110.37822246551514'),
(1151, 6, '-7.801788960741153', '110.37859797477722'),
(1152, 6, '-7.801704632989177', '110.37591576576233'),
(1153, 6, '-7.801656091648937', '110.3755509853363'),
(1154, 6, '-7.8016132192993375', '110.3731182217598'),
(1155, 6, '-7.800016129343946', '110.37314772605896'),
(1156, 6, '-7.798743236310253', '110.37312895059586'),
(1157, 6, '-7.797900839417032', '110.37286072969437'),
(1158, 6, '-7.797581950560623', '110.37260860204697'),
(1159, 6, '-7.796561504586909', '110.37265956401825'),
(1160, 6, '-7.795602176805801', '110.37269443273544'),
(1161, 6, '-7.79485809963974', '110.37267029285431'),
(1162, 6, '-7.794119334713637', '110.37286877632141'),
(1163, 6, '-7.793431059742346', '110.37309676408768'),
(1164, 6, '-7.791462251679649', '110.37379145622253'),
(1165, 6, '-7.790521514384032', '110.37406504154205'),
(1166, 6, '-7.790463050414563', '110.37292242050171'),
(1167, 6, '-7.789990023452275', '110.37293314933777'),
(1168, 6, '-7.789633924150643', '110.37367343902588'),
(1169, 6, '-7.788570939359974', '110.37393093109131'),
(1170, 6, '-7.788310507674854', '110.37324965000153'),
(1171, 6, '-7.7874494874817595', '110.37312626838684'),
(1172, 6, '-7.786939252458227', '110.3732442855835'),
(1173, 6, '-7.78688610294088', '110.37413477897644'),
(1174, 6, '-7.787444172536803', '110.3752613067627'),
(1175, 6, '-7.788230783657248', '110.37493407726288'),
(1176, 6, '-7.788565624429242', '110.37451565265656'),
(1177, 6, '-7.788560309498445', '110.37392556667328'),
(1178, 7, '-7.833400682417006', '110.39033532142639'),
(1179, 7, '-7.832582270131929', '110.39007782936096'),
(1180, 7, '-7.829478666076271', '110.38978815078735');
INSERT INTO `route` (`id`, `id_trayek`, `lat`, `lng`) VALUES
(1181, 7, '-7.825981769426743', '110.3900134563446'),
(1182, 7, '-7.823600886512464', '110.39019584655762'),
(1183, 7, '-7.821548781735721', '110.38903713226318'),
(1184, 7, '-7.819848134623982', '110.38808763027191'),
(1185, 7, '-7.817908325548824', '110.38702011108398'),
(1186, 7, '-7.817281207261389', '110.38671433925629'),
(1187, 7, '-7.816861356355862', '110.38405358791351'),
(1188, 7, '-7.816282067704216', '110.38586139678955'),
(1189, 7, '-7.816122630319547', '110.38642466068268'),
(1190, 7, '-7.81456014072704', '110.38629055023193'),
(1191, 7, '-7.813725747630935', '110.3863924741745'),
(1192, 7, '-7.812630936325901', '110.38676261901855'),
(1193, 7, '-7.810924938231444', '110.38711667060852'),
(1194, 7, '-7.809128583796801', '110.38750290870667'),
(1195, 7, '-7.807433200780898', '110.38793206214905'),
(1196, 7, '-7.8064871846973425', '110.388103723526'),
(1197, 7, '-7.806173617095958', '110.38806617259979'),
(1198, 7, '-7.805052212393077', '110.38867771625519'),
(1199, 7, '-7.804797105689893', '110.3887528181076'),
(1200, 7, '-7.804026469911855', '110.38872599601746'),
(1201, 7, '-7.803271776945509', '110.38887083530426'),
(1202, 7, '-7.802006865960976', '110.38909614086151'),
(1203, 7, '-7.802112806918214', '110.39061695337296'),
(1204, 7, '-7.8021234364355445', '110.39331257343292'),
(1205, 7, '-7.80216630873283', '110.39526522159576'),
(1206, 7, '-7.800492156596502', '110.39538860321045'),
(1207, 7, '-7.79966375866575', '110.39227724075317'),
(1208, 7, '-7.796092204640543', '110.3926956653595'),
(1209, 7, '-7.792701326033856', '110.39308190345764'),
(1210, 7, '-7.790405292323061', '110.39337158203125'),
(1211, 7, '-7.788077356403584', '110.39369344711304'),
(1212, 7, '-7.787875388750427', '110.39453029632568'),
(1213, 7, '-7.787439563482918', '110.3951632976532'),
(1214, 7, '-7.78612145503681', '110.39478778839111'),
(1215, 7, '-7.785504919017733', '110.394948720932'),
(1216, 7, '-7.785111611083374', '110.39512038230896'),
(1217, 7, '-7.783208845864535', '110.3951096534729'),
(1218, 7, '-7.7832293973653925', '110.39079129695892'),
(1219, 7, '-7.783219476186214', '110.3877067565918'),
(1220, 7, '-7.783139042544225', '110.38493871688843'),
(1221, 7, '-7.783080577544612', '110.38329720497131'),
(1222, 7, '-7.783133727544602', '110.38227796554565'),
(1223, 7, '-7.783043372540618', '110.37917733192444'),
(1224, 7, '-7.783043372540618', '110.37621080875397'),
(1225, 7, '-7.783043372540618', '110.37495017051697'),
(1226, 7, '-7.786902045363795', '110.37422060966492'),
(1227, 7, '-7.787465429721041', '110.37529349327087'),
(1229, 7, '-7.787641531346185', '110.37609815597534'),
(1230, 7, '-7.787110036760135', '110.37645220756531'),
(1231, 7, '-7.7873226346754585', '110.37853360176086'),
(1232, 7, '-7.787050863827533', '110.3786301612854'),
(1233, 7, '-7.787592988374982', '110.3803950548172'),
(1234, 7, '-7.78722696562692', '110.38192391395569'),
(1235, 7, '-7.786716730332392', '110.38211703300476'),
(1236, 7, '-7.786132084960207', '110.3822672367096'),
(1237, 7, '-7.786274880411541', '110.38653194904327'),
(1238, 7, '-7.785876258235014', '110.38733124732971'),
(1239, 7, '-7.785052437868554', '110.38811981678009'),
(1240, 7, '-7.783170932540581', '110.3879588842392'),
(1338, 1, '-7.783218413202717', '110.41107416152954'),
(1339, 1, '-7.783290165677504', '110.41134506464005'),
(1340, 1, '-7.783300795672732', '110.41388779878616'),
(1341, 1, '-7.783287508178665', '110.4167228937149'),
(1342, 1, '-7.783303276007613', '110.41965454816818'),
(1343, 1, '-7.783254112277745', '110.42031705379486'),
(1344, 1, '-7.783328522245035', '110.42211815714836'),
(1345, 1, '-7.7833512881463385', '110.42439669370651'),
(1346, 1, '-7.783361918140013', '110.42639762163162'),
(1347, 1, '-7.783369890635092', '110.42769849300385'),
(1348, 1, '-7.783468218061892', '110.42987108230591'),
(1349, 1, '-7.783521368012725', '110.43095737695694'),
(1350, 1, '-7.783433670590247', '110.435830950737'),
(1351, 1, '-7.783444300581823', '110.43802231550217'),
(1352, 1, '-7.78357186045978', '110.43800622224808'),
(1353, 2, '-7.750721253973502', '110.3671932220459'),
(1354, 2, '-7.750545845414264', '110.36566436290741'),
(1355, 2, '-7.750086062025775', '110.36393702030182'),
(1356, 2, '-7.749761821334098', '110.36308944225311'),
(1357, 2, '-7.749458842177237', '110.36243498325348'),
(1358, 2, '-7.749511996431054', '110.36227941513062'),
(1359, 2, '-7.749331271940685', '110.36206752061844'),
(1360, 2, '-7.749084104497396', '110.36208897829056'),
(1361, 2, '-7.748988426738465', '110.36225259304047'),
(1362, 2, '-7.748233634766821', '110.36234378814697'),
(1363, 2, '-7.746735031962709', '110.36243498325348'),
(1364, 0, '-7.755515106149933', '110.48948049545288'),
(1365, 0, '-7.756025379366405', '110.4868358373642'),
(1366, 0, '-7.756599435995093', '110.48353672027588'),
(1367, 0, '-7.757029977952484', '110.48129439353943'),
(1368, 0, '-7.757301059699562', '110.48050582408905'),
(1369, 0, '-7.757875114668317', '110.4797226190567'),
(1370, 0, '-7.758762772072388', '110.4789286851883'),
(1371, 0, '-7.75949096866352', '110.47832787036896'),
(1372, 0, '-7.760580603543002', '110.47728717327118'),
(1373, 0, '-7.761829693711081', '110.47617673873901'),
(1374, 0, '-7.76331265093716', '110.47486782073975'),
(1375, 0, '-7.764779657558935', '110.47351598739624'),
(1376, 0, '-7.766230713418049', '110.47228753566742'),
(1377, 0, '-7.766927005842055', '110.47170281410217'),
(1378, 0, '-7.76809634930091', '110.47074258327484'),
(1379, 0, '-7.769031821724022', '110.46991109848022'),
(1380, 0, '-7.77042971129092', '110.46872019767761'),
(1381, 0, '-7.771875432487382', '110.46745955944061'),
(1382, 0, '-7.772874678051603', '110.46656906604767'),
(1383, 0, '-7.773363669694912', '110.4658180475235'),
(1384, 0, '-7.774474529028256', '110.46372592449188'),
(1385, 0, '-7.776015907921387', '110.46093106269836'),
(1386, 0, '-7.7770417190120975', '110.45907497406006'),
(1387, 0, '-7.778317335522297', '110.45671999454498'),
(1388, 0, '-7.779454758269812', '110.4547244310379'),
(1389, 0, '-7.780406150477821', '110.45298099517822'),
(1390, 0, '-7.781128994511277', '110.45160233974457'),
(1391, 0, '-7.781958137603397', '110.45007348060608'),
(1392, 0, '-7.782930784140637', '110.4483300447464'),
(1393, 0, '-7.783605788880947', '110.44699430465698'),
(1394, 0, '-7.7835951588934424', '110.44466614723206'),
(1395, 0, '-7.783573898917669', '110.44312655925751'),
(1396, 0, '-7.783563268929376', '110.44013321399689'),
(1397, 0, '-7.783552638940814', '110.4368931055069'),
(1399, 0, '-7.7835473228921295', '110.4344254732132'),
(1400, 0, '-7.783621732807347', '110.43143212795258'),
(1401, 0, '-7.783536692903149', '110.42901813983917'),
(1402, 0, '-7.78349417294458', '110.42664170265198'),
(1403, 0, '-7.783456967977302', '110.42409896850586'),
(1404, 0, '-7.783419763006704', '110.42070865631104'),
(1405, 0, '-7.783430392998636', '110.41746854782104'),
(1406, 0, '-7.78341444801063', '110.41462540626526'),
(1407, 0, '-7.78341444801063', '110.41170716285706'),
(1408, 0, '-7.783371928039671', '110.40949702262878'),
(1409, 0, '-7.783377243036279', '110.40657341480255'),
(1410, 0, '-7.783345353055622', '110.40440082550049'),
(1411, 0, '-7.78330283307764', '110.40190100669861'),
(1412, 0, '-7.783292203082463', '110.39870381355286'),
(1413, 0, '-7.783223108107303', '110.39520621299744'),
(1414, 0, '-7.783212478110104', '110.39211094379425'),
(1415, 0, '-7.783233738104222', '110.38836121559143'),
(1416, 0, '-7.78316464311942', '110.38635492324829'),
(1417, 0, '-7.7831274381228805', '110.38449347019196'),
(1418, 0, '-7.783079603122489', '110.38324892520905'),
(1419, 0, '-7.783095548123218', '110.38107097148895'),
(1420, 0, '-7.7830264531156415', '110.37930607795715'),
(1421, 0, '-7.783053028119905', '110.37699937820435'),
(1422, 0, '-7.783047713119187', '110.37491798400879'),
(1423, 0, '-7.783074288122101', '110.37247717380524'),
(1424, 0, '-7.783015823113455', '110.37046015262604'),
(1425, 0, '-7.782967988100328', '110.37023484706879'),
(1426, 0, '-7.782930783086334', '110.36853969097137'),
(1427, 0, '-7.782952043094728', '110.36705911159515'),
(1428, 0, '-7.784833549567497', '110.36682844161987'),
(1429, 0, '-7.7869382756931795', '110.36656558513641'),
(1430, 0, '-7.789298107148673', '110.36625444889069'),
(1431, 0, '-7.789627632150217', '110.36624908447266'),
(1432, 0, '-7.789808339299057', '110.36750972270966'),
(1433, 0, '-7.7897286155665295', '110.36884009838104'),
(1434, 0, '-7.789888063016408', '110.3690493106842'),
(1435, 0, '-7.790541796926219', '110.36892056465149'),
(1436, 0, '-7.790642780122119', '110.36836802959442'),
(1437, 0, '-7.79051522239694', '110.36801397800446'),
(1438, 0, '-7.790541796926219', '110.36761701107025'),
(1439, 0, '-7.7902069577340445', '110.36743462085724'),
(1440, 0, '-7.790074084964536', '110.36614716053009'),
(1441, 0, '-7.791918355236788', '110.36587357521057'),
(1442, 0, '-7.793316168504191', '110.3657341003418'),
(1443, 0, '-7.794772440480171', '110.3655731678009'),
(1444, 0, '-7.796414726520077', '110.36535322666168'),
(1445, 0, '-7.79855128317736', '110.36508500576019'),
(1446, 0, '-7.800278590906276', '110.36491870880127'),
(1447, 0, '-7.801394693645124', '110.36474168300629'),
(1448, 0, '-7.801458470854519', '110.36694645881653'),
(1449, 0, '-7.80152756282039', '110.36988615989685'),
(1450, 0, '-7.801586025244136', '110.37270784378052'),
(1451, 0, '-7.801655117188926', '110.37503063678741'),
(1452, 0, '-7.801617913835449', '110.37564218044281'),
(1453, 0, '-7.801724209122306', '110.37598013877869'),
(1454, 0, '-7.801803930569719', '110.37840485572815'),
(1455, 0, '-7.801772041992579', '110.37997663021088'),
(1456, 0, '-7.801835819144431', '110.3805023431778'),
(1457, 0, '-7.8018836520019175', '110.38177371025085'),
(1458, 0, '-7.8018836520019175', '110.38380682468414'),
(1459, 0, '-7.8019580586582755', '110.38535177707672'),
(1460, 0, '-7.801995261981486', '110.38751900196075'),
(1461, 0, '-7.8019580586582755', '110.38816273212433'),
(1462, 0, '-7.802048409580335', '110.39008319377899'),
(1463, 0, '-7.802133445724432', '110.3919929265976'),
(1464, 0, '-7.802120291826779', '110.39332062005997'),
(1465, 0, '-7.802165467272714', '110.39524376392365'),
(1466, 0, '-7.802184068925516', '110.39634346961975'),
(1467, 0, '-7.80224505588061', '110.39892911911011'),
(1468, 0, '-7.802271629665004', '110.40010392665863'),
(1469, 0, '-7.802415128071541', '110.40225505828857'),
(1470, 0, '-7.801400008656236', '110.40228724479675'),
(1471, 0, '-7.799635502109645', '110.40231943130493'),
(1472, 0, '-7.798758560805807', '110.40235698223114'),
(1473, 0, '-7.798583172324443', '110.4027646780014'),
(1474, 0, '-7.798567227913402', '110.4057365655899'),
(1475, 0, '-7.798599116734874', '110.40798962116241'),
(1476, 0, '-7.7986363203568665', '110.4098242521286'),
(1477, 0, '-7.796616690378465', '110.40989935398102'),
(1478, 0, '-7.793491559192986', '110.41001737117767'),
(1479, 0, '-7.790499277678555', '110.41013538837433'),
(1480, 0, '-7.7878949655303655', '110.4101836681366'),
(1481, 0, '-7.785774299393124', '110.41025340557098'),
(1482, 0, '-7.783839647239826', '110.41036605834961'),
(1483, 0, '-7.783371927796369', '110.41074693202972'),
(1484, 0, '-7.783254997853947', '110.41156768798828'),
(1485, 0, '-7.783281572843733', '110.41398167610168'),
(1486, 0, '-7.783292202839177', '110.41604161262512'),
(1487, 0, '-7.7832975178367905', '110.41733980178833'),
(1488, 0, '-7.783270942848023', '110.42085886001587'),
(1489, 0, '-7.783345352812322', '110.4239970445633'),
(1490, 0, '-7.783366612799686', '110.42653441429138'),
(1491, 0, '-7.783409132771205', '110.42923271656036'),
(1492, 0, '-7.783472912720381', '110.43127119541168'),
(1493, 0, '-7.783446337742732', '110.43470442295074'),
(1494, 0, '-7.7834516527384', '110.43726325035095'),
(1495, 0, '-7.783435707751208', '110.44037461280823'),
(1496, 0, '-7.783462282729517', '110.44366836547852'),
(1497, 0, '-7.7834888577061605', '110.44689238071442'),
(1498, 0, '-7.782723497704649', '110.44846951961517'),
(1499, 0, '-7.781708330546776', '110.45030415058136'),
(1500, 0, '-7.7808154079145', '110.45197248458862'),
(1501, 0, '-7.77952385386598', '110.45439720153809'),
(1502, 0, '-7.778088789147088', '110.45688092708588'),
(1503, 0, '-7.776786596542216', '110.45927882194519'),
(1504, 0, '-7.775558811241276', '110.4614406824112'),
(1505, 0, '-7.7742034596592875', '110.46396732330322'),
(1506, 0, '-7.773028818080903', '110.46618282794952'),
(1507, 0, '-7.771514003952635', '110.46760439872742'),
(1508, 0, '-7.770078911841851', '110.46886503696442'),
(1509, 0, '-7.76802193792999', '110.47062993049622'),
(1510, 0, '-7.766836648646032', '110.47159552574158'),
(1511, 0, '-7.765390910104109', '110.4728615283966'),
(1512, 0, '-7.7632751807541265', '110.47471761703491'),
(1513, 0, '-7.761414838739973', '110.47640204429626'),
(1514, 0, '-7.760606916215356', '110.47714233398438'),
(1515, 0, '-7.759575749685147', '110.4780113697052'),
(1516, 0, '-7.757353949289029', '110.48012495040894'),
(1517, 0, '-7.7569074616686535', '110.481036901474'),
(1518, 0, '-7.756482234922902', '110.4833436012268'),
(1519, 0, '-7.755908178134284', '110.4864764213562'),
(1520, 0, '-7.755376643372269', '110.48937320709229');

-- --------------------------------------------------------

--
-- Table structure for table `trayek`
--

CREATE TABLE IF NOT EXISTS `trayek` (
`id` int(11) NOT NULL,
  `no_trayek` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trayek`
--

INSERT INTO `trayek` (`id`, `no_trayek`) VALUES
(0, '1A'),
(1, '1B'),
(2, '2A'),
(3, '2B'),
(4, '3A'),
(5, '3B'),
(6, '4A'),
(7, '4B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_halte`
--
ALTER TABLE `detail_halte`
 ADD PRIMARY KEY (`id`), ADD KEY `idx_halte` (`id_halte`), ADD KEY `idx_trayek` (`id_trayek`);

--
-- Indexes for table `halte`
--
ALTER TABLE `halte`
 ADD PRIMARY KEY (`id_halte`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
 ADD PRIMARY KEY (`id`), ADD KEY `id_trayek` (`id_trayek`);

--
-- Indexes for table `trayek`
--
ALTER TABLE `trayek`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_halte`
--
ALTER TABLE `detail_halte`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=197;
--
-- AUTO_INCREMENT for table `halte`
--
ALTER TABLE `halte`
MODIFY `id_halte` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=121;
--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1521;
--
-- AUTO_INCREMENT for table `trayek`
--
ALTER TABLE `trayek`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_halte`
--
ALTER TABLE `detail_halte`
ADD CONSTRAINT `detail_halte_ibfk_1` FOREIGN KEY (`id_halte`) REFERENCES `halte` (`id_halte`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `detail_halte_ibfk_2` FOREIGN KEY (`id_trayek`) REFERENCES `trayek` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `route`
--
ALTER TABLE `route`
ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`id_trayek`) REFERENCES `trayek` (`id`) ON UPDATE CASCADE;
--
-- Database: `webauth`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_pwd`
--

CREATE TABLE IF NOT EXISTS `user_pwd` (
  `name` char(30) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `pass` char(32) COLLATE latin1_general_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `user_pwd`
--

INSERT INTO `user_pwd` (`name`, `pass`) VALUES
('xampp', 'wampp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user_pwd`
--
ALTER TABLE `user_pwd`
 ADD PRIMARY KEY (`name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
