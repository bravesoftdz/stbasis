
CREATE TABLE AP_TYPE_FURNITURE
(
 AP_TYPE_FURNITURE_ID INTEGER NOT NULL,
 NAME GUIDENAME,
 FULLNAME NOTE,
 PRIORITY SMALLINT
)

ALTER TABLE AP_TYPE_FURNITURE
ADD PRIMARY KEY (AP_TYPE_FURNITURE_ID)

CREATE GENERATOR GEN_AP_TYPE_FURNITURE_ID;

CREATE TRIGGER AP_TYPE_FURNITURE_BI0 FOR AP_TYPE_FURNITURE
ACTIVE BEFORE INSERT POSITION 0
as
 declare variable ctn integer;
 declare variable err varchar(200);
begin
  select count(*) from
   AP_TYPE_FURNITURE where Upper(name)=Upper(new.name) into ctn;
  if (ctn>0) then begin
   err='������������ <'||new.name||'> ��� ����������..';
   execute procedure error(err);
  end
end

CREATE TRIGGER AP_TYPE_FURNITURE_BU0 FOR AP_TYPE_FURNITURE
ACTIVE BEFORE UPDATE POSITION 0
as
 declare variable ctn integer;
 declare variable err varchar(200);
begin
  select count(*) from  AP_TYPE_FURNITURE
   where Upper(name)=Upper(new.name)and
         AP_TYPE_FURNITURE.AP_TYPE_FURNITURE_id<>New.AP_TYPE_FURNITURE_id into ctn;
  if (ctn>0) then begin
     err='������������ <'||new.name||'> ��� ����������..';
     execute procedure error(err);
  end
end

DESCRIBE TABLE AP_TYPE_FURNITURE
'���������� ����� ������';

grant select, delete, insert, update, references on AP_TYPE_FURNITURE to adminrole;
grant select on AP_TYPE_FURNITURE to premises;


