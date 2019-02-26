--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.2

-- Started on 2019-02-26 11:27:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 9 (class 2615 OID 41551)
-- Name: store; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA store;


ALTER SCHEMA store OWNER TO postgres;

SET search_path = store, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 206 (class 1259 OID 41574)
-- Name: Customer; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE "Customer" (
    "CustomerID" character(6) NOT NULL,
    "LastName" character varying(20),
    "FirstName" character varying(10),
    "Address" character varying(50),
    "City" character varying(20),
    "State" character(2),
    "Zip" character(5),
    "Phone" character varying(15)
);


ALTER TABLE "Customer" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 41577)
-- Name: Order; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE "Order" (
    "ProductID" character(6) NOT NULL,
    "OrderID" character(6) NOT NULL,
    "CustomerID" character(6) NOT NULL,
    "PurchaseDate" date,
    "Quantity" integer,
    "TotalCost" money
);


ALTER TABLE "Order" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 41580)
-- Name: Product; Type: TABLE; Schema: store; Owner: postgres
--

CREATE TABLE "Product" (
    "ProductID" character(6) NOT NULL,
    "ProductName" character varying(40),
    "Model" character varying(10),
    "Manufacturer" character varying(40),
    "UnitPrice" money,
    "Inventory" integer
);


ALTER TABLE "Product" OWNER TO postgres;

--
-- TOC entry 2829 (class 0 OID 41574)
-- Dependencies: 206
-- Data for Name: Customer; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO "Customer" VALUES ('BLU003', 'AAAA', 'Katie', '342 Pine', 'Hammond', 'IN', '46200', '555-9242');
INSERT INTO "Customer" VALUES ('BLU001', 'Blum', 'Jessica', '229 State', 'Whiting', 'IN', '46300', '555-0921');
INSERT INTO "Customer" VALUES ('BLU005', 'Bbbbbbbb', 'Rich', '123 Main St.', 'Chicago', 'IL', '60633', '555-1234');
INSERT INTO "Customer" VALUES ('WIL001', 'Williams', 'Frank', '456 Oak St.', 'Hammond', 'IN', '46102', NULL);


--
-- TOC entry 2830 (class 0 OID 41577)
-- Dependencies: 207
-- Data for Name: Order; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO "Order" VALUES ('LAP001', 'ODR001', 'BLU001', '2012-08-21', 1, '$1.30');
INSERT INTO "Order" VALUES ('LAP002', 'ODR002', 'BLU003', '2012-02-03', 2, '$2.00');
INSERT INTO "Order" VALUES ('LAP001', 'ORD003', 'WIL001', '2012-06-06', 1, '$1.30');


--
-- TOC entry 2831 (class 0 OID 41580)
-- Dependencies: 208
-- Data for Name: Product; Type: TABLE DATA; Schema: store; Owner: postgres
--

INSERT INTO "Product" VALUES ('LAP001', 'Vaio CR31Z', 'CR', 'Sony Vaio', '$1.30', 5);
INSERT INTO "Product" VALUES ('LAP002', 'HP AZE', 'HP', NULL, '$1.00', 18);
INSERT INTO "Product" VALUES ('LAP003', 'HP 34', 'HP', 'HP', '$1,000.00', 200);


--
-- TOC entry 2701 (class 2606 OID 41598)
-- Name: Customer pk_Customer; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY "Customer"
    ADD CONSTRAINT "pk_Customer" PRIMARY KEY ("CustomerID");


--
-- TOC entry 2705 (class 2606 OID 41600)
-- Name: Product pk_Product; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY "Product"
    ADD CONSTRAINT "pk_Product" PRIMARY KEY ("ProductID");


--
-- TOC entry 2703 (class 2606 OID 41602)
-- Name: Order pk_order; Type: CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT pk_order PRIMARY KEY ("OrderID");


--
-- TOC entry 2706 (class 2606 OID 41618)
-- Name: Order fk_order_customer; Type: FK CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT fk_order_customer FOREIGN KEY ("CustomerID") REFERENCES "Customer"("CustomerID");


--
-- TOC entry 2707 (class 2606 OID 41623)
-- Name: Order fk_order_product; Type: FK CONSTRAINT; Schema: store; Owner: postgres
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT fk_order_product FOREIGN KEY ("ProductID") REFERENCES "Product"("ProductID");


-- Completed on 2019-02-26 11:27:42

--
-- PostgreSQL database dump complete
--

