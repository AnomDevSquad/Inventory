-- 0: no hay error
-- 1: no existe alguno de los warehouse a los que se desea transferir
-- 2: no existe el ingrediente en alguno de los warehouse
-- 3: no hay suficiente existencias en el warehouseO
-- 4: el warehouse no se puede mandar a si mismo
-- 999: error desconocido(usualmente de base de datos)
CREATE PROCEDURE Inventory.new_transfer
	@warehouseO as int,
	@warehouseI as int,
	@ing_id as int,
	@ing_qty as int,
	@error int OUTPUT
AS BEGIN
	DECLARE @warehouseFrom as int,
			@warehouseTo as int,
			@validate_ing as int,
			@validate_ing2 as int,
			@validate_ing_qty as int
	BEGIN TRAN
	-- checar que existan ambos warehouses
	SELECT @warehouseFrom = war_id FROM Inventory.warehouses WHERE war_id = @warehouseO;
	SELECT @warehouseTo = war_id FROM Inventory.warehouses WHERE war_id = @warehouseI;

	-- checar que ambos warehouses tengan ese ingrediente registrado
 	SELECT @validate_ing = sto_id_ing FROM Inventory.stock where war_id = @warehouseO AND sto_id_ing = @ing_id;
	SELECT @validate_ing2 = sto_id_ing FROM Inventory.stock where war_id = @warehouseI AND sto_id_ing = @ing_id;

	-- checar que exista suficiente cantidad a transferir en el warehouseO
	SELECT @validate_ing_qty = (sto_quantity - @ing_qty) from Inventory.stock where war_id = @warehouseO AND sto_id_ing = @ing_id;

		IF (@warehouseFrom <> @warehouseO and @warehouseTo <> @warehouseI)
		BEGIN
			SET @error = 1;
			goto handleError;
		END
		IF (@validate_ing <> @validate_ing2)
		BEGIN
			SET @error = 2;
			goto handleError;
		END
		IF (@validate_ing_qty < 0)
		BEGIN
			SET @error = 3;
			goto handleError;
		END
		IF (@warehouseO = @warehouseI)
		BEGIN
			SET @error = 4;
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
END;
