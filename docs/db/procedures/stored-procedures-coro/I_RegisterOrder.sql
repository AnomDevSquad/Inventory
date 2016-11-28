use inventory;
--drop procedure I_RegisterOrder

--results
--0 = No error. Order registered successfuly
--999 = Unknown error found. Something went wrong
CREATE procedure I_RegisterOrder
	@SUBTOTAL as money,
	@IVA as decimal(4,3),
	@ORDERID as int output,
	@RESULT as int OUTPUT
as
begin
	--variables
	declare
	@TOTAL as money,
	@ERROR as int
	
	begin tran --transaction
		set @RESULT = 0;  --initialize result
		set @TOTAL = (@IVA + 1) * @SUBTOTAL;
		
		
		select top 1 @ORDERID = ord_id from Sales.orders order by ord_id desc;
		if(@@ROWCOUNT > 0) 
		begin 
			set @ORDERID = @ORDERID + 1;
			
			insert into Sales.orders values(@ORDERID,GETDATE(),@SUBTOTAL,@IVA * @SUBTOTAL,@TOTAL,1);
			
			--ERROR HANDLER
			set @ERROR = @@ERROR;
			if (@ERROR <> 0) 
				begin
					set @RESULT = 999;
					goto handleError;
				end
		end
		else
		begin
			set @ORDERID = 1;
			insert into Sales.orders values(@ORDERID,GETDATE(),@SUBTOTAL,@IVA * @SUBTOTAL,@TOTAL,1);
			--ERROR HANDLER
		set @ERROR = @@ERROR;
		if (@ERROR <> 0) 
			begin
				set @RESULT = 999;
				goto handleError;
			end
		end
		
	commit tran; --make changes permanent
	return @ORDERID;
--error handler
handleError:
	if(@ERROR <> 0)	rollback tran; --revert changes	
--return result
returnResult:
	return @RESULT; --return result to application
end; -- end procedure
------------------------------------------------------------------------------------

DECLARE @orderid as int, @result as int;

exec I_RegisterOrder 20,.08, @orderid OUTPUT, @result OUTPUT;
select @orderid;

SELECT * FROM orders

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