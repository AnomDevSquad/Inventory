--drop procedure I_LowerStock01

--results
--0 = No error. Stock lowered successfuly
--999 = Unknown error found. Something went wrong
create procedure I_LowerStock01
as
begin
	--variables
	declare
	@ORDERID as int,
	@DISHID as int,
	@DISHQUANTITY as int,
	@ERROR as int,
	@RESULT as int

	begin tran --transaction
		set @RESULT = 0;  --initialize result
		select top 1 @ORDERID = ord_id from Sales.orders order by ord_id desc;
		--ERROR HANDLER
		set @ERROR = @@ERROR;
		if (@ERROR <> 0)
			begin
				set @RESULT = 999;
				goto handleError;
			end
		DECLARE Cursor_GetAllDishes CURSOR FOR select dis_id, ord_dis_quantity from Sales.order_dishes where ord_id = @ORDERID
		Open Cursor_GetAllDishes
		Fetch next from Cursor_GetAllDishes into @DISHID, @DISHQUANTITY
		while @@FETCH_STATUS = 0
			begin
				declare
				@INGID as int,
				@STATICAMOUNT as int,
				@INGQUANTITY as int,
				@i as int
				set @i = 0;
				DECLARE Cursor_LowerStock CURSOR FOR select di.ing_id, di.dis_ing_quantity, s.sto_quantity
														from Kitchen.dish_ingredients di join Inventory.stock s
														on di.ing_id = s.sto_id_ing
														where s.war_id = 1
														and di.dis_id = @DISHID
				Open Cursor_LowerStock
				Fetch next from Cursor_LowerStock into @INGID, @STATICAMOUNT, @INGQUANTITY
				while @@FETCH_STATUS = 0
					begin
						while @i<@DISHQUANTITY
							begin
								set @INGQUANTITY = @INGQUANTITY - @STATICAMOUNT;
								set @i = @i + 1;
							end
						update Inventory.stock set sto_quantity = @INGQUANTITY where war_id = 1 and sto_id_ing = @INGID;
						set @i = 0;
						fetch next from Cursor_LowerStock into @INGID, @STATICAMOUNT, @INGQUANTITY
					end
				close Cursor_LowerStock
				deallocate Cursor_LowerStock

				set @ERROR = @@ERROR;
				if (@ERROR <> 0)
					begin
						set @RESULT = 999;
						goto handleError;
					end
				fetch next from Cursor_GetAllDishes into @DISHID, @DISHQUANTITY
			end
		close Cursor_GetAllDishes
		deallocate Cursor_GetAllDishes
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
