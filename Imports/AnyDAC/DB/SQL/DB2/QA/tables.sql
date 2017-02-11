-- $DELIMITER ;

DROP TABLE "ADQA_All_types";

CREATE TABLE "ADQA_All_types"  (
      "TBIGINT" BIGINT,        
      "TBLOB" BLOB(10485760) NOT LOGGED NOT COMPACT, 
      "TCHAR" CHAR(10), 
      "TCHAR_BIT" CHAR(100) FOR BIT DATA, 
      "TCLOB" CLOB(15728640) NOT LOGGED NOT COMPACT, 
      --"TDATALINK" DATALINK, 
      "TDATE" DATE, 
      "TDECIMAL" DECIMAL(19,4), 
      "TDOUBLE" DOUBLE, 
      "TGRAPHIC" GRAPHIC(100), 
      "TINTEGER" INTEGER, 
      "TLONGVARCHAR" LONG VARCHAR,
      "TLONGVARGRAPHIC" LONG VARGRAPHIC,
      "TREAL" REAL, 
      "TSMALLINT" SMALLINT, 
      "TTIME" TIME, 
      "TTIMESTAMP" TIMESTAMP, 
      "TVARCHAR" VARCHAR(10), 
      "TVARCHAR_BIT" VARCHAR(10) FOR BIT DATA, 
      "TVARGRAPHIC" VARGRAPHIC(100),
      "TDBCLOB" DBCLOB(15728640) NOT LOGGED NOT COMPACT
      );   

DROP TABLE "ADQA_Ascii_types"; 

CREATE TABLE "ADQA_Ascii_types"  (
      "ATSTRING" VARCHAR(5), 
      "ATFLOAT" REAL, 
      "ATNUMBER" SMALLINT, 
      "ATBOOL" SMALLINT, 
      "ATLONGINT" INTEGER, 
      "ATDATE" DATE, 
      "ATTIME" TIME, 
      "ATDATETIME" TIMESTAMP, 
      "ATBLOB" BLOB(10) NOT LOGGED NOT COMPACT, 
      "ATMEMO" LONG VARCHAR );

DROP TABLE "ADQA_Batch_test";

CREATE TABLE "ADQA_Batch_test"  (
      "TINT" INTEGER, 
      "TSTRING" VARCHAR(50), 
      "TBLOB" BLOB(1024) NOT LOGGED NOT COMPACT );

DROP TABLE "ADQA_Blob";      

CREATE TABLE "ADQA_Blob"  (
      "ID" INTEGER NOT NULL GENERATED BY DEFAULT
      AS IDENTITY ( START WITH +0, INCREMENT BY +1, NO CACHE ),
      "BLOBDATA" BLOB(1073741824) NOT LOGGED NOT COMPACT );

DROP TABLE "ADQA_DB_types"; 

CREATE TABLE "ADQA_DB_types"  (
      "FTSTRING" VARCHAR(50), 
      "FTSMALLINT" SMALLINT, 
      "FTINTEGER" INTEGER, 
      "FTWORD" SMALLINT, 
      "FTBOOLEAN" SMALLINT, 
      "FTFLOAT" DOUBLE, 
      "FTCURRENCY" DECIMAL(19,4), 
      "FTBCD" DECIMAL(19,4), 
      "FTDATE" DATE, 
      "FTTIME" TIME, 
      "FTDATETIME" TIMESTAMP, 
      "FTBYTES" VARCHAR(50) FOR BIT DATA, 
      "FTBLOB" BLOB(1024) NOT LOGGED NOT COMPACT, 
      "FTMEMO" LONG VARCHAR );   

DROP TABLE "ADQA_details_autoinc"; 

DROP TABLE "ADQA_master_autoinc"; 

CREATE TABLE "ADQA_master_autoinc"  (
      "ID1" INTEGER NOT NULL GENERATED BY DEFAULT
      AS IDENTITY ( START WITH +0, INCREMENT BY +1, NO CACHE ), 
      "NAME1" VARCHAR(20) );   

ALTER TABLE "ADQA_master_autoinc" 
  ADD CONSTRAINT "PK_mast_autoinc" PRIMARY KEY ("ID1");

CREATE TABLE "ADQA_details_autoinc"  (
      "ID2" INTEGER NOT NULL GENERATED BY DEFAULT
      AS IDENTITY ( START WITH +0, INCREMENT BY +1, NO CACHE ), 
      "FK_ID1" INTEGER, 
      "NAME2" VARCHAR(50) );   

ALTER TABLE "ADQA_details_autoinc" 
  ADD CONSTRAINT "PK_det_autoinc" PRIMARY KEY ("ID2");

ALTER TABLE "ADQA_details_autoinc" 
  ADD CONSTRAINT "FK_detaut_mastauto" FOREIGN KEY ("FK_ID1")
  REFERENCES "ADQA_master_autoinc"  ("ID1")
  ON DELETE CASCADE
  ON UPDATE NO ACTION
  ENFORCED           
  ENABLE QUERY OPTIMIZATION;
 
