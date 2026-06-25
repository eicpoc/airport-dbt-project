{{ config(materialized='view') }}

select
    id                  as region_id,
    code                as region_code,
    local_code,
    trim(name)          as region_name,
    upper(continent)    as continent_code,
    upper(iso_country)  as country_code
from {{ source('airport', 'REGIONS') }}
qualify row_number() over (partition by code order by id desc) = 1