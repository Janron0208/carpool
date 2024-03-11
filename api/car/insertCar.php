<?php
	include '../connected.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo 'Invalid request method.';
  exit;
}
$sql_carid = "SELECT * FROM car_tb ORDER BY Car_ID DESC LIMIT 1";
$result = mysqli_query($conn, $sql_carid);

// Check if any record exists
if (mysqli_num_rows($result) > 0) {
 $row = mysqli_fetch_assoc($result);
 $lastCarID = $row['Car_ID'];

 // Extract last 3 digits and increment
 $lastThreeDigits = substr($lastCarID, -3);
 $plusID = (int) $lastThreeDigits + 1;

 // Format with leading zeros
 $formattedPlusID = str_pad($plusID, 3, "0", STR_PAD_LEFT);

 // Create new Car_ID
 $newCarID = "CAR" . $formattedPlusID;
} else {
 // Set default starting ID if no record exists
 $newCarID = "CAR001";
}
// รับข้อมูล
$carBrand = $_POST['Car_Brand'];
$carModel = $_POST['Car_Model'];
$carNumber = $_POST['Car_Number'];
$carStatus = $_POST['Car_Status'];


$sql = "INSERT INTO car_tb (Car_ID, Car_Brand, Car_Model, Car_Number, Car_Status) VALUES (?, ?, ?, ?, ?)";

// บันทึกข้อมูล
$stmt = $conn->prepare($sql);
$stmt->bind_param('sssss', $newCarID, $carBrand, $carModel, $carNumber, $carStatus);
$stmt->execute();

if ($stmt->affected_rows === 1) {
  echo 'Success.';
} else {
  echo 'Error.';
}
?>