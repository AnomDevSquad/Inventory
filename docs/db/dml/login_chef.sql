create login JonaL
with password='chef00',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [chef] FOR LOGIN [JonaL] WITH DEFAULT_SCHEMA=[Kitchen]
GO


USE [Restaurant]
GO
CREATE USER [chef] FOR LOGIN [JonaL] WITH DEFAULT_SCHEMA=[Kitchen]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY INSERT ON [Kitchen].[ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY UPDATE ON [Kitchen].[ingredients] TO [chef]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dish_ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[dish_ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY INSERT ON [Kitchen].[dish_ingredients] TO [chef]
GO
use [Restaurant]
GO
DENY UPDATE ON [Kitchen].[dish_ingredients] TO [chef]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[dishes] TO [chef]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[dishes] TO [chef]
GO
use [Restaurant]
GO
DENY INSERT ON [Kitchen].[dishes] TO [chef]
GO
use [Restaurant]
GO
DENY UPDATE ON [Kitchen].[dishes] TO [chef]
GO
use [Restaurant]
GO
GRANT SELECT ON [Kitchen].[category] TO [chef]
GO
use [Restaurant]
GO
DENY DELETE ON [Kitchen].[category] TO [chef]
GO
use [Restaurant]
GO
DENY INSERT ON [Kitchen].[category] TO [chef]
GO
use [Restaurant]
GO
DENY UPDATE ON [Kitchen].[category] TO [chef]
GO
