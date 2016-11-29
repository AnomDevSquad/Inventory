<?php

require_once('/../../sqlserverconnection/connection_sql_server.php');
require_once('/../exceptions/EmployeeNotFoundException.php');

class Employee{
  private $id, $name, $last_name, $type, $nickname;

  public function get_id(){ return $this->id; }
  public function get_name(){ return $this->name; }
  public function set_name($value){ $this->name = $value; }
  public function get_last_name(){ return $this->last_name; }
  public function set_last_name($value){ $this->last_name = $value; }
  public function get_type(){ return $this->type; }
  public function set_type($value){ $this->type = $value; }
  public function get_nickname(){ return $this->nickname; }
  public function set_nickname($value){ $this->nickname = $value; }

  public function Employee($nickname, $passwd){
    $connection = new SqlServerConnection();
    try{
      $sql = sprintf(
         "SELECT
            emp_id, emp_name, emp_lastname, emp_type, emp_nickname
          FROM HumanResource.employees
          WHERE
            emp_nickname = '%s' AND
            emp_passwd = '%s'",
            $nickname, sha1($passwd)) ;
      $data = $connection->execute_query($sql);
      $found = odbc_num_rows($data) > 0;
      if(!$found) throw new EmployeeNotFoundException();
      while(odbc_fetch_array($data)){
        $this->id = odbc_result($data, 'emp_id');
        $this->name = odbc_result($data, 'emp_name');
        $this->last_name = odbc_result($data, 'emp_lastname');
        $this->type = odbc_result($data, 'emp_type');
        $this->nickname = odbc_result($data, 'emp_nickname');
      }
    }
    finally{
      $connection->close();
    }
  }

  public function __to_json(){
    return '{
      "id":'.$this->id.',
      "name":"'.$this->name.'",
      "lastName":"'.$this->last_name.'",
      "type":"'.$this->type.'",
      "nickname":"'.$this->nickname.'"
    }';
  }

  public function __get_array(){
    return array("id" => $this->id, "name" => $this->name, "lastName" => $this->last_name, "type" => $this->type, "nickname" => $this->nickname);
  }
}

 ?>
