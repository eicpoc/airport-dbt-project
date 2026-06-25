{{ config(materialized='view') }}

select
    id                  as navaid_id,
    trim(ident)         as navaid_ident,
    trim(name)          as navaid_name,
    upper(type)         as navaid_type,
    frequency_khz,
    latitude_deg,
    longitude_deg,
    elevation_ft,
    upper(iso_country)  as country_code,
    associated_airport  as airport_ident
from {{ source('airport', 'NAVAIDS') }}
qualify row_number() over (partition by id order by id desc) = 1