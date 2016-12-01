<?php
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
    }
    else{
      $json .= '"status": 1, "message":"Invalid Parameters"';
    }
  $json .= '}';
  echo $json;
?>
