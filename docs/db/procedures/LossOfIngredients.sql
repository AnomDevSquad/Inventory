-- 0: no hay error
-- 1: no existe el almacen recibido
-- 2: no existe el ingrediente en el warehouse
-- 3: no hay suficiente existencias en el warehouse
-- 4: concepto no valido para este tipo de perdida
-- 999: error desconocido(usualmente de base de datos)
ALTER PROCEDURE Inventory.LossOfIngredient
  @INGID as int,
  @warehouse as int,
  @ing_qty as int,
  @concept as int,
  @error as int OUTPUT
  AS BEGIN
	DECLARE @validate_warehouse as int,
          @validate_ing as int,
          @validate_ing_qty as int,
          @validate_concept as int
    set @error = 0;
  BEGIN TRAN
	-- checar que exista el almacen
	SELECT @validate_warehouse = COUNT(war_id) FROM Inventory.warehouses WHERE war_id = @warehouse;

	-- checar que exista el ingrediente en el warehouse
	SELECT @validate_ing = COUNT(sto_id_ing) FROM Inventory.stock WHERE war_id = @warehouse and sto_id_ing = @INGID;

	-- checar que exista suficiente cantidad de existencias del ingrediente
	SELECT @validate_ing_qty = (sto_quantity - @ing_qty) FROM Inventory.stock WHERE war_id = @warehouse and sto_id_ing = @INGID;

		IF (@validate_warehouse <> 1)
		BEGIN
			SET @error = 1;
			goto handleError;
		END
		IF (@validate_ing <> 1)
		BEGIN
			SET @error = 2;
			goto handleError;
		END
		IF (@validate_ing_qty < 0)
		BEGIN
			SET @error = 3;
			goto handleError;
		END
		IF (@concept != 3 and @concept != 4 and @concept != 9 and @concept != 10)
		BEGIN
		  SET @error = 4;
		  goto handleError;
		END

		INSERT INTO Inventory.movements VALUES (@INGID,@warehouse,@concept,GETDATE(),@ing_qty);
		UPDATE Inventory.stock SET sto_quantity = (sto_quantity - @ing_qty) WHERE war_id = @warehouse and sto_id_ing = @INGID;
		set @error = @@ERROR;
		if(@error <> 0)
		BEGIN
			set @error = 999;
			goto handleError;
		END
	COMMIT TRAN

	handleError:
		IF(@error <> 0) ROLLBACK TRAN;
		goto returnError;
	returnError:
		RETURN @error;
END;



select * from Inventory.stock
select * from Inventory.movements

declare @e as int
execute Inventory.LossOfIngredient 1,1,4,9,@e output
select @e


--CONCEPTOS
--(3, 'Minimum losses '), (4, 'Maximum Losses'), (9,'Spoiled'), (10, 'Expiration');