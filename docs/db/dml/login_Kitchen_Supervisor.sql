create login GaG
with password='Sup01b',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [supervisor_kitchen] FOR LOGIN [GaG] WITH DEFAULT_SCHEMA=[Kitchen]
GO



USE [Restaurant]
GO
CREATE USER [supervisor_kitchen] FOR LOGIN [GaG] WITH DEFAULT_SCHEMA=[Kitchen]
GO
use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[dishes] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[dishes] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dishes] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[dishes] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[category] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[category] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[category] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[category] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
DENY INSERT ON [Kitchen].[ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
DENY UPDATE ON [Kitchen].[ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT DELETE ON [Kitchen].[dish_ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT INSERT ON [Kitchen].[dish_ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dish_ingredients] TO [supervisor_kitchen]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Kitchen].[dish_ingredients] TO [supervisor_kitchen]
GO
