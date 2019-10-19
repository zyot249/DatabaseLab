-- example trigger
create or replace function tg_af_insert_student_test() returns trigger as
$$ 
begin
	return null;
end; 
$$
language plpgsql

create trigger af_insert_test
after insert on student
for each row
execute procedure tg_af_insert_student_test();

-- trigger after insert student
create or replace function tf_af_insert() returns trigger as
$$
begin
	update clazz
	set number_students = number_students +1
	where clazz_id = new.clazz_id;
	return new;
end;
$$
language plpgsql

create trigger af_insert
after insert on student
for each row
when(new.clazz_id is not null)
execute procedure tf_af_insert();

insert into student
values('20182222','Ngọc Thành','Đào','1998-05-12','M','Truong Dinh','ham hoc','20162102');

select * from clazz;

-- trigger after delete student
create or replace function tf_bf_delete() returns trigger as
$$
begin
	update clazz
	set number_students = number_students - 1
	where clazz_id = old.clazz_id;
	return old;
end;
$$ language plpgsql

create trigger bf_delete
before delete on student
for each row
when(old.clazz_id is not null)
execute procedure tf_bf_delete();

drop trigger bf_delete on student;

delete from student where student_id = '20182222';

select * from clazz;

create or replace function tf_af_delete() returns trigger as
$$
begin
	update clazz
	set number_students = number_students -1
	where clazz_id = old.clazz_id;
	return old;
end;
$$ language plpgsql

create trigger af_delete
after delete on student
for each row
when(old.clazz_id is not null)
execute procedure tf_af_delete();

drop trigger af_delete on student;

-- trigger for both insert update delete

create or replace function tg_af_idu_student() returns trigger as
$$
begin
	if(TG_OP = 'INSERT') and (new.clazz_id is not null) then
		update clazz
		set number_students = number_students + 1
		where clazz_id = new.clazz_id;
	elseif(TG_OP = 'UPDATE') and (old.clazz_id is distinct from new.clazz_id) then
		update clazz
		set number_students = number_students + 1
		where clazz_id = new.clazz_id;
		
		update clazz
		set number_students = number_students - 1
		where clazz_id = old.clazz_id;
	elseif (TG_OP = 'DELETE') and (old.clazz_id is not null) then
		update clazz
		set number_students = number_students - 1
		where clazz_id = old.clazz_id;
	end if;
	return null;
end;
$$ language plpgsql

create trigger af_idu_student
after insert or delete or update on student
for each row
execute procedure tg_af_idu_student();

insert into student
values('20182222','Ngọc Thành','Đào','1998-05-12','M','Truong Dinh','ham hoc','20162102');

select * from clazz;

update student
set clazz_id = '20172202'
where student_id = '20182222';

delete from student
where student_id = '20182222';

-- trigger for constraint the number of student enrolled in a subject per semester <= 200

create or replace view enrollment_infos as
select subject_id, semester, count(student_id) as number_students
from enrollment
group by(subject_id,semester);

select * from enrollment_infos;

create or replace function bf_idu_enrollment() returns trigger as
$$
begin
	if(TG_OP = 'INSERT') and (new.subject_id is not null) and (new.semester is not null) then
		if((select number_students 
		   from enrollment_infos ef 
		   where ef.subject_id = new.subject_id and ef.semester = new.semester) = '200') then
		   	return null;
		else 
			return new;
		end if;
	elseif(TG_OP = 'UPDATE') and ((new.subject_id is distinct from old.subject_id) 
							  or (new.semester is distinct from old.semester)) then
		if((select number_students 
		   from enrollment_infos ef 
		   where ef.subject_id = new.subject_id and ef.semester = new.semester) = '6') then
		   	return null;
		else 
			return new;
		end if;
	end if;
end;
$$ language plpgsql

create trigger idu_enrollment
before insert or update or delete on enrollment
for each row
execute procedure bf_idu_enrollment();

select * from enrollment;
select * from enrollment_infos;

insert into enrollment(student_id, subject_id, semester)
values('20182222','IT1110','20171');
