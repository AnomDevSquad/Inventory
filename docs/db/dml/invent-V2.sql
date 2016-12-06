
insert into Inventory.warehouses values
(1,'Kitchen'),
(2,'Warehouse');
go
insert into Inventory.stock values
(1,1,80,20,700),
(2,1,150,20,700),
(3,1,45,20,700),
(4,1,90,20,700),
(5,1,100,20,700),
(6,1,80,20,700),
(7,1,120,20,700),
(8,1,75,20,700),
(9,1,125,20,700),
(10,1,100,20,700),
(1,2,120,20,700),
(2,2,110,20,700),
(3,2,200,20,700),
(4,2,200,20,700),
(5,2,100,20,700),
(6,2,40,20,700),
(7,2,220,20,700),
(8,2,89,20,700),
(9,2,150,20,700),
(10,2,120,20,700);
go

insert into Inventory.movementconcepts values
(1, 'Purchase'), (2, 'Sale'),  (3, 'Minimum losses '), (4, 'Maximum Losses'), (5, 'Entry Transfer'),
(6, 'Output Transfer'), (9,'Spoiled'), (10, 'Expiration');
go

--  los campos estan en orden
insert into Inventory.movements values
(5,1,1,getdate(),10),
(10,2,2,getdate(),30),
(10,2,1,getdate(),2),
(8,1,2,getdate(),1),
(9,2,1,getdate(),10);
