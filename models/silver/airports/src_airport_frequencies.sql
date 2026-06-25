{{ config(materialized='view') }}

select
    id                  as frequency_id,
    airport_ref         as airport_id,
    trim(airport_ident) as airport_ident,
    upper(type)         as frequency_type,
    trim(description)   as description,
    frequency_mhz
from {{ source('airport', 'AIRPORT_FREQUENCIES') }}
where frequency_mhz is not null
qualify row_number() over (partition by id order by id desc) = 1