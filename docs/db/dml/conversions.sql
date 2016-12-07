
update Inventory.ingredient_measurements set ims_id_measurement='GL' where ims_id_ingredient=27 and ims_id_warehouse=2
update Inventory.ingredient_measurements set ims_id_warehouse=2 where ims_id_ingredient=21 and ims_id_measurement='GL'



insert into  Inventory.conversions
(
	cvn_from_id_ingredient,
	cvn_from_id_warehouse,
	cvn_from_id_measurement,
	cvn_to_id_measurement,
	cvn_factor_number,
	cvn_to_warehouse
) values
(1, 2, 'B', 'PC', 50, 1),
(1, 1, 'PC', 'B', 50, 2),
(2, 2, 'GL', 'ML', 3785, 1),
(2, 1, 'ML', 'GL', 3785, 2),
(3, 2, 'GL', 'ML', 3785, 1),
(3, 1, 'ML', 'GL', 3785, 2),
(4, 2, 'B', 'LVS', 300, 1),
(4, 1, 'LVS', 'B', 300, 2),
(5, 2, 'B', 'LVS', 300, 1),
(5, 1, 'LVS', 'B', 300, 2),
(6, 2, 'B', 'LVS', 300, 1),
(6, 1, 'LVS', 'B', 300, 2),
(7, 2, 'GL', 'ML', 3785, 1),
(7, 1, 'ML', 'GL', 3785, 2),
(8, 2, 'B', 'PC', 50, 1),
(8, 1, 'PC', 'B', 50, 2),
(9, 2, 'B', 'PC', 80, 1),
(9, 1, 'PC', 'B', 80, 2),
(10, 2, 'GL', 'ML', 3785, 1),
(10, 1, 'ML', 'GL', 3785, 2),
(11, 2, 'GL', 'ML', 3785, 1),
(11, 1, 'ML', 'GL', 3785, 2),
(12, 2, 'B', 'PC', 50, 1),
(12, 1, 'PC', 'B', 50, 2),
(13, 2, 'KG', 'G', 1000, 1),
(13, 1, 'G', 'KG', 1000, 2),
(14, 2, 'KG', 'G', 1000, 1),
(14, 1, 'G', 'KG', 1000, 2),
(15, 2, 'GL', 'OZ', 128, 1),
(15, 1, 'OZ', 'GL', 128, 2),
(16, 2, 'B', 'G', 10000, 1),
(16, 1, 'G', 'B', 10000, 2),
(17, 2, 'GL', 'ML', 3785, 1),
(17, 1, 'ML', 'GL', 3785, 2),
(18, 2, 'KG', 'G', 1000, 1),
(18, 1, 'G', 'KG', 1000, 2),
(19, 2, 'GL', 'OZ', 128, 1),
(19, 1, 'OZ', 'GL', 128, 2),
(20, 2, 'GL', 'OZ', 128, 1),
(20, 1, 'OZ', 'GL', 128, 2),
(21, 2, 'GL', 'OZ', 128, 1),
(21, 1, 'OZ', 'GL', 128, 2),
(22, 2, 'B', 'PC', 50, 1),
(22, 1, 'PC', 'B', 50, 2),
(23, 2, 'B', 'PC', 50, 1),
(23, 1, 'PC', 'B', 50, 2),
(24, 2, 'KG', 'G', 1000, 1),
(24, 1, 'G', 'KG', 1000, 2),
(25, 2, 'KG', 'G', 1000, 1),
(25, 1, 'G', 'KG', 1000, 2),
(26, 2, 'B', 'PC', 50, 1),
(26, 1, 'PC', 'B', 50, 2),
(27, 2, 'GL', 'ML', 3785, 1),
(27, 1, 'ML', 'GL', 3785, 2),
(28, 2, 'B', 'PC', 50, 1),
(28, 1, 'PC', 'B', 50, 2),
(29, 2, 'B', 'PC', 50, 1),
(29, 1, 'PC', 'B', 50, 2),
(30, 2, 'B', 'PC', 50, 1),
(30, 1, 'PC', 'B', 50, 2),
(31, 2, 'B', 'PC', 50, 1),
(31, 1, 'PC', 'B', 50, 2),
(32, 2, 'B', 'PC', 50, 1),
(32, 1, 'PC', 'B', 50, 2),
(33, 2, 'KG', 'G', 1000, 1),
(33, 1, 'G', 'KG', 1000, 2),
(34, 2, 'KG', 'G', 1000, 1),
(34, 1, 'G', 'KG', 1000, 2);

SELECT * FROM Inventory.conversions
