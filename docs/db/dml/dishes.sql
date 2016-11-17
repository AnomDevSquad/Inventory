insert into measurementunits values
('PC', 'Piece'), ('SLC', 'Slice'), ('KG', 'Kilogram'), ('G', 'Gram'),
('LT', 'Liter'), ('ML', 'Milliliter'), ('OZ', 'Ounces'), ('LVS', 'Leaves');

insert into dishes  values
(1, 'Japanese Cucumber Salad', 'Cucumber noodles seasoned with sesame vinaigrette and white soy',  5),
(2, 'Green salad', 'Gourmet lettuce with sesame dressing.', 5),
(3, 'Sashimi Salad Curry', 'Gourmet lettuce, slices of fresh fish, roasted garlic chips, soy dressing and curry oil.',  8),
(4, 'Tekka Don', 'Cuts of fresh tuna on sushi rice', 9),
(5, 'Teriyaki chicken', 'Cortes charcoal-grilled with teriyaki sauce', 12),
(6, 'Teriyaki Fish', 'Cortes charcoal-grilled with teriyaki sauce', 14),
(7, 'Fish karaage', 'Fresh fish marinated in sweet sake, ginger and served with ponzu sauce', 16),
(8, 'Fish Casserole', 'Fish fillets cooked casserole with creamy spicy sauce.', 12),
(9, 'Angel lobster', 'Lobster with special mustard sauce.', 25),
(10, 'Lobster Curry', 'Lobster with shiitake mushroom, julienne carrot, julienned green onion, habanero chile and sauce curry.', 28); 




insert into ingredients values
(1, 'Cucumber', 'PC'), (2,'Sesame Vinaigrette','ML'), (3, 'white soy', 'ML'),
--pepino				vinagreta de ajonjoli				soya blanca
(4, 'Escarole lettuce', 'LVS'), (5, 'Romaine lettuce', 'LVS'), (6, 'Oakleaf lettuce', 'LVS'),  (7, 'Sesame dressing', 'ML'),
--lechuga escarola				--lechuga romana				lehuga hoja de roble			--aderezo de ajonjoli
(8, 'Fish', 'PC'), (9, 'Roasted garlic', 'PC'), (10, 'Curry oil', 'ML'), (11, 'Soy dressing', 'ML'),
--pescado				--ajo rostizado				aceite de curry			aderezo de soya
(12, 'Fresh Fish', 'PC'), (13, 'sushi rice', 'G'), (14, 'Fresh Tuna', 'G'),
-- pescado fresco			arroz de sushi				atun fresco
(15, 'Teriyaki sauce', 'OZ'), (16, 'Chicken', 'G'),
-- salsa teriyaki					pollo
(17, 'Sweet sake', 'ML'), (18, 'Ginger', 'G'), (19, 'Ponzu sauce', 'OZ'), (20, 'creamy spicy sauce', 'ML'),
-- sake dulce					jengibre				salsa ponzu			salsa spicy cremosa
(21, 'special mustard sauce' , 'OZ'), (22, 'Lobster', 'PC'),
-- salsa especial de mostaza			langosta
(23, 'Shiitake mushroom ', 'PC'), (24, 'julienne carrot', 'G'), (25, 'julienned green onion', 'G'), (26, 'habanero chile', 'PC'), (27, 'curry sauce', 'ML');
--hongo shiitake					juliana de zanahoria			juliana de bebollin						dah!					salsa curry


insert into dish_ingredients values
(1, 1, 1), (2, 1, 30), (3, 1, 10),
(4, 2, 6), (5, 2, 3), (6, 2, 4), (7, 2, 30),
(4, 3, 6), (5, 3, 3), (6, 3, 4), (8, 3, 2), (9, 3, 2), (10, 3, 15), (11, 3, 10),
(13, 4, 300), (14, 4, 150),
(15, 5, 8), (16, 5, 400),
(15, 6, 8), (8, 6, 400),
(17, 7, 200), (18, 7, 100), (19, 7, 5), (12, 7, 4),
(20, 8, 500), (8, 8, 6),
(21, 9, 10), (22, 9, 1),
(23, 10, 8), (24, 10, 100), (25, 10, 100), (26, 10, 4), (27, 10, 150), (22, 10, 1);


select di.dis_id, d.dis_name, di.ing_id, i.ing_description from dishes d
join dish_ingredients di on  di.dis_id = d.dis_id
join ingredients i on i.ing_id = di.ing_id;

select i.ing_id, i.ing_description, mu.meu_id, mu.meu_description from ingredients i
join measurementunits mu on mu.meu_id = i.mu
