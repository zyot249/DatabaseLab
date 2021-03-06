--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Ubuntu 11.2-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.2 (Ubuntu 11.2-1.pgdg18.04+1)

-- Started on 2019-02-26 16:52:05 +07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16471)
-- Name: store; Type: SCHEMA; Schema: -; Owner: shyn
--

CREATE SCHEMA store;


ALTER SCHEMA store OWNER TO shyn;

--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA store; Type: COMMENT; Schema: -; Owner: shyn
--

COMMENT ON SCHEMA store IS 'store';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16472)
-- Name: Customer; Type: TABLE; Schema: store; Owner: shyn
--

CREATE TABLE store."Customer" (
    "CustomerID" character(6) NOT NULL,
    "LastName" character varying(30),
    "FirstName" character varying(30),
    "Address" character varying(50),
    "City" character varying(30),
    "State" character(2),
    "Zip" character(5),
    "Phone" character varying(11)
);


ALTER TABLE store."Customer" OWNER TO shyn;

--
-- TOC entry 198 (class 1259 OID 16477)
-- Name: Order; Type: TABLE; Schema: store; Owner: shyn
--

CREATE TABLE store."Order" (
    "OrderID" character(6) NOT NULL,
    "CustomerID" character(6) NOT NULL,
    "ProductID" character(6) NOT NULL,
    "PurchaseDate" date,
    "Quantity" integer,
    "TotalCost" money
);


ALTER TABLE store."Order" OWNER TO shyn;

--
-- TOC entry 199 (class 1259 OID 16480)
-- Name: Product; Type: TABLE; Schema: store; Owner: shyn
--

CREATE TABLE store."Product" (
    "ProductID" character(6) NOT NULL,
    "ProductName" character varying(30),
    "Model" character varying(20),
    "Manufacturer" character varying(20),
    "UnitPrice" money,
    "Inventory" integer
);


ALTER TABLE store."Product" OWNER TO shyn;

--
-- TOC entry 2937 (class 0 OID 16472)
-- Dependencies: 197
-- Data for Name: Customer; Type: TABLE DATA; Schema: store; Owner: shyn
--

COPY store."Customer" ("CustomerID", "LastName", "FirstName", "Address", "City", "State", "Zip", "Phone") FROM stdin;
BLU003	AAAA	Katie	342 Pine	Hammond	IN	46200	555-9242
BLU001	Blum	Jessica	229 State	Whiting	IN	46300	555-0921
BLU005	Bbbbbbbb	Rich	123 Main St.	Chicago	IL	60633	555-1234
WIL001	Williams	Frank	456 Oak St.	Hammond	IN	46102	555-1235
\.


--
-- TOC entry 2938 (class 0 OID 16477)
-- Dependencies: 198
-- Data for Name: Order; Type: TABLE DATA; Schema: store; Owner: shyn
--

COPY store."Order" ("OrderID", "CustomerID", "ProductID", "PurchaseDate", "Quantity", "TotalCost") FROM stdin;
\.


--
-- TOC entry 2939 (class 0 OID 16480)
-- Dependencies: 199
-- Data for Name: Product; Type: TABLE DATA; Schema: store; Owner: shyn
--

COPY store."Product" ("ProductID", "ProductName", "Model", "Manufacturer", "UnitPrice", "Inventory") FROM stdin;
LAP001	Vaio CR31Z	CR	Sony Vaio	130₫	5
LAP002	HP AZE	HP	\N	100₫	18
LAP003	HP 34	HP	HP	100.000₫	200
\.


--
-- TOC entry 2809 (class 2606 OID 16476)
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: store; Owner: shyn
--

ALTER TABLE ONLY store."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY ("CustomerID");


--
-- TOC entry 2811 (class 2606 OID 16486)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: store; Owner: shyn
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY ("OrderID");


--
-- TOC entry 2813 (class 2606 OID 16484)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: store; Owner: shyn
--

ALTER TABLE ONLY store."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("ProductID");


--
-- TOC entry 2815 (class 2606 OID 16497)
-- Name: Order Order_fkey_Customer; Type: FK CONSTRAINT; Schema: store; Owner: shyn
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT "Order_fkey_Customer" FOREIGN KEY ("CustomerID") REFERENCES store."Customer"("CustomerID");


--
-- TOC entry 2814 (class 2606 OID 16492)
-- Name: Order Order_fkey_Product; Type: FK CONSTRAINT; Schema: store; Owner: shyn
--

ALTER TABLE ONLY store."Order"
    ADD CONSTRAINT "Order_fkey_Product" FOREIGN KEY ("ProductID") REFERENCES store."Product"("ProductID");


-- Completed on 2019-02-26 16:52:05 +07

--
-- PostgreSQL database dump complete
--

