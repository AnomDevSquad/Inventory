<?php

require_once('/../models/orders/Order.php');
require_once('/../models/orders/Dish.php');
require_once('/../models/exceptions/OrderNotFoundException.php');

$headers = getallheaders();

$json = '{
  ';
if(isset($_GET['orderid'])){
  try{
    $ord = new Order($_GET['orderid']);
    $json .= '"status": 0, "order":'.$ord->to_json();
  }
  catch(OrderNotFoundException $oe){
    $json .= '"status": 1, "errorMessage": "'.$oe->get_message().'"';
  }
}
else{
  $json .= '"status":2, "errorMessage":"Parameter unseted"';
}
$json.='
}';
echo $json;

 ?>
