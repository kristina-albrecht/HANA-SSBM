CREATE TABLE queries (
    querykey INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    query_major  INTEGER NOT NULL,
    qery_minor     INTEGER NOT NULL,
    PRIMARY KEY    (querykey)
);

CREATE TABLE indexconfig (
    indexconfigkey INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY
    indexconfigname VARCHAR(20)
    PRIMARY KEY    (indexconfigkey)
);


CREATE TABLE measurementkey (
    measurementkey INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY
--dims
    querykey INTEGER
    indexconfigkey INTEGER
    olaphint BOOLEAN
    column   BOOLEAN
    cpucount INTEGER
    threadcount INTEGER
    scalefactor INTEGER
    repetition  INTEGER
--facts
    runtime INTEGER
    curstime INTEGER
    usertime INTEGER
    l1misses INTEGER
    l1hits   INTEGER
    llmisses INTEGER
    llhits   INTEGER
    PRIMARY KEY    (measurementkey)   
);