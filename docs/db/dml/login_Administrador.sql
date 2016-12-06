create login Administrador
with password='admin123',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [Administrador] FOR LOGIN [Administrador] WITH DEFAULT_SCHEMA=[db_accessadmin]
GO
USE [Restaurant]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_accessadmin] TO [Administrador]
GO
USE [Restaurant]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [Administrador]
GO




use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[category] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[category] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[category] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[category] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [HumanResource].[employees] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [HumanResource].[employees] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [HumanResource].[employees] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [HumanResource].[employees] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[conversions] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[conversions] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[conversions] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[conversions] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[stock] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[stock] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[stock] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[stock] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Sales].[orderstatus] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[orderstatus] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[orderstatus] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Sales].[orderstatus] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[ingredient_measurements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[ingredient_measurements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[ingredient_measurements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[ingredient_measurements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[measurementunits] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[measurementunits] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[measurementunits] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[measurementunits] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[movements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[movements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[movements] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[warehouses] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[warehouses] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[warehouses] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[warehouses] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Sales].[order_dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[order_dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[order_dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Sales].[order_dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Inventory].[movementconcepts] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[movementconcepts] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movementconcepts] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Inventory].[movementconcepts] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[dishes] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Sales].[orders] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[orders] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[orders] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Sales].[orders] TO [Administrador]
GO
use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[dish_ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[dish_ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dish_ingredients] TO [Administrador]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[dish_ingredients] TO [Administrador]
GO
