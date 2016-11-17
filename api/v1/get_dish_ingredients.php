<?php
  require_once('/../models/orders/Dish.php');
  require_once('/../models/exceptions/DishNotFoundException.php');

  $json = "";

    if (isset($_GET['id'])){
	  	try{
		    $dis = new Dish($_GET['id']);
		    echo '{
		      "status":0,
		      "id":'.$dis->get_id().',
		      "name":"'.$dis->get_name().'",
		      "description":"'.$dis->get_description().'",
		      "price":'.$dis->get_price().',
		      "ingredients":[';
		      $banner = true;
		      foreach ($dis->get_all_ingredients_per_dish() as $value) {
		        if (!$banner) { $json .= ',';} else { $banner = false; }
		        $json .= $value->to_json();
		      }
		    $json .= ']}';
		}
		catch(DishNotFoundException $de){
			echo '{
		      "status" : 2,
		      "message" : "'.$de->get_message().'"
		    }';
		}
	}
	else {
	    echo '{
	    	"status" : 1,
	        "message" : "Invalid Parameter"
	    }';
	}


  echo $json;
?>
