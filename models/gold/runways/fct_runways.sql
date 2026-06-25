{{ config(materialized='table') }}

select
    r.runway_id,
    r.airport_id,
    r.airport_ident,
    a.airport_name,
    a.country_code,
    r.length_ft,
    r.width_ft,
    r.surface_type,
    r.is_lighted,
    r.is_closed
from {{ ref('src_runways') }} r
left join {{ ref('dim_airports') }} a
    on r.airport_id = a.airport_id