<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');

  $json = '{';

    if (isset($_POST['itmid']) && isset($_POST['war']) && isset($_POST['concept']) && isset($_POST['qty']) ) {
      $sto = $_POST['itmid'];
      $waro = $_POST['war'];
      $conc = $_POST['concept'];
      $qty = $_POST['qty'];

      $json .= '
        "status":0,
        "item":"'.$sto.'",
        "warehouse":"'.$waro.'",
        "quantity":"'.$qty.'",
        "concept": "'.$conc.'",
        ';

        $connection = new SqlServerConnection();
        $sql = sprintf('
        declare @e as int;
        execute Inventory.LossOfIngredient %d, %d, %d, %d, @e output;
        select @e as error;
        ');
        /*
        Falta por incluir los para para ejecutar el stored procedure
        */
        $data = $connection->execute_query($sql);
        while (odbc_fetch_array($data)) {
          $error = odbc_restul($data, 'error');
        }
        $connection->close();

        if ($error == 0) {
          $json .= '"result":"Perdidad Registrada de Manera Exitosa"';
        }
        if ($error == 1) {
          $json .= '"result":"No Existe el almacen Seleccionado"';
        }
        if ($error == 2) {
          $json .= '"result":"No Existe el ingrediente en el Alamacen"';
        }
        if ($error == 3) {
          $json .= '"result":"No hay suficiente existencia en el Alamacen"';
        }
        if ($error == 4) {
          $json .= '"result":"Concepto no valido para este tipo de perdida"';
        }
        if ($error == 999) {
          $json .= '"result":"Error desconocido(Puede ser la base de datos)"';
        }

    } else {
      $json .= '"status":1, "message":"Invalid Paramters"';
    }
  $json .= '}';

  echo $json;
?>
