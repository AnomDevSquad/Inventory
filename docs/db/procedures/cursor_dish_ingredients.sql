SELECT di.dis_id FROM dishes d
JOIN dish_ingredients di ON di.dis_id = d.dis_id
JOIN ingredients i ON di.ing_id = i.ing_id;