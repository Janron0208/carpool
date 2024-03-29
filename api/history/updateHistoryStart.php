<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$H_ID = $_POST['H_ID'];
$H_StartTime = $_POST['H_StartTime'];
$H_Project = $_POST['H_Project'];
$H_PicMileageStart = $_POST['H_PicMileageStart'];
$H_PicFront = $_POST['H_PicFront'];
$H_PicBack = $_POST['H_PicBack'];
$H_PicLeft = $_POST['H_PicLeft'];
$H_PicRight = $_POST['H_PicRight'];
$H_PicHood = $_POST['H_PicHood'];
$H_Status = $_POST['H_Status'];





$sql = "UPDATE `carpool`.`history_tb` SET `H_StartTime` = '$H_StartTime', `H_Project` = '$H_Project', `H_PicMileageStart` = '$H_PicMileageStart', `H_PicFront` = '$H_PicFront', `H_PicBack` = '$H_PicBack', `H_PicLeft` = '$H_PicLeft', `H_PicRight` = '$H_PicRight', `H_PicHood` = '$H_PicHood', `H_Status` = '$H_Status' WHERE (`H_ID` = '$H_ID');";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>