<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');

  if (isset($_POST['dishes'])) {
    $array = $_POST['dishes'];
    $dishes = array_unique($_POST['dishes']);
    $quantity = array();
    $count = 0;

    foreach ($dishes as $key => $i) {
      foreach ($array as $key => $j) {
        if ($i == $j) {
          $count++;
        }
      }
      array_push($quantity, $count);
      $count = 0;
    }
  }

?>

<!-- // print_r($dishes);
// echo "<br>";
// print_r($quantity); -->
