create login JoshL
with password='seller00',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [seller] FOR LOGIN [JoshL] WITH DEFAULT_SCHEMA=[Sales]
GO

USE [Restaurant]
GO
CREATE USER [seller] FOR LOGIN [JoshL] WITH DEFAULT_SCHEMA=[Sales]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[orders] TO [seller]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[orders] TO [seller]
GO
use [Restaurant]
GO
DENY DELETE ON [Sales].[orders] TO [seller]
GO
use [Restaurant]
GO
DENY UPDATE ON [Sales].[orders] TO [seller]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[order_dishes] TO [seller]
GO
use [Restaurant]
GO
DENY DELETE ON [Sales].[order_dishes] TO [seller]
GO
use [Restaurant]
GO
DENY SELECT ON [Sales].[order_dishes] TO [seller]
GO
use [Restaurant]
GO
DENY UPDATE ON [Sales].[order_dishes] TO [seller]
GO
