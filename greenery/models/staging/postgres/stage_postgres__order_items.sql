
{{ config(materialized='view') }}

with pg_order_item as (
    select * from {{source('postgres','order_items')}}
)
select 
    order_id,
    product_id,
    quantity
from 
    pg_order_item