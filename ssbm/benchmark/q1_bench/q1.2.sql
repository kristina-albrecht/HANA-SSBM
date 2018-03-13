select sum(lo_extendedprice*lo_discount) as revenue
from lineorder
join  dim_date on lo_orderdatekey = d_datekey
where  D_YearMonthNum = 199401 and lo_discount
between 4 and 6 and lo_quantity between 26 and 35;
