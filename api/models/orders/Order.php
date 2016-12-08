<?php
require_once ('OrderDetail.php');
require_once ('/../exceptions/OrderNotFoundException.php');
require_once ('/../exceptions/NewOrderException.php');
require_once ('/../exceptions/SqlExecuteException.php');

class Order
{
	private $id, $date, $status, $subtotal, $tax_amount, $total, $orderdetails;
	public function __construct()
	{
		$argsCount = func_num_args();
		if($argsCount == 0){
			$this->id=-1;
			$this->date=new DateTime("0000-00-00");
			$this->subtotal = 0;
			$this->tax_amount = 0;
			$this->total = 0;
			$this->status = -1;
			$this->orderdetails = array();
		}
		else{
			$args = func_get_args();
			if($argsCount == 1){
				$this->id = -1;
				// inicializo los platillos como un array para agregarlos de la consulta
				$this->orderdetails = array();
				$connection = new SqlServerConnection();
				try{
					$sql = sprintf(
						"	SELECT	o.ord_id, o.ord_date, o.ord_subtotal, o.ord_iva, od.ord_total,
											od.dis_id, d.dis_name, d.dis_description, d.dis_price, od.ord_dis_quantity
						from Sales.orders o
						join Sales.order_dishes od on od.ord_id = o.ord_id
						join Kitchen.dishes d on d.dis_id = od.dis_id
						where o.ord_id = %d", $args[0]);
					$data = $connection->execute_query($sql);
					$order_details = array();
					$found = odbc_num_rows($data) > 0;
					if(!$found){ throw new OrderNotFoundException(); }
					while(odbc_fetch_array($data)){
						if($this->get_id() != odbc_result($data, 'ord_id')){
							$this->id = odbc_result($data, 'ord_id');
							$this->date = new DateTime(odbc_result($data, 'ord_date'));
							$this->subtotal = odbc_result($data, 'ord_subtotal');
							$this->tax_amount = odbc_result($data, 'ord_iva');
							$this->total = odbc_result($data, 'ord_total');
							$order_details = array();
						}
						$od = new OrderDetail(
										new Dish(
											odbc_result($data, 'dis_id'),
											odbc_result($data, 'dis_name'),
											odbc_result($data, 'dis_description'),
											odbc_result($data, 'dis_price')),
										odbc_result($data, 'ord_dis_quantity'));
						array_push($order_details, $od);
						$this->set_orderdetails($order_details);
					}
				}
				finally{
					$connection->close();
				}
			}
			elseif($argsCount == 3){
				$this->id=$args[0];
				$this->date=$args[1];
				$this->subtotal=$args[2];
				$this->orderdetails=array();
			}
			elseif($argsCount == 4){
				$this->id=$args[0];
				$this->date=$args[1];
				$this->subtotal=$args[2];
				$this->orderdetails=$args[3];
			}
			elseif($argsCount == 6){
				$this->id=$args[0];
				$this->date=$args[1];
				$this->subtotal=$args[2];
				$this->tax_amount = $args[3];
				$this->total = $args[4];
				$this->orderdetails = array();
				$this->status = $args[5];
			}
		}
	}
	public function get_id(){return $this->id;}
	public function set_id($newVal){$this->id = $newVal;}
	public function get_date(){return $this->date;}
	public function set_date($newVal){$this->date = $newVal;}
	public function get_subtotal(){return $this->subtotal;}
	public function set_subtotal($newVal){$this->subtotal = $newVal;}
	public function get_tax_amount(){return $this->tax_amount;}
	public function set_tax_amount($newVal){$this->tax_amount = $newVal;}
	public function get_total(){return $this->total;}
	public function set_total($newVal){$this->total = $newVal;}
	public function get_orderdetails(){ return $this->orderdetails; }
	public function set_orderdetails($newValue) { $this->orderdetails = $newValue; }
	public function get_status() { return $this->status; }
	public function set_status($newValue) { $this->status = $newValue; }
	public function to_json(){
		return '{
			"id":'.$this->get_id().',
			"date":"'.date_format($this->get_date(), 'Y/m/d H:i:s').'",
			"status":'.$this->get_status().',
			"subtotal":'.floatval($this->get_subtotal()).',
			"taxAmount":'.floatval($this->get_tax_amount()).',
			"total":'.floatval($this->get_total()).',
			"details":'.$this->details_to_json().'
		}';
	}
	private function details_to_json(){
			$json = '[
				';
				$first = true;
				foreach ($this->orderdetails as $orderdetail) {
					if(!$first) $json .= ','; else  $first = false;
					$json .= $orderdetail->to_json();
				}
			$json .= '
			]';
			return $json;
	}
	public function __toString(){ return $this->id; }

	public static function get_orders(){
		$list = array();
		$connection = new SqlServerConnection();
		try{
			$sql =
			'SELECT
				o.ord_id, o.ord_date, o.ord_status, o.ord_subtotal, o.ord_iva, o.ord_total,
				od.dis_id, d.dis_name, d.dis_description, d.dis_price, od.ord_dis_quantity
				from Sales.orders o
				join Sales.order_dishes od on od.ord_id = o.ord_id
				join Kitchen.dishes d on d.dis_id = od.dis_id
				order by o.ord_id desc';
			$data = $connection->execute_query($sql);
			$o = new Order();
			$order_details = array();
			while(odbc_fetch_array($data)){
				if($o->get_id() != odbc_result($data,'ord_id')) {
					$o_id = odbc_result($data, 'ord_id');
					$o_date = new DateTime(odbc_result($data, 'ord_date'));
					$o_status = odbc_result($data, 'ord_status');
					$o_subtotal = odbc_result($data, 'ord_subtotal');
					$o_tax_amount = odbc_result($data, 'ord_iva');
					$o_total = odbc_result($data, 'ord_total');
					$o = new Order($o_id, $o_date, $o_subtotal,$o_tax_amount, $o_total, $o_status);
					$order_details = array();
					array_push($list, $o);
				}
				$od = new OrderDetail(
								new Dish(
									odbc_result($data, 'dis_id'),
									odbc_result($data, 'dis_name'),
									odbc_result($data, 'dis_description'),
									odbc_result($data, 'dis_price')
								),
								odbc_result($data, 'ord_dis_quantity')
							);
				array_push($order_details, $od);
				$o->set_orderdetails($order_details);
			}
		}
		finally{
			$connection->close();
		}
		return $list;
	}
	public static function add_new_order($empployee, $dishes, $quantities){
		if(is_a($employee, 'Employee')){
			if(is_array($dishes)){
				$connection = new SqlServerConnection();
				$sql = sprintf(
					'
					DECLARE @e int, @id int;
					EXEC Sales.new_order %d,@e OUTPUT,@id OUTPUT;
					SELECT @e as error, @id as id;
					GO
					', $employee->get_id()
				);
				try{
					$data = $connection->execute_query($sql);
					$id = -1;
					while(odbc_fetch_array($data)){
						$error = odbc_result($data, 'error');
						if($error != 0) throw new NewOrderException();
						$id = odbc_result($data, 'id');
					}
					$sql = sprintf(
						'	SELECT [ord_id]
						      ,[ord_date]
						      ,[ord_subtotal]
						      ,[ord_iva]
						      ,[ord_total]
						      ,[ord_status]
						      ,[ord_employee_id]
						  FROM [Restaurant].[Sales].[orders]
							WHERE [ord_id] = %d
						GO
						', $id
					);
					$order = new Order();
					while(odbc_fetch_array($data)){
						$o_id = odbc_result($data, 'ord_id');
						$o_date = odbc_result($data, 'ord_date');
						$o_subtotal = odbc_result($data, 'ord_subtotal');
						$o_iva = odbc_result($data, 'ord_iva');
						$o_total = odbc_result($data, 'ord_total');
						$o_status = odbc_result($data, 'ord_status');
						$order = new Order($o_id, $o_date, $o_subtotal, $o_iva, $o_total, $o_status);
					}
					$procedure_add_dish ='DECLARE @e int, @m varchar(60);
					EXEC Sales.add_dish_to_order %d,%d,%d, @e OUTPUT;
					SELECT @e as [error];
					GO';
					$i = 0;
					foreach ($dishes as $dish_id) {
						$sql = sprintf($procedure_add_dish, $order->get_id(), $dish_id, $quantities[$i]);
						$data = $connection->execute_query($sql);
						while(odbc_fetch_array($data)){
							$error = odbc_result($data, 'error');
							switch ($error) {
								case 0:
									break;
								case 1:
									throw new OrderNotFoundException();
									break;
								case 2:
									throw new DishNotFoundException();
									break;
								default:
									throw new SqlExcecuteException();
							}
						}
						$i++;
					}
				}
				finally{
					$connection->close();
				}
			}
		}
	}
}
?>
