<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$H_ID = $_POST['H_ID'];
$H_PicMileageStart = $_POST['H_PicMileageStart'];
$H_PicFront = $_POST['H_PicFront'];
$H_PicBack = $_POST['H_PicBack'];
$H_PicLeft = $_POST['H_PicLeft'];
$H_PicRight = $_POST['H_PicRight'];
$H_PicHood = $_POST['H_PicHood'];





$sql = "UPDATE `carpool`.`history_tb` SET `H_PicMileageStart` = '$H_PicMileageStart', `H_PicFront` = '$H_PicFront', `H_PicBack` = '$H_PicBack', `H_PicLeft` = '$H_PicLeft', `H_PicRight` = '$H_PicRight', `H_PicHood` = '$H_PicHood' WHERE (`H_ID` = '$H_ID');";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>