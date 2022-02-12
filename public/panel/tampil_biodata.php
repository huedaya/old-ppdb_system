<?php require_once('../Connections/connect.php'); ?>
<?php require_once('../inc/header.php'); ?>
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

$maxRows_ppdb_biodata = 10;
$pageNum_ppdb_biodata = 0;
if (isset($_GET['pageNum_ppdb_biodata'])) {
  $pageNum_ppdb_biodata = $_GET['pageNum_ppdb_biodata'];
}
$startRow_ppdb_biodata = $pageNum_ppdb_biodata * $maxRows_ppdb_biodata;

mysql_select_db($database_connect, $connect);
$query_ppdb_biodata = "SELECT id_ppdb, nomor_pendaftaran, nama_lengkap, jenis_kelamin, asal_sekolah, status_hapus, status_sah, status_terima FROM ppdb_biodata ORDER BY id_ppdb DESC ";
$query_limit_ppdb_biodata = sprintf("%s LIMIT %d, %d", $query_ppdb_biodata, $startRow_ppdb_biodata, $maxRows_ppdb_biodata);
$ppdb_biodata = mysql_query($query_limit_ppdb_biodata, $connect) or die(mysql_error());
$row_ppdb_biodata = mysql_fetch_assoc($ppdb_biodata);

if (isset($_GET['totalRows_ppdb_biodata'])) {
  $totalRows_ppdb_biodata = $_GET['totalRows_ppdb_biodata'];
} else {
  $all_ppdb_biodata = mysql_query($query_ppdb_biodata);
  $totalRows_ppdb_biodata = mysql_num_rows($all_ppdb_biodata);
}
$totalPages_ppdb_biodata = ceil($totalRows_ppdb_biodata/$maxRows_ppdb_biodata)-1;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<table border="1" align="center">
  <tr>
    <td>NO</td>
    <td>nomor_pendaftaran</td>
    <td>nama_lengkap</td>
    <td>jenis_kelamin</td>
    <td>asal_sekolah</td>
    <td>status_hapus</td>
    <td>status_sah</td>
    <td>status_terima</td>
    <td>aksi</td>
  </tr>
  <?php do { ?>
    <tr>
      <td>1</td>
      <td><?php echo $row_ppdb_biodata['nomor_pendaftaran']; ?></td>
      <td><?php echo $row_ppdb_biodata['nama_lengkap']; ?></td>
      <td><?php echo $row_ppdb_biodata['jenis_kelamin']; ?></td>
      <td><?php echo $row_ppdb_biodata['asal_sekolah']; ?></td>
      <td><?php echo $row_ppdb_biodata['status_hapus']; ?></td>
      <td><?php echo $row_ppdb_biodata['status_sah']; ?></td>
      <td><?php echo $row_ppdb_biodata['status_terima']; ?></td>
      <td><a href="edit_biodata.php?id_ppdb=<?php echo $row_ppdb_biodata['id_ppdb']; ?>">edit</a> - <a href="hapus_biodata.php?id_ppdb=<?php echo $row_ppdb_biodata['id_ppdb']; ?>">hapus(sementara)</a></td>
    </tr>
    <?php } while ($row_ppdb_biodata = mysql_fetch_assoc($ppdb_biodata)); ?>
</table>
</body>
</html>
<?php
mysql_free_result($ppdb_biodata);
?>
