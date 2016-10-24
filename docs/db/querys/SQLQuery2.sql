select * from warehouses
select * from stock
select * from movementconpects
select * from movements

SELECT 
	s.sto_id, 
		i.ing_id, i.ing_description, 
			mu.meu_id, mu.meu_description, 
	w.war_id, w.war_name,
	s.sto_quantity
FROM stock s
JOIN ingredients i ON s.sto_id_ing = i.ing_id
JOIN warehouses w ON s.war_id = w.war_id
JOIN measurementunits mu ON i.mu = mu.meu_id

SELECT i.ing_id, i.ing_description, mu.meu_id, mu.meu_description
from ingredients i
JOIN measurementunits mu on i.mu = mu.meu_id

