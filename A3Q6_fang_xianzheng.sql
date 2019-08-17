--drop table IF EXISTS POSSIBLE_IDS;
--create table POSSIBLE_IDS (ID varchar(60));

create or replace function generate_id(fname varchar, lname varchar, birth varchar)
returns table(ID varchar(60))
as $$
DECLARE
TIMESTAMP1 TIMESTAMP;
total varchar;
age integer;
year integer;
month integer;
day integer;
sun_sign varchar;
BEGIN

   --SELECT EXTRACT(DAY FROM TIMESTAMP birth) into month;
   drop table IF EXISTS POSSIBLE_IDS;
   create table POSSIBLE_IDS (ID varchar(60));
   SELECT TO_TIMESTAMP(birth,'YYYY-MM-DD') into TIMESTAMP1;
   --select (date_trunc('year',TIMESTAMP1)) into year;
   select (date_part('year', age(current_date, TIMESTAMP1))) into age;
   SELECT (EXTRACT(DAY FROM TIMESTAMP1)) into day;
   SELECT (EXTRACT(MONTH FROM TIMESTAMP1)) into month;
   --age:=age-1;
   if (month=3 and day>=21) or (month=4 and day<=20) then sun_sign:='Aries';  end if;
   if (month=4 and day>=21) or (month=5 and day<=21) then sun_sign:='Taurus';  end if;
   if (month=5 and day>=22) or (month=6 and day<=21) then sun_sign:='Gemini';  end if;
   if (month=6 and day>=22) or (month=7 and day<=22) then sun_sign:='Cancer';  end if;
   if (month=7 and day>=23) or (month=8 and day<=21) then sun_sign:='Leo';  end if;
   if (month=8 and day>=22) or (month=9 and day<=23) then sun_sign:='Virgo';  end if;
   if (month=9 and day>=24) or (month=10 and day<=23) then sun_sign:='Libra';  end if;
   if (month=10 and day>=24) or (month=11 and day<=22) then sun_sign:='Scorpio';  end if;
   if (month=11 and day>=23) or (month=12 and day<=22) then sun_sign:='Sagittarius';  end if;
   if (month=12 and day>=23) or (month=1 and day<=20) then sun_sign:='Capricorn';  end if;
   if (month=1 and day>=21) or (month=2 and day<=19) then sun_sign:='Aquarius';  end if;
   if (month=2 and day>=20) or (month=3 and day<=20) then sun_sign:='Pisces';  end if;
   --if month=4 and day>=21 then sun_sign:='Aries';  end if;
   --raise notice 'birth month:%',month;
   --raise notice 'birth day:%',day;
   --raise notice 'sun_sign:%',sun_sign;
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',lname));
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',lname,'_',age));
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',age));
   insert into POSSIBLE_IDS values (CONCAT(lname,'_',age));
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',lname,'_',sun_sign));
   insert into POSSIBLE_IDS values (CONCAT(lname,'_',sun_sign));
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',sun_sign));
   insert into POSSIBLE_IDS values (CONCAT(fname,'_',lname,'_',sun_sign,'_',age));

   return query select * from POSSIBLE_IDS;
END;
$$
LANGUAGE plpgsql;
