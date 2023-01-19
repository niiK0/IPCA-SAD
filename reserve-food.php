<?php
require './db.php';

session_start();

$name = "User";

if(isset($_SESSION['name'])){
  $name = $_SESSION['name'];
}

// query the database
$query = "SELECT building.name AS Building, location.name AS Location FROM building LEFT JOIN
location ON location.id = building.location_id order BY location.name";

$sql = "SELECT location.name AS Location,
          building.name AS Building,
          week_day.id AS Weekday,
          menu.id AS MenuId,
          meals.type AS Type,
          meals.name AS Name,
          meals.description AS Descr,
          meals.price AS Price
        FROM building
        INNER JOIN location ON location.id = building.location_id
        INNER JOIN menu ON menu.building_id = building.id
        INNER JOIN week_day ON week_day.id = menu.weekday_id
        INNER JOIN menu_meals ON menu.id = menu_meals.menu_id
        INNER JOIN meals ON menu_meals.meals_id = meals.id";

$results = mysqli_query($conn, $query);
$results_meals = mysqli_query($conn, $sql);

// convert the query results to an array
$options = array();
while ($row = mysqli_fetch_assoc($results)){
  $options[] = $row;
}

$options_meals = array();
while ($row = mysqli_fetch_assoc($results_meals)) {
  $options_meals[] = $row;
}

// close the database connection
mysqli_close($conn);

// convert the options array to a JSON object
$options_json = json_encode($options);
$options_meals_json = json_encode($options_meals);
?>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>IPCAlimenta - Make reservation</title>
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
      <h1>Make reservation</h1>
      <div id="dish-list">
          <form action="add_reservation.php" method="post" class="cardboard-form-reserve">
            <div class="cardboard-form-reserve-nav">
              <label for="period-select">Day:</label>
                <select style="width:10%" id="day-select" name="day">
                    <option value="1">Segunda</option>
                    <option value="2">Terca</option>
                    <option value="3">Quarta</option>
                    <option value="4">Quinta</option>
                    <option value="5">Sexta</option>
                </select>
                <label for="canteen-select">Select Canteen:</label>
                <select id="canteen-select" name="canteen">
                    <!-- <option value="canteen1">Canteen 1</option>
                    <option value="canteen2">Canteen 2</option> -->
                </select>
                <!-- <label for="period-select">Select Period:</label>
                <select id="period-select" name="period">
                    <option value="lunch">Lunch</option>
                    <option value="dinner">Dinner</option>
                </select> -->
                <input style="width:10%; margin-left: 10px; margin-right:10px;" type="button" value="Search" id="searchBtn" name="search">
            </div>
            <div id="reserve-items-container" class="cardboard-form-reserve-items-container">
                <div id="reserve-item">
                    <p class="reserve-item-type"><span id="reserve-item-type-meat">Carne</span></p>
                    <p class="reserve-item-title"><span id="reserve-item-title-meat">Name</span></p>
                    <p class="reserve-item-desc"><span id="reserve-item-desc-meat">Description</span></p>
                    <input id="reserve-item-buy-meat" type="submit" value="Buy 1.35€" name="reserve">
                </div>
                <div id="reserve-item">
                    <p class="reserve-item-type"><span id="reserve-item-type-vegan">Vegetariano</span></p>
                    <p class="reserve-item-title"><span id="reserve-item-title-vegan">Name</span></p>
                    <p class="reserve-item-desc"><span id="reserve-item-desc-vegan">Description</span></p>
                    <input id="reserve-item-buy-vegan" type="submit" value="Buy 1.35€" name="reserve">
                </div>
                <div id="reserve-item">
                    <p class="reserve-item-type"><span id="reserve-item-type-diet">Dieta</span></p>
                    <p class="reserve-item-title"><span id="reserve-item-title-diet">Name</span></p>
                    <p class="reserve-item-desc"><span id="reserve-item-desc-diet">Description</span></p>
                    <input id="reserve-item-buy-diet" type="submit" value="Buy 1.35€" name="reserve">
                </div>
            </div>
            <input id="menu-id-input" type="hidden" name="menuId">
          </form>
        </div>
      </div>
      <script>
        // get the select element
        var select = document.getElementById("canteen-select");

        // get the options from the PHP script
        var options = <?php echo $options_json; ?>;

        var optGroup1 = document.createElement("optgroup")
        optGroup1.label = "Braga"

        var optGroup2 = document.createElement("optgroup")
        optGroup2.label = "Barcelos"

        select.appendChild(optGroup2)
        select.appendChild(optGroup1)

        // loop through the options and add them to the select element
        options.forEach(function(option) {
          var option_element = document.createElement("option");
          option_element.value = option.Location+option.Building;
          option_element.textContent = option.Building;
          if(option.Location == "Barcelos"){
            optGroup2.appendChild(option_element);
          }else{
            optGroup1.appendChild(option_element);
          }
        });

        var seachBtn = document.getElementById("searchBtn")
        searchBtn.addEventListener("click", function(){
          // get the select element
          var container = document.getElementById("reserve-items-container");
          container.style.visibility = "visible";

          // get the options from the PHP script
          var options_meals = <?php echo $options_meals_json; ?>;

          var weekday = document.getElementById('day-select').value
          var canteen = document.getElementById('canteen-select').value
          let split = canteen.split(/(?=[A-Z])/);
          let locationString = split[0]
          let buildingString = split[1]

          let correct_options = []

          // loop through the options and add them to the select element
          options_meals.forEach(function(option_meals) {
            if(option_meals.Location == locationString){
              if(option_meals.Building == buildingString){
                if(option_meals.Weekday == weekday){
                  correct_options.push(option_meals)
                }
              }
            }
          });

          console.log(correct_options)

          document.getElementById("menu-id-input").value = correct_options[0].MenuId

          correct_options.forEach(function(option_correct) {
            if(option_correct.Type == "Carne"){
              let titleText = document.getElementById("reserve-item-title-meat")
              titleText.textContent = option_correct.Name
              let descText = document.getElementById("reserve-item-desc-meat")
              descText.textContent = option_correct.Descr
              let priceText = document.getElementById("reserve-item-buy-meat")
              priceText.value = "Buy " + option_correct.Price + "€"
            }else if(option_correct.Type == "Dieta"){
              let titleText = document.getElementById("reserve-item-title-diet")
              titleText.textContent = option_correct.Name
              let descText = document.getElementById("reserve-item-desc-diet")
              descText.textContent = option_correct.Descr
              let priceText = document.getElementById("reserve-item-buy-diet")
              priceText.value = "Buy " + option_correct.Price + "€"
            }else if(option_correct.Type == "Vegetariano"){
              let titleText = document.getElementById("reserve-item-title-vegan")
              titleText.textContent = option_correct.Name
              let descText = document.getElementById("reserve-item-desc-vegan")
              descText.textContent = option_correct.Descr
              let priceText = document.getElementById("reserve-item-buy-vegan")
              priceText.value = "Buy " + option_correct.Price + "€"
            }
          });
        })
      </script>
  </body>
</html>
