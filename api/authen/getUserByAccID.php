<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$accID = $_GET['Acc_ID'];

// ดึงข้อมูล
$sql = "SELECT * FROM `account_tb` WHERE `Acc_ID` LIKE '$accID' ORDER BY `Acc_ID` DESC";
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