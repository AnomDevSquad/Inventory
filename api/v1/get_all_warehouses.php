<?php
  require_once('/../models/inventory/Warehouse.php');
  $json = '';
  if (count($list = Warehouse::get_all_warehouses()) > 0) {
    $json .= '{
      "status":0,
      "warehouses":[
    ';
    $banner = true;
    foreach ($list as $value) {
      if (!$banner) { $json .= ','; } else { $banner = false; }
      $json .= $value->to_json();
    }
    $json .= ']}';
  } else {
    $json .= '{
      "status":1,
      "message":"There Are not warehouses";
    }';
  }

  echo $json;
?>
