

insert into Inventory.measurementunits values ('B', 'Box'), ('GL', 'Galon');



UPDATE Kitchen.dish_ingredients SET measurement='OZ' WHERE ing_id=20 AND dis_id=8;
UPDATE Kitchen.dish_ingredients SET dis_ing_quantity=8 WHERE ing_id=20 AND dis_id=8;
UPDATE Kitchen.dish_ingredients SET measurement='OZ' WHERE ing_id=20 AND dis_id=14;
UPDATE Kitchen.dish_ingredients SET dis_ing_quantity=12 WHERE ing_id=20 AND dis_id=14;
UPDATE KITCHEN.dish_ingredients SET measurement='G' where ing_id=16 and dis_id=14
update Kitchen.dish_ingredients set dis_ing_quantity=500 where ing_id=16 and dis_id=14



insert into Inventory.warehouses values (1, 'Kitchen'), (2, 'Warehouse'); --En caso de no tener registros en warehouse incluir...


insert into Inventory.ingredient_measurements values 
(2, 1, 'ML'),
(4, 1, 'LVS'),
(5, 1, 'LVS'),
(6, 1, 'LVS'),
(1,1, 'PC'),
(1,2,'B'),
(2,2, 'GL'),
(3,2,'GL'),
(3,1, 'ML'),
(4,2,'B'),
(5,2,'B'),
(6,2, 'B'),
(7, 1, 'ML'), 
(7,2, 'GL'),
(8,1,'PC'),
(8,2,'B'),
 (9, 1, 'PC'),
 (9, 2, 'B'),
 (10, 1, 'ML'),
 (10,2, 'GL'),
(11, 1, 'ML'),
(11,2, 'GL'),
(12,1, 'PC'),
(12,2, 'B'),
(13, 1, 'G'),
(13,2, 'KG'),
(14, 1, 'G'),
(14,2, 'KG'),
(15,1, 'OZ'),
(15,2,'GL'),
(16, 1, 'G'),
(16, 2, 'B'),
(17, 1, 'ML' ),
(17,2, 'GL'),
(18, 1, 'G'),
(18, 2, 'KG'),
(19, 1, 'OZ'),
(19, 2, 'GL'),
(20, 1, 'OZ'),
(20,2, 'GL'),
(21, 1, 'OZ'),
(21, 1, 'GL'),
(22, 1, 'PC'),
(22,2, 'B'),
(23, 1, 'PC'),
(23, 2, 'B'),
(24, 1, 'G'),
(24, 2, 'KG'),
(25, 1, 'G'),
(25, 2, 'KG'),
(26, 1, 'PC'),
(26, 2, 'B'),
(27, 1, 'ML'),
(27, 2, 'G'),
(28, 1, 'PC'),
(28, 2, 'B'),
(29, 1, 'PC'),
(29, 2, 'B'),
(30, 1, 'PC'),
(30, 2, 'B'),
(31, 1, 'PC'),
(31, 2, 'B'),
(32, 1, 'PC'),
(32, 2, 'B'),
(33, 1, 'G'),
(33, 2, 'KG'),
(34, 1, 'G'),
(34, 2, 'KG');

insert into Inventory.stock values 
(4, 1, 100, 100, 30),
(5, 1, 100, 100, 30),
(6, 1, 100, 100, 30);


insert into Inventory.stock values 
(1, 1, 100, 50, 200),
(1, 2, 4, 3, 6 ),
(2, 2, 6, 10, 3),
(3, 1, 10000, 12000, 5000),
(3, 2, 10, 12, 5),
(4, 2, 20, 50, 15),
(5, 2, 23, 50, 15),
(6, 2, 25, 50, 15),
(7, 1, 7000, 15000, 4000),
(7, 2, 15, 25, 10), 
(8, 1, 100, 130, 50),
(8, 2, 4, 6, 3 ), 
(9,1,80, 150, 60 ),
(9, 2, 4, 8, 3),
(10, 1, 1000, 1500, 800),
(10, 2, 8, 15, 7), 
(11, 1, 10000, 15000, 6000),
(11,2, 10, 16, 8),
(12, 1, 60, 80, 30),
(12, 2, 4, 8, 2),
(13,1, 20000, 40000, 10000),
(13,2, 80, 100, 45),
(14, 1, 7000, 14000, 5000),
(14, 2, 15, 20, 10),
(15, 1, 2000, 8000, 1500),
(15, 2, 15, 22, 12),
(16,1, 14000, 18000, 10000),
(16,2, 8, 14, 9),
(17, 1, 8000, 12000, 4000),
(17, 2, 20, 35, 12),
 (18, 1, 10000, 15000, 4000),
 (18, 2, 20, 25, 8),
 (19, 1, 200, 350, 80),
 (19, 2, 11, 22, 6),
 (20, 1, 450, 600, 240),
 (20,2, 12, 15, 8),
 (21, 1, 600, 750, 430),
 (21, 2, 20, 25, 15),
 (22, 1,  15, 20, 5 ),
 (22, 2, 8, 12, 4),
 (23, 1, 60, 120, 25),
 (23, 2, 10, 12, 4),
 (24, 1, 4000, 10000, 2500),
 (24, 2, 16, 30, 10),
 (25, 1, 5000, 15000, 3500),
 (25, 2, 21, 35, 12),
 (26, 1, 50, 80, 30),
 (26, 2, 10, 22, 10),
 (27, 1, 12000, 40000, 10000),
 (27, 2, 20, 35, 10),
 (28, 1, 30, 45, 20),
 (28, 2, 8, 15, 5),
 (29, 1, 45, 60, 18),
 (29, 2, 6, 25, 5),
 (30, 1, 30, 65, 12),
 (30, 2, 20, 25, 10), 
 (31, 1, 30, 65, 15),
 (31, 2, 16, 20, 8), 
 (32, 1, 26, 40, 15),
 (33, 1, 5000, 10000, 3000),
 (33, 2, 10, 18, 8),
 (34, 1, 8000, 12000, 4000),
 (34, 2, 15, 24, 10);



 --Para cambiar el nombre de las columnas 
EXEC sp_rename 'Inventory.stock.sto_min', 'sto_maximum', 'COLUMN';
EXEC sp_rename 'Inventory.stock.sto_max', 'sto_minimum', 'COLUMN';
