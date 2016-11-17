IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_stock_ingredients]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [stock] DROP CONSTRAINT [FK_stock_ingredients]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_stock_warehouses]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [stock] DROP CONSTRAINT [FK_stock_warehouses]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_order_dishes_dishes]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [order_dishes] DROP CONSTRAINT [FK_order_dishes_dishes]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_order_dishes_orders]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [order_dishes] DROP CONSTRAINT [FK_order_dishes_orders]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_dish_ingredients_dishes]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dish_ingredients] DROP CONSTRAINT [FK_dish_ingredients_dishes]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_dish_ingredients_ingredients]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dish_ingredients] DROP CONSTRAINT [FK_dish_ingredients_ingredients]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_ingredients_measurementunits]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [ingredients] DROP CONSTRAINT [FK_ingredients_measurementunits]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_movements_movementconpects]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [movements] DROP CONSTRAINT [FK_movements_movementconpects]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_movements_stock]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [movements] DROP CONSTRAINT [FK_movements_stock]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_movements_warehouses]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [movements] DROP CONSTRAINT [FK_movements_warehouses]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[warehouses]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [warehouses]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[measurementunits]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [measurementunits]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[movementconpects]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [movementconpects]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[stock]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [stock]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[order_dishes]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [order_dishes]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dish_ingredients]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dish_ingredients]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[ingredients]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [ingredients]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dishes]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dishes]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[orders]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [orders]
;

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[movements]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [movements]
;

CREATE TABLE [warehouses]
(
	[war_id] int NOT NULL,
	[war_name] varchar(50) NOT NULL
)
;

CREATE TABLE [measurementunits]
(
	[meu_id] char(5) NOT NULL,
	[meu_description] varchar(50) NOT NULL
)
;

CREATE TABLE [movementconpects]
(
	[mco_id] int NOT NULL,
	[mco_description] varchar(50) NOT NULL
)
;

CREATE TABLE [stock]
(
	[sto_id_ing] int NOT NULL,
	[war_id] int NOT NULL,
	[sto_quantity] int NOT NULL
)
;

CREATE TABLE [order_dishes]
(
	[dis_id] int NOT NULL,
	[ord_id] int NOT NULL,
	[ord_dis_quantity] int NOT NULL
)
;

CREATE TABLE [dish_ingredients]
(
	[ing_id] int NOT NULL,
	[dis_id] int NOT NULL,
	[dis_ing_quantity] int NOT NULL
)
;

CREATE TABLE [ingredients]
(
	[ing_id] int NOT NULL,
	[ing_description] varchar(50) NOT NULL,
	[mu] char(5) NOT NULL
)
;

CREATE TABLE [dishes]
(
	[dis_id] int NOT NULL,
	[dis_name] varchar(50) NOT NULL,
	[dis_description] text NOT NULL,
	[dis_price] money NOT NULL
)
;

CREATE TABLE [orders]
(
	[ord_id] int NOT NULL,
	[ord_date] datetime NOT NULL,
	[ord_subtotal] money NOT NULL,
	[ord_iva] money NOT NULL,
	[ord_total] money NOT NULL
)
;

CREATE TABLE [movements]
(
	[mov_id] int NOT NULL,
	[mov_date] datetime NOT NULL,
	[mov_quantity] int NOT NULL,
	[mov_id_warehouse] int NOT NULL,
	[mov_id_stock_ingredient] int NOT NULL,
	[mov_concept] int NOT NULL
)
;

ALTER TABLE [warehouses] 
 ADD CONSTRAINT [PK_warehouses]
	PRIMARY KEY CLUSTERED ([war_id])
;

ALTER TABLE [measurementunits] 
 ADD CONSTRAINT [PK_measurementunits]
	PRIMARY KEY CLUSTERED ([meu_id])
;

ALTER TABLE [movementconpects] 
 ADD CONSTRAINT [PK_movementconpects]
	PRIMARY KEY CLUSTERED ([mco_id])
;

ALTER TABLE [stock] 
 ADD CONSTRAINT [PK_stock]
	PRIMARY KEY CLUSTERED ([sto_id_ing])
;

ALTER TABLE [dish_ingredients] 
 ADD CONSTRAINT [PK_dish_ingredients]
	PRIMARY KEY CLUSTERED ([dis_id],[ing_id])
;

ALTER TABLE [ingredients] 
 ADD CONSTRAINT [PK_ingredients]
	PRIMARY KEY CLUSTERED ([ing_id])
;

ALTER TABLE [dishes] 
 ADD CONSTRAINT [PK_dishes]
	PRIMARY KEY CLUSTERED ([dis_id])
;

ALTER TABLE [orders] 
 ADD CONSTRAINT [PK_orders]
	PRIMARY KEY CLUSTERED ([ord_id])
;

ALTER TABLE [movements] 
 ADD CONSTRAINT [PK_movements]
	PRIMARY KEY CLUSTERED ([mov_id])
;

ALTER TABLE [stock] ADD CONSTRAINT [FK_stock_ingredients]
	FOREIGN KEY ([sto_id_ing]) REFERENCES [ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [stock] ADD CONSTRAINT [FK_stock_warehouses]
	FOREIGN KEY ([war_id]) REFERENCES [warehouses] ([war_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [order_dishes] ADD CONSTRAINT [FK_order_dishes_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [order_dishes] ADD CONSTRAINT [FK_order_dishes_orders]
	FOREIGN KEY ([ord_id]) REFERENCES [orders] ([ord_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_dishes]
	FOREIGN KEY ([dis_id]) REFERENCES [dishes] ([dis_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [dish_ingredients] ADD CONSTRAINT [FK_dish_ingredients_ingredients]
	FOREIGN KEY ([ing_id]) REFERENCES [ingredients] ([ing_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [ingredients] ADD CONSTRAINT [FK_ingredients_measurementunits]
	FOREIGN KEY ([mu]) REFERENCES [measurementunits] ([meu_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [movements] ADD CONSTRAINT [FK_movements_movementconpects]
	FOREIGN KEY ([mov_concept]) REFERENCES [movementconpects] ([mco_id]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [movements] ADD CONSTRAINT [FK_movements_stock]
	FOREIGN KEY ([mov_id_stock_ingredient]) REFERENCES [stock] ([sto_id_ing]) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE [movements] ADD CONSTRAINT [FK_movements_warehouses]
	FOREIGN KEY ([mov_id_warehouse]) REFERENCES [warehouses] ([war_id]) ON DELETE No Action ON UPDATE No Action
;
