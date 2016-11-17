<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/inventory/Stock.php');
  $stock = new Stock();
  $json = "";
  if (count($stock->get_all_stock() > 0)) {
    $json .= '{
      "status":0,
      "stock":[';
        $banner = true;
        foreach ($stock->get_all_stock() as $value) {
          if (!$banner) { $json .= ',';} else { $banner = false; }
          $json .= $value->to_json();
        }
        $json .= ']}';
  }
  else {
      $json = '{
        "status":1,
        "message": "There are not products in Stock"
      }';
  }
  echo $json;
?>
