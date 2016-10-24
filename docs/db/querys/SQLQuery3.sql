SELECT
								m.mov_id,
								m.mov_date, 
								m.mov_quantity,
								s.sto_id_ing,
									i.ing_id, i.ing_description,
										mu.meu_id, mu.meu_description,
									w.war_id, w.war_name,
								mc.mco_id, mc.mco_description, mc.mco_type
							FROM movements m
							JOIN movementconpects mc on m.mov_concept = mc.mco_id
							JOIN stock s on m.mov_id_stock_ingredient = s.sto_id_ing
							JOIN ingredients i on s.sto_id_ing = i.ing_id
							JOIN measurementunits mu on i.mu = mu.meu_id
							JOIN warehouses w on s.war_id = w.war_id