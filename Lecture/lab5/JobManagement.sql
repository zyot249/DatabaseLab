create table "JOBS"(
	job_id char(6) primary key,
	job_title character varying(50),
	min_salary numeric,
	max_salary numeric);
	
create table "JOB_HISTORY"(
	employee_id char(6),
	start_date date,
	end_date date,
	job_id char(6),
	department_id char(6));
	
create table "EMPLOYEES"(
	employee_id char(6) primary key,
	first_name character varying(20),
	last_name character varying(20),
	email character varying(50),
	phone_number character varying(10),
	hire_date date,
	job_id char(6),
	salary numeric,
	commission_pct numeric,
	manager_id char(6),
	department_id char(6));
	
drop function get_min_salary cascade;
create or replace function get_min_salary(jid char(6)) returns numeric 
as $$
declare
	min_s numeric = 0;
begin
	min_s := (select min_salary from "JOBS" where job_id = jid);
	return min_s;
end;
$$ language plpgsql

alter table "EMPLOYEES"
	add constraint salary_check check(salary >= get_min_salary(job_id));
	
-- test
insert into "JOBS" values('nv0001','nhan vien la ro','1000000','5000000');

insert into "EMPLOYEES"(employee_id, job_id, salary) values(
	'DD2409',
	'nv0001',
	'1000000');
	
alter table "JOBS"
	rename to jobs;