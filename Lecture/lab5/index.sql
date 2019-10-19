explain
select * from customers join orders using (customerid)
where gender = 'F';

create index ix_orderdate on orderlines using btree(orderdate);

drop index ix_orderdate;

select * from orderlines
where orderdate = '2014-12-01';

