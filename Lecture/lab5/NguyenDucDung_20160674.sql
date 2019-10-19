-- Query by SQL
-- 1
select * from categories;

-- 3
select c.categoryname, count(p.prod_id) as number_of_product
from products p inner join categories c on(p.category = c.category)
group by c.categoryname;

-- 4
select p.prod_id, p.title
from products p left join orderlines o on(p.prod_id = o.prod_id)
group by (p.prod_id, p.title)
having count(o.orderid) = 0;

-- 5
select distinct on(c.country) c.country
from customers c;

-- 8
select o.orderdate, count(orderid) as number_of_orders
from orders o
group by (o.orderdate)
order by o.orderdate asc;

-- 9
select sum(quantity)
from orderlines ol
where ol.orderdate = '2004-02-03';

-- 12
select c.customerid, c.firstname, c.lastname, count(ch.orderid) as number_of_order
from cust_hist ch inner join customers c on (ch.customerid = c.customerid)
group by(c.customerid, c.firstname, c.lastname, ch.orderid)
order by number_of_order desc;

-- 13
select count(*)
from customers c
where c.creditcardexpiration = '2008/09';

-- 15
select *
from cust_hist 
where customerid = '19887';