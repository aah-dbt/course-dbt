

{% snapshot users_snapshot %}

{{
    config(
        target_database='dev_db',
        target_schema='dbt_abdullahahmedclearmecom',

        unique_key='user_id',
        strategy='timestamp',
        updated_at='updated_at',
    )
}}

select * from {{ source('postgres', 'users') }}

{% endsnapshot %}