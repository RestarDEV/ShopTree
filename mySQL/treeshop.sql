-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2020 at 06:18 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `treeshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `treetable`
--

CREATE TABLE `treetable` (
  `id` int(11) NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameTree` text COLLATE utf8_unicode_ci NOT NULL,
  `PathImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Detail` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `treetable`
--

INSERT INTO `treetable` (`id`, `idShop`, `NameTree`, `PathImage`, `Price`, `Detail`) VALUES
(1, '13', 'ข้าวผัดไข่', '/treeshop/Tree/tree411745.jpg', '25', 'ไม่บอก ลุ้นเอาเอง'),
(3, '2', 'gg', '/treeshop/Tree/tree217157.jpg', '56', 'Gg'),
(4, '2', 'เค็บหมู', '/treeshop/Tree/tree598485.jpg', '20', 'Hhh'),
(5, '2', 'ปลอม', '/treeshop/Tree/tree119985.jpg', '30', 'ไม่บอก'),
(6, '2', 'ชาบู', '/treeshop/Tree/tree789965.jpg', '278', 'อร่อย'),
(9, '2', 'ชาบู', '/treeshop/Tree/tree789965.jpg', '278', 'อร่อย'),
(10, '2', '$name', '$pathImage', '$price', '$detail'),
(11, '15', 'เปเปอร์​หยก', '/treeshop/Tree/tree257117.jpg', '10', 'ไม่ทราบ');

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE `usertable` (
  `id` int(11) NOT NULL,
  `ChooseType` text COLLATE utf8_unicode_ci NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `User` text COLLATE utf8_unicode_ci NOT NULL,
  `Password` text COLLATE utf8_unicode_ci NOT NULL,
  `NameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `Address` text COLLATE utf8_unicode_ci NOT NULL,
  `Phone` text COLLATE utf8_unicode_ci NOT NULL,
  `UrlPicture` text COLLATE utf8_unicode_ci NOT NULL,
  `Lat` text COLLATE utf8_unicode_ci NOT NULL,
  `Lng` text COLLATE utf8_unicode_ci NOT NULL,
  `Token` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usertable`
--

INSERT INTO `usertable` (`id`, `ChooseType`, `Name`, `User`, `Password`, `NameShop`, `Address`, `Phone`, `UrlPicture`, `Lat`, `Lng`, `Token`) VALUES
(1, 'User', 'restardevuser', 'restardevuser', '1234', '', '', '', '', '', '', ''),
(2, 'Shop', 'restardevshop', 'restardevshop', '1234', 'ShopTree', '130 หมู่ 2 ต.โพนางดำออก อ.สรรพยา จ.ชัยนาท 17150', '0972938844', '/treeshop/Shop/shop414017.jpg', '15.0898043', '100.2910385', ''),
(3, 'Rider', 'restardevrider', 'restardevrider', '1234', '', '', '', '', '', '', ''),
(12, 'User', 'test', 'testpostman', '123456', '', '', '', '', '', '', ''),
(13, 'Shop', 'Admin', 'admin', '123456', '555555​555555​555555​', 'admin', '1234​ บางนา กรุงเทพ', '/treeshop/Shop/editShop1763.jpg', '15.0835936', '100.2882705', ''),
(14, 'chooseType', 'name', 'user', 'password', '', '', '', '', '', '', ''),
(15, 'Shop', 'gameuser', 'gameuser', '123456', 'ต้นไม้ตกแต่ง', '123', '0972933844', '/treeshop/Shop/shop715571.jpg', '15.083506', '100.2884091', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `treetable`
--
ALTER TABLE `treetable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `treetable`
--
ALTER TABLE `treetable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
