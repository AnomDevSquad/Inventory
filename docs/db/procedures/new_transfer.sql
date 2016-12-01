-- 0: no hay error
-- 1: no existe alguno de los warehouse a los que se desea transferir
CREATE PROCEDURE Inventory.new_transfer @warehouseO int, @warehouseI int, @error int OUTPUT AS
BEGIN
	DECLARE @count_warehouses int;
	SET @count_warehouses = (SELECT COUNT(war_id) FROM Inventory.warehouses WHERE war_id = @warehouseO AND war_id = @warehouseI);
	BEGIN TRAN;
		IF (@count_warehouses <> 2) BEGIN
			SET @error = 1;
			goto handleError;
		END
		ELSE BEGIN
			
		END
	COMMIT TRAN;
	handleError:
		IF(@error = 0) goto returnError;
		ROLLBACK TRAN;
	returnError:
		RETURN @error;
END
GO
CREATE PROCEDURE Inventory.kitchen_transfer @warehouseKitchen int, @error int OUTPUT AS
BEGIN
END
