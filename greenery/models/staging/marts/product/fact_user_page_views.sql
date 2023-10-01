{{ config(materialized='table') }}
 

 SELECT 
    e.user_id,
    u.first_name,
    u.last_name,
    u.email,
    e.session_id, 
    SUM(IFF(event_type = 'checkout', 1, 0)) checkouts,
    SUM(IFF(event_type = 'package_shipped', 1, 0)) package_shipped,
    SUM(IFF(event_type = 'add_to_cart', 1, 0)) add_to_cart,
    SUM(IFF(event_type = 'page_view', 1, 0)) page_view,
    MIN(e.created_at) session_start,
    MAX(e.created_at) session_end,
    DATEDIFF('MINUTE',MIN(e.created_at),MAX(e.created_at)) session_duration_mm
FROM
    {{ref('stage_postgres__users')}} u
JOIN
    {{ref('stage_postgres__events')}} e
ON  
    u.user_id = e.user_id
GROUP BY ALL