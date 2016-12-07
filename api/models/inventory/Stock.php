<?php
	require_once('/../../sqlserverconnection/connection_sql_server.php');
	require_once('Warehouse.php');
	require_once('Ingredient.php');
	require_once('Measurement.php');
	require_once('/../exceptions/StockEmptyException.php');
	require_once('/../exceptions/ItemInStockNotFoundException.php');

	class Stock
	{
		private $ingredient, $warehouse, $quantity, $max, $min;

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
					$sql = sprintf(
					"	SELECT
							i.ing_id, i.ing_description,
							w.war_id, w.war_name,
							s.sto_quantity, s.sto_max, s.sto_min,
							m.meu_id, m.meu_description
						FROM Inventory.stock s
						JOIN Kitchen.ingredients i ON s.sto_id_ing = i.ing_id
						JOIN Inventory.warehouses w ON s.war_id = w.war_id
						JOIN Inventory.ingredient_measurements im ON i.ing_id = im.ims_id_ingredient
						JOIN Inventory.measurementunits m ON im.ims_id_measurement = m.meu_id
						WHERE i.ing_id = %d and w.war_id = '%s'", $args[0], $args[1]);
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
						$this->max = odbc_result($data, 'sto_max');
						$this->min = odbc_result($data, 'sto_min');
					}
					$connection->close();
				}
				elseif ($argsCount == 5) {
					$this->ingredient = $args[0];
					$this->warehouse = $args[1];
					$this->quantity = $args[2];
					$this->max = $args[3];
					$this->min = $args[4];
				}
			}
		}

		public function get_ingredient(){return $this->ingredient;}
		public function set_ingredient($newVal)	{	$this->ingredient = $newVal;}

		public function get_warehouse(){return $this->warehouse;}
		public function set_warehouse($newVal)	{	$this->warehouse = $newVal;}

		public function get_quantity(){return $this->quantity;}
		public function set_quantity($newVal)	{	$this->quantity = $newVal;}
		public function get_max(){return $this->max;}
		public function set_max($newVal)	{	$this->max = $newVal;}
		public function get_min(){return $this->min;}
		public function set_min($newVal)	{	$this->min = $newVal;}
		public function to_json(){
			return '{
				"ingredient":'.$this->ingredient->to_json().',
				"warehouse":'.$this->warehouse->to_json().',
				"quantity":'.$this->quantity.',
				"max":'.$this->max.',
				"min":'.$this->min.'
			}';
		}

	public static function get_all_stock(){
		$list = array();
		$connection = new SqlServerConnection();
		$sql =
		'	SELECT i.ing_id, i.ing_description,w.war_id, w.war_name,s.sto_quantity, s.sto_max, s.sto_min, m.meu_id, m.meu_description
			FROM Inventory.stock s
			JOIN Kitchen.ingredients i ON s.sto_id_ing = i.ing_id
			JOIN Inventory.warehouses w ON s.war_id = w.war_id
			JOIN Inventory.ingredient_measurements im ON i.ing_id = im.ims_id_ingredient
			JOIN Inventory.measurementunits m ON im.ims_id_measurement = m.meu_id';
		$data = $connection->execute_query($sql);
		if(odbc_num_rows($data) < 1) throw new StockEmptyException();
		while (odbc_fetch_array($data)) {
			$ingredient = new Ingredient(
				odbc_result($data, 'ing_id'),
				odbc_result($data, 'ing_description'),
				new Measurement(
					odbc_result($data, 'meu_id'),
					odbc_result($data, 'meu_description')
				)
			);
			$warehouse = new Warehouse(
				odbc_result($data, 'war_id'),
				odbc_result($data, 'war_name')
			);
			$quantity = odbc_result($data, 'sto_quantity');
			$min = odbc_result($data, 'sto_min');
			$max = odbc_result($data, 'sto_max');
			array_push($list, new Stock($ingredient, $warehouse, $quantity, $max, $min));
		}
		$connection->close();
		return $list;
	}


	public static function get_warehouse_stock($warehouse_id){
		$list = array();
		$connection = new SqlServerConnection();
		try{
			$sql =
			'	SELECT i.ing_id, i.ing_description,w.war_id, w.war_name,s.sto_quantity, s.sto_max, s.sto_min, m.meu_id, m.meu_description
				FROM Inventory.stock s
				JOIN Kitchen.ingredients i ON s.sto_id_ing = i.ing_id
				JOIN Inventory.warehouses w ON s.war_id = w.war_id
				JOIN Inventory.ingredient_measurements im ON i.ing_id = im.ims_id_ingredient
				JOIN Inventory.measurementunits m ON im.ims_id_measurement = m.meu_id
				WHERE im.ims_id_warehouse = %d AND w.war_id = %d';
			$sql = sprintf($sql, $warehouse_id, $warehouse_id);
			// echo $sql;
			$data = $connection->execute_query($sql);
			if(odbc_num_rows($data) < 1) throw new StockEmptyException();
			while (odbc_fetch_array($data)) {
				$ingredient = new Ingredient(
					odbc_result($data, 'ing_id'),
					odbc_result($data, 'ing_description'),
					new Measurement(
						odbc_result($data, 'meu_id'),
						odbc_result($data, 'meu_description')
					)
				);
				$warehouse = new Warehouse(
					odbc_result($data, 'war_id'),
					odbc_result($data, 'war_name')
				);
				$quantity = odbc_result($data, 'sto_quantity');
				$min = odbc_result($data, 'sto_min');
				$max = odbc_result($data, 'sto_max');
				array_push($list, new Stock($ingredient, $warehouse, $quantity, $max, $min));
			}
		}
		finally{
			$connection->close();
		}
		return $list;
	}
}
?>
