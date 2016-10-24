<?php

require_once('Dish.php');

class OrderDetail{
  private $dish;
  private $quantity;

  public function __construct(){
		$argsCount = func_num_args();
		if($argsCount == 0){
      $this->dish = new Dish();
      $this->quantity = 0;
    }
    else{
      $args = func_get_args();
      if($argsCount == 2){
        $this->dish = $args[0];
        $this->quantity = $args[1];
      }
    }
  }

  public function get_dish(){ return $this->dish; }
  public function set_dish($newValue){ $this->dish = $newValue; }
  public function get_quantity(){ return $this->quantity; }
  public function set_quantity($newValue){ $this->quantity = $newValue; }
  public function to_json(){
    return '{
      "dish":{
        "id":'.$this->dish->get_id().',
        "name":"'.$this->dish->get_name().'",
        "price":'.$this->dish->get_price().'
      },
      "quantity":'.$this->get_quantity().'
    }';
  }
}


 ?>
