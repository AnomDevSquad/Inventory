<?php
require_once ('/sqlserverconnection/connection_sql_server.php');


class WeekSale
{
	private $total;
	private $day;

	function __construct() {
		$argsCount = func_num_args();
		if($argsCount == 0){
			$this->total=0;
			$this->day='';
		}
		if($argsCount == 2){
			$args = func_get_args();
			$this->total=$args[0];
			$this->day=$args[1];
		}
	}
	public function get_total(){return $this->total;}
	public function set_total($newVal){$this->total = $newVal;}
	public function get_day(){return $this->day;}
	public function set_day($newVal){$this->day = $newVal;}
	
	
	public function to_json(){ return ' { "total":'.$this->get_total().', "day":"'.$this->get_day().'"  }'; }
	

	public static function get_all_ws(){
		$list = array();
		$connection = new SqlServerConnection();

		$from = date("Y-m-d",strtotime('monday last week'));
		$to = date("Y-m-d",strtotime("sunday last week"));
		$sql = sprintf("SELECT COUNT(*) as Cantidad,CONVERT(date, ord_date) as Fecha FROM Sales.orders so 
						where so.ord_date >= '%s' and so.ord_date <= '%s'
						GROUP BY CONVERT(date, ord_date)",$from,$to);
		$data = $connection->execute_query($sql);
		while (odbc_fetch_array($data)) {
			array_push($list, new WeekSale(odbc_result($data, 'Cantidad'),odbc_result($data, 'Fecha')));
		}
		$connection->close();
		return $list;
	}
	
	public static function get_sum_sales(){
		$list = array();
		$connection = new SqlServerConnection();

		$from = date("Y-m-d",strtotime('monday last week'));
		$to = date("Y-m-d",strtotime("sunday last week"));
		$sql = sprintf("SELECT SUM(ord_total) as Cantidad,CONVERT(date, ord_date) as Fecha FROM Sales.orders so 
						where so.ord_date >= '%s' and so.ord_date <= '%s'
						GROUP BY CONVERT(date, ord_date)",$from,$to);
		$data = $connection->execute_query($sql);
		while (odbc_fetch_array($data)) {
			array_push($list, new WeekSale(odbc_result($data, 'Cantidad'),odbc_result($data, 'Fecha')));
		}
		$connection->close();
		return $list;
	}

	//COMO PUEDES TRAERLOS DE DIA A DIA Y POR PROMEDIO
	//INVESTIGA (Y SE PUEDE SEGUN INTERNET) COMO RECUPERAR LOS DATOS DATETIME SIN TIME
}
?>
