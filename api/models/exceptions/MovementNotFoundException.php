<?php

class MovementNotFoundException extends Exception{
  protected $message;
  public function __construct(){
    $this->message = 'Movement not found';
  }
  public function get_message(){ return $this->message; }
}

 ?>
