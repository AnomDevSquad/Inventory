
--1: QTY NO PUEDE SER MENOR A 0
--2: EL ING NO EXISTE
--3: EL WAR NO EXISTE
--4: LA QTY TIENE QUE SER MENOR AL MAX
CREATE PROCEDURE I_AddMoreStock
	@INGID as int,
	@QTY as int,
	@WAREHOUSE as int,
	@ERROR as int OUTPUT
AS BEGIN
	DECLARE 
	@MAX as int,
	@TOT as int
	
	BEGIN TRAN
	IF (@QTY <= 0)
		BEGIN
			SET @error = 1;
			goto handleError;
		END
	SELECT sto_id_ing FROM Inventory.stock WHERE sto_id_ing = @INGID;
	IF(@@ROWCOUNT = 0)
	BEGIN
	 SET @ERROR = 2;
	 GOTO handleError;
	END 
	SELECT war_id FROM Inventory.warehouses WHERE war_id = @WAREHOUSE;
	IF(@@ROWCOUNT = 0)
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
	SET @ERROR = 0;
	COMMIT TRAN
	
handleError:
		IF(@error <> 0) ROLLBACK TRAN;
	returnError:
		RETURN @error;
END;

