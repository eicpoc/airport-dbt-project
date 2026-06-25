{{
    config(
        materialized='incremental',
        unique_key='comment_id',
        incremental_strategy='merge',
        on_schema_change='fail'
    )
}}

select
    c.comment_id,
    c.airport_id,
    a.airport_name,
    c.comment_date,
    c.member_nickname,
    c.subject,
    c.body
from {{ ref('src_airport_comments') }} c
left join {{ ref('dim_airports') }} a
    on c.airport_id = a.airport_id
where 1=1
{% if is_incremental() %}
    and c.comment_date > (select max(comment_date) from {{ this }})
{% endif %}