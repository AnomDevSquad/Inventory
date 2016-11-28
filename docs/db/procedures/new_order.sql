USE Restaurant GO
-- Para hacer un test
SELECT * FROM Sales.orders;
DELETE FROM Sales.orders;

-- Procedure
CREATE PROCEDURE Sales.new_order 
	@emp_id int, @error int OUTPUT, @message varchar(60) OUTPUT, @id int OUTPUT
AS BEGIN
	DECLARE @newId int;
	SET @newId = (SELECT COUNT(ord_id) FROM Sales.orders) + 1;
	
	INSERT INTO Sales.orders VALUES (@newId, GETDATE(), 0, 0, 0,1,@emp_id);
	SET @error = 0;
	SET @message = 'Success';
	SET @id = (SELECT TOP 1 ord_id FROM Sales.orders ORDER BY ord_id DESC);
	RETURN @error;
	RETURN @message;
	RETURN @id;
END
GO

-- Como se usa
DECLARE @e int, @m varchar(60), @id int;
EXEC Sales.new_order 1, @e output, @m output, @id output; 
SELECT @e as [error],@m as [message],@id as [id]

INSERT INTO HumanResource.employees VALUES(1,'Cajeta','Coronado', 'ADMIN', 'Alex', '123');