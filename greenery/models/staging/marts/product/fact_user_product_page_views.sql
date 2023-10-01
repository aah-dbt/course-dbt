{{ config(materialized='table') }}
  
SELECT 
    e.user_id, 
    u.first_name,
    u.last_name,
    u.email,
    u.address_id,
    e.session_id,
    e.product_id,
    e.is_product_purchased,
    e.checkouts,
    e.package_shipped,
    e.add_to_cart,
    e.page_view ,
    p.name AS product_name,
    p.price AS product_price
FROM
    {{ref('int_user_product_page_views')}} e 
LEFT JOIN   
    {{ref('stage_postgres__users')}} u
ON  
    e.user_id = u.user_id
LEFT JOIN
    {{ref('stage_postgres__products')}} p 
ON
    e.product_id = p.product_id 