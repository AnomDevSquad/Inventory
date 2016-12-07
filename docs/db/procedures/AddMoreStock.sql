-- 0: no hay error no hay error
-- 1: la cantidad recibida no puede ser menor o igual a 0
-- 2: no existe ese warehouse
-- 3: no existe ese ingrediente en el warehouse
-- 4: no hay suficiente espacio en el warehouse
ALTER PROCEDURE Inventory.AddMoreStock
	@INGID as int,
	@QTY as int,
	@WAREHOUSE as int,
	@ERROR as int OUTPUT
AS BEGIN
	DECLARE 
	@checkING as int,
	@checkWAR as int,
	@MAX as int,
	@TOT as int
	set @ERROR = 0;
	BEGIN TRAN
	IF (@QTY <= 0)
		BEGIN
			SET @error = 1;
			goto handleError;
		END
	SELECT @checkWAR = COUNT(war_id) FROM Inventory.warehouses WHERE war_id = @WAREHOUSE;
	IF(@checkWAR <> 1)
	BEGIN
		SET @ERROR = 2;
		GOTO handleError;
	END 	
	SELECT @checkING = COUNT(sto_id_ing) FROM Inventory.stock WHERE sto_id_ing = @INGID AND war_id = @WAREHOUSE;
	IF(@checkING <> 1)
	BEGIN
	 SET @ERROR = 3;
	 GOTO handleError;
	END 
	
	SELECT @MAX = sto_max FROM Inventory.stock WHERE sto_id_ing = @INGID and war_id = @WAREHOUSE;
	SELECT @TOT = (sto_quantity + @QTY) FROM Inventory.stock WHERE sto_id_ing = @INGID and war_id = @WAREHOUSE;
	
	IF(@TOT > @MAX)
	BEGIN
		SET @ERROR = 4;
		GOTO handleError;
	END
	
	UPDATE Inventory.stock SET sto_quantity = @TOT WHERE sto_id_ing = @INGID and war_id = @WAREHOUSE;
	SET @ERROR = @@ERROR;
	IF (@ERROR <> 0)
		BEGIN
			SET @ERROR = 999;
			GOTO handleError;
		END 
	INSERT INTO Inventory.movements values(@INGID,@WAREHOUSE,1,GETDATE(),@QTY);
	IF (@ERROR <> 0)
		BEGIN
			SET @ERROR = 999;
			GOTO handleError;
		END 
	COMMIT TRAN
	
handleError:
		IF(@error <> 0) ROLLBACK TRAN;
		goto returnError;
	returnError:
		RETURN @error;
END;

select * from Inventory.stock
declare @e as int
execute Inventory.AddMoreStock 1,32,1,@e output
select @e

select * from Inventory.movements