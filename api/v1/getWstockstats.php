<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/graphs/StockStats.php');
  $ss = new StockStats();
  $json = "";
  if (count($ss->get_warehouse_stock() > 0)) {
    $json .= '{
      "status":0,
      "stats":[';
        $banner = true;
        foreach ($ss->get_warehouse_stock() as $value) {
          if (!$banner) { $json .= ',';} else { $banner = false; }
          $json .= $value->to_json();
        }
        $json .= ']}';
  }
  else {
      $json = '{
        "status":1,
        "message": "No data found"
      }';
  }
  echo $json;


?>
