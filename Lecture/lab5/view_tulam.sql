-- Question 1
create or replace view student_shortinfos(student_id, first_name, last_name, gender, dob, clazz_id)
as select student_id, first_name, last_name, gender, dob, clazz_id from student;

select * from student_shortinfos;

insert into student_shortinfos 
values ('20180001','Đức Dũng', 'Nguyễn','M','1998-09-24','20172201');

select * from student;

select s.student_id, (s.last_name || ' ' || s.first_name) as fullname,s.gender, cl.name as class_name
from student_shortinfos s left join clazz cl on(s.clazz_id = cl.clazz_id);

select cl.clazz_id, cl.name as class_name, count(s.student_id) as num_of_student
from clazz cl left join student_shortinfos s on(cl.clazz_id = s.clazz_id)
group by cl.clazz_id;

update student 
set dob = '1999-09-24'
where student_id = '20180001';

select * from student_shortinfos;

insert into student values ('20180002','Hương Ly','Nguyễn','1998-01-31','F','Nam Tu Liem','Rat Ham','20162101');

-- Question 2
create or replace view student_class_shortinfos(student_id, first_name, last_name, gender, class_name)
as select s.student_id, s.first_name, s.last_name, s.gender, cl.name as class_name
from student s left join clazz cl on(s.clazz_id = cl.clazz_id);

select * from student_class_shortinfos;

update student_class_shortinfos
set student_id = '20160674'
where student_id = '20180001';

-- Question 3
create or replace view class_infos(clazz_id, class_name, num_of_student)
as select cl.clazz_id, cl.name as class_name, count(student_id) as num_of_student
from clazz cl left join student s on(cl.clazz_id = s.clazz_id)
group by (cl.clazz_id);

select * from class_infos;

update class_infos
set clazz_id = '20162203'
where clazz_id = '20162102';