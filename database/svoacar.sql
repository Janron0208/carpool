-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2024 at 02:10 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carpool`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_tb`
--

CREATE TABLE `account_tb` (
  `Acc_ID` varchar(255) NOT NULL,
  `Acc_Type` text NOT NULL,
  `Acc_Code` text NOT NULL,
  `Acc_Fullname` text NOT NULL,
  `Acc_Nickname` text NOT NULL,
  `Acc_Tel` text NOT NULL,
  `Acc_Line` text NOT NULL,
  `Acc_Password` text NOT NULL,
  `Acc_Status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `account_tb`
--

INSERT INTO `account_tb` (`Acc_ID`, `Acc_Type`, `Acc_Code`, `Acc_Fullname`, `Acc_Nickname`, `Acc_Tel`, `Acc_Line`, `Acc_Password`, `Acc_Status`) VALUES
('ACC001', 'admin', '12345', 'นาวา บุญนาค', 'นาวา', '0812345678', 'nawa1234', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC002', 'user', '54321', 'สมชาย ใจดี', 'แมน', '0898765432', 'man.jai', '25d55ad283aa400af464c76d713c07ad', 'Pending'),
('ACC003', 'user', '98765', 'สุรีย์พร วงศ์รักษ์', 'ฝ้าย', '0912345678', 'faii.wong', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC004', 'user', '45678', 'กิตติศักดิ์ พงษ์ศักดิ์', 'บอย', '0823456789', 'boy.pong', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC005', 'user', '36985', 'พิมพิลาไล ทองคำ', 'พิม', '0834567890', 'pim.thong', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC006', 'user', '27894', 'ณัฐพล ธรรมศักดิ์', 'ต้น', '0845678901', 'ton.tum', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC007', 'user', '85296', 'ชลธิชา ภักดีกุล', 'ฝน', '0856789012', 'fon.pakdee', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC008', 'user', '74138', 'วรัญญู วงษ์ชัย', 'อั้ม', '0867890123', 'aum.wong', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC009', 'admin', '62514', 'ปิยะนุช ศรีสุวรรณ', 'ปุ้ย', '0878901234', 'puy.srisuwan', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC010', 'user', '19537', 'ธนกฤต ใจมั่น', 'ตั้ม', '0889012345', 'tum.jaiman', '25d55ad283aa400af464c76d713c07ad', 'Pending'),
('ACC011', 'user', '48269', 'รัชนก แก้วใส', 'แก้ว', '0890123456', 'kaew.kaew', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC012', 'user', '29175', 'นลินี ใจดี', 'ฝน', '0912345679', 'fon.jai', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC013', 'user', '73618', 'ชัยวัฒน์ ศรีสมบูรณ์', 'โอ๊ต', '0923456789', 'oat.srisomboon', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC014', 'user', '51482', 'พิมพิลาไล ทองคำ', 'พิม', '0934567890', 'pim.thong', '25d55ad283aa400af464c76d713c07ad', 'Pending'),
('ACC015', 'user', '46927', 'ณัฐพล ธรรมศักดิ์', 'ต้น', '0945678901', 'ton.tum', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC016', 'admin', '35816', 'ชลธิชา ภักดีกุล', 'ฝน', '0956789012', 'fon.pakdee', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC017', 'user', '24795', 'วรัญญู วงษ์ชัย', 'อั้ม', '0967890123', 'aum.wong', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC018', 'user', '13674', 'ปิยะนุช ศรีสุวรรณ', 'ปุ้ย', '0978901234', 'puy.srisuwan', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC019', 'user', '82563', 'ธนกฤต ใจมั่น', 'ตั้ม', '0989012345', 'tum.jaiman', '25d55ad283aa400af464c76d713c07ad', 'Authorized'),
('ACC020', 'admin', '71452', 'รัชนก แก้วใส', 'แก้ว', '0990123456', 'kaew.kaew', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized');

-- --------------------------------------------------------

--
-- Table structure for table `brand_tb`
--

CREATE TABLE `brand_tb` (
  `Br_ID` varchar(5) NOT NULL,
  `Br_Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_tb`
--

CREATE TABLE `car_tb` (
  `Car_ID` varchar(255) NOT NULL,
  `Car_Brand` text NOT NULL,
  `Car_Model` text NOT NULL,
  `Car_Number` text NOT NULL,
  `Car_Status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `car_tb`
--

INSERT INTO `car_tb` (`Car_ID`, `Car_Brand`, `Car_Model`, `Car_Number`, `Car_Status`) VALUES
('CAR001', 'ISUZU', '-', '4กผ-2033', 'Ready'),
('CAR002', 'ISUZU', '-', '4กผ-2037', 'Ready'),
('CAR003', 'ISUZU', '-', '4กผ-2040', 'Ready'),
('CAR004', 'ISUZU', '-', '4กผ-2043', 'Ready'),
('CAR005', 'TOYOTA', '-', 'ชห-8974', 'Ready'),
('CAR006', 'TOYOTA', '-', 'สฬ-4756', 'Ready'),
('CAR007', 'TOYOTA', '-', 'ชส-3276', 'Ready'),
('CAR008', 'ISUZU', '-', 'ชภ-4286', 'Ready'),
('CAR009', 'ISUZU', '-', 'ชภ-4287', 'Ready'),
('CAR010', 'TOYOTA', '-', 'ศอ-1432', 'Ready'),
('CAR011', '-', '-', '9กจ-6670', 'Ready');

-- --------------------------------------------------------

--
-- Table structure for table `log_tb`
--

CREATE TABLE `log_tb` (
  `Log_ID` varchar(255) NOT NULL,
  `Log_Date` text NOT NULL,
  `ACC_ID` text NOT NULL,
  `Log_Event` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mile_tb`
--

CREATE TABLE `mile_tb` (
  `Mile_ID` int(11) NOT NULL,
  `Mile_LastUpdate` int(11) NOT NULL,
  `Car_ID` int(11) NOT NULL,
  `Number` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_tb`
--
ALTER TABLE `account_tb`
  ADD PRIMARY KEY (`Acc_ID`);

--
-- Indexes for table `brand_tb`
--
ALTER TABLE `brand_tb`
  ADD PRIMARY KEY (`Br_ID`);

--
-- Indexes for table `car_tb`
--
ALTER TABLE `car_tb`
  ADD PRIMARY KEY (`Car_ID`);

--
-- Indexes for table `mile_tb`
--
ALTER TABLE `mile_tb`
  ADD PRIMARY KEY (`Mile_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mile_tb`
--
ALTER TABLE `mile_tb`
  MODIFY `Mile_ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
