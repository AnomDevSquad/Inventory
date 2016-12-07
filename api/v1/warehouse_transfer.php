<?php
  require_once('/../sqlserverconnection/connection_sql_server.php');
  $json = '{';
    if (isset($_POST['itmid']) && isset($_POST['waridout']) && isset($_POST['waridin']) && isset($_POST['qty'])) {
      $sto = $_POST['itmid'];
      $waro = $_POST['waridout'];
      $wari = $_POST['waridin'];
      $qty = $_POST['qty'];

      $connection = new SqlServerConnection();
      $sql = sprintf(
      'declare @var as int;
       EXEC Inventory.transferIngredient %d, %d, %d, %d, @var output;
       select @var as error;',
       $waro, $wari, $sto, $qty
      );
      $data = $connection->execute_query($sql);
      while (odbc_fetch_array($data)) {
        $error = odbc_result($data, 'error');
      }
      $connection->close();
      $json .= '
        "status":0,
        "item":"'.$sto.'",
        "from_warehouse":"'.$waro.'",
        "to_warehouse":"'.$wari.'",
        "quantity":"'.$qty.'",
      ';

      if ($error == 0) {
        $json .= '"result": "Transferencia Exitosa"';
      }
      if ($error == 1) {
        $json .= '"result": "No Existe alguno de los warehouses"';
      }
      if ($error == 2) {
        $json .= '"result": "No se puede transferir al mismo warehouse"';
      }
      if ($error == 3) {
        $json .= '"result": "No Existe ese ingredient"';
      }
      if ($error == 4) {
        $json .= '"result": "No hay suficiente existencia en el warehouse output"';
      }
      if ($error == 5) {
        $json .= '"result": "El ingrediente no se puedo registrar en el warehouses input"';
      }
      if ($error == 6) {
        $json .= '"result": "La cantidad de ingrediente no cabe en el warehouse al que se queire pasar"';
      }
      if ($error == 999) {
        $json .= '"result": "Error desconocido"';
      }
    }
    else{
      $json .= '"status": 1, "message":"Invalid Parameters"';
    }
  $json .= '}';
  echo $json;
?>
