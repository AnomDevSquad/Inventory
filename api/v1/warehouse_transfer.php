<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');
  $json = '{';
    if (isset($_POST['itmid']) && isset($_POST['waridout']) && isset($_POST['waridin']) && isset($_POST['qty'])) {
      $sto = $_POST['itmid'];
      $waro = $_POST['waridout'];
      $wari = $_POST['waridin'];
      $qty = $_POST['qty'];

      $json .= '
        "status":0,
        "item":"'.$sto.'",
        "from_warehouse":"'.$waro.'",
        "to_warehouse":"'.$wari.'",
        "quantity":"'.$qty.'"
      ';

      $connection = new SqlServerConnection();
      $sql = "select war_id from Inventory.warehouses where war_name = '%s'";
      $sqlexecute = sprintf($sql, $waro);
      $data = $connection->execute_query($sqlexecute);
      $id_o = odbc_result($data, 'war_id');

      $sqlexecute = sprintf($sql, $wari);
      $data = $connection->execute_query($sqlexecute);
      $id_i = odbc_result($data, 'war_id');

      $sql = "select * from Kitchen.ingredients where ing_description = '%s'";
      $sqlexecute = sprintf($sql, $waro);
      $data = $connection->execute_query($sql, $sto);
      $id_ing = odbc_result($data, $sto);

      $sql = sprintf('EXEC Inventory.new_transfer %d,%d,%d,%d', $id_o, $id_i, $id_ing, $qty, 1);
      $connection->execute_query($sql);

      $connection->close();
    }
    else{
      $json .= '"status": 1, "message":"Invalid Parameters"';
    }
  $json .= '}';
  echo $json;
?>
