<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
$carID = $_GET['Car_ID'];

// ดึงข้อมูล
$sql = "SELECT *
FROM car_tb
INNER JOIN mile_tb ON car_tb.Car_ID = mile_tb.Car_ID
WHERE car_tb.Car_ID = '$carID'";

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