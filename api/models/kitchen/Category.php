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
			if (func_num_args() == 2) {
				$args = func_get_args();
				$this->set_id($args[0]);
				$this->set_description($args[1]);
			}
		}

		public function __toString(){
			return self::get_description();
		}
	}
?>