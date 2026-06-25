{{ config(materialized='view') }}

select
    id                      as runway_id,
    airport_ref             as airport_id,
    trim(airport_ident)     as airport_ident,
    length_ft,
    width_ft,
    upper(surface)          as surface_type,
    coalesce(lighted, false) as is_lighted,
    coalesce(closed, false)  as is_closed,
    le_ident,
    le_latitude_deg,
    le_longitude_deg,
    le_heading_degt,
    he_ident,
    he_latitude_deg,
    he_longitude_deg,
    he_heading_degt
from {{ source('airport', 'RUNWAYS') }}
where airport_ref is not null
qualify row_number() over (partition by id order by id desc) = 1