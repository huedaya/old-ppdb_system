<?php require_once('../Connections/connect.php'); ?>
<?php

    require_once('../inc/html2fpdf/html2pdf.class.php');
	?>
<?php
if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

$ambil_idppdb_ppdb_report = "-1";
if (isset($_GET['id_ppdb'])) {
  $ambil_idppdb_ppdb_report = $_GET['id_ppdb'];
}
mysql_select_db($database_connect, $connect);
$query_ppdb_report = sprintf("SELECT * FROM ppdb_biodata, ext_agama, ext_pekerjaan_ortu, ext_program_studi WHERE ext_agama.id_agama = ppdb_biodata.id_agama AND  ext_pekerjaan_ortu.id_pekerjaan_ortu = ppdb_biodata.id_pekerjaan_ayah AND  ext_program_studi.id_program_studi = ppdb_biodata.id_program_studi AND ppdb_biodata.id_ppdb = %s", GetSQLValueString($ambil_idppdb_ppdb_report, "int"));
$ppdb_report = mysql_query($query_ppdb_report, $connect) or die(mysql_error());
$row_ppdb_report = mysql_fetch_assoc($ppdb_report);
$totalRows_ppdb_report = mysql_num_rows($ppdb_report);

$ambil_idppdb_ppdb_nilai = "-1";
if (isset($_GET['id_ppdb'])) {
  $ambil_idppdb_ppdb_nilai = $_GET['id_ppdb'];
}
mysql_select_db($database_connect, $connect);
$query_ppdb_nilai = sprintf("SELECT * FROM `ppdb_nilai` WHERE `id_ppdb` = %s", GetSQLValueString($ambil_idppdb_ppdb_nilai, "int"));
$ppdb_nilai = mysql_query($query_ppdb_nilai, $connect) or die(mysql_error());
$row_ppdb_nilai = mysql_fetch_assoc($ppdb_nilai);
$totalRows_ppdb_nilai = mysql_num_rows($ppdb_nilai);
?>
<?php
    $content = '

<page>
<table width="900px" border="1" align="center">
  <tr>
    <td width="120" rowspan="4"><img src="../images/smk.png" style="width: 120px"/></td>
    <td width="350">PANITIA PENERIMAAN PESERTA DIDIK BARU</td>
    <td width="214">Nomor Pendaftaran</td>
  </tr>
  <tr>
    <td height="78">SMK NEGERI 1 BAWANG</td>
    <td>'.$row_ppdb_report['nomor_pendaftaran'].'</td>
  </tr>
  <tr>
    <td>ALAMAT</td>
    <td><img src="http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['PHP_SELF']).'/barcode.php?text='.$row_ppdb_report['nomor_pendaftaran'].'" style="width: 200px">
	</td>
  </tr>
</table>

<br/>

<table width="900" border="0" align="center">
  <tr>
    <td align="center" width="620" height="150">FORMULIR PENDAFTARAN JALUR REGULER</td>
        <td width="100" align="center">
			<table width="900" border="1" align="center">
				<tr>
				  <td  width="100" height="150">3x4</td>
				</tr>
			</table>
			</td>
  </tr>
