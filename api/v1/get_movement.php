<?php
  header("Access-Control-Allow-Origin:*");
  require_once('/../models/exceptions/MovementNotFoundException.php');
  require_once('/../models/inventory/Movement.php');
  $json = '{';

  if (isset($_GET['id'])) {
    try{
    $m = new Movement($_GET['id']);
    $json .= '"status":0, "movement":'.$m->to_json();
    }
    catch (MovementNotFoundException $mnfe){
      $json .= '"status":1, "errorMessage":"'.$mnfe->get_message().'"';
    }
  } else {
    $json .= '"status":2, "erroMessage":"Invalid Parameters"';
  }

  $json .= '}';

  echo $json;
 ?>
