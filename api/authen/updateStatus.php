<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}

// รับข้อมูล
$accID = $_POST['Acc_ID'];
$accStatus = $_POST['Acc_Status'];

// อัปเดตข้อมูล
$sql = "UPDATE account_tb SET Acc_Status = ? WHERE Acc_ID = ?";

// เตรียมคำสั่ง
$stmt = $conn->prepare($sql);
$stmt->bind_param('ss', $accStatus, $accID);
$stmt->execute();

// ตรวจสอบผลลัพธ์
if ($stmt->affected_rows === 1) {
  echo 'Success.';
} else {
  echo 'Error.';
}

$stmt->close(); // ปิด prepared statement (ไม่จำเป็น แต่เป็น good practice)
mysqli_close($conn); // ปิดการเชื่อมต่อ



?>