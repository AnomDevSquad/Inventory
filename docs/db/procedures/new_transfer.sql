-- 0: no hay error
-- 1: no existe alguno de los warehouse a los que se desea transferir
-- 2: no existe el ingrediente en alguno de los warehouse
-- 3: no hay suficiente existencias en el warehouseO
-- 999: error desconocido(usualmente de base de datos)
CREATE PROCEDURE Inventory.new_transfer
@warehouseO as int, @warehouseI as int, @ing_id as int, @ing_qty as int, @error int OUTPUT AS
BEGIN
	DECLARE @count_warehouses int, @validate_ing int, @validate_ing_qty int;
	-- checar que existan ambos warehouses
	SET @count_warehouses = (SELECT COUNT(war_id) FROM Inventory.warehouses WHERE war_id = @warehouseO AND war_id = @warehouseI);
	-- checar que ambos warehouses tengan ese ingrediente registrado
	SET @validate_ing = (SELECT COUNT(sto_id_ing) from Inventory.stock where war_id = @warehouseO AND war_id = @warehouseI);
	-- checar que exista suficiente cantidad a transferir en el warehouseO
	SET @validate_ing_qty = (SELECT sto_quantity - @ing_qty from Inventory.stock where war_id = @warehouseO and sto_id_ing = @ing_id);
	BEGIN TRAN;
		IF (@count_warehouses <> 2)
		BEGIN
			SET @error = 1;
			goto handleError;
		END
		IF (@validate_ing <> 0)
		BEGIN
			SET @error = 2;
			goto handleError;
		END
		IF (@validate_ing_qty < 0)
		BEGIN
			SET @error = 3;
			goto handleError;
		END
		INSERT INTO Inventory.movements VALUES (@ing_id,@warehouseO,6,GETDATE(),@ing_qty);
		UPDATE Inventory.stock SET sto_quantity = (sto_quantity - @ing_qty) WHERE war_id = @warehouseO and sto_id_ing = @ing_id;
		INSERT INTO Inventory.movements VALUES (@ing_id,@warehouseI,5,GETDATE(),@ing_qty);
		UPDATE Inventory.stock SET sto_quantity = (sto_quantity + @ing_qty) WHERE war_id = @warehouseI and sto_id_ing = @ing_id;
		set @error = @@ERROR;
		if(@error <> 0)
		BEGIN
			set @error = 999;
			goto handleError;
		END
	COMMIT TRAN;

	handleError:
		IF(@error <> 0) ROLLBACK TRAN;
	returnError:
		RETURN @error;
END

-- GO
-- CREATE PROCEDURE Inventory.kitchen_transfer @warehouseKitchen int, @error int OUTPUT AS
-- BEGIN
-- END
