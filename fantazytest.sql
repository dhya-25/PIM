-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 05, 2021 at 12:42 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fantazytest`
--

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
CREATE TABLE IF NOT EXISTS `club` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `points` int(11) NOT NULL,
  `fixture` varchar(255) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`id`, `email`, `password`, `name`, `price`, `points`, `fixture`, `userid`) VALUES
(1, 'fares.benslama@esprit.tn', 'ab4f63f9ac65152575886860dde480a1', 'fc New club ', 172, 0, '0', 42),
(2, 'fares.benslama@esprit.dn', 'ab4f63f9ac65152575886860dde480a1', 'fc bmc', 103, 0, '0', 43);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL,
  `firstname` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastname` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `position` varchar(250) NOT NULL,
  `price` double NOT NULL,
  `rating` varchar(255) NOT NULL,
  `appearences` int(11) NOT NULL,
  `goals` int(11) NOT NULL,
  `assists` int(11) NOT NULL,
  `cleansheets` int(11) NOT NULL,
  `redcards` int(11) NOT NULL,
  `yellowcards` int(11) NOT NULL,
  `image` varchar(250) NOT NULL,
  `teamid` int(11) NOT NULL,
  `clubid` int(11) NOT NULL,
  `fixtureid` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `clubid` (`clubid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `firstname`, `lastname`, `position`, `price`, `rating`, `appearences`, `goals`, `assists`, `cleansheets`, `redcards`, `yellowcards`, `image`, `teamid`, `clubid`, `fixtureid`) VALUES
(642, 'Sergio Leonel', 'Agüero del Castillo', '.ATTACKER', 6, '6.700000', 11, 2, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/642.png', 50, 1, 592856),
(645, 'Raheem Shaquille', 'Sterling', '.ATTACKER', 36, '6.900000', 29, 10, 6, 0, 0, 3, 'https://media.api-sports.io/football/players/645.png', 50, 1, 592856),
(652, 'Fernando', 'Marçal de Oliveira', '.DEFENDER', 6, '6.616666', 12, 0, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/652.png', 39, 2, 592875),
(723, 'Joelinton Cassio', 'Apolinário de Lira', '.ATTACKER', 6, '6.855172', 29, 3, 2, 0, 0, 3, 'https://media.api-sports.io/football/players/723.png', 34, 1, 592862),
(883, 'Lee', 'Grant', '.GOALKEEPER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/883.png', 33, 2, 592875),
(885, 'Eric Bertrand', 'Bailly', '.DEFENDER', 6, '6.718181', 11, 0, 0, 0, 0, 3, 'https://media.api-sports.io/football/players/885.png', 33, 2, 592875),
(889, 'Victor', 'Nilsson Lindelöf', '.DEFENDER', 6, '6.868965', 29, 1, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/889.png', 33, 2, 592875),
(1452, 'Mohamed Naser', 'Elsayed Elneny', '.MIDFIELDER', 6, '6.645454', 22, 1, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/1452.png', 42, 1, 592859),
(1600, 'Konstantinos', 'Tsimikas', '.DEFENDER', 6, '6.300000', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/1600.png', 40, 1, 592857),
(1649, 'Patrick', 'Cutrone', '.ATTACKER', 6, '6.500000', 2, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/1649.png', 39, 2, 592875),
(2677, 'João Filipe', 'Iria Santos Moutinho', '.MIDFIELDER', 6, '6.975862', 30, 1, 1, 0, 0, 4, 'https://media.api-sports.io/football/players/2677.png', 39, 1, 592860),
(2678, 'Diogo José', 'Teixeira da Silva', '.ATTACKER', 6, '6.961111', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2678.png', 39, 2, 592875),
(2729, 'Joachim Christian', 'Andersen', '.DEFENDER', 6, '6.896551', 29, 1, 1, 0, 1, 6, 'https://media.api-sports.io/football/players/2729.png', 36, 1, 592861),
(18739, 'Willy-Arnaud', 'Zobo Boly', '.DEFENDER', 6, '6.973684', 19, 1, 1, 0, 0, 1, 'https://media.api-sports.io/football/players/18739.png', 39, 2, 592875),
(18751, 'Ivan Ricardo', 'Neves Abreu Cavaleiro', '.ATTACKER', 6, '6.734375', 33, 3, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/18751.png', 36, 1, 592861),
(18899, 'Isaac', 'Hayden', '.MIDFIELDER', 6, '6.875000', 24, 0, 0, 0, 0, 8, 'https://media.api-sports.io/football/players/18899.png', 34, 1, 592862),
(18904, 'Jonjo', 'Shelvey', '.MIDFIELDER', 6, '6.967857', 28, 1, 3, 0, 0, 7, 'https://media.api-sports.io/football/players/18904.png', 34, 2, 592868),
(18932, 'Fraser', 'Forster', '.GOALKEEPER', 6, '6.875000', 8, 0, 0, 11, 0, 0, 'https://media.api-sports.io/football/players/18932.png', 41, 1, 592863),
(18949, 'Oriol', 'Romeu Vidal', '.MIDFIELDER', 15, '7.085000', 20, 1, 1, 0, 0, 6, 'https://media.api-sports.io/football/players/18949.png', 41, 2, 592874),
(18956, 'Shane', 'Long', '.ATTACKER', 6, '6.410000', 11, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18956.png', 41, 2, 592874),
(18972, 'Anthony', 'Knockaert', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18972.png', 36, 2, 592868),
(19015, 'Joe', 'Bryan', '.DEFENDER', 6, '6.611111', 13, 0, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/19015.png', 36, 1, 592861),
(19076, 'Jamal', 'Lewis', '.DEFENDER', 6, '6.478260', 23, 0, 1, 0, 0, 4, 'https://media.api-sports.io/football/players/19076.png', 34, 1, 592862),
(19122, 'Robbie', 'Gotts', '.DEFENDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/19122.png', 63, 2, 592869),
(19136, 'Jack', 'Clarke', '.ATTACKER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/19136.png', 47, 2, 592870),
(19163, 'Jacob', 'Murphy', '.MIDFIELDER', 6, '6.656521', 23, 2, 2, 0, 0, 3, 'https://media.api-sports.io/football/players/19163.png', 34, 1, 592862),
(19480, 'Harrison', 'Reed', '.MIDFIELDER', 6, '6.917241', 29, 0, 2, 0, 0, 5, 'https://media.api-sports.io/football/players/19480.png', 36, 1, 592861),
(20055, 'Nya', 'Kirby', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/20055.png', 52, 2, 592871),
(20619, 'Illan', 'Meslier', '.GOALKEEPER', 45, '7.100000', 34, 0, 0, 52, 0, 0, 'https://media.api-sports.io/football/players/20619.png', 63, 1, 592863),
(21138, 'Rayan', 'Aït Nouri', '.DEFENDER', 6, '6.672222', 19, 1, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/21138.png', 39, 1, 592860),
(22173, 'Allan', 'Saint-Maximin', '.MIDFIELDER', 6, '6.900000', 23, 3, 4, 0, 0, 0, 'https://media.api-sports.io/football/players/22173.png', 34, 2, 592868);

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
CREATE TABLE IF NOT EXISTS `scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matchweek` varchar(255) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `season` int(11) NOT NULL DEFAULT '2020',
  `clubid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scores_ibfk_1` (`clubid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `squad`
--

DROP TABLE IF EXISTS `squad`;
CREATE TABLE IF NOT EXISTS `squad` (
  `id_entry` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `firstname` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastname` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `position` varchar(250) NOT NULL,
  `price` double NOT NULL,
  `rating` varchar(255) NOT NULL,
  `appearences` int(11) NOT NULL,
  `goals` int(11) NOT NULL,
  `assists` int(11) NOT NULL,
  `cleansheets` int(11) NOT NULL,
  `redcards` int(11) NOT NULL,
  `yellowcards` int(11) NOT NULL,
  `image` varchar(250) NOT NULL,
  `teamid` int(11) NOT NULL,
  `clubid` int(11) NOT NULL,
  `round` varchar(255) NOT NULL,
  `fixtureid` int(11) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_entry`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `squad`
--

INSERT INTO `squad` (`id_entry`, `id`, `firstname`, `lastname`, `position`, `price`, `rating`, `appearences`, `goals`, `assists`, `cleansheets`, `redcards`, `yellowcards`, `image`, `teamid`, `clubid`, `round`, `fixtureid`, `points`) VALUES
(1, 899, 'Andreas', 'Hoelgebaum Pereira', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/899.png', 33, 1, 'Regular Season - 36', 592831, 0),
(2, 18956, 'Shane', 'Long', '.ATTACKER', 6, '6.410000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18956.png', 41, 1, 'Regular Season - 36', 592853, 0),
(3, 18972, 'Anthony', 'Knockaert', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18972.png', 36, 1, 'Regular Season - 36', 592853, 0),
(4, 2678, 'Diogo José', 'Teixeira da Silva', '.ATTACKER', 6, '6.961111', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2678.png', 39, 1, 'Regular Season - 36', 592854, 0),
(5, 19599, 'Damián Emiliano', 'Martínez', '.GOALKEEPER', 30, '6.6', 1, 0, 0, 5, 0, 0, 'https://media.api-sports.io/football/players/19599.png', 66, 1, 'Regular Season - 36', 592855, 11),
(6, 17670, 'Regan', 'Slater', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/17670.png', 62, 1, 'Regular Season - 36', 592848, 0),
(7, 633, 'İlkay', 'Gündoğan', '.MIDFIELDER', 25, '8.3', 1, 0, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/633.png', 50, 1, 'Regular Season - 36', 592852, 5),
(8, 2726, 'Kurt Happy', 'Zouma', '.DEFENDER', 20, '7.2', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2726.png', 49, 1, 'Regular Season - 36', 592851, 2),
(9, 1432, 'Yannick', 'Bolasie Yala', '.ATTACKER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/1432.png', 45, 1, 'Regular Season - 36', 592848, 0),
(10, 2724, 'Lucas', 'Digne', '.DEFENDER', 20, '7.3', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2724.png', 45, 1, 'Regular Season - 36', 592848, 2),
(11, 18942, 'Yan', 'Valery', '.DEFENDER', 5, '5.900000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18942.png', 41, 1, 'Regular Season - 36', 592853, 0),
(12, 138787, 'Anthony', 'Gordon', '.ATTACKER', 6, '6.500000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/138787.png', 45, 1, 'Regular Season - 36', 592848, 0),
(13, 2741, 'Mathew', 'Ryan', '.GOALKEEPER', 15, '5.0', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2741.png', 42, 1, 'Regular Season - 36', 592851, -1),
(14, 629, 'Kevin', 'De Bruyne', '.MIDFIELDER', 30, '7.725000', 0, 5, 11, 0, 0, 1, 'https://media.api-sports.io/football/players/629.png', 50, 1, 'Regular Season - 36', 592852, 0),
(15, 289, 'Andrew', 'Robertson', '.DEFENDER', 20, '7', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/289.png', 40, 1, 'Regular Season - 36', 592850, 2),
(16, 36922, 'Sepp', 'van den Berg', '.DEFENDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/36922.png', 40, 1, 'Regular Season - 36', 592850, 0),
(49, 19163, 'Jacob', 'Murphy', '.MIDFIELDER', 6, '6.656521', 23, 2, 2, 0, 0, 3, 'https://media.api-sports.io/football/players/19163.png', 34, 1, 'Regular Season - 37', 592862, 0),
(50, 19480, 'Harrison', 'Reed', '.MIDFIELDER', 6, '6.917241', 29, 0, 2, 0, 0, 5, 'https://media.api-sports.io/football/players/19480.png', 36, 1, 'Regular Season - 37', 592861, 0),
(51, 18751, 'Ivan Ricardo', 'Neves Abreu Cavaleiro', '.ATTACKER', 6, '6.734375', 33, 3, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/18751.png', 36, 1, 'Regular Season - 37', 592861, 0),
(52, 18899, 'Isaac', 'Hayden', '.MIDFIELDER', 6, '6.875000', 24, 0, 0, 0, 0, 8, 'https://media.api-sports.io/football/players/18899.png', 34, 1, 'Regular Season - 37', 592862, 0),
(53, 1452, 'Mohamed Naser', 'Elsayed Elneny', '.MIDFIELDER', 6, '6.645454', 22, 1, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/1452.png', 42, 1, 'Regular Season - 37', 592859, 0),
(54, 723, 'Joelinton Cassio', 'Apolinário de Lira', '.ATTACKER', 6, '6.855172', 29, 3, 2, 0, 0, 3, 'https://media.api-sports.io/football/players/723.png', 34, 1, 'Regular Season - 37', 592862, 0),
(55, 18932, 'Fraser', 'Forster', '.GOALKEEPER', 6, '6.875000', 8, 0, 0, 11, 0, 0, 'https://media.api-sports.io/football/players/18932.png', 41, 1, 'Regular Season - 37', 592863, 0),
(56, 19015, 'Joe', 'Bryan', '.DEFENDER', 6, '6.611111', 13, 0, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/19015.png', 36, 1, 'Regular Season - 37', 592861, 0),
(57, 20619, 'Illan', 'Meslier', '.GOALKEEPER', 45, '7.100000', 34, 0, 0, 52, 0, 0, 'https://media.api-sports.io/football/players/20619.png', 63, 1, 'Regular Season - 37', 592863, 0),
(58, 2677, 'João Filipe', 'Iria Santos Moutinho', '.MIDFIELDER', 6, '6.975862', 30, 1, 1, 0, 0, 4, 'https://media.api-sports.io/football/players/2677.png', 39, 1, 'Regular Season - 37', 592860, 0),
(59, 2729, 'Joachim Christian', 'Andersen', '.DEFENDER', 6, '6.896551', 29, 1, 1, 0, 1, 6, 'https://media.api-sports.io/football/players/2729.png', 36, 1, 'Regular Season - 37', 592861, 0),
(60, 645, 'Raheem Shaquille', 'Sterling', '.ATTACKER', 36, '6.900000', 29, 10, 6, 0, 0, 3, 'https://media.api-sports.io/football/players/645.png', 50, 1, 'Regular Season - 37', 592856, 0),
(61, 19076, 'Jamal', 'Lewis', '.DEFENDER', 6, '6.478260', 23, 0, 1, 0, 0, 4, 'https://media.api-sports.io/football/players/19076.png', 34, 1, 'Regular Season - 37', 592862, 0),
(62, 642, 'Sergio Leonel', 'Agüero del Castillo', '.ATTACKER', 6, '6.700000', 11, 2, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/642.png', 50, 1, 'Regular Season - 37', 592856, 0),
(63, 1600, 'Konstantinos', 'Tsimikas', '.DEFENDER', 6, '6.300000', 1, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/1600.png', 40, 1, 'Regular Season - 37', 592857, 0),
(64, 21138, 'Rayan', 'Aït Nouri', '.DEFENDER', 6, '6.672222', 19, 1, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/21138.png', 39, 1, 'Regular Season - 37', 592860, 0),
(65, 889, 'Victor', 'Nilsson Lindelöf', '.DEFENDER', 6, '6.868965', 29, 1, 1, 0, 0, 0, 'https://media.api-sports.io/football/players/889.png', 33, 2, 'Regular Season - 38', 592875, 0),
(66, 885, 'Eric Bertrand', 'Bailly', '.DEFENDER', 6, '6.718181', 11, 0, 0, 0, 0, 3, 'https://media.api-sports.io/football/players/885.png', 33, 2, 'Regular Season - 38', 592875, 0),
(67, 19122, 'Robbie', 'Gotts', '.DEFENDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/19122.png', 63, 2, 'Regular Season - 38', 592869, 0),
(68, 18956, 'Shane', 'Long', '.ATTACKER', 6, '6.410000', 11, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18956.png', 41, 2, 'Regular Season - 38', 592874, 0),
(69, 18949, 'Oriol', 'Romeu Vidal', '.MIDFIELDER', 15, '7.085000', 20, 1, 1, 0, 0, 6, 'https://media.api-sports.io/football/players/18949.png', 41, 2, 'Regular Season - 38', 592874, 0),
(70, 652, 'Fernando', 'Marçal de Oliveira', '.DEFENDER', 6, '6.616666', 12, 0, 0, 0, 0, 2, 'https://media.api-sports.io/football/players/652.png', 39, 2, 'Regular Season - 38', 592875, 0),
(71, 18904, 'Jonjo', 'Shelvey', '.MIDFIELDER', 6, '6.967857', 28, 1, 3, 0, 0, 7, 'https://media.api-sports.io/football/players/18904.png', 34, 2, 'Regular Season - 38', 592868, 0),
(72, 20055, 'Nya', 'Kirby', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/20055.png', 52, 2, 'Regular Season - 38', 592871, 0),
(73, 19136, 'Jack', 'Clarke', '.ATTACKER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/19136.png', 47, 2, 'Regular Season - 38', 592870, 0),
(74, 1649, 'Patrick', 'Cutrone', '.ATTACKER', 6, '6.500000', 2, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/1649.png', 39, 2, 'Regular Season - 38', 592875, 0),
(75, 2678, 'Diogo José', 'Teixeira da Silva', '.ATTACKER', 6, '6.961111', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/2678.png', 39, 2, 'Regular Season - 38', 592875, 0),
(76, 883, 'Lee', 'Grant', '.GOALKEEPER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/883.png', 33, 2, 'Regular Season - 38', 592875, 0),
(77, 18932, 'Fraser', 'Forster', '.GOALKEEPER', 6, '6.875000', 8, 0, 0, 11, 0, 0, 'https://media.api-sports.io/football/players/18932.png', 41, 2, 'Regular Season - 38', 592874, 0),
(78, 18739, 'Willy-Arnaud', 'Zobo Boly', '.DEFENDER', 6, '6.973684', 19, 1, 1, 0, 0, 1, 'https://media.api-sports.io/football/players/18739.png', 39, 2, 'Regular Season - 38', 592875, 0),
(79, 18972, 'Anthony', 'Knockaert', '.MIDFIELDER', 3, '5.000000', 0, 0, 0, 0, 0, 0, 'https://media.api-sports.io/football/players/18972.png', 36, 2, 'Regular Season - 38', 592868, 0),
(80, 22173, 'Allan', 'Saint-Maximin', '.MIDFIELDER', 6, '6.900000', 23, 3, 4, 0, 0, 0, 'https://media.api-sports.io/football/players/22173.png', 34, 2, 'Regular Season - 38', 592868, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `equipe` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `equipe`, `password`) VALUES
(41, 'dhya', 'dhya.blel22@gmail.com', '', 'ab4f63f9ac65152575886860dde480a1'),
(42, 'fares', 'fares.benslama@esprit.tn', '40', 'ab4f63f9ac65152575886860dde480a1'),
(43, 'dsasda', 'fares.benslama@esprit.dn', '34', 'ab4f63f9ac65152575886860dde480a1'),
(44, 'faresf', 'fares.benslama@esprit.tns', '42', 'ab4f63f9ac65152575886860dde480a1');

-- --------------------------------------------------------

--
-- Table structure for table `verification_code`
--

DROP TABLE IF EXISTS `verification_code`;
CREATE TABLE IF NOT EXISTS `verification_code` (
  `idcode` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `dateverification` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `codeverification` int(11) NOT NULL,
  PRIMARY KEY (`idcode`),
  UNIQUE KEY `idUser` (`idcode`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `verification_code`
--

INSERT INTO `verification_code` (`idcode`, `idUser`, `dateverification`, `codeverification`) VALUES
(34, 41, '2021-04-07 09:15:18', 55959),
(35, 43, '2021-05-06 16:37:18', 57656),
(36, 44, '2021-05-06 16:39:28', 52284),
(37, 43, '2021-05-10 23:30:22', 86872),
(38, 44, '2021-05-14 17:22:24', 25361);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `club`
--
ALTER TABLE `club`
  ADD CONSTRAINT `club_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`);

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`clubid`) REFERENCES `club` (`id`);

--
-- Constraints for table `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`clubid`) REFERENCES `club` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
