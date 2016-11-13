<?php
require_once('/../../sqlserverconnection/connection_sql_server.php');
require_once ('/../general/Information.php');
require_once ('Measurement.php');

class Ingredient extends Information
{
	private $measurement;
	public function __construct()
	{
		parent::__construct();
		if (func_num_args() == 0) {
			$this->measurement= new Measurement();
		}
		else{
			$args = func_get_args();
			if (func_num_args() == 1) {
				$connection = new SqlServerConnection();
				$sql = sprintf(
				"	SELECT 	i.ing_id, i.ing_description,
									mu.meu_id, mu.meu_description
					FROM Kitchen.ingredients i
					JOIN Inventory.measurementunits mu on i.mu = mu.meu_id
					WHERE ing_id = %d", $args[0]);
				$data = $connection->execute_query($sql);
				$found = odbc_num_rows($data) > 0;
				if(!$found){ throw new IngredientNotFoundException(); }
				while (odbc_fetch_array($data)) {
					$this->set_id(odbc_result($data, 'ing_id'));
					$this->set_description(odbc_result($data, 'ing_description'));
					$this->measurement = new Measurement(
																	odbc_result($data, 'meu_id'),
																	odbc_result($data, 'meu_description')
																);
				}
				$connection->close();
			}
			elseif (func_num_args() == 3) {
				$this->set_id($args[0]);
				$this->set_description($args[1]);
				$this->measurement= $args[2];
			}
		}
	}
	public function get_measurement(){return $this->measurement;}
	public function set_measurement($newValue){$this->measurement = $newValue;}

	public function to_json(){
		return '{
			"id":'.$this->get_id().',
			"description":"'.$this->get_description().'",
			"measurement":'.$this->measurement->to_json().'
		}';
	}

	public function __toString(){
		return self::get_description();
	}
}
?>
