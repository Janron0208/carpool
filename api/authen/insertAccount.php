<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}


$sql_accid = "SELECT * FROM account_tb ORDER BY Acc_ID DESC LIMIT 1";
$result = mysqli_query($conn, $sql_accid);

// Check if any record exists
if (mysqli_num_rows($result) > 0) {
 $row = mysqli_fetch_assoc($result);
 $lastAccID = $row['Acc_ID'];

 // Extract last 3 digits and increment
 $lastThreeDigits = substr($lastAccID, -3);
 $plusID = (int) $lastThreeDigits + 1;

 // Format with leading zeros
 $formattedPlusID = str_pad($plusID, 3, "0", STR_PAD_LEFT);

 // Create new Acc_ID
 $newAccID = "ACC" . $formattedPlusID;
} else {
 // Set default starting ID if no record exists
 $newAccID = "ACC001";
}


// รับข้อมูล
$accType = $_POST['Acc_Type'];
$accCode = $_POST['Acc_Code'];
$accFullname = $_POST['Acc_Fullname'];
$accNickname = $_POST['Acc_Nickname'];
$accTel = $_POST['Acc_Tel'];
$accLine = $_POST['Acc_Line'];
$accPassword = $_POST['Acc_Password'];
$accStatus = 'Pending';

$genHash = md5($accPassword);


$sql = "INSERT INTO account_tb (Acc_ID, Acc_Type, Acc_Code, Acc_Fullname, Acc_Nickname, Acc_Tel, Acc_Line, Acc_Password, Acc_Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

// บันทึกข้อมูล
$stmt = $conn->prepare($sql);
$stmt->bind_param('sssssssss', $newAccID, $accType, $accCode, $accFullname, $accNickname, $accTel, $accLine, $genHash, $accStatus);
$stmt->execute();

// ตรวจสอบผลลัพธ์
if ($stmt->affected_rows === 1) {
  echo 'Success.';
} else {
  echo 'Error.';
}



?>