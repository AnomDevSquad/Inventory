<?php
  require_once('/../models/orders/Order.php');
  require_once('/../sqlserverconnection/connection_sql_server.php');
  require_once('/../models/exceptions/SqlExecuteException.php');
  require_once('/../models/exceptions/OrderNotFoundException.php');
  require_once('/../models/exceptions/DishNotFoundException.php');
  require_once('/../models/exceptions/NewOrderException.php');

  if (isset($_POST['dishes']) && isset($_POST['combos'])) {
    $dishes = $_POST['dishes'];
    $combos = $_POST['combos'];
    $subtotal = floatval($_POST['subtotal']);
    $tax = floatval($_POST['tax']);

    $connection = new SqlServerConnection();

    $sql = sprintf('EXEC I_RegisterOrder %f,%f,%d,%d', $subtotal, $tax, 1, 1);
    $connection->execute_query($sql);

    $sql = "SELECT TOP 1 ord_id FROM Sales.orders ORDER BY ord_id DESC";
    $data = $connection->execute_query($sql);
    $last_id = odbc_result($data, 'ord_id');

    for ($i=0; $i <  count($dishes); $i++) {
      $sql = sprintf('EXEC I_AttachDishes2Order %d,%d,%d', $last_id, $dishes[$i], $combos[$i]);
      $connection->execute_query($sql);
    }

    $connection->execute_query('EXEC I_SaveIngredients');
    $connection->execute_query('EXEC I_LowerStock01');
    $connection->execute_query('EXEC I_InsertMovements');

    $connection->close();

    print_r($dishes);
    print_r($combos);
    print_r($subtotal);
    print_r($tax);
  }
?>
