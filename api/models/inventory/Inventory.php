<?php

require_once('Stock.php');
require_once('Warehouse.php');
require_once('Movement.php');
require_once('MovementConcept.php');
require_once('/../exceptions/TransferException.php');
require_once('/../../sqlserverconnection/connection_sql_server.php');

class Inventory{
  public static function transfer($stockitem, $warehouseout, $warehousein, $quantity){
    $error = 0;
    $connection = new SqlServerConnection();
    try{
      $error = $connection->execute_procedure('EXEC warehouse_transfer ?, ?, ?, ?', array($stockitem, $warehouseout, $warehousein, $quantity));
    }
    finally{
      $connection->close();
    }
    //echo $error;
    return $error==0?$error:($error-50);
  }
  public static function sell_dish($dish){
  }
}

 ?>
