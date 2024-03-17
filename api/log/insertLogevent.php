<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}


$sql_accid = "SELECT * FROM log_tb ORDER BY Log_ID DESC LIMIT 1";
$result = mysqli_query($conn, $sql_accid);

// Check if any record exists
if (mysqli_num_rows($result) > 0) {
 $row = mysqli_fetch_assoc($result);
 $lastLogID = $row['Log_ID'];

 // Extract last 3 digits and increment
 $lastThreeDigits = substr($lastLogID, -10);
 $plusID = (int) $lastThreeDigits + 1;

 // Format with leading zeros
 $formattedPlusID = str_pad($plusID, 10, "0", STR_PAD_LEFT);

 // Create new Log_ID
 $newLogID = "LOG" . $formattedPlusID;
} else {
 // Set default starting ID if no record exists
 $newLogID = "LOG0000000001";
}


// รับข้อมูล
$accID = $_POST['accID'];
$logDate = $_POST['logDate'];
$logEvent = $_POST['logEvent'];



$sql = "INSERT INTO log_tb (Log_ID, Log_Date, ACC_ID, Log_Event) VALUES (?, ?, ?, ?)";

// บันทึกข้อมูล
$stmt = $conn->prepare($sql);
$stmt->bind_param('ssss', $newLogID, $logDate, $accID, $logEvent);
$stmt->execute();

// ตรวจสอบผลลัพธ์
if ($stmt->affected_rows === 1) {
  echo 'Success.';
} else {
  echo 'Error.';
}



?>