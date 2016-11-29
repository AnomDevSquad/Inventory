<?php

  class Security{
    public static function token($emp){
      return sha1($emp->get_id().$emp->get_name().$emp->get_last_name().self::key());
    }

    private static function key(){
      return date('Ymd');
    }
  }
 ?>
