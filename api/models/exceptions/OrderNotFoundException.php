<?php

class OrderNotFoundException extends Exception{
  protected $message;
  public function get_message(){ return $this->message; }
  public function __construct(){
    $this->message = 'Order not found';
  }
}

 ?>
