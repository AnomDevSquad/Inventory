<?php

class NewOrderException extends Exception{
  protected $message;

  public function get_message(){ return $this->message; }
  public function NewOrderException($reason = ''){
    $this->message = 'New order can not create. '.$reason;
  }
}

 ?>
