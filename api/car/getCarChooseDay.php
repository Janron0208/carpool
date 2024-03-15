<?php
	include '../connected.php';

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$start = $_POST['start'];
$end = $_POST['end'];

// ดึงข้อมูล
$sql = "SELECT * FROM reserve_tb AS r
INNER JOIN car_tb AS c ON r.Car_ID = c.Car_ID
WHERE NOT ((r.Res_StartDate BETWEEN '$start' AND '$end')
OR (r.Res_EndDate BETWEEN '$start' AND '$end')
OR ('$start' BETWEEN r.Res_StartDate AND r.Res_EndDate)
OR ('$end' BETWEEN r.Res_StartDate AND r.Res_EndDate))";

// รันคิวรี่
$result = mysqli_query($conn, $sql);

// ตรวจสอบว่ามีข้อมูลหรือไม่
if (mysqli_num_rows($result) > 0) {

  // ประกาศอาร์เรย์
  $items = array();

  // วนลูปแต่ละแถว
  while ($row = mysqli_fetch_assoc($result)) {

    // ดึง Car_ID
    $car_id = $row['Car_ID'];

    // คิวรี่ SQL ค้นหาข้อมูลรถ
    $sql_car = "SELECT * FROM `car_tb` WHERE `Car_ID` = '$car_id'";

    // รันคิวรี่
    $result_car = mysqli_query($conn, $sql_car);

    // ดึงข้อมูลรถ
    $row_car = mysqli_fetch_assoc($result_car);

    // เพิ่มข้อมูลรถลงในอาร์เรย์
    $items[] = $row_car;
    $json = json_encode($items);
  }

  // แสดงอาร์เรย์
  print_r($json);

} else {

  // ไม่พบข้อมูล
  echo "ไม่พบรถที่ว่าง";

}

?>