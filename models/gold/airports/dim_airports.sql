{{ config(materialized='table') }}

with airports as (
    select * from {{ ref('src_airports') }}
),
countries as (
    select * from {{ ref('src_countries') }}
),
regions as (
    select * from {{ ref('src_regions') }}
)
select
    a.airport_id,
    a.airport_ident,
    a.airport_name,
    a.airport_type,
    a.latitude_deg,
    a.longitude_deg,
    a.elevation_ft,
    a.municipality,
    c.country_name,
    a.country_code,
    r.region_name,
    a.region_code,
    a.scheduled_service,
    a.icao_code,
    a.iata_code
from airports a
left join countries c on a.country_code = c.country_code
left join regions r on a.region_code = r.region_code