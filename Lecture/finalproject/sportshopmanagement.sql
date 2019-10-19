CREATE TABLE categories (
    category serial NOT NULL,
    categoryname character varying(50) NOT NULL
);

CREATE TABLE cust_hist (
    customer_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL
);

CREATE TABLE customers (
    customer_id serial NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    email character varying(50),
    phone character varying(50),
    age smallint,
    gender character varying(1),
	username character varying(50) NOT NULL,
    "password" character varying(50) NOT NULL
);

CREATE TABLE inventory (
    product_id integer NOT NULL,
    available integer NOT NULL,
    sales integer NOT NULL
);

CREATE TABLE orderlines (
    orderline_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity smallint NOT NULL,
    orderdate date NOT NULL
);

CREATE TABLE orders (
    order_id serial NOT NULL,
    orderdate date NOT NULL,
    customer_id integer,
    total_cost numeric(12,2) NOT NULL
);

CREATE TABLE products (
    product_id serial NOT NULL,
    category integer NOT NULL,
    title character varying(50) NOT NULL,
    price numeric(12,2) NOT NULL
);

create table users (
	user_id integer NOT NULL,
	username character varying(50) NOT NULL,
	"password" character varying(50) NOT NULL,
	"role" character varying(50) NOT NULL
);

alter table users
	add constraint users_pkey primary key (user_id);
	
ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category);
	
ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
	
ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (product_id);

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
	
ALTER TABLE ONLY products
    ADD CONSTRAINT fk_product_category FOREIGN KEY (category) REFERENCES categories(category) ON DELETE SET NULL;
	
ALTER TABLE ONLY inventory
    ADD CONSTRAINT fk_inventory_productid FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;
	
ALTER TABLE ONLY cust_hist
    ADD CONSTRAINT fk_cust_hist_customerid FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE ONLY cust_hist
    ADD CONSTRAINT fk_cust_hist_orderid FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

ALTER TABLE ONLY cust_hist
    ADD CONSTRAINT fk_cust_hist_productid FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_customerid FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;
	
ALTER TABLE ONLY orderlines
    ADD CONSTRAINT fk_orderid FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

ALTER TABLE ONLY orderlines
    ADD CONSTRAINT fk_productid FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE;
	
-- Insert into User table
insert into users values('1', 'thanhdn', '12345678', 'admin');
insert into users values('2', 'tungvt', '12345678', 'saleman');
insert into users values('3', 'dungnd', '12345678', 'customer');
insert into users values('4', 'chuongct', '12345678', 'customer');

-- Add column into Users table
alter table users
	add column fullname character varying(60);
	
alter table users
	add column avarta_url text;
	
create or replace function tg_bf_insert_orders() returns trigger as
$$
declare
	avail integer := select available from inventory where product_id = new.product_id;
begin
	if(avail >= new.quantity) then 
		update inventory
		set available = avail - new.quantity
		where product_id = new.product_id
		return new;
	else
		return null;
	end if;
end; $$
language plpgsql

create or replace trigger bf_insert_orders
before insert on orders
for each row
when (new.order_id is not null)
execute procedure tg_bf_insert_orders();
