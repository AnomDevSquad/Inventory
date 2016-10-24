SELECT 
o.ord_id, o.ord_date, o.ord_subtotal, 
od.dis_id, d.dis_name, d.dis_description, d.dis_price, od.ord_dis_quantity
from orders o
join order_dishes od on od.ord_id = o.ord_id
join dishes d on d.dis_id = od.dis_id
where o.ord_id = 1;

SELECT
o.ord_id, o.ord_date, o.ord_subtotal, o.ord_iva, o.ord_total,
od.dis_id, d.dis_name, d.dis_description, d.dis_price, od.ord_dis_quantity
from orders o
join order_dishes od on od.ord_id = o.ord_id
join dishes d on d.dis_id = od.dis_id

select 
o.ord_id, o.ord_date, o.ord_subtotal, 
od.dis_id, d.dis_name, d.dis_description, d.dis_price, 
di.ing_id, i.ing_description, 
m.meu_id, m.meu_description
from orders o
join order_dishes od on od.ord_id = o.ord_id
join dishes d on d.dis_id = od.dis_id
join dish_ingredients di on di.dis_id = d.dis_id
join ingredients i on i.ing_id = di.ing_id
join measurementunits m on i.mu = m.meu_id
where o.ord_id = 1;

SELECT * FROM dishes

INSERT INTO orders VALUES
(1,GETDATE(),5, 5*.16,5*1.16);
INSERT INTO orders VALUES
(2,GETDATE(),2*5,2*5*.16,2*5*1.16);

INSERT INTO order_dishes VALUES
(1,1,1);
INSERT INTO order_dishes VALUES
(1,2,2);