ALTER PROCEDURE GETFULLAGENT (
    PMS_PREMISES_ID INTEGER,
    PMS_AGENT_ID INTEGER)
RETURNS (
    AGENT_NAME VARCHAR(1000))
AS
DECLARE VARIABLE INC INTEGER;
DECLARE VARIABLE REGION_ID INTEGER;
DECLARE VARIABLE STREET_ID INTEGER;
DECLARE VARIABLE HOUSE VARCHAR(30);
DECLARE VARIABLE APARTAMENT VARCHAR(30);
DECLARE VARIABLE S VARCHAR(30);
begin
  AGENT_NAME='';
  s='';
  inc=0;
  select a.name, p.pms_region_id, p.pms_street_id, p.housenumber, p.apartmentnumber
    from pms_premises p
    join pms_agent a on a.pms_agent_id=p.pms_agent_id
   where p.pms_premises_id=:PMS_PREMISES_ID and p.pms_agent_id=:PMS_AGENT_ID
    into s, region_id, street_id, house, apartament;

  AGENT_NAME=s;

  for select a.name
      from pms_premises p
      join pms_agent a on a.pms_agent_id=p.pms_agent_id
      where p.pms_region_id=:region_id and p.pms_street_id=:street_id
      and p.housenumber=:house and p.apartmentnumber=:apartament
      and p.pms_premises_id<>:PMS_PREMISES_ID and p.pms_agent_id<>:PMS_AGENT_ID
      into s do begin
    AGENT_NAME=s||','||AGENT_NAME;
  end
  suspend;
end

grant execute on procedure getfullagent to adminrole

grant execute on procedure getfullagent to premises
