create login JaviG
with password='Sup00a',
default_database = Restaurant;


USE [Restaurant]
GO
CREATE USER [supervisor_sales] FOR LOGIN [JaviG] WITH DEFAULT_SCHEMA=[Sales]
GO


USE [Restaurant]
GO
CREATE USER [supervisor_sales] FOR LOGIN [JaviG] WITH DEFAULT_SCHEMA=[Sales]
GO
use [Restaurant]
GO
GRANT DELETE ON [Sales].[order_dishes] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[order_dishes] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[order_dishes] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Sales].[order_dishes] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT DELETE ON [Sales].[orders] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT INSERT ON [Sales].[orders] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT SELECT ON [Sales].[orders] TO [supervisor_sales]
GO
use [Restaurant]
GO
GRANT UPDATE ON [Sales].[orders] TO [supervisor_sales]
GO
