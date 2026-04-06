-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Apr 2026 pada 17.55
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
-- Database: `data_mahasiswa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_mahasiswa`
--

CREATE TABLE `data_mahasiswa` (
  `NIM` char(9) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `alamat` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `data_mahasiswa`
--

INSERT INTO `data_mahasiswa` (`NIM`, `nama`, `alamat`) VALUES
('10305001', 'jiawei', 'rembang'),
('10305002', 'yuxi', 'bandung'),
('10305003', 'didi', 'semarang'),
('10305004', 'xinxin', 'jakarta'),
('10305005', 'bailu', 'kudus'),
('10305006', 'reba', 'jogja'),
('10305007', 'bozai', 'pati');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_peminjam`
--

CREATE TABLE `data_peminjam` (
  `id_peminjaman` int(11) NOT NULL,
  `nim` char(9) NOT NULL,
  `buku` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `data_peminjam`
--

INSERT INTO `data_peminjam` (`id_peminjaman`, `nim`, `buku`) VALUES
(1, '10305001', 'Buku Teknik Nuklir'),
(2, '10305002', 'Buku Biologi'),
(3, '10305003', 'Buku Kalkulus'),
(4, '10305009', 'Buku Fisika'),
(5, '103050011', 'Buku Kimia'),
(6, '10305006', 'Buku Dasar-dasar Pemrograman'),
(7, '103050015', 'Buku Psikologi');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `data_mahasiswa`
--
ALTER TABLE `data_mahasiswa`
  ADD PRIMARY KEY (`NIM`);

--
-- Indeks untuk tabel `data_peminjam`
--
ALTER TABLE `data_peminjam`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `data_peminjam`
--
ALTER TABLE `data_peminjam`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
