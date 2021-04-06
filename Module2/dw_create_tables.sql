create schema dw;

drop table if exists dw.product_dim;
CREATE TABLE dw.product_dim
(
 prod_id   	  serial NOT NULL, --we created surrogated key
 product_id   varchar(50) NOT NULL,  --exist in ORDERS table
 product_name varchar(255) NOT NULL,
 category     varchar(50) NOT NULL,
 sub_category varchar(50) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( prod_id )
);

drop table if exists dw.customer_dim ;
CREATE TABLE dw.customer_dim
(
 cust_id       serial NOT NULL,
 customer_id   varchar(20) NOT NULL, --id can't be NULL
 customer_name varchar(50) NOT NULL,
 segment 	   varchar(50) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( cust_id )
);

drop table if exists dw.manager_dim ;
CREATE TABLE dw.manager_dim
(
 manager_id serial NOT NULL,
 person     varchar(50) NOT NULL,
 region     varchar(50) NOT NULL,
 CONSTRAINT PK_manager_dim PRIMARY KEY ( manager_id )
);

drop table if exists dw.geo_dim ;
CREATE TABLE dw.geo_dim
(
 geo_id      serial NOT NULL,
 country     varchar(20) NOT NULL,
 state       varchar(50) NOT NULL,
 city        varchar(50) NOT NULL,
 postal_code varchar(50) NULL,       --can't be integer, we lost first 0
 manager_id  integer NOT NULL,
 CONSTRAINT PK_geo_dim PRIMARY KEY ( geo_id ),
 CONSTRAINT fk_manager_id FOREIGN KEY (manager_id) REFERENCES dw.manager_dim (manager_id)
);

drop table if exists dw.shipping_dim;
CREATE TABLE dw.shipping_dim
(
 ship_id       serial NOT NULL,
 shipping_mode varchar(50) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);

--CALENDAR use function instead 
--example https://tapoueh.org/blog/2017/06/postgresql-and-the-calendar/

drop table if exists dw.calendar_dim ;
CREATE TABLE dw.calendar_dim
(
date_id serial  NOT NULL,
year        int NOT NULL,
quarter     int NOT NULL,
month       int NOT NULL,
week        int NOT NULL,
week_day    varchar(20) NOT NULL,
date        date NOT NULL,
leap  varchar(20) NOT NULL,
CONSTRAINT PK_calendar_dim PRIMARY KEY ( date_id )
);


--METRICS

drop table if exists dw.sales_fact ;
CREATE TABLE dw.sales_fact
(
 sales_id     serial NOT NULL,
 order_id     varchar(25) NOT NULL,
 order_date   date NOT NULL,
 prod_id      integer NOT NULL,
 cust_id      integer NOT NULL,
 geo_id       integer NOT NULL,
 ship_date    date NOT NULL,
 ship_id      integer NOT NULL,
 sales        numeric(9,4) NOT NULL,
 quantity     int4 NOT NULL,
 discount     numeric(4,2) NOT NULL,
 profit       numeric(9,4) NOT NULL,
 returned     varchar(5) NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( sales_id ),
 CONSTRAINT fk_prod_id FOREIGN KEY ( prod_id ) REFERENCES dw.product_dim ( prod_id ),
 CONSTRAINT fk_cust_id FOREIGN KEY ( cust_id ) REFERENCES dw.customer_dim ( cust_id ),
 CONSTRAINT fk_geo_id FOREIGN KEY ( geo_id ) REFERENCES dw.geo_dim ( geo_id ),
 CONSTRAINT fk_ship_id FOREIGN KEY ( ship_id ) REFERENCES dw.shipping_dim ( ship_id )
);
