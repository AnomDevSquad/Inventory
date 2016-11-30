SELECT 
	i.ing_id, i.ing_description,
	w.war_id, w.war_name,
	s.sto_quantity
FROM Inventory.stock s
JOIN Kitchen.ingredients i ON s.sto_id_ing = i.ing_id
JOIN Inventory.warehouses w ON s.war_id = w.war_id

SELECT * FROM Inventory.ingredient_measurements
SELECT * FROM Inventory.measurementunits
SELECT * FROM Inventory.warehouses
SELECT * FROM Kitchen.ingredients
SELECT * FROM Inventory.stock

INSERT INTO Inventory.ingredient_measurements VALUES
(2, 2, 'KG'),
(3, 1, 'G');
