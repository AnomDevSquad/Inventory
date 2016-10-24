<?php

class SqlSrvConnection{
  private $connection;
  private $db = 'inventory';
  private $user = 'sa';
  private $passwd = 'usersql';
  private $connection_info;
  private $server_name = 'USER';

  function __construct(){
    $this->connection_info = array("Database"=>$this->db, "UID"=>$this->user, "Password"=>$this->passwd);
    $this->connection = sqlsrv_connect($this->server_name, $this->connection_info);
  }
  public function execute_procedure(){
    $args = func_get_args();
    $proc = $args[0];
    $params = $args[1];
    try{
      $stmt = sqlsrv_query($this->connection, $proc, $params);
      sqlsrv_next_result($stmt);
    }
    finally{
      $this->close();
    }
  }
  private function close(){
    sqlsrv_close($this->connection);
  }
}

 ?>
