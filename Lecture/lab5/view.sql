-- Q1
create or replace view student_shortinfos as
	select student_id, last_name, first_name, gender, dob, clazz_id
	from student
--1.1	
select * from student_shortinfos where gender = 'F'
--1.2
insert into student_shortinfos(student_id, last_name, first_name, gender, dob) values('20161234', 'Nguyễn', 'Quỳnh Lâm', 'F','1998-01-21') 
insert into student_shortinfos(student_id, last_name, first_name, gender, dob) values('20166589', 'Tran', 'Duc Phung', 'M','1998-12-16') 

select * from student_shortinfos

delete from student_shortinfos where student_id = '20166589'
delete from student_shortinfos where student_id = '20161234'
update student_shortinfos set gender = 'M' where student_id = '20161234'
--1.3
-- (a)
select student_id, concat(last_name,' ', first_name) as full_name, gender, name from student_shortinfos s , clazz cl
where s.clazz_id = cl.clazz_id
-- (b)
select clazz.clazz_id, name, count(student_id) from clazz  left join student_shortinfos 
on( student_shortinfos.clazz_id = clazz.clazz_id) group by (clazz.clazz_id)
--1.4
update student set dob = '1998-08-19' where student_id = '20160004'
-- 1.5
INSERT INTO student(student_id, first_name, last_name, dob, gender, address, note, clazz_id)
VALUES ('20160456', 'Thế Chương', 'Chu', '1998-09-05', 'M', 'Hà Đông', NULL, '20162101');

--Q2
create or replace view student_class_shortinfos as
	select student_id, first_name, last_name, gender, name
	from clazz right join student on(clazz.clazz_id = student.clazz_id)
	
select * from student_class_shortinfos

--Q3
create or replace view class_infos as
	select c.clazz_id, name, count(s.student_id)
	from student s right join clazz c on ( s.clazz_id = c.clazz_id)
	group by c.clazz_id
	
select * from class_infos

--
drop trigger delete_class_view on class_infos
create trigger delete_class_view
instead of delete on class_infos
for each row
execute procedure delete_class_view_func();

create or replace function delete_class_view_func() returns trigger as
$$
begin
	-- update monitor id of class table to null
	-- if the student play a roll of class monitor
	update clazz set monitor_id = null where monitor in
				(select student_id from student where clazz_id  = old.clazz_id)
				
	delete from enrollment where (select student_id from student where clazz_id  = old.clazz_id)
	
	delete from student where clazz_id = old.clazz_id;
	delete from clazz where clazz_id = old.clazz_id;
	return old;
end;
$$ language plpgsql volatile;

-- try new function
delete from class_infos where clazz_id = '20162102'
select * from class_infos
delete from class_infos where clazz_id = '20162101'
create or replace function insert_class_view_func() returns trigger as
$$
begin
	insert into student(student_id, clazz_id) values(student_id, clazz_id);
	insert into clazz(clazz_id, name) values(clazz_id, name);
--	return old;
end;
$$ language plpgsql volatile;
-- create trigger
drop trigger insert_into_class_view on class_infos;
create trigger insert_into_class_view
instead of insert on class_infos
for each row
execute procedure insert_class_view_func();

insert into 