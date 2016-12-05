use inventory;
--drop procedure I_SaveIngredients

--results
--0 = No error. Order registered successfuly
--999 = Unknown error found. Something went wrong
CREATE procedure I_InsertMovements
as
begin
	--variables
	declare
	@ERROR as int,
	@RESULT as int

	begin tran --transaction
		set @RESULT = 0;  --initialize result

		DECLARE @INGID as int,
		@INGQUANTITY as int

		DECLARE Cursor_InsertMovements CURSOR FOR select s.sto_id_ing, st.sto_quantity - s.sto_quantity
																							from Inventory.stock s join Inventory.stockTemp st
																							on s.sto_id_ing = st.sto_id_ing
																							where s.war_id = 1
																							group by s.sto_id_ing, st.sto_quantity, s.sto_quantity
																							having (st.sto_quantity - s.sto_quantity) > 0
				Open Cursor_InsertMovements
				Fetch next from Cursor_InsertMovements into @INGID, @INGQUANTITY
				while @@FETCH_STATUS = 0
					begin
						if(@INGQUANTITY > 0)
						begin
							insert into Inventory.movements values(@INGID,1,2,GETDATE(),@INGQUANTITY);
						end
						Fetch next from Cursor_InsertMovements into @INGID, @INGQUANTITY
					end
				close Cursor_InsertMovements
				deallocate Cursor_InsertMovements
		drop table Inventory.stockTemp;
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
