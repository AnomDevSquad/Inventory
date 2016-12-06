create login AntS
with password='IMaster001a',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [Inventory_Master] FOR LOGIN [AntS] WITH DEFAULT_SCHEMA=[Inventory]
GO

USE [Restaurant]
GO
CREATE USER [Inventory_Master] FOR LOGIN [AntS] WITH DEFAULT_SCHEMA=[Inventory]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[movements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[movements] TO [Inventory_Master]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[movements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[movementconcepts] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[movementconcepts] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movementconcepts] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[movementconcepts] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[measurementunits] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[measurementunits] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[measurementunits] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[measurementunits] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[stock] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[stock] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[stock] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[stock] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[ingredient_measurements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[ingredient_measurements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[ingredient_measurements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[ingredient_measurements] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[warehouses] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[warehouses] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[warehouses] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[warehouses] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[conversions] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[conversions] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[conversions] TO [Inventory_Master]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[conversions] TO [Inventory_Master]
GO
