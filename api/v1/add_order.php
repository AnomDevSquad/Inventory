<?php
  require_once('/../models/orders/Dish.php');
  require_once('/../sqlserverconnection/connection_sql_server.php');

  if (isset($_POST['dishes'])) {
    $array = $_POST['dishes'];
    $dishes = array_unique($_POST['dishes']);
    $quantity = array();
    $count = 0;

    foreach ($dishes as $key => $i) {
      foreach ($array as $key => $j) {
        if ($i == $j) {
          $count++;
        }
      }
      array_push($quantity, $count);
      $count = 0;
    }

    $list = array();
    foreach ($dishes as $key => $value) {
      array_push($list, new Dish($value));
    }

    $sum = 0;
    $subtotal = 0;
    $iva = 0;

    for ($i=0; $i < count($list); $i++) {
      $sum = $list[$i]->get_price() * $quantity[$i];
      $subtotal += $sum;
      $sum = 0;
    }
    $iva = ($subtotal * 16) / 100;

    // $connection = new SqlServerConnection();
    // $connection->execute_non_query('{CALL I_RegisterOrder(?,?,?,?)}', array($subtotal, $iva, 1, 1));
    //
    // $sql = 'SELECT TOP 1 ord_id FROM Sales.orders ORDER BY ord_id DESC';
    // $data = $connection->execute_query($sql);
    // $last_id = odbc_result($data, 'ord_id');
    //
    // for ($i=0; $i < count($dishes); $i++) {
    //   $connection->execute_non_query('{CALL I_AttachDishes2Order(?,?,?)}', array($last_id, $dishes[$i], $quantity[$i]));
    // }
    // $connection->execute_non_query('{CALL I_SaveIngredients}', array());
    // // aqui para
    // $connection->execute_non_query('{CALL I_LowerStock01}', array());
    // $connection->execute_non_query('{CALL I_InsertMovements}', array());
    // $connection->close();
    // echo "FIN";
  }
?>
