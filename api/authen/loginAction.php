<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}

// รับข้อมูล
$accCode = $_POST['accCode'];
$inputPassword = $_POST['inputPassword'];


// อัปเดตข้อมูล
$sql = "SELECT * FROM `account_tb` WHERE `Acc_Code` LIKE '$accCode'";
$result = mysqli_query($conn, $sql);

// ตรวจสอบว่ามีข้อมูลหรือไม่
if (mysqli_num_rows($result) > 0) {
  // มีข้อมูล
  $row = mysqli_fetch_assoc($result);

  // แปลง inputPassword เป็น MD5
  $md5InputPassword = md5($inputPassword);

  // เปรียบเทียบค่า MD5 กับฟิลด์ Acc_Password
  if ($md5InputPassword === $row['Acc_Password']) {
    // ตรงกัน
    echo 'true';
  } else {
    // ไม่ตรงกัน
    echo 'false';
  }
} else {
  // ไม่มีข้อมูล
  echo 'false';
}

// ปิดการเชื่อมต่อกับฐานข้อมูล
mysqli_close($conn);
?>