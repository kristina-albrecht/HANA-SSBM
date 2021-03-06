CREATE COLUMN TABLE queries (
    Q_Key	INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    Q_Group	INTEGER NOT NULL,
    Q_Query	INTEGER NOT NULL,
    PRIMARY	KEY    (Q_Key)
);

CREATE COLUMN TABLE schema (
    S_Key	INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    S_SchemaType VARCHAR(5),
    PRIMARY KEY    (S_Key)
);

CREATE COLUMN TABLE indices (
    I_ConfigKey INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY
    I_Configname VARCHAR(20)
    PRIMARY KEY    (I_Configkey)
);


CREATE COLUMN TABLE Measurements (
    M_Key	INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY
--dims
    M_QueryKey INTEGER
    M_IndexConfigKey	INTEGER
	M_SchemaKey	INTEGER
    M_Olaphint	BOOLEAN
--facts
    M_CpuCount	INTEGER
    M_ThreadCount	INTEGER
    M_ScaleFactor	INTEGER
    M_Repetition 	INTEGER

    M_Runtime INTEGER
    M_Curstime INTEGER
    M_Usertime INTEGER
    M_l1misses INTEGER
    M_l1hits   INTEGER
    M_llmisses INTEGER
    M_llhits   INTEGER
    PRIMARY KEY    (M_Key)   
);