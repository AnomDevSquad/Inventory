<?php

class EmployeeNotFoundException extends Exception{
  protected $message;

  public function get_message(){ return $this->message; }
  public function EmployeeNotFoundException(){
    $this->message = "Employee not found";
  }
}

 ?>
