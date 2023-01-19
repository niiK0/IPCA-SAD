<?php
require './db.php';

session_start();

$name = "User";

if(isset($_SESSION['name'])){
  $name = $_SESSION['name'];
}

  if(isset($_POST['Login'])){
    $email = $_POST['email'];
    $pin = $_POST['pin'];

    $sql_find = "SELECT id, name, email FROM user WHERE email='$email' AND pin='$pin'";
    $results = mysqli_query($conn, $sql_find);

    if(mysqli_num_rows($results) == 1){
      // get the user's name and email
      $user = mysqli_fetch_assoc($results);
      $user_name = $user['name'];
      $user_email = $user['email'];
      $user_id = $user['id'];

      // store the user's name and email as session variables
      $_SESSION['name'] = $user_name;
      $_SESSION['email'] = $user_email;
      $_SESSION['user_id'] = $user_id;

      // redirect the user to a logged-in area of the website
      header("location: index.php");
    }else{
      echo  "<script>alert('User doesn't exist!');</script>";
    }
    
    $conn->close();

  }

?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>IPCAlimenta - Login</title>
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
      <h1>Login</h1>
      <div id="login-content">
        <div class="cardboard-form">
          <form action="#" method="post" name="loginform">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <br>
            <label for="pin">PIN:</label>
            <input type="password" id="pin" name="pin" required>
            <br>
            <input type="submit" value="Login" name="Login">
            <br>
          </form>
          <div class="link-register">
            <a href="register.php">Not yet registered? Register here</a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
