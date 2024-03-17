-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2024 at 06:06 PM
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
('ACC001', 'admin', '12345', 'นาวา บุญนาค', 'นาวา', '0812345678', 'nawa1234', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC002', 'user', '54321', 'สมชาย ใจดี', 'แมน', '0898765432', 'man.jai', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC003', 'user', '98765', 'สุรีย์พร วงศ์รักษ์', 'ฝ้าย', '0912345678', 'faii.wong', '25d55ad283aa400af464c76d713c07ad', 'Expired'),
('ACC004', 'user', '45678', 'กิตติศักดิ์ พงษ์ศักดิ์', 'บอย', '0823456789', 'boy.pong', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC005', 'admin', '36985', 'พิมพิลาไล ทองคำ', 'พิม', '0834567890', 'pim.thong', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC006', 'user', '27894', 'ณัฐพล ธรรมศักดิ์', 'ต้น', '0845678901', 'ton.tum', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC007', 'user', '85296', 'ชลธิชา ภักดีกุล', 'ฝน', '0856789012', 'fon.pakdee', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC008', 'user', '74138', 'วรัญญู วงษ์ชัย', 'อั้ม', '0867890123', 'aum.wong', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC009', 'admin', '62514', 'ปิยะนุช ศรีสุวรรณ', 'ปุ้ย', '0878901234', 'puy.srisuwan', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC010', 'user', '19537', 'ธนกฤต ใจมั่น', 'ตั้ม', '0889012345', 'tum.jaiman', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC011', 'user', '48269', 'รัชนก แก้วใส', 'แก้ว', '0890123456', 'kaew.kaew', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC012', 'user', '29175', 'นลินี ใจดี', 'ฝน', '0912345679', 'fon.jai', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC013', 'user', '73618', 'ชัยวัฒน์ ศรีสมบูรณ์', 'โอ๊ต', '0923456789', 'oat.srisomboon', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC014', 'user', '51482', 'พิมพิลาไล ทองคำ', 'พิม', '0934567890', 'pim.thong', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC015', 'user', '46927', 'ณัฐพล ธรรมศักดิ์', 'ต้น', '0945678901', 'ton.tum', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC016', 'admin', '35816', 'ชลธิชา ภักดีกุล', 'ฝน', '0956789012', 'fon.pakdee', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC017', 'user', '24795', 'วรัญญู วงษ์ชัย', 'อั้ม', '0967890123', 'aum.wong', '25d55ad283aa400af464c76d713c07ad', 'Unauthorized'),
('ACC018', 'user', '13674', 'ปิยะนุช ศรีสุวรรณ', 'ปุ้ย', '0978901234', 'puy.srisuwan', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC019', 'user', '82563', 'ธนกฤต ใจมั่น', 'ตั้ม', '0989012345', 'tum.jaiman', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC020', 'admin', '71452', 'รัชนก แก้วใส', 'แก้ว', '0990123456', 'kaew.kaew', '25d55ad283aa400af464c76d713c07ad', 'Actived'),
('ACC021', 'admin', '23576', 'ณัฐพล จันทร์รอน', 'ฟิล์ม', '0972806742', 'pingchingpongchongii', '97fa33ae093e9dfa499bced6a42b3e43', 'Actived');

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
('CAR001', 'ISUZU', '-', '4กผ-2033', 'No'),
('CAR002', 'ISUZU', '-', '4กผ-2037', 'Ready'),
('CAR003', 'ISUZU', '-', '4กผ-2040', 'No'),
('CAR004', 'ISUZU', '-', '4กผ-2043', 'Ready'),
('CAR005', 'TOYOTA', '-', 'ชห-8974', 'No'),
('CAR006', 'TOYOTA', '-', 'สฬ-4756', 'Ready'),
('CAR007', 'TOYOTA', '-', 'ชส-3276', 'No'),
('CAR008', 'ISUZU', '-', 'ชภ-4286', 'Ready'),
('CAR009', 'ISUZU', '-', 'ชภ-4287', 'Ready'),
('CAR010', 'TOYOTA', '-', 'ศอ-1432', 'Ready'),
('CAR011', '-', '-', '9กจ-6670', 'Ready');

-- --------------------------------------------------------

--
-- Table structure for table `doc_tb`
--

CREATE TABLE `doc_tb` (
  `Doc_ID` varchar(255) NOT NULL,
  `Car_ID` text NOT NULL,
  `Acc_ID` text NOT NULL,
  `Doc_File` text NOT NULL,
  `Doc_Upload` text NOT NULL DEFAULT '-',
  `Doc_Pay` text NOT NULL DEFAULT '-',
  `Doc_PayDate` text NOT NULL DEFAULT '-',
  `Doc_Status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_tb`
--

CREATE TABLE `log_tb` (
  `Log_ID` varchar(255) NOT NULL,
  `Log_Date` text NOT NULL,
  `ACC_ID` text NOT NULL,
  `Log_Event` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `log_tb`
--

INSERT INTO `log_tb` (`Log_ID`, `Log_Date`, `ACC_ID`, `Log_Event`) VALUES
('LOG0000000001', '20240316', 'ACC021', 'คุณ ณัฐพล จันทร์รอนฟิล์ม ได้เข้าสู่ระบบ เมื่อ 15:19 น.'),
('LOG0000000002', '20240316', 'ACC021', 'คุณ ณัฐพล จันทร์รอน(ฟิล์ม) ได้เข้าสู่ระบบ เมื่อ 15:20 น.'),
('LOG0000000003', '20240316', 'ACC021', 'คุณ ณัฐพล จันทร์รอน(ฟิล์ม) เข้าสู่ระบบ เมื่อวันที่ 16/03/2024 เวลา 15:25 น.');

-- --------------------------------------------------------

--
-- Table structure for table `mile_tb`
--

CREATE TABLE `mile_tb` (
  `Mile_ID` varchar(255) NOT NULL,
  `Car_ID` text NOT NULL,
  `Mile_LastUpdate` text NOT NULL,
  `Mile_Number` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `mile_tb`
--

INSERT INTO `mile_tb` (`Mile_ID`, `Car_ID`, `Mile_LastUpdate`, `Mile_Number`) VALUES
('MILE001', 'CAR001', '20220325', '178820'),
('MILE002', 'CAR002', '20220426', '160359'),
('MILE003', 'CAR003', '20240312', '235684'),
('MILE004', 'CAR004', '20240304', '185707'),
('MILE005', 'CAR005', '20240312', '469115'),
('MILE006', 'CAR006', '20240311', '631142'),
('MILE007', 'CAR007', '20200224', '435156'),
('MILE008', 'CAR008', '20240223', '526478'),
('MILE009', 'CAR009', '20240312', '529466'),
('MILE010', 'CAR010', '20221126', '606386'),
('MILE011', 'CAR011', '20240311', '98289');

-- --------------------------------------------------------

--
-- Table structure for table `reserve_tb`
--

CREATE TABLE `reserve_tb` (
  `Res_ID` varchar(255) NOT NULL,
  `Res_Project` text NOT NULL,
  `Res_StartDate` text NOT NULL,
  `Res_EndDate` text NOT NULL,
  `Car_ID` text NOT NULL,
  `Acc_ID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `reserve_tb`
--

INSERT INTO `reserve_tb` (`Res_ID`, `Res_Project`, `Res_StartDate`, `Res_EndDate`, `Car_ID`, `Acc_ID`) VALUES
('RES001', 'DE', '20240318', '20240318', 'CAR001', 'ACC002'),
('RES002', 'MRTA', '20240318', '20240325', 'CAR004', 'ACC005'),
('RES003', 'Store', '20240318', '20240321', 'CAR002', 'ACC006'),
('RES004', 'ตรวจศูนย์ DE3', '20240318', '20240330', 'CAR003', 'ACC007'),
('RES005', 'ตรวจศูนย์ DE1 , DE2 ขอนแก่น,กาฬสินธุ์ มหาสารคาม,ร้อยเอ็ด', '20240318', '20240325', 'CAR005', 'ACC008'),
('RES006', 'Survey ราชบุรี', '20240318', '20240319', 'CAR006', 'ACC009'),
('RES007', 'PTT', '20240318', '20240321', 'CAR007', 'ACC010'),
('RES008', 'MWA', '20240318', '20240405', 'CAR008', 'ACC011'),
('RES009', 'Survey ราชบุรี', '20240318', '20240318', 'CAR009', 'ACC011'),
('RES010', 'DE', '20240318', '20240318', 'CAR010', 'ACC011'),
('RES011', 'Store', '20240318', '20240318', 'CAR011', 'ACC011');

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
-- Indexes for table `doc_tb`
--
ALTER TABLE `doc_tb`
  ADD PRIMARY KEY (`Doc_ID`);

--
-- Indexes for table `log_tb`
--
ALTER TABLE `log_tb`
  ADD PRIMARY KEY (`Log_ID`);

--
-- Indexes for table `mile_tb`
--
ALTER TABLE `mile_tb`
  ADD PRIMARY KEY (`Mile_ID`);

--
-- Indexes for table `reserve_tb`
--
ALTER TABLE `reserve_tb`
  ADD PRIMARY KEY (`Res_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
