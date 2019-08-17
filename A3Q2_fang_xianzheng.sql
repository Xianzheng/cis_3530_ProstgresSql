CREATE OR REPLACE FUNCTION find_max_commission(n INTEGER)
RETURNS INTEGER
AS $$
DECLARE
	com agents.commission%TYPE;
	c1 cursor for select * from agents order by agents.aid;
	vc1 record;
	result text;
BEGIN
	select commission into com
	from agents
	where aid=n;
	if found then
		return com;
	else
		raise notice 'Invalid agent id, Valid agent ids are:';
		open c1;
		loop
			fetch c1 into vc1;
			exit when not found;
			raise notice '%:% %', vc1.aid,vc1.fname,vc1.lname;
		end loop;
		close c1;
	end if;
	raise exception 'Invalid agent Id';
END;
$$
LANGUAGE plpgsql;
