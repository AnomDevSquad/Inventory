/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 12.1 		*/
/*  Created On : 09-nov.-2016 17:41:46 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

CREATE DATABASE Restaurant;
GO
USE Restaurant;
GO

/* Drop Foreign Key Constraints */

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_conversions_ingredient_measurements]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [conversions] DROP CONSTRAINT [FK_conversions_ingredient_measurements]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_conversions_measurementunits]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [conversions] DROP CONSTRAINT [FK_conversions_measurementunits]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_dish_ingredients_dishes]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [dish_ingredients] DROP CONSTRAINT [FK_dish_ingredients_dishes]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_dish_ingredients_ingredients]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [dish_ingredients] DROP CONSTRAINT [FK_dish_ingredients_ingredients]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_dish_ingredients_measurementunits]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [dish_ingredients] DROP CONSTRAINT [FK_dish_ingredients_measurementunits]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ingredient_measurements_measurementunits]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [ingredient_measurements] DROP CONSTRAINT [FK_ingredient_measurements_measurementunits]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_ingredient_measurements_stock]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [ingredient_measurements] DROP CONSTRAINT [FK_ingredient_measurements_stock]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_movements_movementconcepts]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [movements] DROP CONSTRAINT [FK_movements_movementconcepts]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_movements_stock]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [movements] DROP CONSTRAINT [FK_movements_stock]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_order_dishes_dishes]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [order_dishes] DROP CONSTRAINT [FK_order_dishes_dishes]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_order_dishes_orders]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [order_dishes] DROP CONSTRAINT [FK_order_dishes_orders]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_orders_employees]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [orders] DROP CONSTRAINT [FK_orders_employees]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_orders_orderstatus]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [orders] DROP CONSTRAINT [FK_orders_orderstatus]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_stock_ingredients]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [stock] DROP CONSTRAINT [FK_stock_ingredients]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_stock_warehouses]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
--ALTER TABLE [stock] DROP CONSTRAINT [FK_stock_warehouses]
--GO

--/* Drop Tables */

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[conversions]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [conversions]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dish_ingredients]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [dish_ingredients]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dishes]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [dishes]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[employees]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [employees]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[ingredient_measurements]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [ingredient_measurements]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[ingredients]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [ingredients]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[measurementunits]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [measurementunits]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[movementconcepts]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [movementconcepts]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[movements]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [movements]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[order_dishes]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [order_dishes]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[orders]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [orders]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[orderstatus]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [orderstatus]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[stock]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [stock]
--GO

--IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[warehouses]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
--DROP TABLE [warehouses]
--GO

/* Create Tables */

CREATE TABLE [conversions]
(
	[cvn_from_id_ingredient] int NOT NULL,
	[cvn_from_id_warehouse] int NOT NULL,
	[cvn_from_id_measurement] char(3) NOT NULL,
	[cvn_to_id_measurement] char(3) NOT NULL,
	[cvn_factor_number] int NOT NULL
)
GO

CREATE TABLE [dish_ingredients]
(
	[ing_id] int NOT NULL,
	[dis_id] int NOT NULL,
	[measurement] char(3) NOT NULL,
	[dis_ing_quantity] int NOT NULL
)
GO

CREATE TABLE [dishes]
(
	[dis_id] int NOT NULL,
	[dis_name] varchar(50) NOT NULL,
	[dis_description] text NOT NULL,
	[dis_price] money NOT NULL
)
GO

CREATE TABLE [employees]
(
	[emp_id] smallint NOT NULL,
	[emp_name] varchar(70) NOT NULL,
	[emp_lastname] varchar(70) NOT NULL,
	[emp_type] char(5) NOT NULL,
	[emp_nickname] varchar(50) NOT NULL,
	[emp_passwd] varchar(50) NOT NULL
)
GO

CREATE TABLE [ingredient_measurements]
(
	[ims_id_ingredient] int NOT NULL,
	[ims_id_warehouse] int NOT NULL,
	[ims_id_measurement] char(3) NOT NULL
)
GO

