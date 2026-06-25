{{ config(materialized='view') }}

select
    id                      as comment_id,
    thread_ref,
    airport_ref             as airport_id,
    trim(airport_ident)     as airport_ident,
    comment_date,
    trim(member_nickname)   as member_nickname,
    trim(subject)           as subject,
    body
from {{ source('airport', 'AIRPORT_COMMENTS') }}
where body is not null
qualify row_number() over (partition by id order by id desc) = 1