<?php
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
        "concept": "'.$conc.'"
      ';
    }

  $json .= '}';

  echo $json;
?>
