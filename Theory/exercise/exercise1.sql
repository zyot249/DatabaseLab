-- Question 1
select e.first_name, e.last_name
from "EMPLOYEES" e,"DEPARTMENTS" d,"LOCATIONS" l
where e.department_id = d.department_id 
	and d.location_id = l.location_id
	and l.city = 'Hanoi'
order by e.last_name asc;
-- Question 2
select * from "EMPLOYEES";
-- Question 3
select department_id, department_name, manager_id as "MNG"
from "DEPARTMENTS";
-- Question 4
select distinct on (department_id, job_id) department_id, job_id
from "EMPLOYEES";
-- Question 5
select e.first_name, e.last_name
from "EMPLOYEES" e, "JOBS" j
where e.job_id = j.job_id
	and e.salary = j.min_salary;
-- Question 6 - string functions
select count(last_name)
from "EMPLOYEES"
where last_name like '%nh';
-- Question 7
select last_name, length(last_name) as length_of_last_name
from "EMPLOYEES"
where length(last_name) >= 8;
-- Question 8
select last_name, (left(first_name, 1) || right(last_name,3) || '2019') as username
from "EMPLOYEES";
-- Question 9
select (last_name || ' ' || first_name) as "FULL_NAME",
	(phone_number || '-' || email) as "CONTACT_DETAILS"
from "EMPLOYEES";
-- Question 10 - replace null value
select first_name, last_name, (case when phone_number isnull then 'N/A' 
							   else phone_number end) as phone_number
from "EMPLOYEES";
-- Question 11 - date functions
select last_name, first_name
from "EMPLOYEES"
where date_part('month',hire_date) = '6';
-- Question 12
select * from "EMPLOYEES"
where date_part('year',age(current_date, hire_date)) <= 4;
-- Question 13 - case functions
select salary, (case when salary >= '5000000' then 'Very high'
			   		when salary >= '3000000' then 'High'
			   		when salary < '300000' then 'Low'
			   end) as comment
from "EMPLOYEES";
-- Question 14 - where clause
select employee_id, first_name, job_id, department_id
from "EMPLOYEES"
where department_id != 'DEP0001' and department_id != 'DEP0003';
-- Question 15
select * from "EMPLOYEES"
where (salary <= '6000000' and salary >= '800000' and commission_pct is not null)
	or(department_id != 'DEP0001' and department_id != 'DEP0003' and date_part('year',hire_date) <= '2012');
-- Question 16 - join clause
select d.department_name, l.city, l.state_province
from "DEPARTMENTS" d, "LOCATIONS" l
where d.location_id = l.location_id;
-- Question 17
select em.last_name as employee,ma.last_name as manager
from "EMPLOYEES" em left join "EMPLOYEES" ma on (em.manager_id = ma.employee_id)
where em.manager_id is not null;
-- Question 18
select last_name, salary
from "EMPLOYEES"
where salary < (select salary from "EMPLOYEES" where employee_id = 'EMP0002');
-- Question 19 - aggregate functions
select count(employee_id)
from "EMPLOYEES"
where department_id = 'DEP0002';
-- Question 20
select AVG(salary)
from "EMPLOYEES"
where job_id = 'KT0001';
-- Question 21 - group by clause
select department_id, count(employee_id)
from "EMPLOYEES"
group by department_id;
-- Question 22
select e.department_id, count(e.employee_id)
from "EMPLOYEES" e, "DEPARTMENTS" d, "LOCATIONS" l
where e.department_id = d.department_id and d.location_id = l.location_id 
	and l.city = 'Hanoi'
group by e.department_id;
-- Question 23
select d.department_name, round(avg(e.salary))
from "EMPLOYEES" e, "DEPARTMENTS" d
where e.department_id = d.department_id
group by d.department_name
having count(employee_id) = 2;
-- Question 24
select co.country_name
from "DEPARTMENTS" d, "LOCATIONS" l, "COUNTRIES" co
where d.location_id = l.location_id and l.country_id = co.country_id
group by co.country_name
having count(d.department_id) > 3;
-- Question 25
with dlc as(select * from "DEPARTMENTS" d, "LOCATIONS" l, "COUNTRIES" co
where d.location_id = l.location_id and l.country_id = co.country_id)
(select country_name from dlc where department_name = 'Kinh doanh')
intersect
(select country_name from dlc where department_name = 'Nhan su');
-- Question 26
select distinct co.country_name
from "DEPARTMENTS" d, "LOCATIONS" l, "COUNTRIES" co
where d.location_id = l.location_id and l.country_id = co.country_id
	and (d.department_name = 'Nhan su' or d.department_name = 'Kinh doanh');
	-- other way
with dlc as(select * from "DEPARTMENTS" d, "LOCATIONS" l, "COUNTRIES" co
where d.location_id = l.location_id and l.country_id = co.country_id)
(select country_name from dlc where department_name = 'Kinh doanh')
union
(select country_name from dlc where department_name = 'Nhan su');
-- Question 27 - miscellaneous
select first_name, salary, department_id
from "EMPLOYEES"
where department_id = 'DEP0002'
	and salary > (select min(salary) from "EMPLOYEES"  where department_id = 'DEP0002');
-- Question 28
with avg_salary as(select department_id,round(avg(salary)) as avg_salary from "EMPLOYEES" group by department_id)
select e.first_name, e.salary, e.department_id, av.avg_salary
from "EMPLOYEES" e, avg_salary av
where e.department_id = av.department_id
	and e.salary < av.avg_salary
	and e.department_id in (select department_id from "EMPLOYEES" where first_name = 'Thanh');
-- Question 29
with dlc as(select * from "DEPARTMENTS" d, "LOCATIONS" l, "COUNTRIES" co
where d.location_id = l.location_id and l.country_id = co.country_id)
select country_name
from "COUNTRIES"
where country_name not in (select country_name from dlc where department_name = 'Kinh doanh');
-- Question 30
with cdc as (select country_id, count(department_id) as num
from "LOCATIONS" l left outer join "DEPARTMENTS" d on(l.location_id = d.location_id)
group by country_id)
select country_name
from cdc, "COUNTRIES" co
where cdc.country_id = co.country_id
	and num = (select max(num) from cdc);
