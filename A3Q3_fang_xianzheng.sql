CREATE OR REPLACE FUNCTION generateEmail(n INTEGER)
RETURNS VARCHAR
AS $$
DECLARE
	c1 cursor is select * from agents where agents.aid = n ;
	vc1 record;
	string1 VARCHAR;
	string2 VARCHAR;
BEGIN
	open c1;
	fetch c1 into vc1;
	close c1;
	select university.name into string1
	from university
	where university.uid = vc1.uid;
	select country.name into string2
	from country
	where country.cid = vc1.cid;
	if string1 = 'GUELPH' then
		return	lower(CONCAT(vc1.fname,'.',vc1.lname,'.',string2,'@','UO',string1,'.ca'));
  end if;
  if string1 = 'BROCK' or string1 = 'TRENT' then
		return 	lower(CONCAT(vc1.fname,'.',vc1.lname,'.',string2,'@',string1,'U','.ca'));
	end if;
	if string1 ='WINDSOR' or string1 = 'TORONTO'or string1 = 'SHERBROOKE' then
		return 	lower(CONCAT(vc1.fname,'.',vc1.lname,'.',string2,'@','U',string1,'.ca'));
	end if;
END;
$$
LANGUAGE plpgsql;
