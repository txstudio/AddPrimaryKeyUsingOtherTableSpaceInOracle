-- -----------------------------------------
-- 依照不同情境建立主索引鍵 (primary-key)
-- -----------------------------------------


-- -----------------------------------------
-- case 1 : 一般情況設定主索引鍵 (primary-key) 與索引 (index)
-- -----------------------------------------
CREATE INDEX SYSTEM.STOCK_SCHEMA_INDEX
	ON SYSTEM.STOCKS (SCHEMA ASC);
  
ALTER TABLE SYSTEM.STOCKS ADD (
	CONSTRAINT SYSTEM_STOCK_PK
	PRIMARY KEY (NO)
);

/*
DROP INDEX SYSTEM.STOCK_SCHEMA_INDEX;

ALTER TABLE SYSTEM.STOCKS
	DROP CONSTRAINT SYSTEM_STOCK_PK;
*/

-- -----------------------------------------
-- case 2 : 將主索引鍵 (primary-key) 與索引 (index) 放到不同的表格空間 (tablespace)
-- -----------------------------------------
CREATE INDEX SYSTEM.STOCK_SCHEMA_INDEX
	ON SYSTEM.STOCKS (SCHEMA ASC)
	TABLESPACE STOCK_INDEX;
  
ALTER TABLE SYSTEM.STOCKS ADD (
	CONSTRAINT SYSTEM_STOCK_PK
	PRIMARY KEY (NO)
	USING INDEX TABLESPACE STOCK_INDEX
);

/*
DROP INDEX SYSTEM.STOCK_SCHEMA_INDEX;

ALTER TABLE SYSTEM.STOCKS
	DROP CONSTRAINT SYSTEM_STOCK_PK;
*/

-- -----------------------------------------
-- case 2 : 先建立唯一索引後再建立主索引鍵 (primary-key)
-- -----------------------------------------
CREATE INDEX "SYSTEM".STOCK_SCHEMA_INDEX
	ON SYSTEM.STOCKS (SCHEMA ASC)
	TABLESPACE STOCK_INDEX;
	
CREATE UNIQUE INDEX "SYSTEM".STOCK_NO_INDEX
	ON SYSTEM.STOCKS (NO ASC)
	TABLESPACE STOCK_INDEX;

ALTER TABLE "SYSTEM".STOCKS ADD (
	CONSTRAINT STOCK_PK
	PRIMARY KEY(NO)
	USING INDEX "SYSTEM"."STOCK_NO_INDEX"
);

/*
DROP INDEX SYSTEM.STOCK_SCHEMA_INDEX;

ALTER TABLE SYSTEM.STOCKS
	DROP CONSTRAINT STOCK_PK;
	
DROP INDEX SYSTEM.STOCK_NO_INDEX;
*/
