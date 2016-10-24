insert into warehouses values
('W01','Kitchen'),
('W02','Warehouse');
go
insert into stock values
(1,'W01',80),
(2,'W01',150),
(3,'W01',45),
(4,'W01',90),
(5,'W01',100),
(6,'W01',80),
(7,'W01',120),
(8,'W01',75),
(9,'W01',125),
(10,'W01',100),
(1,'W02',120),
(2,'W02',110),
(3,'W02',200),
(4,'W02',200),
(5,'W02',100),
(6,'W02',40),
(7,'W02',220),
(8,'W02',89),
(9,'W02',150),
(10,'W02',120);
go
--date--cantidad--almacen--idstock--concept
insert into movements values
(getdate(),5,'W01',10,2),
(getdate(),30,'W02',3,10),
(getdate(),20,'W01',10,2),
(getdate(),8,'W02',6,1),
(getdate(),43,'W01',10,10);


--ya son las 2 de la mañana.....weba