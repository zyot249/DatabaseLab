-- 1) List of subjects whose credits number is 5 or above.
-- 2) List of students in the class named "CNTT 2 K58".

-- 3) List of students in classes whose name contains "CNTT"
SELECT student.student_id, student.first_name, student.last_name 
FROM student INNER JOIN clazz ON student.clazz_id = clazz.clazz_id
WHERE clazz.name LIKE '%CNTT%';

-- 4) Give a list of students who enrolled in both "Lập trình Java" (Java Programming) 
-- and "Lập trình nhúng" (Embedded Programming).
--4
SELECT s.student_id,first_name,last_name 
FROM student s, enrollment e, subject sub
WHERE s.student_id = e.student_id AND e.subject_id = sub.subject_id
	AND sub.name = 'Học máy'
INTERSECT
SELECT s.student_id,first_name,last_name 
FROM student s, enrollment e, subject sub
WHERE s.student_id = e.student_id AND e.subject_id = sub.subject_id
	AND sub.name =  'Cơ sở dữ liệu' ;
	
	
SELECT student_id,first_name,last_name 
FROM student s, enrollment e, subject sub
WHERE s.student_id = e.student_id AND e.subject_id = sub.subject_id
	AND sub.name = 'Học máy' AND sub.name =  'Cơ sở dữ liệu' ;	
	

-- 5) Give a list of students who enrolled in  "Lập trình Java" (Java Programming) 
-- or  "Lập trình hướng đối tượng" (Object-oriented Programming).
SELECT student_id, first_name, last_name
FROM student natural join subject natural join enrollment
WHERE name = 'Học máy' OR name = 'Cơ sở dữ liệu';

-- 6) Which subject has never been registered by any student. 
-- correct
SELECT * FROM subject
EXCEPT 
SELECT s.* 
FROM suject s, enrollment e
WHERE s.subject_id = e.subject_id;

-- correct
SELECT s.* 
FROM suject s LEFT OUTER JOIN enrollment e ON (s.subject_id = e.subject_id)
WHERE e.student_id is NULL;

-- incorrect
SELECT * FROM subject
EXCEPT 
SELECT s.* 
FROM suject s LEFT OUTER JOIN enrollment e ON ( s.subject_id = e.subject_id);

-- correct
SELECT * 
FROM subject
WHERE subject_id  NOT IN (SELECT subject_id FROM enrollment); 

-- 7) List of subjects (subject name and credit number corresponding) that student "Nguyễn Hoài An" (first_name = 'Hoài An' and last_name = 'Nguyễn') have enrolled in the semester '20162'.
select su.name, su.credit
from student s, enrollment e, subject su
where s.student_id = e.student_id and e.subject_id = su.subject_id
and first_name= 'Ngọc An' and last_name = 'Bùi'
and semester = '20172' ;

-- 8) Give a list of students who learned the subject 'Cơ sở dữ liệu' in the second half of 2016 (it means semesters = '20162'): student id, student name, midterm score, final exam score and subject score. Subject score is determined by the weighted average of midterm score and final exam score : subject score = midterm score * (1- percentage_final_exam/100)  + final score *percentage_final_exam/100.

select student_id, first_name ||' ' || last_name as fullname,
	midterm_score, final_score, 
	final_score * percentage_final_exam*1.00/100 + midterm_score * (1-percentage_final_exam*1.00/100) as "subject score"
from student s, enrollment e, subject su
where s.student_id = e.student_id and e.subject_id = su.subject_id
and su.name = 'Cơ sở dữ liệu'
and semester = '20172' ;

-- 9) Give ID of students who enrolled in suject whose id is 'IT1110', in the semester '20171' but failed. Note: the student does not pass a subject if midterm score or final exam score is below 3 ; or subject score is below 4.

select student_id
from enrollment e, subject su
where e.subject_id = su.subject_id and e.subject_id = 'IT1110' and semester = '20171'
	and  ( midterm_score < 3 OR final_score < 3 
		OR (final_score * percentage_final_exam/100 
			+ midterm_score * (1-percentage_final_exam/100)) < 4 );
-- 16/04/2019 : 
-- 12 -> 11 -> 15, 13, 14, (16, 17),--> 10, --> 18
-- ==============

-- 12) Students were born in June 1999.
select *
from student
where extract(year from dob) = 1999 and extract (month from dob) = 06;
-- dob between '1999-06-01'  and '1999-06-30'
-- dob >= '1999-06-01' and dob <= '1999-06-30'


-- 11) Students aged 25 and above. Given information: student name, age
select first_name || ' ' || last_name as "student name", 
extract(year from current_date) - extract(year from dob) as "age"
from student
where extract(year from current_date) - extract(year from dob) >= 25;


-- 15) Give number of subjects that each lecturer can teach. List must contain: lecturer id, lecturer's fullname, number of subjects.

select l.lecturer_id,  l.first_name || ' ' || l.last_name, count(subject_id) as "subject number"
from teaching t, lecturer l 
where t.lecturer_id = l.lecturer_id 
group by l.lecturer_id;

-- 13) List of subjects which have at least 2 lecturers in charge?
select s.subject_id, s.name, count(*) as "teacher number"
from teaching t , subject s
where t.subject_id  = s.subject_id
group by s.subject_id
having count(*) >= 2;

select * 
from subject
where subject_id IN (
	select subject_id
	from teaching
	group by subject_id
	having count(*) >=2 );

-- 14) List of subjects which have less than 2 lecturers in charge?

select s.subject_id, s.name, count(t.subject_id) as "teacher number"
from subject s left join teaching t on (t.subject_id  = s.subject_id)
group by s.subject_id
having count(t.subject_id) < 2;

select * 
from subject
where subject_id NOT IN (
	select subject_id
	from teaching
	group by subject_id
	having count(*) >= 2 );

-- 16) List of subjects which have less than 5 students enrolled in the semester '20172'. 
-- 17) Display class name and number of students corresponding in each class. Sort the result in descending order by the number of students.

-- 10) List of students who obtained the highest score in subject whose id is 'IT3090', in the semester '20172'.

WITH tmp_table AS (
	select student_id,	midterm_score, final_score, 
		final_score * percentage_final_exam*1.00/100 + midterm_score * (1-percentage_final_exam*1.00/100) 
		as subject_score
	from enrollment e, subject su
	where e.subject_id = su.subject_id
		and su.subject_id = 'IT3090'
		and semester = '20172')
SELECT s.* 
FROM tmp_table t, student s
WHERE t.student_id = s.student_id 
	and subject_score = ( select max(subject_score) from tmp_table);


-- 10.1) Subjects that have the highest credit number
select * from subject 
where credit = (  select max(credit) from subject) ;

select * from subject 
where credit >=ALL (select credit from subject) ;

-- 18) List of all students with their class name, monitor name and form teacher name.
select s.* , c.name, m.first_name || ' ' || m.last_name as monitor_name,
	l.first_name || ' ' || l.last_name as lecturer_name
from student s, clazz c, student m , lecturer l
where s.clazz_id = c.clazz_id and c.monitor_id = m.student_id 
	and c.lecturer_id = l.lecturer_id;



