CREATE VIEW Inventory.orders_dishes_ingredients AS
SELECT 
	o.ord_id, o.ord_date,
	od.dis_price AS [dis_price_sold], od.ord_date as [ord_dish_date], od.ord_dis_quantity, 
	d.dis_id, d.dis_name, d.dis_description, d.dis_price,
	i.ing_id, i.ing_description,
	di.dis_ing_quantity, di.measurement
FROM Sales.orders o
JOIN Sales.order_dishes od ON o.ord_id = od.ord_id
JOIN Kitchen.dishes d ON od.dis_id = d.dis_id
JOIN Kitchen.dish_ingredients di ON d.dis_id = di.dis_id
JOIN Kitchen.ingredients i ON di.ing_id = i.ing_id
ORDER BY o.ord_id