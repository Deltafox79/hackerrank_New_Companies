-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Set 15, 2018 alle 14:56
-- Versione del server: 8.0.12
-- Versione PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `companies`
--
CREATE DATABASE IF NOT EXISTS `companies` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `companies`;

-- --------------------------------------------------------

--
-- Struttura della tabella `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_code` varchar(255) NOT NULL,
  `founder` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `company`
--

INSERT INTO `company` (`company_code`, `founder`) VALUES
('C1', 'Monika'),
('C2', 'Samantha');

-- --------------------------------------------------------

--
-- Struttura della tabella `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `employee_code` varchar(255) NOT NULL,
  `manager_code` varchar(255) NOT NULL,
  `senior_manager_code` varchar(255) NOT NULL,
  `lead_manager_code` varchar(255) NOT NULL,
  `company_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `employee`
--

INSERT INTO `employee` (`employee_code`, `manager_code`, `senior_manager_code`, `lead_manager_code`, `company_code`) VALUES
('E1', 'M1', 'SM1', 'LM1', 'C1'),
('E2', 'M1', 'SM1', 'LM1', 'C1'),
('E3', 'M2', 'SM3', 'LM2', 'C2'),
('E4', 'M3', 'SM3', 'LM2', 'C2');

-- --------------------------------------------------------

--
-- Struttura della tabella `lead_manager`
--

DROP TABLE IF EXISTS `lead_manager`;
CREATE TABLE `lead_manager` (
  `lead_manager_code` varchar(255) NOT NULL,
  `company_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `lead_manager`
--

INSERT INTO `lead_manager` (`lead_manager_code`, `company_code`) VALUES
('LM1', 'C1'),
('LM2', 'C2');

-- --------------------------------------------------------

--
-- Struttura della tabella `manager`
--

DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `manager_code` varchar(255) NOT NULL,
  `senior_manager_code` varchar(255) NOT NULL,
  `lead_manager_code` varchar(255) NOT NULL,
  `company_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `manager`
--

INSERT INTO `manager` (`manager_code`, `senior_manager_code`, `lead_manager_code`, `company_code`) VALUES
('M1', 'SM1', 'LM1', 'C1'),
('M2', 'SM3', 'LM2', 'C2'),
('M3', 'SM3', 'LM2', 'C2');

-- --------------------------------------------------------

--
-- Struttura della tabella `senior_manager`
--

DROP TABLE IF EXISTS `senior_manager`;
CREATE TABLE `senior_manager` (
  `senior_manager_code` varchar(255) NOT NULL,
  `lead_manager_code` varchar(255) NOT NULL,
  `company_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dump dei dati per la tabella `senior_manager`
--

INSERT INTO `senior_manager` (`senior_manager_code`, `lead_manager_code`, `company_code`) VALUES
('SM1', 'LM1', 'C1'),
('SM2', 'LM1', 'C1'),
('SM3', 'LM2', 'C2');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
