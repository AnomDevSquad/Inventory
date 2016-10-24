<?php
require_once ('/../inventory/Ingredient.php');
require_once ('/../../sqlserverconnection/connection_sql_server.php');
require_once('/../exceptions/DishNotFoundException.php');
require_once('/../kitchen/Recipe.php');

class Dish
{
	private $id;
	private $name;
	private $description;
	private $price;
	private $ingredients;

	function __construct() {
		$argsCount = func_num_args();
		if($argsCount == 0){
			$this->id=-1;
			$this->name="";
			$this->description="";
			$this->price=0;
			$this->ingredients = array();
		}
		else{
			$args = func_get_args();
			if($argsCount == 1){
			  $connection = new SqlServerConnection();
				try{
			    $sql = sprintf('SELECT dis_id, dis_name, dis_description, dis_price FROM dishes WHERE dis_id = %d', $args[0]);
			    $query = $connection->execute_query($sql);
			    $found = odbc_num_rows($query)>0;
			    if(!$found) throw new DishNotFoundException();
			    while(odbc_fetch_array($query)) {
				    $this->id = odbc_result($query, 'dis_id');
				    $this->name = odbc_result($query, 'dis_name');
				    $this->description = odbc_result($query, 'dis_description');
				    $this->price = odbc_result($query, 'dis_price');
					}
				}
				finally{
					$connection->close();
				}
			}
			elseif($argsCount == 4){
				$this->id = $args[0];
				$this->name = $args[1];
				$this->description = $args[2];
				$this->price = $args[3];
				$this->ingredients = array();
			}
			elseif($argsCount == 5){
				$this->id = $args[0];
				$this->name = $args[1];
				$this->description = $args[2];
				$this->price = $args[3];
				$this->ingredients = $args[4];
			}
		}
	}
	public function get_id(){return $this->id;}
	public function set_id($newVal){$this->id = $newVal;}
	public function get_name(){return $this->name;}
	public function set_name($newVal){$this->name = $newVal;}
	public function get_description(){return $this->description;}
	public function set_description($newVal){$this->description = $newVal;}
	public function get_price(){return $this->price;}
	public function set_price($newVal){$this->price = $newVal;}
	public function get_ingredients(){return $this->ingredients;}
	public function set_ingredients($newValue){$this->ingredients = $newValue;}
	public function add_ingredient($ingredient){
		if($ingredient instanceof Ingredient)
			array_push($this->ingredients, $ingredient);
	}
	public function remove_ingredient($ingredient){
		if($ingredient instanceof Ingredient){
			$removed = false;
			$count = -1;
			$toRemove = $count;
			foreach ($this->ingredients as $ing) {
				$count++;
				if(!$removed){
					if($ing->get_id() == $ingredient->get_id()){
						$toRemove = $count;
						$removed = true;
					}
				}
			}
			if($toRemove>-1)
				unset($this->ingredients[$toRemove]);
			return $removed;
		}
		else {
			return false;
		}
	}
	public function load_ingredients(){ echo 'not implemented'; }
	public function to_json(){
		return '{
			"id":'.$this->get_id().',
			"name":"'.$this->get_name().'",
			"description":"'.$this->get_description().'",
			"price":'.$this->get_price().',
			"ingredients":'.$this->ingredients_to_json().'
		}';
	}
	private function ingredients_to_json(){
		$json = '[
			';
			$first = true;
			foreach ($this->ingredients as $ingredient) {
				if(!$first) $json .= ','; else  $first = false;
				$json .= $ingredient->to_json();
			}
		$json .= '
			]';
		return $json;
	}
	public function __toString(){ return $this->name; }

	public function get_all_ingredients_per_dish(){
    $list = array();
    $connection = new SqlServerConnection();
    $sql = sprintf(
		'select i.ing_id, i.ing_description, di.dis_ing_quantity
		from ingredients i join dish_ingredients di on i.ing_id = di.ing_id
		join dishes d on d.dis_id = di.dis_id where d.dis_id = %d',$this->id);
    $query = $connection->execute_query($sql);
    $found = odbc_num_rows($query)>0;
	if(!$found) throw new DishNotFoundException();
    while (odbc_fetch_array($query)) {
      $ing = odbc_result($query, 'ing_id');
      $desc = odbc_result($query, 'ing_description');
      $quan = odbc_result($query, 'dis_ing_quantity');
      array_push($list, new Recipe($ing, $desc, $quan));
    }
    $connection->close();
    return $list;
  }
}
?>
