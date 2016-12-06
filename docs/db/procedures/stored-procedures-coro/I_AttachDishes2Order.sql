use inventory;
--drop procedure I_AttachDishes2Order

--results
--0 = No error. Order registered successfuly
--999 = Unknown error found. Something went wrong
ALTER procedure I_AttachDishes2Order
	@ORDERID as int,
	@DISHID as int,
	@QUANTITY as int
as begin
	--variables
	declare
	@VALUE as money,
	@ERROR as int,
	@RESULT as int
	
	begin tran --transaction
		set @RESULT = 0;  --initialize result
		
		select ord_dis_quantity from Sales.order_dishes where ord_id = @ORDERID and dis_id = @DISHID;
		if (@@ROWCOUNT = 0) 
			begin
				select @VALUE = dis_price from Kitchen.dishes where dis_id = @DISHID;
				insert into Sales.order_dishes(ord_id,dis_id,ord_dis_quantity,ord_dis_date,dis_dis_subtotal) values(@ORDERID,@DISHID,@QUANTITY,GETDATE(),@VALUE);
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

execute FF_AddOrder 4
execute I_LowerStock 'Cheese Burger'
execute I_LowerStock 'Cheese Burger'

select * from Orders
select * from Order_Product
