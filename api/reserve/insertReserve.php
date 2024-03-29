<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}


$sql_resid = "SELECT * FROM reserve_tb ORDER BY Res_ID DESC LIMIT 1";
$result = mysqli_query($conn, $sql_resid);

// Check if any record exists
if (mysqli_num_rows($result) > 0) {
 $row = mysqli_fetch_assoc($result);
 $lastResID = $row['Res_ID'];

 // Extract last 3 digits and increment
 $lastThreeDigits = substr($lastResID, -7);
 $plusID = (int) $lastThreeDigits + 1;

 // Format with leading zeros
 $formattedPlusID = str_pad($plusID, 7, "0", STR_PAD_LEFT);

 // Create new Log_ID
 $newResID = "RES" . $formattedPlusID;
} else {
 // Set default starting ID if no record exists
 $newResID = "RES0000001";
}


// รับข้อมูล
$Res_Project = $_POST['Res_Project'];
$Res_StartDate = $_POST['Res_StartDate'];
$Res_EndDate = $_POST['Res_EndDate'];
$Car_ID = $_POST['Car_ID'];
$Acc_ID = $_POST['Acc_ID'];


$sql = "INSERT INTO reserve_tb (Res_ID, Res_Project, Res_StartDate, Res_EndDate, Car_ID, Acc_ID) VALUES (?, ?, ?, ?, ?, ?)";

// บันทึกข้อมูล
$stmt = $conn->prepare($sql);
$stmt->bind_param('ssssss', $newResID, $Res_Project, $Res_StartDate, $Res_EndDate, $Car_ID, $Acc_ID);
$stmt->execute();

// ตรวจสอบผลลัพธ์
if ($stmt->affected_rows === 1) {
  echo 'Success.';
} else {
  echo 'Error.';
}



?>