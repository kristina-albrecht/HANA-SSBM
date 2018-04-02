CREATE INDEX idx_d_weeknuminyear_d_year ON dim_date(D_WeekNumInYear, D_Year);
CREATE INDEX idx_d_yearmonthnum ON dim_date(D_YearMonthNum);
CREATE INDEX idx_lo_discount_lo_quantity ON lo_lineorder(LO_Discount,LO_Quantity);