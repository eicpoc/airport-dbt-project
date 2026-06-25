{{ config(materialized='table') }}

select
    n.navaid_id,
    n.navaid_ident,
    n.navaid_name,
    n.navaid_type,
    n.frequency_khz,
    n.country_code,
    a.airport_name,
    n.airport_ident
from {{ ref('src_navaids') }} n
left join {{ ref('dim_airports') }} a
    on n.airport_ident = a.airport_ident