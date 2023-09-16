
{{ config(materialized='view') }}

with pg_promos as (
    select * from {{source('postgres','promos')}}
)
select 
    promo_id,
    discount,
    status
from 
    pg_promos

