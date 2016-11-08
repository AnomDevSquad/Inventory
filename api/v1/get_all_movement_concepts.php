<?php
  require_once('/../models/inventory/MovementConcept.php');
  $concept = new MovementConcept();

  $json = "";
  if (count($concept->get_all_movement_concepts()) > 0) {
    $json .= '{
      "status":0,
      "concepts":[';
        $banner = true;
        foreach ($concept->get_all_movement_concepts() as $value) {
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
