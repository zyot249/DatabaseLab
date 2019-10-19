create or replace function num_of_student(in cid char(8)) returns integer
as $$
declare nos integer;
begin
	nos := count(student_id) from student where clazz_id = cid;
	return nos;
end;$$
language plpgsql

alter table clazz add column number_students integer;

create or replace function update_number_student() returns int
as $$
-- declare cid clazz%ROWTYPE;
-- declare number_stds integer;
begin
-- 	for cid in (select * from clazz) loop
-- 	select into number_stds count(*)
-- 	from student
-- 	where clazz_id = cid.clazz_id;
-- 	update clazz
-- 		set number_students = number_stds where clazz_id = cid.clazz_id;
-- 	end loop;
	update clazz c
	set number_students = (select count(*) from student where clazz_id = c.clazz_id);
	return 1;
end;$$
language plpgsql

select update_number_student();