<?php
	require_once('/../../sqlserverconnection/connection_sql_server.php');
	require_once('/../general/Information.php');
	require_once('/../exceptions/WarehouseNotFoundException.php');

	class Warehouse extends Information
	{
		public function __construct()
		{
			parent::__construct();
			if(func_num_args() == 0) { }
			else{
				$args = func_get_args();
				if (func_num_args() == 1) {
					$connection = new SqlServerConnection();
					try{
						$args = func_get_args();
						$sql = sprintf(
						"	SELECT war_id, war_name
							FROM Inventory.warehouses
							WHERE war_id = '%s'", strval($args[0]));
						$data = $connection->execute_query($sql);
						$found = odbc_num_rows($data) > 0;
						if(!$found){ throw new WarehouseNotFoundException(); }
						while(odbc_fetch_array($data)){
							$this->set_id(odbc_result($data, 'war_id'));
							$this->set_description(odbc_result($data, 'war_name'));
						}
					}
					finally{
						$connection->close();
					}
				}
				elseif (func_num_args() == 2) {
					$this->set_id($args[0]);
					$this->set_description($args[1]);
				}
			}
		}

		// public function add(){
		// 	$connection = new SqlServerConnection();
		// 	$sql = "INSERT INTO warehouses(war_id, war_description)VALUES(?,?)";
		// 	$connection->execute_non_query($sql, array($this->id, $this->description);
		// 	$connection->close();
		// }

		public static function get_all_warehouses(){
			$connection = new SqlServerConnection();
			$list = array();
			$sql = 'SELECT war_id, war_name FROM Inventory.warehouses';
			$data = $connection->execute_query($sql);
			while (odbc_fetch_array($data)) {
				array_push($list, new Warehouse(odbc_result($data, 'war_id'), odbc_result($data, 'war_name')));
			}
			$connection->close();
			return $list;
		}

		public function to_json(){
			return json_encode(array('id'=>$this->get_id(), 'description'=>$this->get_description()));
		}
		public function __toString(){
			return self::get_id();
		}
	}
?>
