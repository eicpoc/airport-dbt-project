{{ config(materialized='table') }}

select
    a.region_name,
    a.country_name,
    count(distinct n.navaid_id)        as total_navaids,
    count(distinct n.navaid_type)      as distinct_navaid_types,
    case
        when count(distinct n.navaid_id) = 0 then 'No Coverage'
        when count(distinct n.navaid_id) < 3 then 'Low Coverage'
        else 'Adequate Coverage'
    end as coverage_status
from {{ ref('dim_airports') }} a
left join {{ ref('fct_navaids') }} n
    on a.airport_ident = n.airport_ident
group by 1, 2
order by total_navaids asc