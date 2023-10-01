{{ config(
    materialized='table',
    post_hook= 'grant select on {{ this}} to reporting' 
) }}
  
SELECT 
    e.user_id, 
    u.first_name,
    u.last_name,
    u.email,
    u.address_id,
    e.session_id,
    e.product_id,
    e.is_product_purchased,
    {{event_type_names('stage_postgres__events','event_type','e.')}}
    p.name AS product_name,
    p.price AS product_price
FROM
    {{ref('int_user_product_page_views_macro')}} e 
LEFT JOIN   
    {{ref('stage_postgres__users')}} u
ON  
    e.user_id = u.user_id
LEFT JOIN
    {{ref('stage_postgres__products')}} p 
ON
    e.product_id = p.product_id 