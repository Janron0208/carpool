<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}

$Res_StartDate = $_POST['Res_StartDate'];
$Res_EndDate = $_POST['Res_EndDate'];
$status = "end";
$dateEnd = date("Ymd");


$sql = "UPDATE `reserve_tb` SET `Res_EndDate` = '$dateEnd', `Res_Status` = '$status' WHERE `reserve_tb`.`Res_StartDate` = '$Res_StartDate' AND `reserve_tb`.`Res_EndDate` = '$Res_EndDate';";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>