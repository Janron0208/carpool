<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$Acc_ID = $_POST['Acc_ID'];
$Acc_Password = $_POST['Acc_Password'];

$PassHash = md5($Acc_Password);

$sql = "UPDATE account_tb
SET Acc_Password = '$PassHash'
WHERE Acc_ID = '$Acc_ID';";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "แก้ไขข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>