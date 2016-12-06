use inventory;
--drop procedure I_SaveIngredients

--results
--0 = No error. Order registered successfuly
--999 = Unknown error found. Something went wrong
alter procedure I_SaveIngredients
as
begin
	--variables
	declare
	@ERROR as int,
	@RESULT as int

	begin tran --transaction
		set @RESULT = 0;  --initialize result
		CREATE TABLE Inventory.[stockTemp]
		(
			[sto_id_ing] int PRIMARY KEY NOT NULL,
			[war_id] int NOT NULL,
			[sto_quantity] int NOT NULL,
			[sto_min] int NOT NULL,
			[sto_max] int
		);
		INSERT INTO Inventory.stockTemp select sto_id_ing, war_id, sto_quantity, sto_min, sto_max from Inventory.stock where war_id = 1;


		set @ERROR = @@ERROR;
		if (@ERROR <> 0)
			begin
				set @RESULT = 999;
				goto handleError;
			end

	commit tran; --make changes permanent
--error handler
handleError:
	if(@ERROR <> 0)	rollback tran; --revert changes
--return result
returnResult:
	return @RESULT; --return result to application
end; -- end procedure
------------------------------------------------------------------------------------

exec I_LowerStock01

select * from orders
select * from order_dishes
select * from dishes
select * from dish_ingredients
select * from ingredients
select * from stock order by war_id

select * from stock order by war_id, sto_id_ing
update stock set sto_quantity = 2000 where war_id = 'W01' and ing_id = @INGID;

update Ingredient set ing_cuantity = 2000

select di.ing_id, di.dis_ing_quantity, s.sto_quantity
from dish_ingredients di join stock s
on di.ing_id = s.sto_id_ing
where s.war_id = 'W01'
and di.dis_id = 1
