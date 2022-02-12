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

mysql_select_db($database_connect, $connect);
$query_ext_pekerjaan_ortu = "SELECT * FROM ext_pekerjaan_ortu";
$ext_pekerjaan_ortu = mysql_query($query_ext_pekerjaan_ortu, $connect) or die(mysql_error());
$row_ext_pekerjaan_ortu = mysql_fetch_assoc($ext_pekerjaan_ortu);
$totalRows_ext_pekerjaan_ortu = mysql_num_rows($ext_pekerjaan_ortu);
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
    <td>id_pekerjaan_ortu</td>
    <td>tipe_pekerjaan</td>
    <td>nama_pekerjaan</td>
    <td>status</td>
    <td>aksi</td>
  </tr>
  <?php do { ?>
    <tr>
      <td><?php echo $row_ext_pekerjaan_ortu['id_pekerjaan_ortu']; ?></td>
      <td><?php echo $row_ext_pekerjaan_ortu['tipe_pekerjaan']; ?></td>
      <td><?php echo $row_ext_pekerjaan_ortu['nama_pekerjaan']; ?></td>
      <td><?php echo $row_ext_pekerjaan_ortu['status']; ?></td>
      <td><a href="edit_pekerjaan_ortu.php?id=<?php echo $row_ext_pekerjaan_ortu['id_pekerjaan_ortu']; ?>">edit</a> - <a href="deactive_pekerjaan_ortu.php?id=<?php echo $row_ext_pekerjaan_ortu['id_pekerjaan_ortu']; ?>">deactive</a> - <a href="hapus_pekerjaan_ortu.php?id=<?php echo $row_ext_pekerjaan_ortu['id_pekerjaan_ortu']; ?>">hapus</a></td>
    </tr>
    <?php } while ($row_ext_pekerjaan_ortu = mysql_fetch_assoc($ext_pekerjaan_ortu)); ?>
</table>
<p><a href="input_pekerjaan_ortu.php">Tambah Pekerjaan Ortu</a></p>
</body>
</html>
<?php
mysql_free_result($ext_pekerjaan_ortu);
?>
