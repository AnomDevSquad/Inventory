-- error = 0 todo correcto :D
-- error = 51 la cantidad a transferir es mayor a la cantidad que hay en stock
-- error = 52 no existe el item del warehouse al que se desea transferir
-- error = 53 no existe el item en el warehouse del que se desea transferir
-- error = 54 no existe el warehouse al que se desea transferir
-- error = 55 no existe el warehouse del que se desea transferir
CREATE PROCEDURE warehouse_transfer @itmId as int, @warIdOut as char(3), @warIdIn as char(3), @quantity as int
AS BEGIN
	SET NOCOUNT ON;
	DECLARE @qtyInStockWarOut AS INT, @error as int, @itmIdCount as int, @warIdCount as int;
	SET @warIdCount = (SELECT COUNT(war_id) FROM warehouses WHERE war_id = @warIdOut);
	IF(@warIdCount = 1)
		BEGIN
			SET @warIdCount = (SELECT COUNT(war_id) FROM warehouses WHERE war_id = @warIdIn);
			IF(@warIdCount = 1)
				BEGIN
					SET @itmIdCount = (SELECT COUNT(sto_id_ing) FROM stock WHERE sto_id_ing = @itmId AND war_id = @warIdOut);
					IF(@itmIdCount = 1)
						BEGIN
							SET @itmIdCount = (SELECT COUNT(sto_id_ing) FROM stock WHERE sto_id_ing = @itmId AND war_id = @warIdIn);
							IF (@itmIdCount = 1)
								BEGIN
								SET @qtyInStockWarOut = (SELECT sto_quantity FROM stock WHERE sto_id_ing = @itmId AND war_id = @warIdOut);
								IF((@qtyInStockWarOut-@quantity)>0)
									BEGIN
										INSERT INTO movements VALUES (GETDATE(), @quantity, @warIdOut, @itmId, 6);
										INSERT INTO movements VALUES (GETDATE(), @quantity, @warIdIn, @itmId, 5);
										UPDATE stock SET sto_quantity = (sto_quantity - @quantity) WHERE war_id = @warIdOut and sto_id_ing = @itmId;
										UPDATE stock SET sto_quantity = (sto_quantity + @quantity) WHERE war_id = @warIdIn and sto_id_ing = @itmId;
										SET @error = 0;
									END
								ELSE
									BEGIN
										SET @error = 51;
									END
								END
							ELSE
								BEGIN
									SET @error = 52;
								END
						END
					ELSE
						BEGIN
							SET @error = 53;
						END
				END
			ELSE
				BEGIN
					SET @error = 54;
				END
		END
	ELSE
		BEGIN
			SET @error = 55;
		END
	SELECT @error as ERROR;
END
