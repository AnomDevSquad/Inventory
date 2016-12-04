<?php
require_once ('/../../sqlserverconnection/connection_sql_server.php');


class StockStats
{
	private $ing;
	private $qty;

	function __construct() {
		$argsCount = func_num_args();
		if($argsCount == 0){
			$this->ing='';
			$this->qty=0;
		}
		if($argsCount == 2){
			$args = func_get_args();
			$this->ing=$args[0];
			$this->qty=$args[1];
		}
	}
	public function get_ing(){return $this->ing;}
	public function set_ing($newVal){$this->ing = $newVal;}
	public function get_qty(){return $this->qty;}
	public function set_qty($newVal){$this->qty = $newVal;}


	public function to_json(){ return ' { "ing":'.$this->get_ing().', "qty":"'.$this->get_qty().'"  }'; }


	public function get_kitchen_stock(){
		$list = array();
		$connection = new SqlServerConnection();

		$sql = sprintf("SELECT ki.ing_description AS Ing, s.sto_quantity AS Qty
										FROM Inventory.stock s JOIN Kitchen.ingredients ki
										ON s.sto_id_ing = ki.ing_id
										WHERE s.war_id = 1");
		$data = $connection->execute_query($sql);
		while (odbc_fetch_array($data)) {
			array_push($list, new StockStats(odbc_result($data, 'Ing'),odbc_result($data, 'Qty')));
		}
		$connection->close();
		return $list;
	}

	public function get_warehouse_stock(){
		$list = array();
		$connection = new SqlServerConnection();

		$sql = sprintf("SELECT ki.ing_description AS Ing, s.sto_quantity AS Qty
										FROM Inventory.stock s JOIN Kitchen.ingredients ki
										ON s.sto_id_ing = ki.ing_id
										WHERE s.war_id = 2");
		$data = $connection->execute_query($sql);
		while (odbc_fetch_array($data)) {
			array_push($list, new StockStats(odbc_result($data, 'Ing'),odbc_result($data, 'Qty')));
		}
		$connection->close();
		return $list;
	}

}
?>
