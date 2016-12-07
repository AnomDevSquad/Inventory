<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');

  class Transfer{
    public static function new_transfer($ingredient_id, $warehouse_out_id, $warehouse_in_id, $quantity){
      $connection = new SqlServerConnection();
      $error = -1;
      try{
        $sql = 'DECLARE @e int; EXEC Inventory.new_transfer %d, %d, %d, %d, @e OUTPUT; SELECT @e as [error];';
        $sql = sprintf($sql, $warehouse_out_id, $warehouse_in_id, $ingredient_id, $quantity);
        $data = $connection->execute_query($sql);
        $error = odbc_result($data, 'error');
      }
      finally{
        $connection->close();
      }
      return $error;
    }
  }

  $messages = array();
  $messages[0] = '"Transfer success"';
  $messages[1] = '"At least one of the warehouses doesn\'t exist"';
  $messages[2] = '"At least one of the ingredients doesn\'t exist "';
  $messages[3] = '"There isn\'t enough stock to transfer"';
  $messages[4] = '"There isn\'t enough space in the warehouse that you are trying to send to"';
  $messages[5] = '"The conversion factor isn\'t registered"';
  $messages[999] = '"Data base error"';


  $json = '{';
    if (isset($_POST['itmid']) && isset($_POST['waridout']) && isset($_POST['waridin']) && isset($_POST['qty'])) {
      $sto = $_POST['itmid'];
      $waro = $_POST['waridout'];
      $wari = $_POST['waridin'];
      $qty = $_POST['qty'];



      $result = Transfer::new_transfer($sto, $waro, $wari, $qty);
      $json .= '"status": '.$result.', "message": '.$messages[$result];
    }
    else{
      $json .= '"status": 6, "message":"Invalid Parameters"';
    }
  $json .= '}';
  echo $json;
?>
