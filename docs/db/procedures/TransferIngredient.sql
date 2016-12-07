--TRANSFER INGREDIENT
-- 0: no hay error
-- 1: no existe alguno de los warehouses
-- 2: los warehouses no se pueden transferir a si mismos
-- 3: no existe ese ingrediente
-- 4: no hay suficiente existencias en el warehouseO
-- 5: el ingrediente no se pudo registrar en warehouseI
-- 6: el cantidad de ingrediente no cabe en el warehouse al que se quiere pasar
-- 999: error desconocido(usualmente de base de datos)
ALTER PROCEDURE Inventory.TransferIngredient
	@warehouseO as int,
	@warehouseI as int,
	@INGID as int,
	@INGQTY as int
AS
BEGIN
  DECLARE
  @checkEnoughStock as int,
  @checkEnoughSpace as int,
  @stockInWarI as int,
  @checkIng as int,
  @error as int
  BEGIN TRAN
  set @error = 0;
    IF(	ISNULL((SELECT war_id FROM Inventory.warehouses WHERE war_id = @warehouseO), 0) = 0
		OR ISNULL((SELECT war_id FROM Inventory.warehouses WHERE war_id = @warehouseI), 0) = 0 )
		BEGIN
			SET @error = 1;
			goto handleError;
		END
	IF(@warehouseO = @warehouseI)
		BEGIN
			SET @error = 2;
			goto handleError;
		END
	SELECT @checkIng = COUNT(sto_id_ing) FROM Inventory.stock WHERE war_id = @warehouseO AND sto_id_ing = @INGID;
	IF(@checkIng <> 1)
		BEGIN
			SET @error = 3;
			goto handleError;
		END
	SELECT @checkEnoughStock = sto_quantity FROM Inventory.stock WHERE war_id = @warehouseO AND sto_id_ing = @INGID;
	IF(@INGQTY > @checkEnoughStock)
		BEGIN
			SET @error = 4;
			goto handleError;
		END
	SELECT @checkIng = COUNT(sto_id_ing) FROM Inventory.stock WHERE war_id = @warehouseI AND sto_id_ing = @INGID;
	IF(@checkIng = 1)
		BEGIN
			SELECT @checkEnoughSpace = sto_max, @stockInWarI = sto_quantity FROM Inventory.stock WHERE war_id = @warehouseI AND sto_id_ing = @INGID;
			IF((@INGQTY + @stockInWarI) > @checkEnoughSpace)
				BEGIN
					SET @error = 6;
					goto handleError;
				END
			ELSE
				BEGIN
					Update Inventory.stock SET sto_quantity = sto_quantity + @INGQTY WHERE war_id = @warehouseI AND sto_id_ing = @INGID;
					set @error = @@ERROR;
					IF(@error <> 0)
						BEGIN
							set @error = 5;
							goto handleError;
						END
					Update Inventory.stock SET sto_quantity = sto_quantity - @INGQTY WHERE war_id = @warehouseO AND sto_id_ing = @INGID;
					set @error = @@ERROR;
					IF(@error <> 0)
						BEGIN
							set @error = 999;
							goto handleError;
						END
				END
		END
	ELSE
		BEGIN
			INSERT INTO Inventory.stock VALUES(@INGID,@warehouseI,@INGQTY,0,100);
			set @error = @@ERROR;
			IF(@error <> 0)
				BEGIN
					set @error = 5;
					goto handleError;
				END
			Update Inventory.stock SET sto_quantity = sto_quantity - @INGQTY WHERE war_id = @warehouseO AND sto_id_ing = @INGID;
			set @error = @@ERROR;
			IF(@error <> 0)
				BEGIN
					set @error = 999;
					goto handleError;
				END
		END

  COMMIT TRAN;

handleError:
  IF(@error <> 0) ROLLBACK TRAN;
  goto returnError;
returnError:
  return @error;
END
