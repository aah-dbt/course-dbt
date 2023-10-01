{{ config(materialized='table') }}
 

 WITH product_order AS
(
SELECT DISTINCT
    o.user_id, 
    i.product_id,
    e.session_id,
    e.event_id
FROM
    {{ref('stage_postgres__events')}} e 
JOIN
    {{ref('stage_postgres__order_items')}}  i
ON
    e.order_id = i.order_id 
JOIN
    stage_postgres__orders o
ON
    o.order_id = i.order_id   
)
SELECT 
    e.user_id, 
    e.session_id,
    COALESCE(e.product_id,po.product_id) product_id,
    TO_BOOLEAN(IFF(SUM(IFF(event_type = 'checkout', 1, 0)) > 0,'true','false')) is_product_purchased,
    SUM(IFF(event_type = 'checkout', 1, 0)) checkouts,
    SUM(IFF(event_type = 'package_shipped', 1, 0)) package_shipped,
    SUM(IFF(event_type = 'add_to_cart', 1, 0)) add_to_cart,
    SUM(IFF(event_type = 'page_view', 1, 0)) page_view 
FROM
    {{ref('stage_postgres__events')}} e
LEFT JOIN
    product_order po
ON
    e.event_id = po.event_id 
    and e.user_id = po.user_id 
GROUP BY ALL