{%- macro event_type_names(table_name,column_name,prefix) -%} 

{%-
    set event_types= dbt_utils.get_column_values(
        table =ref(table_name)
        ,column=column_name
    )
-%}
    {%- for event_type in event_types %} 
    {{ event_type }},
    {%- endfor %} 
{%- endmacro %}