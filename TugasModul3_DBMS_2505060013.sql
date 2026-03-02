-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Feb 2026 pada 06.37
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mahasiswa1`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa1`
--

CREATE TABLE `mahasiswa1` (
  `NPM` char(5) NOT NULL,
  `Nama` varchar(25) NOT NULL,
  `Tempat_Lahir` varchar(30) NOT NULL,
  `Tanggal_Lahir` date NOT NULL,
  `Jenis_Kelamin` enum('L','P') NOT NULL,
  `No_Hp` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mahasiswa1`
--

INSERT INTO `mahasiswa1` (`NPM`, `Nama`, `Tempat_Lahir`, `Tanggal_Lahir`, `Jenis_Kelamin`, `No_Hp`) VALUES
('111', 'Zhang Ling He', 'China', '1997-12-30', 'L', '0987654321'),
('112', 'Dylan Wang', 'Tiongkok', '1998-12-20', 'L', '1234567890'),
('113', 'Xiao Yuxi', 'Tiongkok', '1995-07-20', 'L', '1224567890'),
('115', 'Dilraba Dilmut', 'Tiongkok', '1992-07-03', 'P', '1234456789');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `mahasiswa1`
--
ALTER TABLE `mahasiswa1`
  ADD PRIMARY KEY (`NPM`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
