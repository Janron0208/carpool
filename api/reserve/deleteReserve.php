<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$Res_ID = $_POST['Res_ID'];
$sql = "DELETE FROM `carpool`.`reserve_tb` WHERE (`Res_ID` = '$Res_ID')";
$result = $conn->query($sql);
// ปิดการเชื่อมต่อ
$conn->close();

?>