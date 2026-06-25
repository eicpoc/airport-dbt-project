{{ config(materialized='table') }}

select
    a.country_name,
    count(distinct r.runway_id)                    as total_runways,
    sum(r.length_ft)                                as total_runway_length_ft,
    round(avg(r.length_ft), 0)                      as avg_runway_length_ft,
    sum(case when r.is_lighted then 1 else 0 end)   as lighted_runway_count,
    sum(case when r.is_closed then 1 else 0 end)    as closed_runway_count
from {{ ref('fct_runways') }} r
join {{ ref('dim_airports') }} a
    on r.airport_id = a.airport_id
group by 1
order by total_runway_length_ft desc