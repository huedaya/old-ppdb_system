-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2014 at 10:30 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_ppdb_system`
--

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `fungsi1`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fungsi1`(`nama_studi` VARCHAR(20)) RETURNS varchar(5) CHARSET latin1
    NO SQL
begin
	declare nomor, hasil varchar(5);
	declare panjang int;

	select (max(substring(nomor_pendaftaran,9,9)+1)) into nomor from ppdb_biodata where substring(nomor_pendaftaran,6,8) = id_program_studi;

	if (nomor is NULL) then
		set nomor = 1;
	end if;

	set panjang = length(nomor);

	if panjang = 1 then
		set hasil = concat("000",nomor);
	elseif panjang = 2 then
		set hasil = concat("00",nomor);
	elseif panjang = 3 then
		set hasil = concat("0",nomor);
	elseif panjang = 4 then
		set hasil = concat(nomor);
	end if;

return hasil;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ext_agama`
--

DROP TABLE IF EXISTS `ext_agama`;
CREATE TABLE IF NOT EXISTS `ext_agama` (
  `id_agama` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_agama`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ext_agama`
--

INSERT INTO `ext_agama` (`id_agama`, `nama`, `status`) VALUES
(1, 'Islam', 1),
(2, 'Kristen', 1),
(3, 'Katolik', 1),
(4, 'Hindu', 1),
(5, 'Budha', 1),
(6, 'Konghucu', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ext_pekerjaan_ortu`
--

