<?php
  require_once('/../models/orders/Dish.php');
  $json = '';
  if (count($list = Dish::get_all_dishes()) > 0) {
    $json .= '{
      "status":0,
      "dishes":[';
        $banner = true;
        foreach ($list as $value) {
          if (!$banner){ $json .= ', ';} else { $banner = false;}
          $json .= $value->to_json();
        }
    $json .= ']}';
  } else {
    $json = '{
      "status":1,
      "message": "There are not dishes"
    }';
  }

  echo $json;
 ?>
