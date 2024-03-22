<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$Car_ID = $_POST['Car_ID'];
$sql = "DELETE FROM `carpool`.`car_tb` WHERE (`Car_ID` = '$Car_ID')";
$result = $conn->query($sql);
// ปิดการเชื่อมต่อ
$conn->close();

?>