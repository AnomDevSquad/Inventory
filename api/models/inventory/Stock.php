<?php
	require_once('/../../sqlserverconnection/connection_sql_server.php');
	require_once('Warehouse.php');
	require_once('Ingredient.php');
	require_once('Measurement.php');

	class Stock
	{
		private $ingredient;
		private $warehouse;
		private $quantity;

		public function __construct()
		{
			$argsCount = func_num_args();
			if ($argsCount == 0) {
				$this->ingredient = new Ingredient();
				$this->warehouse = new Warehouse();
				$this->quantity = 0;
			}
			else{
				$args = func_get_args();
				if ($argsCount == 2) {
					$connection = new SqlServerConnection();
					$sql = sprintf('SELECT
															i.ing_id, i.ing_description,
																mu.meu_id, mu.meu_description,
														w.war_id, w.war_name,
														s.sto_quantity
													FROM stock s
													JOIN ingredients i ON s.sto_id_ing = i.ing_id
													JOIN warehouses w ON s.war_id = w.war_id
													JOIN measurementunits mu ON i.mu = mu.meu_id
													WHERE i.ing_id = %d and w.war_id = \'%s\'', $args[0], $args[1]);
					$data = $connection->execute_query($sql);
					$found = odbc_num_rows($data) > 0;
					if(!$found) throw new ItemInStockNotFoundException();
					while (odbc_fetch_array($data)) {
						$this->ingredient = new Ingredient(
																			odbc_result($data, 'ing_id'),
																			odbc_result($data, 'ing_description'),
																			new Measurement(
																				odbc_result($data, 'meu_id'),
																				odbc_result($data, 'meu_description')
																			)
																		);
						$this->warehouse = new Warehouse(
																		odbc_result($data, 'war_id'),
																		odbc_result($data, 'war_name')
																	);
						$this->quantity = odbc_result($data, 'sto_quantity');
					}
					$connection->close();
				}
				elseif ($argsCount == 3) {
					$this->ingredient = $args[0];
					$this->warehouse = $args[1];
					$this->quantity = $args[2];
				}
			}
		}

		public function get_ingredient(){return $this->ingredient;}
		public function set_ingredient($newVal)	{	$this->ingredient = $newVal;}

		public function get_warehouse(){return $this->warehouse;}
		public function set_warehouse($newVal)	{	$this->warehouse = $newVal;}

		public function get_quantity(){return $this->quantity;}
		public function set_quantity($newVal)	{	$this->quantity = $newVal;}

		public function get_all_stock(){
			$list = array();
			$connection = new SqlServerConnection();
			$sql ='SELECT i.ing_id, i.ing_description,mu.meu_id, mu.meu_description,w.war_id, w.war_name,s.sto_quantity
			FROM stock s JOIN ingredients i ON s.sto_id_ing = i.ing_id JOIN warehouses w ON s.war_id = w.war_id
			JOIN measurementunits mu ON i.mu = mu.meu_id';
			$data = $connection->execute_query($sql);
			$found = odbc_num_rows($data) > 0;
			if(!$found) throw new ItemInStockNotFoundException();
			while (odbc_fetch_array($data)) {
				$ingredient = new Ingredient(odbc_result($data, 'ing_id'),odbc_result($data, 'ing_description'),
				new Measurement(odbc_result($data, 'meu_id'),odbc_result($data, 'meu_description')));
				$warehouse = new Warehouse(odbc_result($data, 'war_id'),odbc_result($data, 'war_name'));
				$quantity = odbc_result($data, 'sto_quantity');
				array_push($list, new Stock($ingredient, $warehouse, $quantity));
			}
			$connection->close();
			return $list;
		}

		public function to_json(){
			return '{
				"ingredient":'.$this->ingredient->to_json().',
				"warehouse":'.$this->warehouse->to_json().',
				"quantity":'.$this->quantity.'
			}';
		}
	}
?>
