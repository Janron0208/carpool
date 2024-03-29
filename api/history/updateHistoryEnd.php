<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$H_ID = $_POST['H_ID'];
$H_EndDate = $_POST['H_EndDate'];
$H_EndTime = $_POST['H_EndTime'];
$H_MileageEnd = $_POST['H_MileageEnd'];
$H_PicMileageEnd = $_POST['H_PicMileageEnd'];
$H_Comment = $_POST['H_Comment'];
$H_Status = 'success';



$sql = "UPDATE `carpool`.`history_tb` SET `H_EndDate` = '$H_EndDate',`H_EndTime` = '$H_EndTime', `H_MileageEnd` = '$H_MileageEnd', `H_MileageEnd` = '$H_MileageEnd', `H_PicMileageEnd` = '$H_PicMileageEnd', `H_Comment` = '$H_Comment', `H_Status` = '$H_Status' WHERE (`H_ID` = '$H_ID');";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>