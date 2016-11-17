<?php

class WarehouseNotFoundException extends Exception{
  protected $message;
  public function __construct(){
    $this->message = 'Warehouse not found';
  }
  public function get_message(){ return $this->message; }
}

 ?>
