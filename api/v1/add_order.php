<?php
  require_once('/../models/orders/Order.php');
  require_once('/../sqlserverconnection/connection_sql_server.php');
  require_once('/../models/exceptions/SqlExecuteException.php');
  require_once('/../models/exceptions/OrderNotFoundException.php');
  require_once('/../models/exceptions/DishNotFoundException.php');
  require_once('/../models/exceptions/NewOrderException.php');

  $headers = getallheaders();

  $json = '{';

  if (isset($_POST['dishes'])) {
    $array = $_POST['dishes'];
    $dish_ids = array_unique($_POST['dishes']);
    $dish_qtys = array();
    $count = 0;

    foreach ($dish_ids as $key => $i) {
      foreach ($array as $key => $j) {
        if ($i == $j) {
          $count++;
        }
      }
      array_push($dish_qtys, $count);
      $count = 0;
    }

    $dish_ids = array_values($dish_ids);
  //   $employee = new Employee();
  //   $employee.set_id($headers['empid']);
  //   try{
  //     Order::add_new_order($employee, $dish_ids, $dish_qtys);
  //     $json .= '
  //     "status": 0,
  //     "message": "Success"';
  //   }
  //   catch(NewOrderException $ex){
  //     $json .= '
  //     "status": 2,
  //     "message": "'.$ex->get_message().'"';
  //   }
  //   catch(OrderNotFoundException $ex){
  //     $json .= '
  //     "status": 2,
  //     "message": "'.$ex->get_message().'"';
  //   }
  //   catch(DishNotFoundException $ex){
  //     $json .= '
  //     "status": 2,
  //     "message": "'.$ex->get_message().'"';
  //   }
  //   catch(SqlExcecuteException $ex){
  //     $json .= '
  //     "status": 2,
  //     "message": "'.$ex->get_message().'"';
  //   }
  // }
  // else{
  //   $json .= '
  //   "status": 1,
  //   "message": "Parameters not were found."';
  // }


    $list = array();
    foreach ($dish_ids as $key => $value) {
      array_push($list, new Dish($value));
    }

    $sum = 0;
    $subtotal = 0;
    $iva = 0;

    for ($i=0; $i < count($list); $i++) {
      $sum = $list[$i]->get_price() * $dish_qtys[$i];
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

    for ($i=0; $i < count($dish_ids); $i++) {
      $sql = sprintf('EXEC I_AttachDishes2Order %d,%d,%d', $last_id, $dish_ids[$i], $dish_qtys[$i]);
      $connection->execute_query($sql);
    }
    $connection->execute_query('EXEC I_SaveIngredients');
    $connection->execute_query('EXEC I_LowerStock01');
    $connection->execute_query('EXEC I_InsertMovements');

    print_r($dish_ids);
    print_r($dish_qtys);

    $connection->close();
  }
  $json .= '}';
  echo $json;
?>
