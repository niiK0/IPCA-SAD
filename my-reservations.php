<?php
require './db.php';

session_start();

$name = "User";

if(isset($_SESSION['name'])){
  $name = $_SESSION['name'];
  $id = $_SESSION['user_id'];
}

// query the database

$sql = "SELECT `order`.id AS OrderId,
`order`.date_order AS OrderDate,
`order`.date_delivery AS DelivDate,
menu.id AS MenuId,
meals.type AS Type,
meals.name AS Name,
meals.description AS Descr,
meals.price AS Price,
week_day.id AS Weekday,
building.name AS Building
FROM `order`
INNER JOIN menu ON menu.id = `order`.menu_id
INNER JOIN menu_meals ON menu.id = menu_meals.menu_id
INNER JOIN meals ON menu_meals.meals_id = meals.id
INNER JOIN building ON building.id = menu.building_id
INNER JOIN week_day ON week_day.id = menu.weekday_id
WHERE `order`.user_id = $id";

$results_orders = mysqli_query($conn, $sql);

// close the database connection
mysqli_close($conn);
?>



<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>IPCAlimenta - Reservations</title>
  </head>
  <body>
  <nav>
  <ul>
        <li style="float: left;"><a href="index.php">Home</a></li>
        <li style="float: right;"><?php echo $name ?></li>
        <?php 
        if(!isset($_SESSION['email'])){
          ?>
          <li style="float: right;"><a href="register-login.php">Login/Register</a></li>
          <?php
        }else{
          ?>
          <li style="float: right;"><a href="logout.php">Logout</a></li>
          <li style="float: right;"><a href="reserve-food.php">Make reservation</a></li>
          <li style="float: right;"><a href="my-reservations.php">My reservations</a></li>
          <?php
        }
        ?>
      </ul>
    </nav>
    <div id="page-content">
      <h1>My Reservations</h1>
      <div id="reservation-list">
        <?php 
          if ($results_orders->num_rows > 0) {
            echo "<table><tr><th>ID</th><th>Ordered Date</th><th>Delivery Date</th><th>Meal Type</th><th>Meal</th><th>Desctiption</th><th>Price</th><th>Weekday</th><th>Building</th></tr>";
            while($row = $results_orders->fetch_assoc()) {
                echo "<tr><td>". $row["OrderId"]. "</td><td>". $row["OrderDate"]. "</td><td>" . $row["DelivDate"] . "</td><td>" . $row["Type"] . "</td><td>" . $row["Name"] . "</td><td>" . $row["Descr"] . "</td><td>" . $row["Price"] . "</td><td>" . $row["Weekday"] . "</td><td>" . $row["Building"] . "</td></tr>";
            }
            echo "</table>";
          } else {
            echo "This user hasn't placed any orders";
          }
        ?>
      </div>
    </div>
  </body>
</html>
