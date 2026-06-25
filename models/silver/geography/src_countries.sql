{{ config(materialized='view') }}

select
    id               as country_id,
    upper(code)      as country_code,
    trim(name)       as country_name,
    upper(continent) as continent_code
from {{ source('airport', 'COUNTRIES') }}
qualify row_number() over (partition by code order by id desc) = 1