</table>
<br/>
<table width="900" border="1" align="center">
  <tr>
    <td colspan="5">BIODATA CALON SISWA BARU</td>
  </tr>
  <tr>
    <td width="151">Tahun Lulus</td>
    <td colspan="4">'.$row_ppdb_report['tahun_lulus'].'</td>
  </tr>
  <tr>
    <td>Nama Lengkap</td>
    <td colspan="4">'.$row_ppdb_report['nama_lengkap'].'</td>
  </tr>
  <tr>
    <td>Program Studi</td>
    <td colspan="4">'.$row_ppdb_report['nama_studi'].'</td>
  </tr>
  <tr>
    <td>Jenis Kelamin</td>
    <td colspan="2">'.$row_ppdb_report['jenis_kelamin'].'</td>
    <td width="95">Agama</td>
    <td width="180">'.$row_ppdb_report['nama'].'</td>
  </tr>
  <tr>
    <td>Tempat Lahir</td>
    <td colspan="4">'.$row_ppdb_report['tempat_lahir'].'</td>
  </tr>
  <tr>
    <td>Tanggal Lahir</td>
    <td colspan="2">'.$row_ppdb_report['tanggal_lahir'].'</td>
    <td>Umur</td>
    <td>'.$row_ppdb_report['umur'].'</td>
  </tr>
  <tr>
    <td>Alamat Rumah</td>
    <td colspan="4">'.$row_ppdb_report['alamat_rumah'].'</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="137">RT.</td>
    <td width="130">'.substr($row_ppdb_report['rt_rw'],0,2).'</td>
    <td>Kecamatan</td>
    <td>'.$row_ppdb_report['kecamatan'].'</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>RW.</td>
    <td>'.substr($row_ppdb_report['rt_rw'],3,5).'</td>
    <td>Kabupaten</td>
    <td>'.$row_ppdb_report['kabupaten'].'</td>
  </tr>
  <tr>
    <td>No Hp Siswa</td>
    <td colspan="2">'.$row_ppdb_report['no_hp_calon_siswa'].'</td>
    <td>Kode Pos</td>
    <td>'.$row_ppdb_report['kode_pos'].'</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>Tinggi Badam '.$row_ppdb_report['tinggi_badan'].'</td>
    <td>Berat Badan '.$row_ppdb_report['berat_badan'].'</td>
    <td>Golongan Darah</td>
    <td>'.$row_ppdb_report['golongan_darah'].'</td>
  </tr>
  <tr>
    <td>Nama Ayah Kandung</td>
    <td colspan="4">'.$row_ppdb_report['nama_ayah_kandung'].'</td>
  </tr>
  <tr>
    <td>Pekerjaan Ayah Kandung</td>
    <td colspan="4">'.$row_ppdb_report['nama_pekerjaan'].'</td>
  </tr>
  <tr>
    <td>Nama Ibu Kandung</td>
    <td colspan="4">'.$row_ppdb_report['nama_ibu_kandung'].'</td>
  </tr>
  <tr>
    <td>Pekerjaan Ibu Kandung</td>
    <td colspan="4">'.$row_ppdb_report['id_pekerjaan_ibu'].'</td>
  </tr>
  <tr>
    <td>No. HP Orangtua</td>
    <td>'.$row_ppdb_report['no_hp_orang_tua'].'</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Asal Sekolah</td>
    <td colspan="4">'.$row_ppdb_report['asal_sekolah'].'</td>
  </tr>
</table>
<br/>
<table width="900" border="1" align="center">
  <tr>
    <td colspan="2">DATA NILAI MAPEL UN</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">KELENGKAPAN DOKUMEN</td>
  </tr>
  <tr>
    <td width="183">Matematika</td>
    <td width="90">'.$row_ppdb_nilai['mapel_matematika'].'</td>
    <td width="150">&nbsp;</td>
    <td width="100">&nbsp;</td>
    <td width="132">Piagam Prestasi</td>
    <td width="15">'.$row_ppdb_report['piagam_prestasi'].'</td>
  </tr>
  <tr>
    <td>Bahasa Indonesia</td>
    <td>'.$row_ppdb_nilai['mapel_bindonesia'].'</td>
    <td>Total Nilai UN</td>
    <td>&nbsp;</td>
    <td>FC. Raport Smt 1-5</td>
    <td>'.$row_ppdb_report['fc_raport'].'</td>
  </tr>
  <tr>
    <td>Bahasa Inggris</td>
    <td>'.$row_ppdb_report['tempat_lahir'].'</td>
    <td>'.$row_ppdb_nilai['total_nilai'].'</td>
    <td>&nbsp;</td>
    <td>Ijasah</td>
    <td>'.$row_ppdb_report['ijasah'].'</td>
  </tr>
  <tr>
    <td>Ilmu Pengetahuan Alam</td>
    <td>'.$row_ppdb_nilai['mapel_ilmupengetahuanalam'].'</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>SKHUN</td>
    <td>'.$row_ppdb_report['skhun'].'</td>
  </tr>
</table>
<br/>
<table width="900" border="0" align="center">
  <tr>
    <td width="400">Mengetahui,</td>
    <td width="61">&nbsp;</td>
    <td width="250">Banjarnegara,</td>
  </tr>
  <tr>
    <td>Orang Tua/Wali Calon Siswa</td>
    <td>&nbsp;</td>
    <td>Pendaftar</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>'.$row_ppdb_report['mengetahui'].'</td>
    <td>&nbsp;</td>
    <td>'.$row_ppdb_report['nama_lengkap'].'</td>
  </tr>
  <tr>
    <td>Tanda tangan dan Nama Terang</td>
    <td>&nbsp;</td>
    <td>Tanda tangan dan Nama terang</td>
  </tr>
</table>
<br/><br/>
<table width="1000" border="0" align="center" style="background-color: #000;color: #fff;text-align:center">
  <tr>
    <td width="750">Contact Person: 082137741668 (Bu Istina), 081327510049 (Bu Eri Riastri), 085640084944 (Pak Sugi)</td>
  </tr>
</table>
</page>';

    $html2pdf = new HTML2PDF('P','A4','fr');
    $html2pdf->WriteHTML($content);
    $html2pdf->Output('exemple.pdf');
?>

<?php
mysql_free_result($ppdb_report);

mysql_free_result($ppdb_nilai);
?>

