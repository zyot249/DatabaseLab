-- modify database
-- add needed primary keys
alter table categories 
	add constraint categories_pk primary key(category);

alter table inventory 
	add constraint inventory_pk primary key(product_id);
	
alter table products 
	add constraint products_pk primary key(product_id);

alter table orders 
	add constraint orders_pk primary key(order_id);

-- add foreign keys

alter table inventory
	add constraint inventory_fk_products foreign key(product_id) references products(product_id);
	
alter table orders
	add constraint orders_fk_products foreign key(product_id) references products(product_id);
	
alter table orders
	add constraint orders_fk_users foreign key(customer_id) references users(user_id);
	
alter table products
	add constraint products_fk_productscategories foreign key(category) references categories(category);
	
-- set unique attributes
alter table users
	add constraint unique_username unique(username);
	
-- set check constraints
alter table inventory
	add constraint check_available check(available >= 0);
	
alter table inventory
	add constraint check_sales check(sales >= 0);
	
alter table orders
	add constraint check_quantity check(quantity >= 1);

alter table products
	add constraint check_price check(price >= 0);
	