<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$Acc_ID = $_POST['Acc_ID'];
$Acc_Code = $_POST['Acc_Code'];
$Acc_Fullname = $_POST['Acc_Fullname'];
$Acc_Nickname = $_POST['Acc_Nickname'];
$Acc_Tel = $_POST['Acc_Tel'];
$Acc_Line = $_POST['Acc_Line'];


$sql = "UPDATE account_tb
SET Acc_Code = '$Acc_Code',
Acc_Fullname = '$Acc_Fullname',
Acc_Nickname = '$Acc_Nickname',
Acc_Tel = '$Acc_Tel',
Acc_Line = '$Acc_Line'
WHERE Acc_ID = '$Acc_ID';";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>