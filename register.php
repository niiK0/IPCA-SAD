<?php
require './db.php';

session_start();

$name = "User";

if(isset($_SESSION['name'])){
  $name = $_SESSION['name'];
}

  if(isset($_POST['Register'])){
    $email = $_POST['email'];
    $pin = $_POST['pin'];
    $name = $_POST['name'];
    $nif = $_POST['nif'];

    $sql_find = "SELECT email FROM user WHERE email='$email'";
    $result = $conn->query($sql_find);

    if($result->num_rows > 0){
      echo  "<script>alert('User already exists!');</script>";
      header("location: index.php");
    }else{
      $sql_create = "INSERT INTO user(email, pin, name, nif) VALUES ('$email', $pin, '$name', $nif)";
      if ($conn->query($sql_create) === TRUE) {
        // store the user's name and email as session variables
        $_SESSION['name'] = $name;
        $_SESSION['email'] = $email;

        // redirect the user to a logged-in area of the website
        header("location: index.php");
      } else {
        // echo  "<script>alert('There was an error!');</script>";
        echo "Error: " . $sql_create . "<br>" . $conn->error;
      }
    }

    $conn->close();

  }

?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>IPCAlimenta - Register</title>
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
        <h1>Register</h1>
        <div id="login-content">
            <div class="cardboard-form">
                <form action="#" method="post" name="registerform">
                  <label for="email">Email *:</label>
                  <input type="email" id="email" name="email" required>
                  <br>
                  <label for="pin">PIN *:</label>
                  <input type="password" maxlength="4" id="pin" name="pin" required>
                  <br>
                  <label for="name">Full name *:</label>
                  <input type="text" id="name" name="name" required>
                  <br>
                  <label for="nif">NIF (optional):</label>
                  <input type="number" maxlength="9" id="nif" name="nif" value="0">
                  <br>
                  <input type="submit" value="Register" name="Register">
                  <br>
                </form>
                <div class="link-register">
                    <a href="register-login.php">Already registered? Login here</a>
                </div>
            </div>
        </div>
    </div>
  </body>
</html>
