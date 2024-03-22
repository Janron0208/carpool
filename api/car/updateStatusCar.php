<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$Car_ID = $_POST['Car_ID'];
$Car_Status = $_POST['Car_Status'];

$sql = "UPDATE car_tb
SET Car_Status = '$Car_Status'
WHERE Car_ID = '$Car_ID';";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>