insert into kitchen.category values (1, 'Entrace'),
									(2, 'Sushi and Sashimi'),
									(3, 'Main Course'),
									(4, 'Tempura'),
									(5, 'Drinks');


insert into Kitchen.dishes  values  
--Entrace
(1, 'Japanese Cucumber Salad', 'Cucumber noodles seasoned with sesame vinaigrette and white soy',  5, 1),
(2, 'Green salad', 'Gourmet lettuce with sesame dressing.', 5, 1),
(3, 'Sashimi Salad Curry', 'Gourmet lettuce, slices of fresh fish, roasted garlic chips, soy dressing and curry oil.', 8, 1),
--SUSHI AND SASHIMI
(4, 'Tekka Don', 'Cuts of fresh tuna on sushi rice', 9, 2),
(11, 'Sushi Combination', '10 assorted pieces of fish and seafood', 12, 2),
(12, 'Chirashi Sushi', 'Rice base decorated with variety of fish', 14, 2),
(13, 'Mixed Sashimi', 'Variety of sliced fresh fish', 15, 2),
--MAIN COURSE
(5, 'Teriyaki chicken', 'Cortes charcoal-grilled with teriyaki sauce', 12, 3), 
(6, 'Teriyaki Fish', 'Cortes charcoal-grilled with teriyaki sauce', 14, 3),
(8, 'Fish Casserole', 'Fish fillets cooked casserole with creamy spicy sauce.', 12, 3),
(9, 'Angel lobster', 'Lobster with special mustard sauce.', 25, 3),
(10, 'Lobster Curry', 'Lobster with shiitake mushroom, julienne carrot, julienned green onion, habanero chile and sauce curry.', 28, 3),
--TEMPURA
(7, 'Fish karaage', 'Fresh fish marinated in sweet sake, ginger and served with ponzu sauce', 16, 4),
(14, 'Chicken tempura', 'Chicken marinated in creamy spicy sauce and ginger', 10, 4),


 
insert into Inventory.measurementunits values 
('PC', 'Piece'), ('SLC', 'Slice'), ('KG', 'Kilogram'), ('G', 'Gram'),
('LT', 'Liter'), ('ML', 'Milliliter'), ('OZ', 'Ounces'), ('LVS', 'Leaves');


insert into Kitchen.ingredients values 
(1, 'Cucumber'), (2,'Sesame Vinaigrette'), (3, 'white soy'),
--pepino				vinagreta de ajonjoli				soya blanca 
(4, 'Escarole lettuce'), (5, 'Romaine lettuce'), (6, 'Oakleaf lettuce'),  (7, 'Sesame dressing'),
--lechuga escarola				--lechuga romana				lehuga hoja de roble			--aderezo de ajonjoli
(8, 'Fish'), (9, 'Roasted garlic'), (10, 'Curry oil'), (11, 'Soy dressing'),
--pescado				--ajo rostizado				aceite de curry			aderezo de soya
(12, 'Fresh Fish'), (13, 'sushi rice'), (14, 'Fresh Tuna'),
-- pescado fresco			arroz de sushi				atun fresco
(15, 'Teriyaki sauce'), (16, 'Chicken Breast'),
-- salsa teriyaki					pollo
(17, 'Sweet sake'), (18, 'Ginger'), (19, 'Ponzu sauce'), (20, 'creamy spicy sauce'),
-- sake dulce					jengibre				salsa ponzu			salsa spicy cremosa
(21, 'special mustard sauce' ), (22, 'Lobster'),
-- salsa especial de mostaza			langosta
(23, 'Shiitake mushroom '), (24, 'julienne carrot'), (25, 'julienned green onion'), (26, 'habanero chile'), (27, 'curry sauce'),
--hongo shiitake					juliana de zanahoria			juliana de bebollin						dah!					salsa curry
(28, 'Butterfish'), (29, 'Red tuna'), (30, 'Mackerel'), (31, 'Salmon'), (32, 'Eel'),
--Pez mantequilla		atun rojo		pescado caballa		salmon			anguila
(33, 'Ground pepper'), (34, 'Cornmeal');
--pimienta molida		harina de maiz


insert into  Kitchen.dish_ingredients values 
(1, 1, 'PC',1), (2, 1,'ML', 30), (3, 1, 'ML',10),
(4, 2,'LVS',6), (5, 2,'LVS', 3), (6, 2, 'LVS', 4), (7, 2, 'ML', 30), 
(4, 3, 'LVS', 6), (5, 3, 'LVS', 3), (6, 3,'LVS', 4), (8, 3,'PC', 2), (9, 3, 'PC', 2), (10, 3, 'ML',  15), (11, 3,'ML', 10),
(13, 4,'G', 300), (14, 4, 'G',150),
(15, 5, 'OZ', 8), (16, 5,'G', 400),
(15, 6,'OZ', 8), (8, 6,'PC' ,4),
(17, 7,'ML', 200), (18, 7, 'G' ,100), (19, 7, 'OZ', 5), (12, 7, 'PC', 4),
(20, 8, 'ML', 500), (8, 8, 'PC',6),
(21, 9, 'OZ', 10), (22, 9, 'PC',1),
(23, 10,'PC', 8), (24, 10, 'G' ,100), (25, 10, 'G', 100), (26, 10, 'PC' ,4), (27, 10, 'ML',150), (22, 10, 'PC', 1),
(28, 11, 'PC', 1),  (29, 11, 'PC', 1), (31, 11, 'PC', 1), (32, 11, 'PC', 1), (13, 11, 'G', 300), (27, 11, 'ML', 10),
(13, 12, 'G', 500), (28, 12, 'PC', 1), (29, 12, 'PC', 1), (30, 12, 'PC', 1), (31, 12, 'PC', 1), (20, 12, 'OZ', 6),
(28, 13, 'PC', 2), (29, 13, 'PC', 1), (30, 13, 'PC', 3),(31, 13, 'PC', 2), (32, 13, 'PC', 2), (20, 13, 'OZ', 3),
(33, 14, 'G', 2), (34, 14, 'G', 50), (16, 14, 'PC', 2), (18, 14, 'G', 30), (20, 14, 'ML', 18); 

