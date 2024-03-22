<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$H_ID = $_POST['H_ID'];
$Car_ID = $_POST['Car_ID'];
$Acc_ID = $_POST['Acc_ID'];
$H_StartDate = $_POST['H_StartDate'];
$H_EndDate = $_POST['H_EndDate'];
$H_Project = $_POST['H_Project'];
$H_MileageStart = $_POST['H_MileageStart'];


$sql = "INSERT INTO `history_tb` (`H_ID`, `Acc_ID`, `Car_ID`, `H_StartDate`, `H_EndDate`, `H_StartTime`, `H_EndTime`, `H_Project`, `H_MileageStart`, `H_MileageEnd`, `H_PicFront`, `H_PicBack`, `H_PicLeft`, `H_PicRight`, `H_PicHood`, `H_PicMileageEnd`, `H_PicMileageStart`, `H_Status`) VALUES ('$H_ID', '$Acc_ID', '$Car_ID', '$H_StartDate', '$H_EndDate', '-', '-', '$H_Project', '$H_MileageStart', '-', '-', '-', '-', '-', '-', '-', '-', 'started');";

// รัน SQL query
if (mysqli_query($conn, $sql)) {
  echo "เพิ่มข้อมูลเรียบร้อย";
} else {
  echo "เกิดข้อผิดพลาด: " . mysqli_error($conn);
}

?>