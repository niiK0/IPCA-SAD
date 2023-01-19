<?php
require './db.php';

session_start();

$name = "User";

if(isset($_SESSION['name'])){
  $name = $_SESSION['name'];
}

?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>IPCAlimenta</title>
  </head>
  <body>
  <nav>
  <ul>
        <li style="float: left;"><a href="index.php">Home</a></li>
        <li style="float: right;"><?php echo $name; ?></li>
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
      <h1>IPCAlimenta</h1>
      <div id="login-content">
        <p style="font-size: 2em;">Interface criada para a 4ª parte do projeto da cadeira de Sistemas de Armazenamento de Dados do curso Engenharia em Desenvolvimento de Jogos Digitais no ano de 2022/2023<br><br>Realizado por: <br>a23495 - Nicolae malai<br>a23494 - Bernardo Neves</p>
      </div>
    </div>
  </body>
</html>