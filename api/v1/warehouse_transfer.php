<?php

require_once('/../models/inventory/Stock.php');
require_once('/../models/inventory/Warehouse.php');
require_once('/../models/exceptions/WarehouseNotFoundException.php');
require_once('/../models/exceptions/ItemInStockNotFoundException.php');
require_once('/../models/inventory/Inventory.php');

$json = '{';
  if(isset($_POST['itmid']) && isset($_POST['waridout']) && isset($_POST['waridin']) && isset($_POST['qty'])){
      $sto = $_POST['itmid'];
      $waro = $_POST['waridout'];
      $wari = $_POST['waridin'];
      $qty = $_POST['qty'];

      // $json .= '
      //   "status":0,
      //   "item":"'.$sto.'",
      //   "from_warehouse":"'.$waro.'",
      //   "to_warehouse":"'.$wari.'",
      //   "quantity":"'.$qty.'"
      // ';

      $result = Inventory::transfer($sto, $waro, $wari, $qty);
      if($result == 0)
        $json .= '"status": 0, "message": "Transfer successful"';
      elseif($result == 1)
        $json .= '"status": 1, "errorMessage":"Transfer fail. The quantity to transfer is more than the quantity avaliable"';
      elseif($result == 2)
        $json .= '"status": 2, "errorMessage":"Transfer fail. The item cannt be transfer to that warehouse"';
      elseif($result == 3)
        $json .= '"status": 3, "errorMessage":"Transfer fail. The item wasnt found in the warehouse"';
      elseif($result == 4)
        $json .= '"status": 4, "errorMessage":"Transfer fail. The warehouse that you are trying to transfer doesnt exist"';
      elseif($result == 5)
        $json .= '"status": 5, "errorMessage":"Transfer fail. The warehouse from where you are trying to transfer doesnt exist"';
  }
  else{
    $json .= '"status": 6, "errorMessage":"Parameters not assigned"';
  }
$json .= '}';

echo $json;

 ?>
