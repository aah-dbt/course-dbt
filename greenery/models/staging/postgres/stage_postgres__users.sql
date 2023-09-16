
{{ config(materialized='view') }}

with pg_users as (
    select * from {{source('postgres','users')}}
)
select 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
from 
    pg_users