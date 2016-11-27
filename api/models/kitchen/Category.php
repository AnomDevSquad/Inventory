<?php
	require_once('/../general/Information.php');
	require_once('/../../sqlserverconnection/connection_sql_server.php');
	/**
	* Category class
	*/
	class Category extends Information
	{

		function __construct()
		{
			parent::__construct();
			if (func_num_args() == 1) {
				$args = func_get_args();
				$connection = new SqlServerConnection();
				$sql = sprintf("SELECT cat_id, cat_name FROM Kitchen.category WHERE cat_id = %d", $args[0]);
				$data = $connection->execute_query($sql);
				$this->set_id(odbc_result($data, 'cat_id'));
				$this->set_description(odbc_result($data, 'cat_name'));
				$connection->close();
			}
			if (func_num_args() == 2) {
				$args = func_get_args();
				$this->set_id($args[0]);
				$this->set_description($args[1]);
			}
		}

		public function to_json(){
			return '{
				"id":'.$this->get_id().',
				"name":"'.$this->get_description().'"
			}';
		}

		public function __toString(){
			return self::get_description();
		}
	}
?>
