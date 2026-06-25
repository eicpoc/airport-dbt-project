{{ config(materialized='view') }}

select
    id                  as airport_id,
    trim(ident)         as airport_ident,
    trim(type)          as airport_type,
    trim(name)          as airport_name,
    latitude_deg,
    longitude_deg,
    elevation_ft,
    upper(continent)    as continent_code,
    upper(iso_country)  as country_code,
    upper(iso_region)   as region_code,
    trim(municipality)  as municipality,
    scheduled_service,
    icao_code,
    iata_code,
    gps_code,
    local_code
from {{ source('airport', 'AIRPORTS') }}
where ident is not null
qualify row_number() over (partition by ident order by id desc) = 1