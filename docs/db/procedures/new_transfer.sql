-- 0: no hay error
-- 1: no existe alguno de los warehouse a los que se desea transferir
-- 2: no existe el ingrediente en alguno de los warehouse
-- 3: no hay suficiente existencias en el warehouseO
-- 4: el cantidad de ingrediente no cabe en el warehouse al que se quiere pasar
-- 5: el factor de conversion no se encuentra en las conversiones
-- 999: error desconocido(usualmente de base de datos)
ALTER PROCEDURE Inventory.new_transfer
	@warehouseO as int,
	@warehouseI as int,
	@ing_id as int,
	@ing_qty_out as int,
	@error int OUTPUT
AS BEGIN
	DECLARE @factor int, @qty_to_war_in int, @qty_stock_out int, @qty_stock_in int, @qty_stock_in_max int;
	SET @error = 0;
	BEGIN TRAN;
		IF(	ISNULL((SELECT war_id FROM Inventory.warehouses WHERE war_id = @warehouseO), 0) = 0
			OR ISNULL((SELECT war_id FROM Inventory.warehouses WHERE war_id = @warehouseI), 0) = 0 ) BEGIN
			SET @error = 1;
			goto handleError;
		END
		IF(	ISNULL((SELECT sto_id_ing FROM Inventory.stock s WHERE s.sto_id_ing = @ing_id AND s.war_id = @warehouseO),0) = 0
			OR ISNULL((SELECT sto_id_ing FROM Inventory.stock s WHERE s.sto_id_ing = @ing_id AND s.war_id = @warehouseI),0) = 0) BEGIN
			SET @error = 2;
			goto handleError;
		END
		SET @factor = ISNULL((SELECT c.cvn_factor_number FROM Inventory.conversions c WHERE c.cvn_from_id_ingredient = @ing_id AND c.cvn_from_id_warehouse = @warehouseO AND c.cvn_to_warehouse= @warehouseI), 0);
		SET @qty_stock_out = (SELECT s.sto_quantity FROM Inventory.stock s WHERE s.sto_id_ing = @ing_id AND s.war_id = @warehouseO);
		SET @qty_stock_in = (SELECT s.sto_quantity FROM Inventory.stock s WHERE s.sto_id_ing = @ing_id AND s.war_id = @warehouseI);
		SET @qty_stock_in_max = (SELECT s.sto_max FROM Inventory.stock s WHERE s.sto_id_ing = @ing_id AND s.war_id = @warehouseI);
		
		IF(@qty_stock_out < @ing_qty_out) BEGIN
			 SET @error = 3;
			 goto handleError;
		END
		IF((SELECT (@qty_stock_in + @qty_to_war_in)) > @qty_stock_in_max) BEGIN
			SET @error = 4;
			goto handleError;
		END		
		IF(@factor = 0) BEGIN
			SET @error = 5;
			goto handleError;
		END
		
		-- conversion
		IF(@warehouseI = 1) BEGIN
			SET @qty_to_war_in = @ing_qty_out * @factor;
		END
		ELSE BEGIN
			IF(@warehouseI = 2) BEGIN
				SET @qty_to_war_in = @ing_qty_out / @factor;
			END
		END
		
		
		INSERT INTO Inventory.movements VALUES (@ing_id, @warehouseO, 6, GETDATE(), @ing_qty_out);
		SET @error = @@ERROR;
		IF(@error <> 0) BEGIN
			SET @error = 999;
			goto handleError;
		END
			
		INSERT INTO Inventory.movements VALUES (@ing_id, @warehouseI, 5, GETDATE(), @qty_to_war_in);
		SET @error = @@ERROR;
		IF(@error <> 0) BEGIN
			SET @error = 999;
			goto handleError;
		END
		
		UPDATE Inventory.stock SET sto_quantity = sto_quantity - @ing_qty_out WHERE sto_id_ing = @ing_id AND war_id = @warehouseO;
		SET @error = @@ERROR;
		IF(@error <> 0) BEGIN
			SET @error = 999;
			goto handleError;
		END
		
		UPDATE Inventory.stock SET sto_quantity = sto_quantity + @qty_stock_in WHERE sto_id_ing = @ing_id AND war_id = @warehouseI;
		SET @error = @@ERROR;
		IF(@error <> 0) BEGIN
			SET @error = 999;
			goto handleError;
		END
		SET @error = 0;
	COMMIT TRAN;

	handleError:
		IF(@error <> 0) ROLLBACK TRAN;
	returnError:
		RETURN @error;
END