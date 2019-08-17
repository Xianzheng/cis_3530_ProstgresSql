create or replace function uppercase()
returns trigger
as $$
DECLARE
foo varchar;
BEGIN
	new.fname=upper(new.fname);
	new.lname=upper(new.lname);
	return new;
END;
$$
language plpgsql;

drop trigger if exists ensure_case on agents;
create trigger ensure_case
before INSERT
on agents
for each row
execute procedure uppercase();
