<?php
	require_once('/../../sqlserverconnection/connection_sql_server.php');
	require_once('MovementConcept.php');
	require_once('Stock.php');
	require_once('Ingredient.php');
	require_once('Measurement.php');
	require_once('Warehouse.php');
	require_once('MovementConcept.php');
	require_once('/../exceptions/MovementNotFoundException.php');

	class Movement
	{
		private $id;
		private $date;
		private $quantity;
		private $stock;
		private $movement_concept;

		public function __construct()
		{
			$argsCount = func_num_args();
			if ($argsCount  == 0) {
				$this->id = 0;
				$this->date = new DateTime();
				$this->quantity = 0;
				$this->warehouse = new Warehouse();
				$this->stock = new Stock();
				$this->movement_concept = new MovementConcept();
			}
			else{
				$args = func_get_args();
				if ($argsCount == 1) {
					$connection = new SqlServerConnection();
					try{
						$sql = sprintf('SELECT
											m.mov_id,
											m.mov_date,
											m.mov_quantity,
											s.sto_id_ing,
												i.ing_id, i.ing_description,
													mu.meu_id, mu.meu_description,
												w.war_id, w.war_name,
												s.sto_quantity,
											mc.mco_id, mc.mco_description, mc.mco_type
										FROM Inventory.movements m
										JOIN Inventory.movementconpects mc on m.mov_concept = mc.mco_id
										JOIN Inventory.stock s on m.mov_id_stock_ingredient = s.sto_id_ing
										JOIN Inventory.ingredients i on s.sto_id_ing = i.ing_id
										JOIN Inventory.measurementunits mu on i.mu = mu.meu_id
										JOIN Inventory.warehouses w on s.war_id = w.war_id
										WHERE m.mov_id = %d', $args[0]);
						$data = $connection->execute_query($sql);
						$found = odbc_num_rows($data) > 0;
						if(!$found) throw new MovementNotFoundException();
						while (odbc_fetch_array($data)) {
							$this->id = odbc_result($data, 'mov_id');
							$this->date = odbc_result($data, 'mov_date');
							$this->quantity = odbc_result($data, 'mov_quantity');
							$this->stock = new Stock(
								new Ingredient(odbc_result($data, 'ing_id'), odbc_result($data, 'ing_description'),
									new Measurement(odbc_result($data, 'meu_id'), odbc_result($data, 'meu_description'))
								),
								new Warehouse(odbc_result($data, 'war_id'), odbc_result($data, 'war_name')),
								odbc_result($data, 'sto_quantity')
							);
							$this->movement_concept = new MovementConcept(odbc_result($data, 'mco_id'),odbc_result($data, 'mco_description'), odbc_result($data, 'mco_type'));
						}
					}
					finally{
						$connection->close();
					}
				}
				elseif ($argsCount == 5) {
					$this->id = $args[0];
					$this->date = $args[1];
					$this->quantity = $args[2];
					$this->stock = $args[3];
					$this->movement_concept = $args[4];
				}
			}
		}

		public function get_id(){return $this->id;}
		public function set_id($newVal){$this->id = $newVal;}
		public function get_date(){return $this->date;}
		public function set_date($newVal){$this->date = $newVal;}
		public function get_quantity(){return $this->quantity;}
		public function set_quantity($newVal){$this->quantity = $newVal;}
		public function get_movement_concept(){return $this->movement_concept;}
		public function set_movement_concept($newVal){$this->movement_concept = $newVal;}
		public function get_stock(){return $this->stock;}
		public function set_stock($newVal){$this->stock = $newVal;}

		public function to_json(){
			return '{
				"id":'.$this->id.',
				"date":"'.$this->date.'",
				"quantity":'.$this->quantity.',
				"stock":'.$this->stock->to_json().',
				"movementConcept":'.$this->movement_concept->to_json().'
			}
			';
		}
		public function __toString(){
			return self::get_id();
		}

		public static function get_all_movements(){
			$list = array();
			$connection = new SqlServerConnection();
			try{
				$sql =
				"	SELECT m.mov_id, m.mov_date, m.mov_quantity, i.ing_id, i.ing_description,
					s.sto_quantity, mu.meu_id, mu.meu_description, w.war_id, w.war_name, mc.mco_id,
					mc.mco_description
					FROM Inventory.movements m
					JOIN Inventory.movementconcepts mc on m.mov_concept = mc.mco_id
					JOIN Inventory.stock s on s.sto_id_ing = m.mov_id_stock_ingredient
					JOIN Kitchen.ingredients i on i.ing_id = s.sto_id_ing
					JOIN Inventory.ingredient_measurements im on im.ims_id_ingredient = i.ing_id
					JOIN Inventory.measurementunits mu on mu.meu_id = im.ims_id_measurement
					JOIN Inventory.warehouses w on w.war_id = s.war_id";
				$data = $connection->execute_query($sql);
				while (odbc_fetch_array($data)) {
					$id = odbc_result($data, 'mov_id');
					$date = odbc_result($data, 'mov_date');
					$quantity = odbc_result($data, 'mov_quantity');
					$stock = new Stock(
							new Ingredient(
								odbc_result($data, 'ing_id'),
								odbc_result($data, 'ing_description'),
								new Measurement(
									odbc_result($data, 'meu_id'),
									odbc_result($data, 'meu_description')
								)
							),
							new Warehouse(
								odbc_result($data, 'war_id'),
								odbc_result($data, 'war_name')
							),
							odbc_result($data, 'sto_quantity')
						);
					$movement_concept = new MovementConcept(odbc_result($data, 'mco_id'),odbc_result($data, 'mco_description'));
					array_push($list, new Movement($id, $date, $quantity, $stock, $movement_concept));
				}
			}
			finally{
				$connection->close();
			}
			return $list;
		}
	}
?>
