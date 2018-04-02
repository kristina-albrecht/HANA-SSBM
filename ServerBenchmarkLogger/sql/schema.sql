DROP TABLE  customer;

CREATE COLUMN TABLE  customer (
	C_CUSTOMERKEY INTEGER,
	C_Name varchar(25),
	C_Address varchar(25),
	C_City varchar(10),
	C_Nation varchar(15),
	C_Region varchar(12),
	C_Phone varchar(15),
	C_MktSegment varchar(10),
	PRIMARY KEY ("C_CUSTOMERKEY")
);

CREATE INDEX idx_c_name ON customer(C_Name);
CREATE INDEX idx_c_city ON customer(C_City);
CREATE INDEX idx_c_region ON customer(C_Region);
CREATE INDEX idx_c_phone ON customer(C_Phone);
CREATE INDEX idx_c_mktsegment ON customer(C_MktSegment);

DROP TABLE  part;

CREATE COLUMN TABLE  part
(
	P_PartKey integer,
	P_Name varchar(25),
	P_MFGR varchar(10),
	P_Category varchar(10),
	P_Brand varchar(15),
	P_Colour varchar(15),
	P_Type varchar(25),
	P_Size tinyint,
	P_Container char(10),
	PRIMARY KEY (P_PartKey)
);

CREATE INDEX idx_p_name ON part(P_Name);
CREATE INDEX idx_p_mfgr ON part(P_MFGR);
CREATE INDEX idx_p_category ON part(P_Category);
CREATE INDEX idx_p_brand ON part(P_Brand);


DROP TABLE  supplier;

CREATE COLUMN TABLE  supplier (
	S_SuppKey integer,
	S_Name char(25),
	S_Address varchar(25),
	S_City char(10),
	S_Nation char(15),
	S_Region char(12),
	S_Phone char(15),
	PRIMARY KEY(S_SuppKey)
);

CREATE INDEX idx_s_city ON supplier(S_City);
CREATE INDEX idx_s_name ON supplier(S_Name);
CREATE INDEX idx_s_phone ON supplier(S_Phone);



DROP TABLE  dim_date;

CREATE COLUMN TABLE  dim_date
(
	D_DateKey integer,
	D_Date char(18),
	D_DayOfWeek char(9),
	D_Month char(9),
	D_Year smallint,
	D_YearMonthNum integer,
	D_YearMonth char(7),
	D_DayNumInWeek tinyint,
	D_DayNumInMonth tinyint,
	D_DayNumInYear smallint,
	D_MonthNumInYear tinyint,
	D_WeekNumInYear tinyint,
	D_SellingSeason char(12),
	D_LastDayInWeekFl tinyint,
	D_LastDayInMonthFl tinyint,
	D_HolidayFl tinyint,
	D_WeekDayFl tinyint,
	PRIMARY KEY(D_DateKey)
);

DROP TABLE lineorder;

CREATE COLUMN TABLE  lineorder
(
	LO_OrderKey bigint not null,
	LO_LineNumber tinyint not null,
	LO_CustKey int not null,
	LO_PartKey int not null,
	LO_SuppKey int not null,
	LO_OrderDateKey int not null,
	LO_OrderPriority varchar(15),
	LO_ShipPriority char(1),
	LO_Quantity tinyint,
	LO_ExtendedPrice decimal,
	LO_OrdTotalPrice decimal,
	LO_Discount decimal,
	LO_Revenue decimal,
	LO_SupplyCost decimal,
	LO_Tax tinyint,
	LO_CommitDateKey integer not null,
	LO_ShipMode varchar(10)
);

CREATE INDEX idx_lo_orderkey_lo_linenumber ON lineorder(LO_OrderKey, LO_LineNumber);
CREATE INDEX idx_lo_custkey ON lineorder(LO_CustKey);
CREATE INDEX idx_lo_suppkey ON lineorder(LO_SuppKey);
CREATE INDEX idx_lo_partkey ON lineorder(LO_PartKey);
CREATE INDEX idx_lo_orderdatekey ON lineorder(LO_OrderDateKey);
CREATE INDEX idx_lo_commitdatekey ON lineorder(LO_CommitDateKey);
