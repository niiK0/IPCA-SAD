<?php
require './db.php';

session_start();

if(isset($_SESSION['email'])){
  $user_id = $_SESSION['user_id'];

  if(isset($_POST['reserve'])){
    $menu_id = $_POST['menuId'];

    // Today's date
    $today = date('Y-m-d');

    // Tomorrow's date
    $tomorrow = date('Y-m-d', strtotime('+1 day'));

    $sql_create = "INSERT INTO `order` (menu_id, user_id, date_order, date_delivery)
    VALUES ($menu_id, $user_id, '$today', '$tomorrow')";
    if ($conn->query($sql_create) === TRUE) {

        header("location: my-reservations.php");
    } else {
    // echo  "<script>alert('There was an error!');</script>";
    echo "Error: " . $sql_create . "<br>" . $conn->error;
    }
    
    $conn->close();

  }
}

?>