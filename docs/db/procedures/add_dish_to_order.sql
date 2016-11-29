ALTER PROCEDURE Sales.add_dish_to_order 
	@order int, @dish int, @quantity int,
	@error int OUTPUT, @message VARCHAR(60) OUTPUT
AS BEGIN
	DECLARE 
		@subtotal money,
		@tax money, 
		@total money,
		@dishPrice money,
		@dishDetailQuantity int,
		@dish_order_count int;
	SET @dishPrice = (SELECT dis_price FROM Kitchen.dishes WHERE dis_id = @dish);
	SET @dish_order_count = (SELECT COUNT(ord_id) FROM Sales.order_dishes WHERE ord_id = @order AND dis_id = @dish);
	
	IF (@dish_order_count = 0) BEGIN
		INSERT INTO Sales.order_dishes VALUES (@dish, @order, GETDATE(), @quantity, @dishPrice);
	END
	ELSE BEGIN
		UPDATE Sales.order_dishes SET ord_dis_quantity = ord_dis_quantity + @quantity WHERE ord_id = @order AND dis_id = @dish;
	END
	
	SET @dishDetailQuantity = (SELECT ord_dis_quantity FROM Sales.order_dishes WHERE ord_id = @order AND dis_id = @dish);
	SET @subtotal = @dishDetailQuantity * @dishPrice;
	
	UPDATE Sales.orders SET ord_subtotal = @subtotal WHERE ord_id = @order;
	UPDATE Sales.orders SET ord_iva = ord_subtotal * .16 WHERE ord_id = @order;
	UPDATE Sales.orders SET ord_total = ord_iva + ord_subtotal WHERE ord_id = @order;
	SET @error = 0;
	SET @message = 'Success';
	
	RETURN @error;
	RETURN @message;
END

DECLARE @e int, @m varchar(60);
EXEC Sales.add_dish_to_order 1,4,1, @e OUTPUT, @m OUTPUT;
SELECT @e as [error], @m as [message]

SELECT * FROM Sales.order_dishes
SELECT * FROM Sales.orders
DELETE FROM Sales.order_dishes
DELETE FROM Sales.orders 