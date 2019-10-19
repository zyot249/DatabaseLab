with product_3_months as
(select product_id, sum(quantity) as sum_products
from orders
where (current_date - orderdate) <= 90
group by(product_id))
select * from products
where product_id in (select product_id from product_3_months 
					 where sum_products = (select max(sum_products) from product_3_months));