CREATE TABLE [ingredients]
(
	[ing_id] int NOT NULL,
	[ing_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [measurementunits]
(
	[meu_id] char(3) NOT NULL,
	[meu_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [movementconcepts]
(
	[mco_id] int NOT NULL,
	[mco_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [movements]
(
	[mov_id] int NOT NULL IDENTITY (1, 1),
	[mov_id_stock_ingredient] int NOT NULL,
	[mov_warehouse_id] int NOT NULL,
	[mov_concept] int NOT NULL,
	[mov_date] datetime NOT NULL,
	[mov_quantity] int NOT NULL
)
GO

CREATE TABLE [order_dishes]
(
	[dis_id] int NOT NULL,
	[ord_id] int NOT NULL,
	[ord_dis_quantity] int NOT NULL,
	[ord_date] datetime NOT NULL,
	[ord_total] money NOT NULL
)
GO

CREATE TABLE [orders]
(
	[ord_id] int NOT NULL,
	[ord_date] datetime NOT NULL,
	[ord_subtotal] money NOT NULL,
	[ord_iva] money NOT NULL,
	[ord_total] money NOT NULL,
	[ord_status] int NOT NULL,
	[ord_employee_id] smallint NOT NULL
)
GO

CREATE TABLE [orderstatus]
(
	[ors_id] int NOT NULL,
	[ors_description] varchar(50) NOT NULL
)
GO

CREATE TABLE [stock]
(
	[sto_id_ing] int NOT NULL,
	[war_id] int NOT NULL,
	[sto_quantity] int NOT NULL,
	[sto_min] int NOT NULL,
	[sto_max] int
)
GO

CREATE TABLE [warehouses]
(
	[war_id] int NOT NULL,
	[war_name] varchar(50) NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [conversions] 
 ADD CONSTRAINT [PK_conversions]
	PRIMARY KEY CLUSTERED ([cvn_from_id_ingredient] ASC,[cvn_from_id_warehouse] ASC,[cvn_from_id_measurement] ASC,[cvn_to_id_measurement] ASC)
GO

ALTER TABLE [dish_ingredients] 
 ADD CONSTRAINT [PK_dish_ingredients]
	PRIMARY KEY CLUSTERED ([ing_id] ASC,[dis_id] ASC,[measurement] ASC)
GO

ALTER TABLE [dishes] 
 ADD CONSTRAINT [PK_dishes]
	PRIMARY KEY CLUSTERED ([dis_id] ASC)
GO

ALTER TABLE [employees] 
 ADD CONSTRAINT [PK_employees]
	PRIMARY KEY CLUSTERED ([emp_id] ASC)
GO

ALTER TABLE [ingredient_measurements] 
 ADD CONSTRAINT [PK_ingredient_measurements]
	PRIMARY KEY CLUSTERED ([ims_id_ingredient] ASC,[ims_id_warehouse] ASC,[ims_id_measurement] ASC)
GO

ALTER TABLE [ingredients] 
 ADD CONSTRAINT [PK_ingredients]
	PRIMARY KEY CLUSTERED ([ing_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_ingredients_measurementunits] 
 ON [ingredients] ()
GO

ALTER TABLE [measurementunits] 
 ADD CONSTRAINT [PK_measurementunits]
	PRIMARY KEY CLUSTERED ([meu_id] ASC)
GO

ALTER TABLE [movementconcepts] 
 ADD CONSTRAINT [PK_movementconpects]
	PRIMARY KEY CLUSTERED ([mco_id] ASC)
GO

ALTER TABLE [movements] 
 ADD CONSTRAINT [PK_movements]
	PRIMARY KEY CLUSTERED ([mov_id] ASC)
GO

ALTER TABLE [order_dishes] 
 ADD CONSTRAINT [PK_order_dishes]
	PRIMARY KEY CLUSTERED ([dis_id] ASC,[ord_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_order_dishes_dishes] 
 ON [order_dishes] ([dis_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_order_dishes_orders] 
 ON [order_dishes] ([ord_id] ASC)
GO

ALTER TABLE [orders] 
 ADD CONSTRAINT [PK_orders]
	PRIMARY KEY CLUSTERED ([ord_id] ASC)
GO

CREATE NONCLUSTERED INDEX [IXFK_orders_dishes] 
 ON [orders] ()
GO

ALTER TABLE [orderstatus] 
 ADD CONSTRAINT [PK_orderstatus]
	PRIMARY KEY CLUSTERED ([ors_id] ASC)
GO

ALTER TABLE [stock] 
 ADD CONSTRAINT [PK_stock]
	PRIMARY KEY CLUSTERED ([sto_id_ing] ASC,[war_id] ASC)
GO

ALTER TABLE [warehouses] 
 ADD CONSTRAINT [PK_warehouses]
	PRIMARY KEY CLUSTERED ([war_id] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [conversions] ADD CONSTRAINT [FK_conversions_ingredient_measurements]
	FOREIGN KEY ([cvn_from_id_ingredient],[cvn_from_id_warehouse],[cvn_from_id_measurement]) REFERENCES [ingredient_measurements] ([ims_id_ingredient],[ims_id_warehouse],[ims_id_measurement]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [conversions] ADD CONSTRAINT [FK_conversions_measurementunits]
	FOREIGN KEY ([cvn_to_id_measurement]) REFERENCES [measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_ingredients]
	FOREIGN KEY ([ing_id]) REFERENCES [ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_measurementunits]
	FOREIGN KEY ([measurement]) REFERENCES [measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [ingredient_measurements] ADD CONSTRAINT [FK_ingredient_measurements_measurementunits]
	FOREIGN KEY ([ims_id_measurement]) REFERENCES [measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [ingredient_measurements] ADD CONSTRAINT [FK_ingredient_measurements_stock]
	FOREIGN KEY ([ims_id_ingredient],[ims_id_warehouse]) REFERENCES [stock] ([sto_id_ing],[war_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [movements] ADD CONSTRAINT [FK_movements_movementconcepts]
	FOREIGN KEY ([mov_concept]) REFERENCES [movementconcepts] ([mco_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [movements] ADD CONSTRAINT [FK_movements_stock]
	FOREIGN KEY ([mov_id_stock_ingredient],[mov_warehouse_id]) REFERENCES [stock] ([sto_id_ing],[war_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [order_dishes] ADD CONSTRAINT [FK_order_dishes_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [order_dishes] ADD CONSTRAINT [FK_order_dishes_orders]
	FOREIGN KEY ([ord_id]) REFERENCES [orders] ([ord_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [orders] ADD CONSTRAINT [FK_orders_employees]
	FOREIGN KEY ([ord_employee_id]) REFERENCES [employees] ([emp_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [orders] ADD CONSTRAINT [FK_orders_orderstatus]
	FOREIGN KEY ([ord_status]) REFERENCES [orderstatus] ([ors_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [stock] ADD CONSTRAINT [FK_stock_ingredients]
	FOREIGN KEY ([sto_id_ing]) REFERENCES [ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [stock] ADD CONSTRAINT [FK_stock_warehouses]
	FOREIGN KEY ([war_id]) REFERENCES [warehouses] ([war_id]) ON DELETE No Action ON UPDATE No Action
GO

CREATE SCHEMA HumanResource;
GO
CREATE SCHEMA Inventory;
GO
CREATE SCHEMA Kitchen;
GO
CREATE SCHEMA Sales;
GO

ALTER SCHEMA HumanResource TRANSFER dbo.employees;

ALTER SCHEMA Inventory TRANSFER dbo.conversions;
ALTER SCHEMA Inventory TRANSFER dbo.stock;
ALTER SCHEMA Inventory TRANSFER dbo.warehouses;
ALTER SCHEMA Inventory TRANSFER dbo.movements;
ALTER SCHEMA Inventory TRANSFER dbo.movementconcepts;
ALTER SCHEMA Inventory TRANSFER dbo.measurementunits;
ALTER SCHEMA Inventory TRANSFER dbo.ingredient_measurements

ALTER SCHEMA Kitchen TRANSFER dbo.ingredients;
ALTER SCHEMA Kitchen TRANSFER dbo.dishes;
ALTER SCHEMA Kitchen TRANSFER dbo.dish_ingredients;

ALTER SCHEMA Sales TRANSFER dbo.orders;
ALTER SCHEMA Sales TRANSFER dbo.orderstatus;
ALTER SCHEMA Sales TRANSFER dbo.order_dishes;

