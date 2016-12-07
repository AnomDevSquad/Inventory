create login GilC
with password='storer00',
default_database = Restaurant;

USE [Restaurant]
GO
CREATE USER [storer] FOR LOGIN [GilC] WITH DEFAULT_SCHEMA=[Inventory]
GO



USE [Restaurant]
GO
CREATE USER [storer] FOR LOGIN [GilC] WITH DEFAULT_SCHEMA=[Inventory]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[warehouses] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[warehouses] TO [storer]
GO
use [Restaurant]
GO
DENY INSERT ON [Inventory].[warehouses] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[warehouses] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[conversions] TO [storer]
GO
use [Restaurant]
GO
DENY INSERT ON [Inventory].[conversions] TO [storer]
GO
use [Restaurant]
GO
DENY SELECT ON [Inventory].[conversions] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[conversions] TO [storer]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movementconcepts] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[movementconcepts] TO [storer]
GO
use [Restaurant]
GO
DENY INSERT ON [Inventory].[movementconcepts] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[movementconcepts] TO [storer]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[movements] TO [storer]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[movements] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[movements] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[movements] TO [storer]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[stock] TO [storer]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[stock] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[stock] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[stock] TO [storer]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[ingredient_measurements] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[ingredient_measurements] TO [storer]
GO
use [Restaurant]
GO
DENY INSERT ON [Inventory].[ingredient_measurements] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[ingredient_measurements] TO [storer]
GO
use [Restaurant]
GO
GRANT INSERT ON [Inventory].[measurementunits] TO [storer]
GO
use [Restaurant]
GO
GRANT SELECT ON [Inventory].[measurementunits] TO [storer]
GO
use [Restaurant]
GO
DENY DELETE ON [Inventory].[measurementunits] TO [storer]
GO
use [Restaurant]
GO
DENY UPDATE ON [Inventory].[measurementunits] TO [storer]
GO
