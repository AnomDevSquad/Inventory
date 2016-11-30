<?php

class StockEmptyException extends Exception{
  protected $message;
  public function __construct(){
    $this->message = 'Stock empty';
  }
  public function get_message(){ return $this->message; }
}

 ?>
