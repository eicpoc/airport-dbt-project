{{ config(materialized='table') }}

select
    f.frequency_id,
    f.airport_id,
    a.airport_name,
    f.frequency_type,
    f.description,
    f.frequency_mhz
from {{ ref('src_airport_frequencies') }} f
left join {{ ref('dim_airports') }} a
    on f.airport_id = a.airport_id