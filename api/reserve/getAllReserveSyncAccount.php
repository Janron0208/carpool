<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}


// ดึงข้อมูล
$sql = "SELECT * FROM reserve_tb
INNER JOIN account_tb ON reserve_tb.Acc_ID = account_tb.Acc_ID
WHERE reserve_tb.Res_Status = 'start';";
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