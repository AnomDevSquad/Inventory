<?php

require_once('/../models/orders/Order.php');
require_once('/../models/orders/Dish.php');
require_once('/../models/exceptions/OrderNotFoundException.php');

$headers = getallheaders();

$json = '{
  ';
$list = Order::get_orders();
if(count($list)>0){
  $json .='"status":0,
  "orders":[';
  $first = true;
  foreach ($list as $order) {
    if(!$first) $json .= ','; else $first = false;
    $json .= $order->to_json();
  }
  $json .= "]";
}
else{
  $json .= '"status": 2, "errorMessage":"No orders were found"';
}
$json.='
}';
echo $json;

 ?>