DROP TABLE IF EXISTS `ext_pekerjaan_ortu`;
CREATE TABLE IF NOT EXISTS `ext_pekerjaan_ortu` (
  `id_pekerjaan_ortu` int(10) NOT NULL AUTO_INCREMENT,
  `tipe_pekerjaan` int(2) NOT NULL DEFAULT '1',
  `nama_pekerjaan` varchar(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_pekerjaan_ortu`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `ext_pekerjaan_ortu`
--

INSERT INTO `ext_pekerjaan_ortu` (`id_pekerjaan_ortu`, `tipe_pekerjaan`, `nama_pekerjaan`, `status`) VALUES
(4, 1, 'PETANI', 1),
(5, 1, 'WIRASWASTA', 1),
(6, 1, 'SWASTA', 1),
(7, 1, 'BURUH TANI', 1),
(8, 1, 'BURUH', 1),
(9, 1, 'KARYAWAN', 1),
(10, 1, 'PNS', 1),
(11, 2, 'IBU RUMAH TANGGA / IRT', 1),
(12, 1, 'PEDAGANG', 1),
(13, 1, 'PENS. GURU / PNS', 1),
(14, 1, 'SOPIR', 1),
(15, 1, 'PENSIUNAN', 1),
(16, 1, 'GURU', 1),
(17, 1, 'BURUH BANGUNAN', 1),
(18, 1, 'PENJAHIT', 1),
(19, 1, 'TUKANG BATU', 1),
(20, 1, 'KONTRUKSI', 1),
(21, 1, 'TNI-AD', 1),
(22, 1, 'PURN. POLRI', 1),
(23, 1, 'LAINNYA', 1),
(24, 1, 'PERANGKAT DESA', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ext_program_studi`
--

DROP TABLE IF EXISTS `ext_program_studi`;
CREATE TABLE IF NOT EXISTS `ext_program_studi` (
  `id_program_studi` int(10) NOT NULL AUTO_INCREMENT,
  `no_studi` int(3) NOT NULL,
  `nama_studi` varchar(100) NOT NULL,
  `alias_studi` varchar(10) NOT NULL,
  `jumlah_kelas` int(3) NOT NULL,
  `jumlah_siswa` int(100) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_program_studi`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `ext_program_studi`
--

INSERT INTO `ext_program_studi` (`id_program_studi`, `no_studi`, `nama_studi`, `alias_studi`, `jumlah_kelas`, `jumlah_siswa`, `status`) VALUES
(1, 1, 'Akuntansi', 'AK', 3, 105, 1),
(2, 2, 'Administrasi Perkantoran', 'AP', 3, 105, 1),
(3, 3, 'Tata Niaga', 'TN', 3, 105, 1),
(4, 4, 'Rekayasa Perangkat Lunak', 'RPL', 2, 70, 1),
(5, 5, 'Teknik Komputer dan Jaringan', 'TKJ', 3, 105, 1),
(7, 7, 'Agribisnis Perikanan', 'APi', 2, 70, 1),
(8, 6, 'Tata Busana', 'TB', 2, 72, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_biodata`
--

DROP TABLE IF EXISTS `ppdb_biodata`;
CREATE TABLE IF NOT EXISTS `ppdb_biodata` (
  `id_ppdb` bigint(20) NOT NULL AUTO_INCREMENT,
  `nomor_pendaftaran` varchar(100) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(2) NOT NULL,
  `id_agama` int(2) NOT NULL,
  `tempat_lahir` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `umur` int(3) NOT NULL,
  `alamat_rumah` varchar(500) NOT NULL,
  `rt_rw` varchar(10) NOT NULL,
  `kecamatan` varchar(100) NOT NULL,
  `kabupaten` varchar(100) NOT NULL,
  `kode_pos` int(10) NOT NULL,
  `no_hp_calon_siswa` varchar(20) NOT NULL,
  `tinggi_badan` int(4) NOT NULL,
  `berat_badan` int(4) NOT NULL,
  `golongan_darah` varchar(3) NOT NULL,
  `nama_ayah_kandung` varchar(100) NOT NULL,
  `id_pekerjaan_ayah` int(10) NOT NULL,
  `nama_ibu_kandung` varchar(100) NOT NULL,
  `id_pekerjaan_ibu` int(10) NOT NULL,
  `no_hp_orang_tua` varchar(20) NOT NULL,
  `asal_sekolah` varchar(255) NOT NULL,
  `tahun_lulus` year(4) NOT NULL,
  `piagam_prestasi` tinyint(1) NOT NULL DEFAULT '0',
  `fc_raport` tinyint(1) NOT NULL DEFAULT '0',
  `ijasah` tinyint(1) NOT NULL DEFAULT '0',
  `skhun` tinyint(1) NOT NULL DEFAULT '0',
  `id_program_studi` int(10) NOT NULL,
  `tempat_daftar` varchar(100) NOT NULL,
  `tanggal_daftar` date NOT NULL,
  `mengetahui` varchar(255) NOT NULL,
  `jalur` varchar(25) NOT NULL,
  `status_hapus` int(2) NOT NULL DEFAULT '0',
  `status_sah` int(2) NOT NULL DEFAULT '0',
  `status_terima` int(2) NOT NULL DEFAULT '0',
  `foto` varchar(200) NOT NULL DEFAULT 'default.jpg',
  `id_petugas` int(10) NOT NULL,
  PRIMARY KEY (`id_ppdb`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `ppdb_biodata`
--

INSERT INTO `ppdb_biodata` (`id_ppdb`, `nomor_pendaftaran`, `nama_lengkap`, `jenis_kelamin`, `id_agama`, `tempat_lahir`, `tanggal_lahir`, `umur`, `alamat_rumah`, `rt_rw`, `kecamatan`, `kabupaten`, `kode_pos`, `no_hp_calon_siswa`, `tinggi_badan`, `berat_badan`, `golongan_darah`, `nama_ayah_kandung`, `id_pekerjaan_ayah`, `nama_ibu_kandung`, `id_pekerjaan_ibu`, `no_hp_orang_tua`, `asal_sekolah`, `tahun_lulus`, `piagam_prestasi`, `fc_raport`, `ijasah`, `skhun`, `id_program_studi`, `tempat_daftar`, `tanggal_daftar`, `mengetahui`, `jalur`, `status_hapus`, `status_sah`, `status_terima`, `foto`, `id_petugas`) VALUES
(7, '2014.01.0001', 'ARMAN MAULANA', 'L', 1, 'SURABAYA', '1990-04-09', 24, 'JL. RAYA PUCANG BAWANG NO 180', '02/04', 'BAWANG', 'SURABAYA', 53411, '089629457431', 170, 60, 'O', 'IBNU SAHID', 20, 'MAIMUNAH', 11, '080111111111', 'SMPN 1 SURABAYA', 2014, 0, 0, 0, 0, 1, 'SURABAYA', '2014-06-12', 'IBNU SAHID', 'REGULER', 0, 0, 0, 'default.png', 1),
(9, '2014.02.0001', 'ASWIN SETIAWAN', 'L', 1, 'SURABAYA', '1997-04-12', 17, 'DS. KARANG PUCUNG, WANADADI', '04/01', 'KASILIB', 'SURABAYA', 53490, '087998981991', 150, 40, 'B', 'MUTOHAR', 5, 'DARYATI', 11, '080111111111', 'SMPN 2 SURABAYA', 2012, 1, 1, 1, 1, 2, 'SURABAYA', '2014-06-13', 'MUTOHAR', 'REGULER', 0, 1, 0, 'default.png', 0),
(10, '2014.03.0001', 'SDFASD', 'L', 1, 'FSDF', '1997-12-12', 16, 'WSEQ', '01/01', 'ASD', 'ASD', 213123, '1231231231231', 312, 12, 'O', 'ASDASD', 4, 'ASDASD', 4, '1312312312', 'ASDASD', 2013, 1, 1, 1, 1, 3, 'ASDASDAS', '2014-06-13', 'ASDASD', 'REGULER', 0, 0, 0, 'default.jpg', 1),
(12, '2014.02.0001', 'JASMORO RAFI', 'L', 1, 'SURABAYA', '1997-03-12', 17, 'DS. KADADI', '03/01', 'WANADADI', 'SURABAYA', 543231, '08561559154', 170, 50, 'A', 'PRIYATNO', 9, 'MISNYAH', 16, '080111111111', 'SMP NEGERI 1 WANADADI', 2012, 0, 0, 0, 0, 2, 'SURABAYA', '2014-06-13', 'MUTOHAR', 'REGULER', 0, 1, 1, 'default.jpg', 1),
(13, '2014.04.0001', 'MATTHEW JAMES BELLAMY', 'L', 1, 'SURABAYA', '1997-03-12', 17, 'DS. KARANG PUCUNG, WANADADI', '04/01', 'WANADADI', 'SURABAYA', 543231, '08561559154', 170, 50, 'A', 'PRIYATNO', 4, 'MISNYAH', 5, '080111111111', 'SMPN 2 SURABAYA', 2012, 1, 1, 1, 1, 4, 'SURABAYA', '2014-06-13', 'BUDI', 'REGULER', 1, 0, 0, 'default.jpg', 1),
(14, '2014.02.0001', 'SOLEH', 'L', 1, 'SURABAYA', '1997-03-12', 17, 'SURABAYA', '04/01', 'SURABAYA', 'SURABAYA', 63287, '983240', 178, 89, 'A', 'JKF', 4, 'ASODHI', 4, '98908', 'ILUASD', 2014, 0, 0, 0, 0, 2, 'SURABAYA', '2014-06-13', 'FJDS', 'REGULER', 0, 1, 0, 'default.jpg', 1);

--
-- Triggers `ppdb_biodata`
--
DROP TRIGGER IF EXISTS `ppdb_delete`;
DELIMITER //
CREATE TRIGGER `ppdb_delete` BEFORE DELETE ON `ppdb_biodata`
 FOR EACH ROW -- TRIGGER DELETE
begin
declare id_ppdb int;

set id_ppdb = old.id_ppdb;

	DELETE FROM ppdb_nilai WHERE ppdb_nilai.id_ppdb = id_ppdb;

end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ppdb_insert`;
DELIMITER //
CREATE TRIGGER `ppdb_insert` BEFORE INSERT ON `ppdb_biodata`
 FOR EACH ROW -- TRIGGER INSERT PPDB
begin
    -- DEKRASI VARIABLE YANG DIBUTUHKAN
    declare program_studi, jadi, nomor, angkatan varchar(25);
   
    -- AKTIFKAN TANGGAL SEKARANG
    set new.tanggal_daftar = date(now()); 
    
    -- MENGAMBIL TAHUN ANGKATAN DARI TANGGAL DAFTAR
    set angkatan = SUBSTRING(new.tanggal_daftar,1,4);

    -- REPLACE STRING PROGRAM STUDI
    set program_studi = case
        when new.id_program_studi = 1 then '01'
        when new.id_program_studi = 2 then '02'
        when new.id_program_studi = 3 then '03'
        when new.id_program_studi = 4 then '04'
        when new.id_program_studi = 5 then '05'
        when new.id_program_studi = 6 then '07'
        when new.id_program_studi = 7 then '07'
        else ''
    end;

    -- JIKA KOSONG MAKA SET BARU
    if (fungsi1(program_studi)=NULL) then
        set nomor = '0001';
    else
        set nomor = fungsi1(program_studi);
    end if;

    -- ID UNIK NOMOR_PENDAFTARAN / YYYY.PROGRAM_JURUSAN.ID
    set jadi = concat(angkatan,'.',program_studi,'.',nomor);

    set new.nomor_pendaftaran = jadi;

 


-- UPPERCASE ALL NAME
    set new.nama_lengkap = UCASE(new.nama_lengkap);   
    set new.jenis_kelamin = UCASE(new.jenis_kelamin);
    set new.tempat_lahir = UCASE(new.tempat_lahir);  
    set new.alamat_rumah = UCASE(new.alamat_rumah);  
    set new.kecamatan = UCASE(new.kecamatan); 
    set new.kabupaten = UCASE(new.kabupaten);  
    set new.nama_ayah_kandung = UCASE(new.nama_ayah_kandung);  
    set new.nama_ibu_kandung = UCASE(new.nama_ibu_kandung);         
    set new.asal_sekolah = UCASE(new.asal_sekolah);     
    set new.tempat_daftar = UCASE(new.tempat_daftar);   
    set new.mengetahui = UCASE(new.mengetahui);   
    set new.jalur = UCASE(new.jalur);   

-- COUNT AGE
    set new.umur = DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(new.tanggal_lahir)), '%Y')+0 ;
end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ppdb_update`;
DELIMITER //
CREATE TRIGGER `ppdb_update` BEFORE UPDATE ON `ppdb_biodata`
 FOR EACH ROW -- TRIGGER UPDATE DATA PPDB
begin
    -- DEKRASI VARIABLE YANG DIBUTUHKAN
    declare program_studi, jadi, nomor, angkatan varchar(25);

    -- AKTIFKAN TANGGAL SEKARANG
    set new.tanggal_daftar = date(now());

    -- MENGAMBIL TAHUN ANGKATAN DARI TANGGAL DAFTAR
    set angkatan = SUBSTRING(new.tanggal_daftar,1,5);
 
    -- REPLACE STRING PROGRAM STUDI
    set program_studi = case
        when new.id_program_studi = 1 then '01'
        when new.id_program_studi = 2 then '02'
        when new.id_program_studi = 3 then '03'
        when new.id_program_studi = 4 then '04'
        when new.id_program_studi = 5 then '05'
        when new.id_program_studi = 6 then '06'
        when new.id_program_studi = 7 then '07'
        else ''
    end;
    
    -- JIKA KOSONG MAKA SET BARU
    if (fungsi1(program_studi)=NULL) then
        set nomor = '00001';
    else
        set nomor = fungsi1(program_studi);
    end if;

    -- ID UNIK NOMOR_PENDAFTARAN / YYYY.PROGRAM_JURUSAN.ID
    set jadi = concat(angkatan,'.',program_studi,'.',nomor);

    -- SET ID UNIK
    if (old.id_program_studi = new.id_program_studi) then
        set new.nomor_pendaftaran = old.nomor_pendaftaran;
    else
        set new.nomor_pendaftaran = jadi;
    end if;


    -- UPPERCASE ALL NAME
    set new.nama_lengkap = UCASE(new.nama_lengkap);   
    set new.jenis_kelamin = UCASE(new.jenis_kelamin);
    set new.tempat_lahir = UCASE(new.tempat_lahir);  
    set new.alamat_rumah = UCASE(new.alamat_rumah);  
    set new.kecamatan = UCASE(new.kecamatan); 
    set new.kabupaten = UCASE(new.kabupaten);  
    set new.nama_ayah_kandung = UCASE(new.nama_ayah_kandung);  
    set new.nama_ibu_kandung = UCASE(new.nama_ibu_kandung);         
    set new.asal_sekolah = UCASE(new.asal_sekolah);     
    set new.tempat_daftar = UCASE(new.tempat_daftar);   
    set new.mengetahui = UCASE(new.mengetahui);   
    set new.jalur = UCASE(new.jalur);   

    -- COUNT AGE
    set new.umur = DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(new.tanggal_lahir)), '%Y')+0 ;
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_instansi`
--

DROP TABLE IF EXISTS `ppdb_instansi`;
CREATE TABLE IF NOT EXISTS `ppdb_instansi` (
  `id_instansi` int(11) NOT NULL AUTO_INCREMENT,
  `nama_instansi` varchar(255) NOT NULL,
  `induk_instansi` varchar(100) NOT NULL,
  `alamat_instansi` varchar(255) NOT NULL,
  `kodepos` int(7) NOT NULL,
  `kecamatan` varchar(100) NOT NULL,
  `kabupaten` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `kepala_instansi` varchar(100) NOT NULL,
  `maintenance` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_instansi`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ppdb_instansi`
--

INSERT INTO `ppdb_instansi` (`id_instansi`, `nama_instansi`, `induk_instansi`, `alamat_instansi`, `kodepos`, `kecamatan`, `kabupaten`, `logo`, `kepala_instansi`, `maintenance`) VALUES
(1, 'SMK NEGERI 1 BAWANG', 'PEMERINTAH KABUPATEN SURABAYA DINAS PEDNDIDIKAN, PEMUDA DAN OLAHRAGA', 'JLN. RAYA PUCANG NO. 132 Telp. (0286) 591407 Fax. (0286) 5985374<br/>http://smkn1bawang.sch.id', 53471, 'BAWANG', 'SURABAYA', 'smk.png', 'DRS. AZIZ PURWANTO, M.M', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_nilai`
--

DROP TABLE IF EXISTS `ppdb_nilai`;
CREATE TABLE IF NOT EXISTS `ppdb_nilai` (
  `id_ppdb_nilai` int(10) NOT NULL AUTO_INCREMENT,
  `id_ppdb` int(10) NOT NULL,
  `mapel_matematika` double NOT NULL,
  `mapel_bindonesia` double NOT NULL,
  `mapel_binggris` double NOT NULL,
  `mapel_ilmupengetahuanalam` double NOT NULL,
  `total_nilai` double NOT NULL,
  `sah` int(2) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ppdb_nilai`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `ppdb_nilai`
--

INSERT INTO `ppdb_nilai` (`id_ppdb_nilai`, `id_ppdb`, `mapel_matematika`, `mapel_bindonesia`, `mapel_binggris`, `mapel_ilmupengetahuanalam`, `total_nilai`, `sah`, `status`) VALUES
(4, 7, 9.5, 9.25, 9, 10, 37.75, 0, 1),
(5, 9, 9.5, 9, 9.25, 10, 37.75, 1, 1),
(6, 10, 9.5, 9, 9, 9, 36.5, 0, 1),
(8, 12, 9, 9, 9, 9, 36, 0, 1),
(9, 13, 9, 9, 9, 9, 36, 0, 1),
(10, 14, 8, 8, 8, 8, 32, 1, 1);

--
-- Triggers `ppdb_nilai`
--
DROP TRIGGER IF EXISTS `calc_un_insert`;
DELIMITER //
CREATE TRIGGER `calc_un_insert` BEFORE INSERT ON `ppdb_nilai`
 FOR EACH ROW begin
	declare mtk, ind, ing, ipa double;

	set mtk = new.mapel_matematika;
	set ind = new.mapel_bindonesia;
	set ing = new.mapel_binggris;
	set ipa = new.mapel_ilmupengetahuanalam;

	set new.total_nilai = mtk + ind + ing + ipa;

end
//
DELIMITER ;
DROP TRIGGER IF EXISTS `calc_un_update`;
DELIMITER //
CREATE TRIGGER `calc_un_update` BEFORE UPDATE ON `ppdb_nilai`
 FOR EACH ROW begin
	declare mtk, ind, ing, ipa double;

	set mtk = new.mapel_matematika;
	set ind = new.mapel_bindonesia;
	set ing = new.mapel_binggris;
	set ipa = new.mapel_ilmupengetahuanalam;

	set new.total_nilai = mtk + ind + ing + ipa;

end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_petugas`
--

DROP TABLE IF EXISTS `ppdb_petugas`;
CREATE TABLE IF NOT EXISTS `ppdb_petugas` (
  `id_petugas` int(11) NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `level` int(2) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_petugas`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ppdb_petugas`
--

INSERT INTO `ppdb_petugas` (`id_petugas`, `nama_lengkap`, `username`, `password`, `level`, `status`) VALUES
(1, 'Operator', 'admin', '21232f297a57a5a743894a0e4a801fc3', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_prestasi`
--

DROP TABLE IF EXISTS `ppdb_prestasi`;
CREATE TABLE IF NOT EXISTS `ppdb_prestasi` (
  `id_prestasi` int(10) NOT NULL AUTO_INCREMENT,
  `id_ppdb` int(10) NOT NULL,
  `nama_prestasi` varchar(200) NOT NULL,
  `peringkat_juara` int(5) NOT NULL,
  `tingkat_prestasi` varchar(200) NOT NULL,
  `nilai_prestasi` double NOT NULL,
  `sah` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_prestasi`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ppdb_prestasi`
--

INSERT INTO `ppdb_prestasi` (`id_prestasi`, `id_ppdb`, `nama_prestasi`, `peringkat_juara`, `tingkat_prestasi`, `nilai_prestasi`, `sah`) VALUES
(3, 7, 'INTERNATIONAL SCIENCE & ASTRONOMY COMETITION MMXIII', 1, 'INTL', 5, 0),
(4, 9, 'LOMBA VOLI 2013', 2, 'PROV', 2, 0),
(5, 13, 'INTERNATIONAL SCIENCE & ASTRONOMY COMETITION MMXIII', 1, 'INTL', 5, 0),
(6, 14, 'Basket', 1, 'KAB', 1.5, 0);

--
-- Triggers `ppdb_prestasi`
--
DROP TRIGGER IF EXISTS `nilai_prestasi`;
DELIMITER //
CREATE TRIGGER `nilai_prestasi` BEFORE INSERT ON `ppdb_prestasi`
 FOR EACH ROW begin
	declare peringkat_juara, tingkat_prestasi, nilai varchar(200);

	-- TENTUKAN NILAI MASING MASING 

	set nilai = case
		-- JUARA I, II, III tingkat KABUPATEN
		when new.peringkat_juara = 1 AND new.tingkat_prestasi = 'KAB' 
			then '1.50'
		when new.peringkat_juara = 2 AND new.tingkat_prestasi = 'KAB' 
			then '1.25'
		when new.peringkat_juara = 3 AND new.tingkat_prestasi = 'KAB' 
			then '1.00'

		-- JUARA I, II, III tingkat PROVINSI
		when new.peringkat_juara = 1 AND new.tingkat_prestasi = 'PROV' 
			then '2.25'
		when new.peringkat_juara = 2 AND new.tingkat_prestasi = 'PROV' 
			then '2.00'
		when new.peringkat_juara = 3 AND new.tingkat_prestasi = 'PROV' 
			then '1.75'


		-- JUARA I, II, III tingkat NASIONAL
		when new.peringkat_juara = 1 AND new.tingkat_prestasi = 'NAS' 
			then '2.75'
		when new.peringkat_juara = 2 AND new.tingkat_prestasi = 'NAS' 
			then '2.50'
		when new.peringkat_juara = 3 AND new.tingkat_prestasi = 'NAS' 
			then '2.25'

		-- JUARA I, II, III tingkat INTERNASIONAL
		when new.peringkat_juara = 1 AND new.tingkat_prestasi = 'INTL' 
			then '5.00'
		when new.peringkat_juara = 2 AND new.tingkat_prestasi = 'INTL' 
			then '4.75'
		when new.peringkat_juara = 3 AND new.tingkat_prestasi = 'INTL' 
			then '4.50'

		else '0'
	end;

	set new.nilai_prestasi = nilai;
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ppdb_setting`
--

DROP TABLE IF EXISTS `ppdb_setting`;
CREATE TABLE IF NOT EXISTS `ppdb_setting` (
  `id_setting` int(10) NOT NULL AUTO_INCREMENT,
  `judul_kegiatan` varchar(500) NOT NULL,
  `judul_form` varchar(500) NOT NULL,
  `tahun_ajaran` varchar(10) NOT NULL,
  `h1_01` varchar(200) NOT NULL,
  `h1_02` varchar(200) NOT NULL,
  `h1_03` varchar(200) NOT NULL,
  `h1_04` varchar(200) NOT NULL,
  `p_01` varchar(500) NOT NULL,
  `p_02` varchar(500) NOT NULL,
  `p_03` varchar(500) NOT NULL,
  `p_04` varchar(500) NOT NULL,
  `footer` varchar(500) NOT NULL,
  PRIMARY KEY (`id_setting`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ppdb_setting`
--

INSERT INTO `ppdb_setting` (`id_setting`, `judul_kegiatan`, `judul_form`, `tahun_ajaran`, `h1_01`, `h1_02`, `h1_03`, `h1_04`, `p_01`, `p_02`, `p_03`, `p_04`, `footer`) VALUES
(1, 'PANITIA PENERIMAAN PESERTA DIDIK BARU', 'FORMULIR PENDAFTARAN JALUR REGULER', '2014/2015', 'BIODATA CALON SISWA BARU', 'DATA NILAI MAPEL UN', 'KELENGKAPAN DOKUMEN', 'PROGRAM STUDI', '(Besar kecilnya huruf tidak masalah )', '(Tuliskan nilai mata pelajaran UN sesuai dengan SKHUN ASLI)', '(Beri tanda Centang ? )', '(Pilih Jurusan yang Anda Inginkan)', 'Contact Person: 082137741668 (Bu Istina), 081327510049 (Bu Eri Riastri), 085640084944 (Pak Sugi)');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
