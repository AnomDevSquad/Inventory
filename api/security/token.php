<?php
  // do something

class Security{

  public static function a(){
    // el token se hace a base de
    // -- las 3 primeras letras del nombre del usuario
    // -- la fecha y hora del dia en que entro
    // -- los ultimos 3 digitos de su contraseña
    //
    // podra tener el token solamnte una vez hasta que finalice el dia.
    $args = func_get_args();
    return sha1($args[0].$args[1].$args[2]);
  }

  public static function vt($a, $prmtrs){
    return $a == /*Security::a(*/$prmtrs/*)*/;
  }
}
 ?>
