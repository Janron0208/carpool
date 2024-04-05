<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$accStatus = $_GET['Acc_Status'];

// ดึงข้อมูล
$sql = "SELECT * FROM `account_tb` WHERE `Acc_Status` LIKE '$accStatus' ORDER BY `account_tb`.`Acc_Type` ASC";
$result = $conn->query($sql);

// แปลงข้อมูลเป็น JSON
$data = array();
while ($row = $result->fetch_assoc()) {
  $data[] = $row;
}

// ปิดการเชื่อมต่อ
$conn->close();

// แสดงผลลัพธ์
echo json_encode($data);

?>