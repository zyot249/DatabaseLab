-- test function 
create function test(in val1 int4, in val2 int4, out result int4) as
$$
declare vmultiplier int4 := 3;
begin
	result := val1*vmultiplier + val2;
end;
$$
language plpgsql

select test(10,5)
-- end test

-- Q1
create or replace function number_of_student(in val char(8), out result int4) as
$$ 
begin
	 result :=  count(student_id) from student where student.clazz_id = val;
	 -- select into result count(*) from student where student.clazz_id = val;
end;
$$
language plpgsql
immutable
returns null on null input

select number_of_student(null)
security definer;
-- Q2

grant execute on function number_of_student to fred;
grant select on student to fred;

-- Q3 
-- add new attribute 
alter table clazz add column number_students int;
-- create function to update number of student into new column
create or replace function update_number_of_student() returns int as
$$ 
declare 
	--clazz_var clazz%ROWTYPE;
	--num integer;
begin
	--for clazz_var in (select * from clazz) loop
		--select into num count(*) from student where student.clazz_id = clazz_var.clazz_id;
		--update clazz
			--set number_students = num where clazz_id = clazz_var.clazz_id;
		
	--end loop;
	update clazz c
	set number_students = (select count(*) from student where clazz_id = c.clazz_id);
	return 1;
end;
$$ 
language plpgsql
-- test function
select * from clazz
-- call function
select  update_number_of_student()
-- why define function : no data transform bwt server and client
--					   : reduce time