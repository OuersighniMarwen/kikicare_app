-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 21 nov. 2020 à 11:27
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `kikicare_bd`
--

-- --------------------------------------------------------

--
-- Structure de la table `animals`
--

CREATE TABLE `animals` (
  `id_animal` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `date_naissance` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `url_image` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `famille` varchar(255) NOT NULL,
  `race` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `animals`
--

INSERT INTO `animals` (`id_animal`, `id_user`, `nom`, `date_naissance`, `url_image`, `status`, `famille`, `race`) VALUES
(1, 2, 'Diana', '2020-11-21 09:43:57', '', 'wallah ma na3ref', 'Berger', 'Allemand'),
(2, 1, 'Rex', '2020-11-21 09:44:02', '', 'don\'t know', 'Berger', 'Malinois'),
(3, 3, 'Hab', '2020-11-21 09:41:49', '', 'Lost', 'Caniche', 'Caniche');

-- --------------------------------------------------------

--
-- Structure de la table `tacheanimal`
--

CREATE TABLE `tacheanimal` (
  `id_tache` int(11) NOT NULL,
  `id_animal` int(11) NOT NULL,
  `titre_tache` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(25) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `num_tel` varchar(8) DEFAULT NULL,
  `adress` varchar(250) DEFAULT NULL,
  `url_image` varchar(250) NOT NULL,
  `mode_cnx` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `first_name`, `last_name`, `email`, `password`, `num_tel`, `adress`, `url_image`, `mode_cnx`) VALUES
(1, 'Marwen', 'Ouersighni', 'marwenouersighni@gmail.com', 'azerty', '99244073', 'Boumhal', '', 'email'),
(2, 'Marou', 'Ouer', 'marwen@gmail.com', '123456789', '99244073', 'Bel Air', '', 'EMAIL'),
(3, 'Elyes', 'Torki', 'elyestorki@esprit.tn', '12345678', '50615359', 'Sousse', '', 'EMAIL'),
(4, 'Mohamed', 'Ahmed', 'mohamed@Ahmed.com', 'aaaaaaaa', '14785236', 'aaaaaaaaaaaa', '', 'EMAIL');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id_animal`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `animals`
--
ALTER TABLE `animals`
  MODIFY `id_animal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
