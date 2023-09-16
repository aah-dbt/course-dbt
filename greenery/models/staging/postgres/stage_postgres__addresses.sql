
{{ config(materialized='view') }}

with source as (
    select * from {{source('postgres','addresses')}}
)
select 
    address_id,
    address,
    zipcode,
    state,
    country
from 
    source