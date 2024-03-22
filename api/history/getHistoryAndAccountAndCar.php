<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$Acc_ID = $_POST['Acc_ID'];
$Car_ID = $_POST['Car_ID'];

// ดึงข้อมูล
$sql = "SELECT history_tb.*,
    account_tb.*,
    car_tb.*
FROM history_tb
INNER JOIN account_tb ON history_tb.Acc_ID = account_tb.Acc_ID
INNER JOIN car_tb ON history_tb.Car_ID = car_tb.Car_ID
WHERE history_tb.Acc_ID = '$Acc_ID'
AND history_tb.H_Status = 'Started'
AND history_tb.Car_ID = '$Car_ID'";
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