-- 0: no hay error
-- 1: no existe la orden
-- 2: no existe el platillo
ALTER PROCEDURE Sales.add_dish_to_order 
	@order int, @dish int, @quantity int,
	@error int OUTPUT
AS BEGIN
	DECLARE
		@subtotal money,
		@dishDetailQuantity int,
		@dishPrice money,
		@dish_order_count int,
		@order_count int,
		@dish_count int;
	SET @dishPrice = (SELECT dis_price FROM Kitchen.dishes WHERE dis_id = @dish);
	SET @dish_order_count = (SELECT COUNT(ord_id) FROM Sales.order_dishes WHERE ord_id = @order AND dis_id = @dish);
	SET @dish_count = (SELECT COUNT(dis_id) FROM Kitchen.dishes d WHERE d.dis_id = @dish);
	SET @dish_count = (SELECT ISNULL(@dish_count, 0));
	SET @order_count = (SELECT COUNT(o.ord_id) FROM Sales.orders o WHERE o.ord_id = @order);
	SET @order_count = (SELECT ISNULL(@order_count, 0));
	
	BEGIN TRANSACTION;
	IF (@order_count <> 1) BEGIN
		SET @error = 1;
		goto handleError;
	END
	ELSE BEGIN
		IF (@dish_count <> 1) BEGIN
			SET @error = 2;
			goto handleError;	
		END
		ELSE BEGIN
			IF (@dish_order_count = 0) BEGIN
				INSERT INTO Sales.order_dishes VALUES (@dish, @order, GETDATE(), @quantity, @dishPrice);
				SET @error = @@ERROR
				IF(@error <> 0) BEGIN
					SET @error = 999;
					goto handleError;
				END
			END
			ELSE BEGIN
				UPDATE Sales.order_dishes SET ord_dis_quantity = ord_dis_quantity + @quantity WHERE ord_id = @order AND dis_id = @dish;
				SET @error = @@ERROR
				IF(@error <> 0) BEGIN
					SET @error = 999;
					goto handleError;
				END
			END
			
			SET @dishDetailQuantity = (SELECT ord_dis_quantity FROM Sales.order_dishes WHERE ord_id = @order AND dis_id = @dish);
			SET @subtotal = @dishDetailQuantity * @dishPrice;
			
			UPDATE Sales.orders SET ord_subtotal = @subtotal WHERE ord_id = @order;
			SET @error = @@ERROR
			IF(@error <> 0) BEGIN
				SET @error = 999;
				goto handleError;
			END
			UPDATE Sales.orders SET ord_iva = ord_subtotal * .16 WHERE ord_id = @order;
			SET @error = @@ERROR
			IF(@error <> 0) BEGIN
				SET @error = 999;
				goto handleError;
			END
			UPDATE Sales.orders SET ord_total = ord_iva + ord_subtotal WHERE ord_id = @order;
			SET @error = @@ERROR
			IF(@error <> 0) BEGIN
				SET @error = 999;
				goto handleError;
			END
			SET @error = 0;
			goto returnError;
		END
	END
	COMMIT TRANSACTION;
	handleError:
		IF(@error = 0) goto returnError;
		ROLLBACK TRANSACTION;
	returnError:
		RETURN @error;
END

DECLARE @e int, @m varchar(60);
EXEC Sales.add_dish_to_order 2,8992,3, @e OUTPUT;
SELECT @e as [error]

SELECT * FROM Sales.order_dishes
SELECT * FROM Sales.orders
DELETE FROM Sales.order_dishes
DELETE FROM Sales.orders 