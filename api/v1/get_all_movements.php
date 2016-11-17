<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/inventory/Movement.php');
  require_once('/../models/inventory/Warehouse.php');
  require_once('/../models/inventory/Ingredient.php');
  require_once('/../models/inventory/Stock.php');
  require_once('/../models/inventory/Measurement.php');
  require_once('/../models/inventory/MovementConcept.php');
  $json = "";
  if (count($list = Movement::get_all_movements()) > 0) {
    $json .= '{
      "status":0,
      "movements":[';
        $banner = true;
        foreach ($list as $value) {
          if (!$banner) { $json .= ',';} else { $banner = false; }
          $json .= $value->to_json();
        }
        $json .= ']}';
  }
  else {
      $json = '{
        "status":1,
        "message": "There are not movements"
      }';
  }
  echo $json;
 ?>
