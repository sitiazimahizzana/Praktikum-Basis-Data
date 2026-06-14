-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2026 at 03:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toko_buku`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_transaksi` (IN `p_id_pelanggan` INT, IN `p_id_buku` INT, IN `p_jumlah` INT)   BEGIN
    DECLARE v_harga       DECIMAL(10,2);
    DECLARE v_stok        INT;
    DECLARE v_total_harga DECIMAL(10,2);
 
    SELECT harga, stok
    INTO   v_harga, v_stok
    FROM   buku
    WHERE  id_buku = p_id_buku;
 
    IF v_stok < p_jumlah THEN
        SELECT CONCAT('ERROR: Stok tidak mencukupi. Stok tersedia: ', v_stok,
                      ' buku, diminta: ', p_jumlah, ' buku.') AS pesan;
    ELSE
        SET v_total_harga = v_harga * p_jumlah;
 
        UPDATE buku
        SET    stok = stok - p_jumlah
        WHERE  id_buku = p_id_buku;
 
        INSERT INTO transaksi (id_pelanggan, id_buku, jumlah, total_harga, tanggal_transaksi)
        VALUES (p_id_pelanggan, p_id_buku, p_jumlah, v_total_harga, CURDATE());
 
        UPDATE pelanggan
        SET    total_belanja = total_belanja + v_total_harga
        WHERE  id_pelanggan = p_id_pelanggan;
 
        SELECT CONCAT('Transaksi berhasil! Total harga: Rp ',
                      FORMAT(v_total_harga, 0, 'id_ID'), '.') AS pesan;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_diskon` (`total_belanja` DECIMAL(10,2)) RETURNS DECIMAL(5,2) DETERMINISTIC BEGIN
    DECLARE diskon DECIMAL(5,2);
    IF total_belanja >= 5000000 THEN
        SET diskon = 10.00;
    ELSEIF total_belanja >= 1000000 THEN
        SET diskon = 5.00;
    ELSE
        SET diskon = 0.00;
    END IF;
    RETURN diskon;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `penulis` varchar(100) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penulis`, `harga`, `stok`) VALUES
(1, 'Laut Bercerita', 'Leila S. Chudori', 109000.00, 1),
(2, 'Gadis Kretek', 'Ratih Kumala', 99000.00, 4),
(3, 'Naoko', 'Keigo Higashino', 99000.00, 4),
(4, 'Atomic Habits', 'James Clear', 118000.00, 7),
(5, 'Bumi Manusia', 'Pramoedya Ananta Toer', 104000.00, 16);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `total_belanja` decimal(10,2) DEFAULT 0.00,
  `status_member` enum('REGULER','GOLD','PLATINUM') DEFAULT 'REGULER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `total_belanja`, `status_member`) VALUES
(55, 'Nut', 6000000.00, 'PLATINUM'),
(66, 'Lego', 200000.00, ''),
(77, 'Tui', 1500000.00, 'GOLD'),
(88, 'Hong', 500000.00, 'REGULER'),
(99, 'William', 7495000.00, 'PLATINUM');

--
-- Triggers `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `update_status_member` AFTER UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    IF NEW.total_belanja >= 5000000 THEN
        UPDATE pelanggan
        SET    status_member = 'PLATINUM'
        WHERE  id_pelanggan = NEW.id_pelanggan;
 
    ELSEIF NEW.total_belanja >= 1000000 THEN
        UPDATE pelanggan
        SET    status_member = 'GOLD'
        WHERE  id_pelanggan = NEW.id_pelanggan;
 
    ELSE
        UPDATE pelanggan
        SET    status_member = 'REGULER'
        WHERE  id_pelanggan = NEW.id_pelanggan;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_pelanggan`, `id_buku`, `jumlah`, `total_harga`, `tanggal_transaksi`) VALUES
(4, 99, 3, 5, 495000.00, '2026-06-14'),
(5, 99, 2, 5, 495000.00, '2026-06-14'),
(6, 88, 2, 1, 99000.00, '2026-06-14'),
(7, 99, 4, 5, 590000.00, '2026-06-14'),
(8, 88, 4, 3, 354000.00, '2026-06-14'),
(9, 77, 5, 1, 104000.00, '2026-06-14'),
(10, 66, 5, 3, 312000.00, '2026-06-14'),
(11, 55, 3, 1, 99000.00, '2026-06-14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_buku` (`id_buku`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
