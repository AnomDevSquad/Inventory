<?php
  // $json = '';
  // if (isset($_POST['dishes'])) {
  //   $data = $_POST['dishes'];
  //   $json .= '{
  //     "status": 0,
  //     "dishes":[';
  //       $banner = true;
  //       foreach ($data as $key => $value) {
  //         if (!$banner) {
  //           $json .= ',';
  //         } else {
  //           $banner = false;
  //         }
  //         $json .= $value;
  //       }
  //     $json .= ']}';
  // } else {
  //   $json .= '{
  //     "status":1,
  //     "message":"Invalid Parameters"
  //   }';
  // }
  $array = [
     2,
     5,
     2,
     6,
     7,
     8,
     1,
     9,
     1,
  ];

  $dishes = array_unique($array);
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

  print_r($dishes);
  echo "<br>";
  print_r($quantity);

?>
