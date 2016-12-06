<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/inventory/Stock.php');
  require_once('/../models/exceptions/StockEmptyException.php');
  $json = '{';
    try{
      $all_stock = Stock::get_all_stock();
      $json .= '
      "status":0,
      "stock":[
      ';
      $first = true;
      foreach ($all_stock as $stock) {
        if(!$first) $json .= ','; else $first = false;
        $json .= $stock->to_json();
      }
      $json .= ']';
    }
    catch(StockEmptyException $ex){
      $json .= '
      "status": 1,
      "message": "'.$ex->get_message().'"
      ';
    }
  echo $json.'}';
?>
