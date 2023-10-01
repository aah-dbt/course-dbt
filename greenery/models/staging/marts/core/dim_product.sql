{{ config(materialized='table') }}

SELECT *
FROM
    {{ref('stage_postgres__products')}}