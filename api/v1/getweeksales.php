<?php
  header("Access-Control-Allow-Origin:*");
  require_once('WeekSale.php');
  $ws = new WeekSale();
  $json = "";
  if (count($ws->get_all_ws() > 0)) {
    $json .= '{
      "status":0,
      "totals":[';
        $banner = true;
        foreach ($ws->get_all_ws() as $value) {
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
