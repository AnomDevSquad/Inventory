<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/graphs/WeekSale.php');
  $ws = new WeekSale();
  $json = "";
  if (count($ws->get_sum_sales() > 0)) {
    $json .= '{
      "status":0,
      "totals":[';
        $banner = true;
        foreach ($ws->get_sum_sales() as $value) {
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
