-- Question 1
select subject_id, name
from subject
where credit >= 5;

-- Question 2
select student_id
from student natural join clazz
where clazz.name = 'CNTT1.01-K61';

-- Question 3
select student_id
from student natural join clazz
where clazz.name like 'CNTT%';

-- Question 4
select distinct on (student_id) student_id
from (
	select student_id from subject natural join enrollment
	where name = 'Mạng máy tính'
) as first_filter 
natural join (subject natural join enrollment)
where name = 'Tin học đại cương';

-- Question 5
select distinct on (student_id) student_id, last_name, first_name
from subject natural join enrollment natural join student
where name = 'Mạng máy tính' or name = 'Tin học đại cương';

-- Question 6
select distinct on(subject_id) subject_id
from subject natural left join enrollment
where student_id IS NULL;

-- second answer
select distinct on(sub.subject_id) sub.subject_id
from subject sub left outer join enrollment e on (sub.subject_id = e.subject_id)
where e.student_id IS NULL;

-- third way
select * from subject
except
select s.*
from subject s, enrollment e 
where s.subject_id = e.subject_id;

-- Question 7
select sub.name, sub.credit
from subject sub, student s, enrollment e
where s.student_id = e.student_id and sub.subject_id = e.subject_id
	and e.semester = '20172' and s.last_name = 'Trần' and s.first_name = 'Thu Hồng';
	
-- Question 8
-- create function way
create function get_subject_score(midterm_score double precision, final_score double precision, coeff int) 
	returns double precision as 
$$ begin
	return (((100 - coeff)*midterm_score)+(coeff*final_score))/100;
end;$$
language plpgsql;

-- using function
select s.student_id, concat(s.last_name, ' ', s.first_name) as student_name, e.midterm_score, e.final_score, get_subject_score(e.midterm_score, e.final_score, sub.percentage_final_exam) as subject_score
from subject sub, student s, enrollment e
where s.student_id = e.student_id and sub.subject_id = e.subject_id
	and e.semester = '20172' and sub.name = 'Cơ sở dữ liệu';
	
-- not use function
select s.student_id, (s.last_name || ' ' || s.first_name) as student_name, e.midterm_score, e.final_score,
((1 - sub.percentage_final_exam/100.0)*e.midterm_score + sub.percentage_final_exam/100.0*e.final_score) as subject_score
from subject sub, student s, enrollment e
where s.student_id = e.student_id and sub.subject_id = e.subject_id
	and e.semester = '20172' and sub.name = 'Cơ sở dữ liệu';

-- Question 9
select s.student_id
from subject sub, student s, enrollment e
where s.student_id = e.student_id and sub.subject_id = e.subject_id
	and e.semester = '20171' and sub.subject_id = 'IT1110'
	and (e.midterm_score < 3 
		 or  e.final_score < 3 
		 or ((1 - sub.percentage_final_exam/100.0)*e.midterm_score + sub.percentage_final_exam/100.0*e.final_score) < 4);

-- Question 10
with score as(
select s.student_id, 
	(s.last_name || ' ' || s.first_name) as student_name, 
	e.midterm_score, e.final_score,
	((1 - sub.percentage_final_exam/100.0)*e.midterm_score + sub.percentage_final_exam/100.0*e.final_score) as subject_score
from subject sub, student s, enrollment e
where s.student_id = e.student_id and sub.subject_id = e.subject_id
	and e.semester = '20172' and sub.name = 'Cơ sở dữ liệu')
select score.student_id, score.student_name, score.subject_score
from score
where subject_score = (select max(subject_score) from score);

-- Question 11
select (s.last_name || ' ' || s.first_name) as student_name , (date_part('year',age(current_date,s.dob)) + 1) as age
from student s
where date_part('year',age(current_date,s.dob)) >= 31;

-- Question 12
select (s.last_name || ' ' || s.first_name) as student_name
from student s
where s.dob between '1987-06-01' and '1987-06-30';

-- Question 13
select s.name
from subject s left outer join teaching te on (s.subject_id = te.subject_id)
group by s.subject_id
having count(lecturer_id) >= 2;

-- Question 14
insert into subject 
values ('XL0001','Java in Database lecture','4','60');

select s.name
from subject s left outer join teaching te on (s.subject_id = te.subject_id)
group by s.subject_id
having count(lecturer_id) < 2;

-- Question 15
select l.lecturer_id, (l.first_name || ' ' || l.last_name) as "lecturer''s fullname", count(te.subject_id) as "number of subjects"
from lecturer l left outer join teaching te on(l.lecturer_id = te.lecturer_id) 
		inner join subject s on(te.subject_id = s.subject_id)
group by l.lecturer_id;

-- Question 16
select s.name as subject_name
from subject s inner join enrollment e on(s.subject_id = e.subject_id)
where e.semester = '20172'
group by s.subject_id
having count(e.student_id) < 5;

-- Question 17
select cl.name, count(s.student_id) as "number of students"
from clazz cl left outer join student s on(cl.clazz_id = s.clazz_id)
group by cl.clazz_id
order by count(s.student_id) desc;

-- Question 18
with clazz_info as(
	select cl.clazz_id, cl.name as clazz_name,
		(s.last_name || ' ' || s.first_name) as "monitor_name",
		(l.last_name || ' ' || l.first_name) as "teacher_name"
	from clazz cl left outer join lecturer l on(cl.lecturer_id = l.lecturer_id)
				left outer join student s on(cl.monitor_id = s.student_id))
select s.student_id, (s.last_name || ' ' || s.first_name) as student_name,
	ci.clazz_name, ci.monitor_name, ci.teacher_name
from student s inner join clazz_info ci on(s.clazz_id = ci.clazz_id);