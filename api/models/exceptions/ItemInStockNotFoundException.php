<?php

class ItemInStockNotFoundException extends Exception{
  protected $message;
  public function __construct(){
    $this->message = 'Item in stock not found';
  }
  public function get_message(){ return $this->message; }
}

 ?>
