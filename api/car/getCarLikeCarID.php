<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$carID = $_POST['Car_ID'];

// ดึงข้อมูล
$sql = "SELECT * FROM `car_tb` WHERE `Car_ID` LIKE '$carID' ORDER BY `Car_ID` DESC";

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