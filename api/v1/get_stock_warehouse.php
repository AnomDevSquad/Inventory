<?php

require_once ('/../models/inventory/Stock.php');

$json = '{';

if(isset($_GET['warid'])){
  $all_warehouse_stock = Stock::get_warehouse_stock($_GET['warid']);
  $json .= '"status": 0, "stock":[';
  $first = true;
  foreach ($all_warehouse_stock as $stock) {
    if(!$first) $json .= ','; else $first = false;
    $json .= $stock->to_json();
  }
  $json .= ']';
}
else{
  $json .= '"status": 1, "message":"invalid parameters"';
}

$json .= '}';

echo $json;
 ?>
