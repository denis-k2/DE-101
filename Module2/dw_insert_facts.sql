insert into dw.sales_fact
select
100+row_number() over () as sales_id,
order_id,
order_date,
prod_id,
cust_id,
geo_id,
ship_date,
ship_id,
sales,
quantity,
discount,
profit,
returned
from
(select distinct
o.order_id,
order_date,
p.prod_id,
cd.cust_id,
geo_id,
ship_date,
s.ship_id,
sales,
quantity,
discount,
profit,
returned
from stg.orders o
inner join dw.product_dim p on o.product_name = p.product_name and o.subcategory=p.sub_category and o.category=p.category and o.product_id=p.product_id
inner join dw.customer_dim cd on cd.customer_id=o.customer_id and cd.customer_name=o.customer_name 
inner join dw.geo_dim g on g.country=o.country and g.city = o.city and g.state = o.state and g.postal_code = o.postal_code --City Burlington doesn't have postal code
inner join dw.shipping_dim s on o.ship_mode = s.shipping_mode
left join stg."returns" r on r.order_id = o.order_id) a;
