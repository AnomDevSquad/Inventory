ALTER PROCEDURE HumanResource.new_employee 
	@nickname varchar(50), @password varchar(32), @name varchar(50), @last_name varchar(50), @type char(5), @error int OUTPUT
AS
BEGIN
	DECLARE @newId int, @pass varchar(40);
	BEGIN TRAN
		SET @newId = ISNULL((SELECT TOP 1 emp_id FROM HumanResource.employees ORDER BY emp_id DESC), 0) + 1;
		SET @pass = (SELECT SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @password)), 3, 40));
		INSERT INTO HumanResource.employees VALUES (@newId, @name, @last_name, @type, @nickname, @pass);
		SET @error = @@ERROR;
		IF (@error <> 0) BEGIN
			SET @error = 999;
			goto handleError;
		END
		SET @error = 0;
	COMMIT TRAN
	handleError:
		if(@error <> 0) rollback tran;
	returnError:
		RETURN @error;
END

DECLARE @error int;
EXEC HumanResource.new_employee 'xentyo', '123456', 'Christian', 'Camacho', 'ADMIN', @error;
SELECT @error as error
	
	
	SELECT * FROM HumanResource.employees 