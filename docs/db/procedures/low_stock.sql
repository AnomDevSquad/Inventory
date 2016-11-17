CREATE PROCEDURE low_stock_by_dish
	@DishId as int
AS 
BEGIN
	DECLARE cursor_dish_ingredients CURSOR FOR 
		SELECT di.dis_id, d.dis_name, di.ing_id, i.ing_description FROM dishes d
		JOIN dish_ingredients di ON di.dis_id = d.dis_id
		JOIN ingredients i ON di.ing_id = i.ing_id;
	BEGIN TRAN
	
	COMMIT TRAN;
END