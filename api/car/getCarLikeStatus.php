<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
$carStatus = $_GET['Car_Status'];

// ดึงข้อมูล
$sql = "SELECT * FROM `car_tb` WHERE `Car_Status` LIKE '$carStatus'";
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