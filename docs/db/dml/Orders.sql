
insert into Sales.orderstatus values 
(0, 'Order Delivered'),
(1, 'Order in Process'),
(2, 'Order Canceled');

insert into Sales.Orders values
(1, getDate(), 13.00, 2.08, 15.08, 0, 1),
(2, getDate(), 40.00, 6.4, 46.4, 0, 2),
(3, getDate(), 44.00, 7.04, 51.04, 0, 2),
(4, getDate(), 113.00, 18.08, 131.08, 0, 1 );


insert into Sales.order_dishes values
 (2, 1, 1, getDate(), 5.00),
 (3, 1, 1, GETDATE(), 8.00),
 (1, 2, 2, getDate(), 10.00),
 (6, 2, 1, getDate(), 14.00),
 (7, 2, 1, getDate(), 16.00),
 (6, 3, 2, getDate(), 28.00),
 (3, 3, 2, getDate(), 16.00),
 (9, 4, 3, getDate(), 75.00),
 (1, 4, 4, getDate(), 20.00),
 (4, 4, 2, getDate(), 18.00);







