
{{ config(materialized='table') }}
 

SELECT 
    u.user_id, 
    a.state,
    a.country,
    count(distinct o.order_id) number_of_order,
    count(distinct case when o.status = 'delivered' then o.order_id end) number_of_order_delivered,
    count(distinct case when o.status = 'shipped' then o.order_id end)  number_of_order_shipped,
    count(distinct case when o.status = 'preparing' then o.order_id end)  number_of_order_preparing,
    count(distinct p.promo_id) number_of_promo,
    sum(o.order_total) order_total,
    sum(p.discount) total_discount,
    avg(datediff('minute',o.created_at,coalesce(o.delivered_at,o.estimated_delivery_at))) avg_delivery_duration_mm,
    sum(datediff('minute',o.created_at,coalesce(o.delivered_at,o.estimated_delivery_at))) total_delivery_duration_mm,
    TO_BOOLEAN(CASE WHEN count(distinct o.order_id) >= 2 THEN 'true' ELSE 'false' END) has_ordered_two_plus,
    MIN(o.created_at) first_order_date,
    MAX(o.created_at) last_order_date
FROM
    {{ref('stage_postgres__users')}} u
LEFT JOIN  
    {{ref('stage_postgres__orders')}} o
ON u.user_id = o.user_id
LEFT JOIN  
    {{ref('stage_postgres__addresses')}} a
ON u.address_id = a.address_id
LEFT JOIN  
    {{ref('stage_postgres__promos')}} p
ON o.promo_id = p.promo_id
GROUP BY ALL