DROP TRIGGER "ADQA_autoinc";

CREATE TRIGGER "ADQA_autoinc"
AFTER UPDATE OF id1 ON "ADQA_master_autoinc"
REFERENCING NEW AS N OLD AS O
FOR EACH ROW MODE DB2SQL
 UPDATE "ADQA_details_autoinc" SET fk_id1 = N.id1 WHERE fk_id1 = O.id1;

DROP TABLE "ADQA_ForAsync";

CREATE TABLE "ADQA_ForAsync"  (
      "ID" INTEGER, 
      "NAME" VARCHAR(20) );   

DROP TABLE "ADQA_Identity_tab";

CREATE TABLE "ADQA_Identity_tab"  (
      "AUTO" INTEGER NOT NULL GENERATED BY DEFAULT
      AS IDENTITY ( START WITH +0, INCREMENT BY +1, NO CACHE ), 
      "DESCR" VARCHAR(50) );   

DROP TABLE "ADQA_LockTable";

CREATE TABLE "ADQA_LockTable"  (
      "ID" INTEGER, 
      "NAME" VARCHAR(100) );   

DROP TABLE "ADQA_MaxLength";

CREATE TABLE "ADQA_MaxLength"  (
      "STR" VARCHAR(255), 
      "MEMOS" LONG VARCHAR,
      "WIDESTR" VARGRAPHIC(255), 
      "BLOBS" BLOB(1073741824) NOT LOGGED NOT COMPACT );   

DROP TABLE "ADQA_NoValsTable";       

CREATE TABLE "ADQA_NoValsTable"  (
      "ID" INTEGER WITH DEFAULT 2000, 
      "NAME" VARCHAR(10) WITH DEFAULT 'hello');   

DROP TABLE "ADQA_Numbers";

CREATE TABLE "ADQA_Numbers"  (
      "DTBYTE" SMALLINT, 
      "DTSBYTE" SMALLINT, 
      "DTINT16" SMALLINT, 
      "DTINT32" INTEGER, 
      "DTINT64" BIGINT, 
      "DTUINT16" DECIMAL(5,0), 
      "DTUINT32" DECIMAL(10,0), 
      "DTUINT64" DECIMAL(20,0), 
      "DTDOUBLE" DOUBLE, 
      "DTCURRENCY" DECIMAL(19,4),
      "DTBCD" DECIMAL(28,14), 
      "DTFMTBCD" DECIMAL(28,14),
      "DTBOOLEAN" DECIMAL(2,0) );   

DROP TABLE "ADQA_TabWithPK";

CREATE TABLE "ADQA_TabWithPK"  (
      "F1" INTEGER NOT NULL );   

ALTER TABLE "ADQA_TabWithPK"
  ADD CONSTRAINT "PK_tabwpk" PRIMARY KEY ("F1");

DROP TABLE "ADQA_TransTable";

CREATE TABLE "ADQA_TransTable"  (
      "ID" INTEGER NOT NULL WITH DEFAULT 2000,
      "NAME" VARCHAR(100) WITH DEFAULT '' );

ALTER TABLE "ADQA_TransTable"
  ADD CONSTRAINT "PK_TransTable" PRIMARY KEY ("ID");

DROP TABLE "ADQA_WString";

CREATE TABLE "ADQA_WString" (
      "WIDESTRING" VARGRAPHIC (1000));

DROP TABLE "ADQA_Bcd";

CREATE TABLE "ADQA_Bcd"  (
      "FTCURRENCY" DECIMAL(19,4), 
      "FTBCD" DECIMAL(19,4), 
      "FTFMTBCD" DECIMAL(22,4) );

DROP TABLE "ADQA_ParamBind";

CREATE TABLE "ADQA_ParamBind" (
  "P1" VARCHAR(50),
  "P2" VARCHAR(50),
  "P3" VARCHAR(50),
  "P4" VARCHAR(50) );

DROP TABLE "ADQA_map1";

CREATE TABLE "ADQA_map1"  (
      "ID1" INTEGER NOT NULL , 
      "NAME1" VARCHAR(20) );

DROP TABLE "ADQA_map2";

CREATE TABLE "ADQA_map2"  (
      "ID2" INTEGER NOT NULL , 
      "NAME2" VARCHAR(20) );

DROP TABLE "ADQA_map3";
 
CREATE TABLE "ADQA_map3"  (
      "ID3" INTEGER NOT NULL , 
      "NAME3" VARCHAR(20) );   

DROP TABLE "ADQA_map4";

CREATE TABLE "ADQA_map4"  (
      "ID4" INTEGER NOT NULL , 
      "NAME4" VARCHAR(20) );     