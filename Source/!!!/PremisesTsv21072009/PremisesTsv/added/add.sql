CREATE TABLE PMS_OBJECT (
    PMS_OBJECT_ID INTEGER NOT NULL,
    NAME SHORTNAME,
    NOTE NOTE,
    SORTNUMBER SMALLINT NOT NULL);

ALTER TABLE PMS_OBJECT ADD PRIMARY KEY (PMS_OBJECT_ID);

grant select, delete, insert, update on PMS_OBJECT to adminrole;
grant select, delete, insert, update on PMS_OBJECT to premises;

CREATE GENERATOR GEN_PMS_OBJECT_ID;

ALTER TABLE PMS_PREMISES
ADD PMS_OBJECT_ID INTEGER;

CREATE TABLE PMS_DIRECTION (
    PMS_DIRECTION_ID INTEGER NOT NULL,
    NAME SHORTNAME,
    NOTE NOTE,
    SORTNUMBER SMALLINT NOT NULL);

ALTER TABLE PMS_DIRECTION ADD PRIMARY KEY (PMS_DIRECTION_ID);

grant select, delete, insert, update on PMS_DIRECTION to adminrole;
grant select, delete, insert, update on PMS_DIRECTION to premises;

CREATE GENERATOR GEN_PMS_DIRECTION_ID;

ALTER TABLE PMS_PREMISES
ADD PMS_DIRECTION_ID INTEGER;

CREATE TABLE PMS_ACCESSWAYS (
    PMS_ACCESSWAYS_ID INTEGER NOT NULL,
    NAME SHORTNAME,
    NOTE NOTE,
    SORTNUMBER SMALLINT NOT NULL);

ALTER TABLE PMS_ACCESSWAYS ADD PRIMARY KEY (PMS_ACCESSWAYS_ID);

grant select, delete, insert, update on PMS_ACCESSWAYS to adminrole;
grant select, delete, insert, update on PMS_ACCESSWAYS to premises;

CREATE GENERATOR GEN_PMS_ACCESSWAYS_ID;

ALTER TABLE PMS_PREMISES
ADD pms_accessways_id INTEGER;

ALTER TABLE PMS_PREMISES
ADD remoteness NOTE;

ALTER TABLE PMS_PREMISES
ADD AREABUILDING NOTE;

ALTER TABLE PMS_PREMISES
ADD LANDMARK NOTE;

for PJ and JD
ALTER TABLE PMS_AGENT
ADD PHONE NOTE
COLLATE PXW_CYRL 
