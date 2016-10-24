<?php

class TransferException{
  protected $message, $reason;
  public function __construct(){
    $args = func_get_args();
    $argsCount = count($args);
    if($argsCount == 0){
      $this->message = 'Transfer can not be done.';
      $this->reason = 'No reason.';
    }
    elseif($argsCount == 1){
      $this->message = 'Transfer can not be done.';
      $this->reason = $args[0];
    }
  }

  public function get_message(){ return $this->message.' Reason: '.$this->reason; }
}

 ?>
