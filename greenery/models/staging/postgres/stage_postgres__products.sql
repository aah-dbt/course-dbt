{{ config(materialized='view') }}

with pg_product as (
    select * from {{source('postgres','products')}}
)
select 
    product_id,
    name,
    price,
    inventory
from 
    pg_product