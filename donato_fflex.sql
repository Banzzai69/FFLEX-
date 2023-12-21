-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-donato.alwaysdata.net
-- Generation Time: Dec 21, 2023 at 08:50 AM
-- Server version: 10.6.14-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `donato_fflex`
--

-- --------------------------------------------------------

--
-- Table structure for table `Abonne`
--

CREATE TABLE `Abonne` (
  `AbonneID` int(11) NOT NULL,
  `Nom` varchar(255) NOT NULL,
  `Prenom` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `DateInscription` date DEFAULT curdate(),
  `DerniereConnexion` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `Abonne`
--

INSERT INTO `Abonne` (`AbonneID`, `Nom`, `Prenom`, `Email`, `DateInscription`, `DerniereConnexion`) VALUES
(1, 'Donald', 'Duck', 'donald.duck@disney.com', '2023-12-21', NULL),
(2, 'Smith', 'Alice', 'alice.smith@gmail.com', '2023-12-21', NULL),
(3, 'Johnson', 'Bob', 'bob.johnson@gmail.com', '2023-12-21', NULL),
(4, 'Dupont', 'Alice', 'alice.dupont@example.com', '2023-12-21', NULL),
(5, 'Martin', 'Paul', 'paul.martin@example.com', '2023-12-21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Contenu`
--

CREATE TABLE `Contenu` (
  `ContenuID` int(11) NOT NULL,
  `Titre` varchar(255) NOT NULL,
  `Genre` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `DateSortie` date DEFAULT NULL,
  `Duree` int(11) DEFAULT NULL CHECK (`Duree` > 0),
  `PromotionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Contenu`
--

INSERT INTO `Contenu` (`ContenuID`, `Titre`, `Genre`, `Description`, `DateSortie`, `Duree`, `PromotionID`) VALUES
(1, 'The Matrix', 'Science Fiction', 'Inception of virtual reality', '1999-03-31', 136, NULL),
(2, 'Breaking Bad', 'Drama', 'High school chemistry teacher turned methamphetamine manufacturer', '2008-01-20', 62, NULL),
(3, 'The Dark Knight', 'Action', 'Batman faces the Joker', '2008-07-18', 152, NULL),
(4, 'Stranger Things', 'Science Fiction', 'Mysterious events in a small town', '2016-07-15', 50, NULL),
(5, 'Planet Earth II', 'Documentary', 'Explore the beauty of our planet', '2016-11-06', 3600, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `HistoriqueAbonnement`
--

CREATE TABLE `HistoriqueAbonnement` (
  `HistoriqueAbonnementID` int(11) NOT NULL,
  `AbonneID` int(11) DEFAULT NULL,
  `TypeAbonnementID` int(11) DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL,
  `StatutAbonnement` enum('Actif','Expiré') DEFAULT 'Actif',
  `PromotionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `HistoriqueAbonnement`
--

INSERT INTO `HistoriqueAbonnement` (`HistoriqueAbonnementID`, `AbonneID`, `TypeAbonnementID`, `DateDebut`, `DateFin`, `StatutAbonnement`, `PromotionID`) VALUES
(1, 1, 1, '2023-09-01', '2023-10-01', 'Expiré', 1),
(2, 2, 2, '2023-06-01', '2023-07-01', 'Expiré', 2),
(3, 3, 1, '2023-01-01', '2023-12-31', 'Actif', 3);

-- --------------------------------------------------------

--
-- Table structure for table `HistoriqueAchatLocation`
--

CREATE TABLE `HistoriqueAchatLocation` (
  `HistoriqueAchatLocationID` int(11) NOT NULL,
  `AbonneID` int(11) DEFAULT NULL,
  `ContenuID` int(11) DEFAULT NULL,
  `DateAchatLocation` date DEFAULT NULL,
  `TypeAchatLocation` varchar(50) DEFAULT NULL,
  `Cout` decimal(10,2) DEFAULT NULL,
  `EstLocation` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `HistoriqueAchatLocation`
--

INSERT INTO `HistoriqueAchatLocation` (`HistoriqueAchatLocationID`, `AbonneID`, `ContenuID`, `DateAchatLocation`, `TypeAchatLocation`, `Cout`, `EstLocation`) VALUES
(1, 1, 1, '2023-07-01', 'Achat', 9.99, 0),
(2, 2, 2, '2023-07-02', 'Location', 3.99, 1),
(3, 3, 3, '2023-07-03', 'Achat', 12.99, 0),
(4, 1, 4, '2023-07-04', 'Location', 2.99, 1),
(5, 2, 5, '2023-07-05', 'Achat', 8.99, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Paiement`
--

CREATE TABLE `Paiement` (
  `PaiementID` int(11) NOT NULL,
  `AbonneID` int(11) DEFAULT NULL,
  `Montant` decimal(10,2) NOT NULL,
  `DatePaiement` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Paiement`
--

INSERT INTO `Paiement` (`PaiementID`, `AbonneID`, `Montant`, `DatePaiement`) VALUES
(1, 1, 9.99, '2023-09-05'),
(2, 2, 14.99, '2023-06-15'),
(3, 3, 9.99, '2023-01-10'),
(4, 1, 9.99, '2023-09-20');

-- --------------------------------------------------------

--
-- Table structure for table `Promotion`
--

CREATE TABLE `Promotion` (
  `PromotionID` int(11) NOT NULL,
  `Nom` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `TauxReduction` decimal(5,2) DEFAULT NULL,
  `DateDebut` date DEFAULT NULL,
  `DateFin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Promotion`
--

INSERT INTO `Promotion` (`PromotionID`, `Nom`, `Description`, `TauxReduction`, `DateDebut`, `DateFin`) VALUES
(1, 'Promoété2023', 'Réduction estivale', 10.00, '2023-06-01', '2023-08-31'),
(2, 'BackToSchool', 'Promotion de rentrée', 15.00, '2023-08-15', '2023-09-15'),
(3, 'HappyHolidays', 'Réduction festive', 20.00, '2023-12-01', '2023-12-31');

-- --------------------------------------------------------

--
-- Table structure for table `TypeAbonnement`
--

CREATE TABLE `TypeAbonnement` (
  `TypeAbonnementID` int(11) NOT NULL,
  `NomType` varchar(50) NOT NULL,
  `Tarif` decimal(10,2) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `TypeAbonnement`
--

INSERT INTO `TypeAbonnement` (`TypeAbonnementID`, `NomType`, `Tarif`, `Description`) VALUES
(1, 'Standard', 9.99, 'Accès standard à la plateforme'),
(2, 'Premium', 14.99, 'Accès premium avec fonctionnalités avancées');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Abonne`
--
ALTER TABLE `Abonne`
  ADD PRIMARY KEY (`AbonneID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Contenu`
--
ALTER TABLE `Contenu`
  ADD PRIMARY KEY (`ContenuID`),
  ADD KEY `PromotionID` (`PromotionID`);

--
-- Indexes for table `HistoriqueAbonnement`
--
ALTER TABLE `HistoriqueAbonnement`
  ADD PRIMARY KEY (`HistoriqueAbonnementID`),
  ADD KEY `AbonneID` (`AbonneID`),
  ADD KEY `TypeAbonnementID` (`TypeAbonnementID`),
  ADD KEY `PromotionID` (`PromotionID`);

--
-- Indexes for table `HistoriqueAchatLocation`
--
ALTER TABLE `HistoriqueAchatLocation`
  ADD PRIMARY KEY (`HistoriqueAchatLocationID`),
  ADD KEY `AbonneID` (`AbonneID`),
  ADD KEY `ContenuID` (`ContenuID`);

--
-- Indexes for table `Paiement`
--
ALTER TABLE `Paiement`
  ADD PRIMARY KEY (`PaiementID`),
  ADD KEY `AbonneID` (`AbonneID`);

--
-- Indexes for table `Promotion`
--
ALTER TABLE `Promotion`
  ADD PRIMARY KEY (`PromotionID`);

--
-- Indexes for table `TypeAbonnement`
--
ALTER TABLE `TypeAbonnement`
  ADD PRIMARY KEY (`TypeAbonnementID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Abonne`
--
ALTER TABLE `Abonne`
  MODIFY `AbonneID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Contenu`
--
ALTER TABLE `Contenu`
  MODIFY `ContenuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `HistoriqueAbonnement`
--
ALTER TABLE `HistoriqueAbonnement`
  MODIFY `HistoriqueAbonnementID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `HistoriqueAchatLocation`
--
ALTER TABLE `HistoriqueAchatLocation`
  MODIFY `HistoriqueAchatLocationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Paiement`
--
ALTER TABLE `Paiement`
  MODIFY `PaiementID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Promotion`
--
ALTER TABLE `Promotion`
  MODIFY `PromotionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TypeAbonnement`
--
ALTER TABLE `TypeAbonnement`
  MODIFY `TypeAbonnementID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Contenu`
--
ALTER TABLE `Contenu`
  ADD CONSTRAINT `Contenu_ibfk_1` FOREIGN KEY (`PromotionID`) REFERENCES `Promotion` (`PromotionID`);

--
-- Constraints for table `HistoriqueAbonnement`
--
ALTER TABLE `HistoriqueAbonnement`
  ADD CONSTRAINT `HistoriqueAbonnement_ibfk_1` FOREIGN KEY (`AbonneID`) REFERENCES `Abonne` (`AbonneID`),
  ADD CONSTRAINT `HistoriqueAbonnement_ibfk_2` FOREIGN KEY (`TypeAbonnementID`) REFERENCES `TypeAbonnement` (`TypeAbonnementID`),
  ADD CONSTRAINT `HistoriqueAbonnement_ibfk_3` FOREIGN KEY (`PromotionID`) REFERENCES `Promotion` (`PromotionID`);

--
-- Constraints for table `HistoriqueAchatLocation`
--
ALTER TABLE `HistoriqueAchatLocation`
  ADD CONSTRAINT `HistoriqueAchatLocation_ibfk_1` FOREIGN KEY (`AbonneID`) REFERENCES `Abonne` (`AbonneID`),
  ADD CONSTRAINT `HistoriqueAchatLocation_ibfk_2` FOREIGN KEY (`ContenuID`) REFERENCES `Contenu` (`ContenuID`);

--
-- Constraints for table `Paiement`
--
ALTER TABLE `Paiement`
  ADD CONSTRAINT `Paiement_ibfk_1` FOREIGN KEY (`AbonneID`) REFERENCES `Abonne` (`AbonneID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
