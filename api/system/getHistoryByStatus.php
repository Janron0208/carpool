<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$H_Status = $_POST['H_Status'];

// ดึงข้อมูล
$sql = "SELECT * FROM `history_tb` WHERE `H_Status` NOT LIKE 'success'";
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