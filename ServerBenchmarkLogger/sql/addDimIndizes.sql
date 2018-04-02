CREATE INDEX idx_c_region ON customer(C_Region);
CREATE INDEX idx_c_mktsegment ON customer(C_MktSegment);

CREATE INDEX idx_p_mfgr ON part(P_MFGR);
CREATE INDEX idx_p_category ON part(P_Category);

CREATE INDEX idx_s_nation ON supplier(S_Nation);
CREATE INDEX idx_s_region ON supplier(S_Region);

CREATE INDEX idx_d_year ON dim_date(D_Year);

