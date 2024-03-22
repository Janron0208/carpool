<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$Acc_ID = $_POST['Acc_ID'];

// ดึงข้อมูล
$sql = "SELECT * FROM `reserve_tb` WHERE `Acc_ID` LIKE '$Acc_ID' ORDER BY `Res_StartDate` ASC";
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