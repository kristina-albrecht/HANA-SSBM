ALTER TABLE  customer ROW;

ALTER TABLE  part ROW;

ALTER TABLE  supplier ROW;

ALTER TABLE  dim_date ROW;

DROP TABLE  lineorder;

CREATE ROW TABLE  lineorder
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

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.tbl' INTO "SYSTEM"."LINEORDER" 
WITH

record delimited by '\n' 
field delimited by '|';

CREATE INDEX idx_lo_orderkey_lo_linenumber ON lineorder(LO_OrderKey, LO_LineNumber);
CREATE INDEX idx_lo_custkey ON lineorder(LO_CustKey);
CREATE INDEX idx_lo_suppkey ON lineorder(LO_SuppKey);
CREATE INDEX idx_lo_partkey ON lineorder(LO_PartKey);
CREATE INDEX idx_lo_orderdatekey ON lineorder(LO_OrderDateKey);
CREATE INDEX idx_lo_commitdatekey ON lineorder(LO_CommitDateKey);
