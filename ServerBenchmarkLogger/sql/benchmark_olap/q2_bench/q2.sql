select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
 on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey join supplier
on lo_suppkey = s_suppkey
where  p_category = 'MFGR#12'
and s_region = 'AMERICA'
group by d_year, p_brand
order by d_year, p_brand
WITH HINT(USE_OLAP_PLAN);

select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey
join supplier
on lo_suppkey = s_suppkey
where  p_brand between 'MFGR#2221' and 'MFGR#2228'
and s_region = 'ASIA'
group by d_year, p_brand
order by d_year, p_brand
WITH HINT(USE_OLAP_PLAN);

select sum(lo_revenue), d_year, p_brand
from lineorder
join dim_date
on lo_orderdatekey = d_datekey
join part
on lo_partkey = p_partkey
join supplier
on lo_suppkey = s_suppkey
where  p_brand= 'MFGR#2239'
and s_region = 'EUROPE'
group by d_year, p_brand
order by d_year, p_brand
WITH HINT(USE_OLAP_PLAN);
