<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$H_ID = $_POST['H_ID'];
$H_StartTime = $_POST['H_StartTime'];
$H_Project = $_POST['H_Project'];
$H_PicFront = $_POST['H_PicFront'];
$H_PicBack = $_POST['H_PicBack'];
$H_PicLeft = $_POST['H_PicLeft'];
$H_PicRight = $_POST['H_PicRight'];
$H_PicHood = $_POST['H_PicHood'];
$H_PicMileageStart = $_POST['H_PicMileageStart'];
// $H_Status = $_POST['H_Status'];



$sql = "UPDATE `history_tb` SET `H_StartTime` = '08:47', `H_Project` = 'รรรรรรww', `H_PicFront` = 'picture.jpg', `H_PicBack` = 'picture.jpg', `H_PicLeft` = 'picture.jpg', `H_PicRight` = 'picture.jpg', `H_PicHood` = 'picture.jpg', `H_PicMileageStart` = 'picture.jpg', `H_Status` = 'start' WHERE `history_tb`.`H_ID` = '$H_ID';";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>