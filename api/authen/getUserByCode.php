<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$accCode = $_GET['Acc_Code'];

// ดึงข้อมูล
$sql = "SELECT * FROM `account_tb` WHERE `Acc_Code` LIKE '$accCode'";
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