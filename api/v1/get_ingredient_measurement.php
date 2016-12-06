<?php

require_once('/../models/inventory/Stock.php');
require_once('/../models/exceptions/ItemInStockNotFoundException.php');

$json = '{';

  if(isset($_GET['ingredientid']) && isset($_GET['warehouseid'])){
    try{
      $stock = new Stock($_GET['ingredientid'], $_GET['warehouseid']);
      $json .= '"status": 0, "message": "success",
      "measurement": '.$stock->get_ingredient()->get_measurement()->to_json();
    }
    catch(ItemInStockNotFoundException $ex){
      $json .= '"status": 2, "message":"'.$ex->get_message().'"';
    }
  }
  else{
    $json .= '"status": 1, "message":"No parameters sssigned"';
  }

$json .= '}';

echo $json;

 ?>
