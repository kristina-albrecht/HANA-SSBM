IMPORT FROM CSV FILE '/hana/shared/HXE/HDB90/work/SSBM1/date.tbl' INTO "SYSTEM"."DIM_DATE" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/hana/shared/HXE/HDB90/work/SSBM1/customer.tbl' INTO "SYSTEM"."CUSTOMER" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/hana/shared/HXE/HDB90/work/SSBM1/lineorder.tbl' INTO "SYSTEM"."LINEORDER" 
WITH

batch 10000
record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/hana/shared/HXE/HDB90/work/SSBM1/part.tbl' INTO "SYSTEM"."PART" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/hana/shared/HXE/HDB90/work/SSBM1/supplier.tbl' INTO "SYSTEM"."SUPPLIER" 
WITH

record delimited by '\n' 
field delimited by '|';


