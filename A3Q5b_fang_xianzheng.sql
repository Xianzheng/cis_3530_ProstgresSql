create or replace function alert()
returns TRIGGER
as $$
declare
	mark1 varchar(30);
	mark2 varchar(30);
BEGIN
	select url into mark1
	from university
	where uid = new.uid;
	--raise notice '%',mark1;
	if new.url != mark1 then
	raise notice 'University of % is changing its url',new.name;
	end if;
	return new;
END;
$$
LANGUAGE plpgsql;

drop trigger if exists ensure_alert on university;
create trigger ensure_alert
before UPDATE
on university
for each row
execute procedure alert();
