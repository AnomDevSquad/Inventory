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

    $dishes = array_values($dishes);

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

    $connection = new SqlServerConnection();
    $sql = sprintf('EXEC I_RegisterOrder %d,%d,%d,%d', $subtotal, $iva, 1, 1);
    $connection->execute_query($sql);

    $sql = 'SELECT TOP 1 ord_id FROM Sales.orders ORDER BY ord_id DESC';
    $data = $connection->execute_query($sql);
    $last_id = odbc_result($data, 'ord_id');

    for ($i=0; $i < count($dishes); $i++) {
      $sql = sprintf('EXEC I_AttachDishes2Order %d,%d,%d', $last_id, $dishes[$i], $quantity[$i]);
      $connection->execute_query($sql);
    }
    $connection->execute_query('EXEC I_SaveIngredients');
    $connection->execute_query('EXEC I_LowerStock01');
    $connection->execute_query('EXEC I_InsertMovements');

    print_r($dishes);
    print_r($quantity);

    $connection->close();
  }
?>
