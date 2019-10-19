-- 1 query SQL
-- a
select p.title
from products p inner join categories c on(p.category = c.category)
where c.categoryname = 'Documentary';

-- b
select p.prod_id, p.title
from products p left join orderlines o on(p.prod_id = o.prod_id)
group by (p.prod_id, p.title)
having count(o.orderid) = 0;

-- c
select * from customers
where customerid not in (select customerid from cust_hist);

-- d
select country, count(customerid) as num_of_customers
from customers 
group by(country);

-- e
select ol.orderlineid, ol.prod_id,
		p.title as product_title,
		ol.quantity, p.price as unit_price,
		(p.price * ol.quantity) as amount 
from orderlines ol inner join products p on(ol.prod_id = p.prod_id)
where ol.orderid = 942;

-- f
select avg(totalamount) as avg_order_value
from orders;

-- g
select * from products where prod_id in(select prod_id from inventory
									   where sales = (select max(sales) from inventory));


-- 2 trigger
create or replace function tg_af_insert_orderlines() returns trigger as
$$ 
begin
	update inventory 
	set sales = sales + new.quantity 
	where prod_id = new.prod_id;
	update inventory 
	set quan_in_stock = quan_in_stock - new.quantity
	where prod_id = new.prod_id;
	return new;
end;
$$ language plpgsql

create trigger af_insert_orderlines
after insert on orderlines
for each row
when (new.prod_id is not null)
execute procedure tg_af_insert_orderlines();

select * from inventory;

insert into orderlines values ('9','1','1','1','2004-01-27');