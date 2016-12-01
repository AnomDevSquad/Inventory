-- errors
-- 0	: orden bajada de stock correctamnte
-- 1	: la orden que se desea bajar en stock no se encuentra
-- 2	: el status de la orden esta como ya bajado
-- 3	: no existen ingredeientes que se puedan bajar del stock
-- 4	: no existen todos los ingredientes de la orden
-- 999	: el stock no se pudo bajar
ALTER PROCEDURE Inventory.order_lower_stock @order int, @warehouse int, @error int OUTPUT AS
BEGIN
	DECLARE @ing_id int,
			@ord_qty int,
			@dish_qty int,
			@dish_qty_by_ord int,
			@qty_to_update int,
			@count_ingredeints_to_update int,
			@current_stock int;
	SET @count_ingredeints_to_update = (SELECT COUNT(ing_id) 
										FROM Inventory.orders_dishes_ingredients i 
										JOIN Inventory.stock s ON i.ing_id = s.sto_id_ing 
										WHERE i.ord_id = @order AND s.war_id = @warehouse);
	SET @count_ingredeints_to_update = (SELECT ISNULL((@count_ingredeints_to_update), 0));
	BEGIN TRANSACTION;
		IF((SELECT COUNT(ord_id) FROM Sales.orders WHERE ord_id = @order) <> 1) BEGIN
			SET @error = 1;
			goto handleError;
		END
		ELSE BEGIN
			IF((SELECT ord_status FROM Sales.orders WHERE ord_id = @order) = 0)	BEGIN
				SET @error = 2;
				goto handleError;
			END
			ELSE BEGIN
				IF(@count_ingredeints_to_update = 0) BEGIN
					SET @error = 3;
					goto handleError;
				END
				ELSE BEGIN
					DECLARE cursor_select CURSOR FOR 
						SELECT
							i.ing_id, i.ord_dis_quantity, i.dis_ing_quantity, i.ord_dis_quantity * i.dis_ing_quantity as [quantity_to_update]  
						FROM Inventory.orders_dishes_ingredients i WHERE i.ord_id = @order ORDER BY i.ing_id;
					OPEN cursor_select;
					FETCH NEXT FROM cursor_select INTO @ing_id, @ord_qty, @dish_qty, @dish_qty_by_ord
					WHILE @@FETCH_STATUS = 0
					BEGIN
						UPDATE Inventory.stock SET sto_quantity = (sto_quantity - @dish_qty_by_ord) WHERE sto_id_ing = @ing_id and war_id = @warehouse;
						SET @error = @@ERROR;
						IF(@error <> 0) BEGIN
							SET @error = 999;
							goto handleError;
						END	
						INSERT INTO Inventory.movements VALUES (@ing_id, @warehouse, 2, GETDATE(), @dish_qty_by_ord);
						SET @error = @@ERROR;
						IF(@error <> 0) BEGIN
							SET @error = 999;
							goto handleError;
						END	
						FETCH NEXT FROM cursor_select INTO @ing_id, @ord_qty, @dish_qty, @dish_qty_by_ord
					END
					CLOSE cursor_select
					DEALLOCATE cursor_select
					UPDATE Sales.orders SET ord_status = 0 WHERE ord_id = @order;
					SET @error = @@ERROR;
					IF(@error <> 0) BEGIN
						SET @error = 999;
						goto handleError;
					END
				END
			END
		END
	COMMIT TRANSACTION;
	
	handleError:
		IF(@error = 0) BEGIN
			goto returnError;
		END
		ROLLBACK TRANSACTION;
	returnError:
		RETURN @error;
END