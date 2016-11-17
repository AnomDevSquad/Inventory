<?php
class Information
{
	private $id;
	private $description;

	function __construct()
	{
		switch(func_num_args()){
			case 0:
				$this->id= -1;
				$this->description="";
				break;
			case 2:
				$args = func_get_args();
				$this->id=$args[0];
				$this->description=$args[1];
				break;
		}
	}
	public function get_id() {	return $this->id;	}
	public function set_id($newVal) {	$this->id = $newVal; }
	public function get_description()	{	return $this->description; }
	public function set_description($newVal) { $this->description = $newVal; }
}
?>
