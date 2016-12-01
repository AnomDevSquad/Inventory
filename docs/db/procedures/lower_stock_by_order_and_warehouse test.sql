DECLARE @e int, @id int;
EXEC Sales.new_order 1, @e OUTPUT, @id OUTPUT
SELECT @e [error], @id [id];
GO

DECLARE @e int;
EXEC Inventory.order_lower_stock 35, 1, @e OUTPUT;
SELECT @e [error];
GO