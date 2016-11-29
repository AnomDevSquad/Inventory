<?php

require_once('/../models/employees/Employee.php');
require_once('/../models/exceptions/EmployeeNotFoundException.php');
require_once('/../.security/.token.php');

$json = '{';

$headers = getallheaders();

if(isset($headers['nick']) && isset($headers['pass'])){
  try{
    $emp = new Employee($headers['nick'], $headers['pass']);
    $json .= '
    "status" : 0,
    "message" : "",
    "session" : {
      "employee" : '.$emp->__to_json().',
      "date" : '.json_encode(array((int)date("Ymd"),"year" => (int)date("Y"),"month" => (int)date("m"),"day" => (int)date("d"))).',
      "token" : "'.Security::token($emp).'"
    }';
  }
  catch(EmployeeNotFoundException $ex){
    $json .= '
    "status" : 2,
    "message" : "'.$ex->get_message().'"
    ';
  }
}
else{
  $json .= '"status" : 1,';
  $json .= '"message" : "Incomplete Headers"';
}
$json .= '}';

echo $json;

 ?>
