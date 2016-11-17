<?php
  require_once('/../models/inventory/MovementConcept.php');
  $json = "";
  if (count($list = MovementConcept::get_all_movement_concepts()) > 0) {
    $json .= '{
      "status":0,
      "concepts":[';
        $banner = true;
        foreach ($list as $value) {
          if (!$banner) { $json .= ',';} else { $banner = false; }
          $json .= $value->to_json();
        }
        $json .= ']}';
  } else {
      $json = '{
        "status":1,
        "message": "There are not movement concepts"
      }';
  }
  echo $json;
 ?>
