<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// กำหนดค่าเริ่มต้น
$start = $_POST['start'];
$end = $_POST['end'];


// ดึง Car_ID ทั้งหมดจาก car_tb
$sql = "SELECT Car_ID FROM car_tb";
$result = mysqli_query($conn, $sql);

// ประกาศ array สำหรับเก็บ Car_ID ที่ว่าง
$available_cars = array();

while ($row = mysqli_fetch_assoc($result)) {
  $car_id = $row['Car_ID'];
  $Res_Status = "start";

  // ตรวจสอบว่า Car_ID นี้มีการจองหรือไม่
  $sql = "SELECT * FROM reserve_tb WHERE Car_ID = '$car_id'";
  $reserve_result = mysqli_query($conn, $sql);

  // กรณีไม่มีการจอง
  if (mysqli_num_rows($reserve_result) == 0) {
    array_push($available_cars, $car_id);
  } else {
    // กรณีมีการจอง ตรวจสอบว่าวันที่จองซ้อนทับกับช่วงวันที่ระบุหรือไม่
    $is_available = true;
    while ($reserve_row = mysqli_fetch_assoc($reserve_result)) {
      $res_start_date = $reserve_row['Res_StartDate'];
      $res_end_date = $reserve_row['Res_EndDate'];

      // ตรวจสอบว่าวันที่ระบุอยู่ในช่วงวันที่จอง
      if (($start >= $res_start_date && $start <= $res_end_date) ||
          ($end >= $res_start_date && $end <= $res_end_date) ||
          ($start <= $res_start_date && $end >= $res_end_date)) {
        $is_available = false;
        break;
      }
    }

    // กรณีไม่ซ้อนทับ เพิ่ม Car_ID ลงใน array
    if ($is_available) {
      array_push($available_cars, $car_id);
    }
  }

}

// แสดง Car_ID ที่ว่าง
// echo implode(", ", $available_cars);

// เตรียม array สำหรับเก็บข้อมูล JSON
$json_data = array();

// วนลูปแต่ละ Car_ID ที่ว่าง
foreach ($available_cars as $car_id) {
  // ดึงข้อมูล Car_ID นี้
  $sql1 = "SELECT * FROM car_tb WHERE Car_ID = '$car_id' AND Car_Status = 'Ready'";
  $result1 = mysqli_query($conn, $sql1);
  $car_data = mysqli_fetch_assoc($result1);

  // เพิ่มข้อมูล Car_ID นี้ลงใน array JSON
  array_push($json_data, $car_data);
}

// แปลง array JSON เป็น JSON string
$json = json_encode($json_data);

// แสดงผลลัพธ์ JSON
echo $json;



?>