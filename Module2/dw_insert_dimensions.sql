insert into dw.product_dim (prod_id, product_id, product_name, category, sub_category)
select 100+row_number() over (), product_id, product_name, category, subcategory from (select distinct product_id,product_name,category,subcategory from stg.orders) a;

insert into dw.customer_dim 
select 100+row_number() over(), customer_id, customer_name, segment from (select distinct customer_id, customer_name, segment from stg.orders ) a;

insert into dw.manager_dim 
select 100+row_number() over(), person, region from (select distinct person, region from stg.people ) a;

insert into dw.geo_dim 
select 100+row_number() over(), country, state, city, postal_code, manager_id
from (select distinct orders.country, orders.state, orders.city, orders.postal_code, m.manager_id from stg.orders join dw.manager_dim m on orders.region = m.region) a;

insert into dw.shipping_dim 
select 100+row_number() over(), ship_mode from (select distinct ship_mode from stg.orders ) a;


insert into dw.calendar_dim 
select 
to_char(date,'yyyymmdd')::int as date_id,  
       extract('year' from date)::int as year,
       extract('quarter' from date)::int as quarter,
       extract('month' from date)::int as month,
       extract('week' from date)::int as week,
       to_char(date, 'dy') as week_day,
       date::date,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
  from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day')
       as t(date);
