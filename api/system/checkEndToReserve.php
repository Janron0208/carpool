<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// 1. สร้างตัวแปร today เก็บวันที่ปัจจุบัน
$today = date("Ymd"); // YYYYMMDD format


// 2. ค้นหาข้อมูล where Res_Status = 'start'
$sql = "SELECT * FROM carpool.reserve_tb WHERE Res_Status = 'start'";
$result = mysqli_query($conn, $sql);


// 3. เปรียบเทียบค่า Res_EndDate กับ today และอัปเดต Res_Status
while ($row = mysqli_fetch_assoc($result)) {
  $resEndDate = $row['Res_EndDate'];
  $resID = $row['Res_ID'];
  if ($resEndDate < $today) {
    $sql2 = "UPDATE carpool.reserve_tb SET Res_Status = 'end' WHERE Res_ID = '$resID'";
    mysqli_query($conn, $sql2);
  }
}

// ปิดการเชื่อมต่อ MySQL
mysqli_close($conn);
?>