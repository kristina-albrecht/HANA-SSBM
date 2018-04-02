select d_year, c_nation,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
c_region = 'AMERICA'
and s_region = 'AMERICA'
and (p_mfgr = 'MFGR#1'
or p_mfgr = 'MFGR#2')
group by d_year, c_nation
order by d_year, c_nation
WITH HINT(USE_OLAP_PLAN);

select d_year, s_nation, p_category,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
c_region = 'AMERICA'
and s_region = 'AMERICA'
and (d_year = 1997 or d_year = 1998)
and (p_mfgr = 'MFGR#1'
or p_mfgr = 'MFGR#2')
group by d_year, s_nation, p_category
order by d_year, s_nation, p_category
WITH HINT(USE_OLAP_PLAN);

select d_year, s_city, p_brand,
sum(lo_revenue - lo_supplycost) as profit
from lineorder
join dim_date
  on lo_orderdatekey = d_datekey
join customer
  on lo_custkey = c_customerkey
join supplier
  on lo_suppkey = s_suppkey
join part
  on lo_partkey = p_partkey
where
s_nation = 'UNITED STATES'
and (d_year = 1997 or d_year = 1998)
and p_category = 'MFGR#14'
group by d_year, s_city, p_brand
order by d_year, s_city, p_brand
WITH HINT(USE_OLAP_PLAN);

