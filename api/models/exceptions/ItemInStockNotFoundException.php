<?php

class ItemInStockNotFoundException extends Exception{
  protected $message;

  public function ItemInStockNotFoundException(){
    $this->message = 'Item int stock not found';
  }
}

 ?>
