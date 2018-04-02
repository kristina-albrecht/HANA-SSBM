CREATE INDEX idx_c_city ON customer(C_City);
CREATE INDEX idx_p_brand ON part(P_Brand);
CREATE INDEX idx_s_city ON supplier(S_City);
CREATE INDEX idx_d_yearmonthnum ON dim_date(D_YEARMONTHNUM);
CREATE INDEX idx_d_yearmonth ON dim_date(D_YEARMONTH);
CREATE INDEX idx_d_daynuminyear ON dim_date(D_DAYNUMINYEAR);

