<?php

  class DishNotFoundException extends Exception{
    protected $message;
    public function get_message(){ return $this->message; }
    public function __construct(){
      $this->message = 'Dish not Found';
    }
  }

?>
