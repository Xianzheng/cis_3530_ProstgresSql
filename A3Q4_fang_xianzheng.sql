drop table if exists recruit_stats;
create table recruit_stats (University varchar, mumRecruited integer,NumDegreesOffered integer);
Do
$$
DECLARE
  foo1 varchar(30);
	vc1 record;
	arow record;
	arow1 record;
	arow2 record;
	foo integer;
  count integer;
BEGIN
   count:=0;
   foo:=0;
	 for vc1 in
	 select * from university
	 loop
		raise notice '************************';
		raise notice '%',concat('University of ',vc1.name);
		raise notice ' ';
		raise notice '%','Recruited:';
		raise notice ' ';
		for arow in
		select recruits_from.* from recruits_from
		where recruits_from.uid = vc1.uid
			loop
				for arow1 in
					select distinct country.* from country
					where country.cid = arow.cid
					loop
						raise notice '% students from %',arow.numstudents,arow1.name;

						raise notice ' ';
					end loop;
					foo:= foo+arow.numstudents;
        --  raise notice 'number of student is % %',arow.numstudents,foo;
			end loop;
			raise notice 'Total number of students=%',foo;
      INSERT INTO recruit_stats VALUES(vc1.name,foo,3);
			foo:=0;
			raise notice ' ';
		raise notice '%','Degree Offered:';
		raise notice ' ';
		for arow2 in
			select distinct degree.*
			from degree, degree_offered
			where degree_offered.uid = vc1.uid
			and degree_offered.did = degree.did
				loop
				raise notice '%',arow2.name;
				raise notice ' ';
        count:=count+1;
				end loop;
        update recruit_stats set numdegreesoffered = count
        where university = vc1.name;
        count:=0;
	 end loop;

END;
$$
LANGUAGE plpgsql;
