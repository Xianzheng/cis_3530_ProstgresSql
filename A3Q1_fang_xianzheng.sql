CREATE OR REPLACE FUNCTION numberAgents(na VARCHAR)
RETURNS INTEGER
AS $number$
DECLARE
	number INTEGER;
BEGIN

	select count(distinct agents.*) into number
	from agents, university
	where agents.uid = university.uid
	and university.name = UPPER(na);
	RETURN number;
END;
$number$ LANGUAGE plpgsql;
