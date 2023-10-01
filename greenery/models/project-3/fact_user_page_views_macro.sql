{{ config(materialized='table') }}
 

 SELECT 
    e.user_id,
    u.first_name,
    u.last_name,
    u.email,
    e.session_id,
    {{event_types('stage_postgres__events','event_type')}}
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