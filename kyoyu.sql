-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 mars 2026 à 09:20
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `kyoyu`
--

-- --------------------------------------------------------

--
-- Structure de la table `groupes`
--

DROP TABLE IF EXISTS `groupes`;
CREATE TABLE IF NOT EXISTS `groupes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid_secret` varchar(255) NOT NULL,
  `cle_chiffrement` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_secret` (`uid_secret`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `groupes`
--

INSERT INTO `groupes` (`id`, `uid_secret`, `cle_chiffrement`) VALUES
(2, '76798f27-89c9-4f22-a575-255172fe8b38', 'kJGaztO8gawife6rxlD4GcVlCHYnTZJkpY63VvrCBQU='),
(3, 'bdfddd12-f6e2-4a96-8949-6bf862959a9d', 'RcH5dvdDw1zRveqOx-cjJqWmrlxpeliHiLmBobdSmzo='),
(4, 'd6c189ad-eb7e-4bad-8102-ab3af04916b6', '0ZFCRjxLkSE29f99W0bN9-0UdbtmnV1D0QqK5HA73Oo='),
(5, '24552b7b-a3f6-4cb9-a4b5-bd0c786b2ab8', 'f8HuaLCJntIsFx-5Ofdi51f8aDbu8SGw0piVPIV3dTY='),
(6, 'fe5980fd-6056-4036-a67b-e6feca1c0579', 'sNpWvCQ_iDrzBynA41bz-e278G1Ssxb35F5Xcf8djfE='),
(7, '8bdaacb5-ee80-4086-8c99-6885ae5158e2', 'E9cwvbLe6TrJAnVBP6xPTpLF7xQrjnzRSuhmlVBg93M=');

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupe_uid` varchar(255) NOT NULL,
  `contenu_chiffre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_envoie` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `groupe_uid` (`groupe_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `groupe_uid`, `contenu_chiffre`, `date_envoie`) VALUES
(1, 'd6c189ad-eb7e-4bad-8102-ab3af04916b6', 'gAAAAABpxEPY1Eby6mVtHtGLRNWBm5_bTrUopa_e5j3j19bjkVT0X7eKNUoWxCahtIAN65edAAt9RVr4g04PHZ9rj94_5zEojw==', '0000-00-00 00:00:00'),
(2, 'd6c189ad-eb7e-4bad-8102-ab3af04916b6', 'gAAAAABpxEPbn6TgEZRDOoozE5vOL510QP3yAX3Cbe2lIxpoO1JMPO7IDSEF2Z9HZUoDrybYwjwcDOwfXB8Wsix9FecMSfN3hA==', '0000-00-00 00:00:00'),
(3, 'd6c189ad-eb7e-4bad-8102-ab3af04916b6', 'gAAAAABpxEPdJYA6maYZqRQUl8SB1NlHnW_GRrPX89dbp3HgrDU1nBp1yBRuJMQk5E-iI8jU7W3JtEb8ghWxOCqFiEPUraJZLA==', '0000-00-00 00:00:00');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`groupe_uid`) REFERENCES `groupes` (`uid_secret`) ON DELETE CASCADE ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
