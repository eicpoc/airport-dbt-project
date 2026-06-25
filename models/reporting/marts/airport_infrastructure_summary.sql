{{ config(materialized='table') }}

select
    a.airport_id,
    a.airport_name,
    a.country_name,
    a.region_name,
    count(distinct r.runway_id)      as total_runways,
    count(distinct n.navaid_id)      as total_navaids,
    count(distinct f.frequency_id)   as total_frequencies,
    count(distinct c.comment_id)     as total_comment
from {{ ref('dim_airports') }} a
left join {{ ref('fct_runways') }} r on a.airport_id = r.airport_id
left join {{ ref('fct_navaids') }} n on a.airport_ident = n.airport_ident
left join {{ ref('fct_airport_frequencies') }} f on a.airport_id = f.airport_id
left join {{ ref('fct_airport_comments') }} c on a.airport_id = c.airport_id
group by 1, 2, 3, 4