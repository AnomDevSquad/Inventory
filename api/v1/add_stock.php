<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');
  $json  = '{';
    // definir los parametros a enviar
    if (isset($_POST['']) && isset($_POST['']) && isset($_POST[''])) {
      $connection = new SqlServerConnection();
      // definir los argumentos que recibira el stored procedure
      $sql = sprintf('
      declare @e as int;
      execute Inventory.AddMoreStock %d, %d ,%d, @e output;
      select @e as error;'
      );
      $data = $connection->execute_query($sql);
      while (odbc_fetch_array($data)) {
        $error = odbc_result($data, 'error');
      }
      $connection->close();

      if ($error == 0) {
        $json .= '"result": "La agregacion se realizo de manera exitosa"';
      }
      if ($error == 1) {
        $json .= '"result": "La cantidad recibida no puede ser menor o igual a 0"';
      }
      if ($error == 2) {
        $json .= '"result": "No existe el Alamacen seleccionado"';
      }
      if ($error == 3) {
        $json .= '"result": "No Existe ese ingrediente en el Alamacen"';
      }
      if ($error == 4) {
        $json .= '"result": "No hay Suficiente Espacion en el Alamacen"';
      }

    } else {
      $json .= '"status":1, "message":"Invalid Parameters"';
    }
  $json .= "}";

  echo $json;
?>
