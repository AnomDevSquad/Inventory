<?php

class SqlExcecuteException extends Exception{
  protected $message;

  public function get_message() { return $this->message; }
  public function SqlExcecuteException($reason){
    $this->message = 'Has been occured an SQL error. '.$reason;
  }
}

 ?>
