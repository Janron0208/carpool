<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$Acc_ID = $_POST['Acc_ID'];

// ดึงข้อมูล
$sql = "SELECT reserve_tb.*, car_tb.*
FROM reserve_tb
INNER JOIN car_tb ON reserve_tb.Car_ID = car_tb.Car_ID
WHERE reserve_tb.Acc_ID LIKE '$Acc_ID' AND reserve_tb.Res_Status LIKE 'start'
ORDER BY reserve_tb.Res_StartDate ASC;";
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