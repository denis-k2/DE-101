![Структура аналитического решения](https://user-images.githubusercontent.com/78604607/114277362-26ca5e80-9a2b-11eb-9934-0936b1a18d88.png)

## Зарегестрировался в Amazon Web Services.
Создал базу данных в RDS. Выбрал PostgseSQL.

## Создание Staging
Запросы, переносящие 3 исходные таблицы из excel документа в staging.

- [stg_orders.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/stg_orders.sql)
- [stg_people.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/stg_people.sql)
- [stg_returns.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/stg_returns.sql)

## Создание Dimensional model - Snowflake schema.
![Физическая модель](https://user-images.githubusercontent.com/78604607/114273488-810ef380-9a1a-11eb-97b1-408db8628ce4.png)

- [dw_create_tables.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/dw_create_tables.sql)
- [dw_insert_dimensions.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/dw_insert_dimensions.sql)
- [dw_insert_facts.sql](https://github.com/denis-k2/DE-101/blob/main/Module2/dw_insert_facts.sql)

## Google Data Studio
Подключился к базе данных в облаке из Data Sudio и создал визуализацию.

**Пользовательский запрос:**

```sql
select * from dw.sales_fact sf
inner join dw.shipping_dim s on sf.ship_id=s.ship_id
inner join dw.geo_dim g on sf.geo_id=g.geo_id
inner join dw.product_dim p on sf.prod_id=p.prod_id
inner join dw.customer_dim cd on sf.cust_id=cd.cust_id;
```

Ссылка на dashboard скоро появится ...
