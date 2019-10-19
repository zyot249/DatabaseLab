-- 13
SELECT salary, 
    CASE
        WHEN salary >= 5000 THEN 'Very high'
        WHEN salary >= 3000 THEN 'High'
        ELSE 'Low'
    END AS comment
FROM Employees

-- 14
SELECT employee_id, first_name, job_id, department_id
FROM Employees
WHERE department_id NOT IN (20, 60, 80)

-- 15
SELECT *
FROM Employees
WHERE ((salary BETWEEN 600 AND 800) AND commission_pct IS NOT NULL)
    OR
    (department_id NOT IN (80, 90, 100) AND hire_date < '1990-01-01')

-- Join clauses
-- 16
SELECT department_name, city, state_province
FROM Departments NATURAL JOIN Locations

-- 17
SELECT Employees.last_name, Managers.last_name
FROM Employees 
    INNER JOIN Employees AS Managers ON Employees.manager_id = Managers.employee_id

-- 18
SELECT last_name, salary
FROM Employees
WHERE salary < (
    SELECT salary
    FROM Employees
    WHERE employee_id = 103
)

-- Aggregate functions
-- 19
SELECT COUNT(*) AS total_employees
FROM Employees
WHERE department_id = 'D122'

-- 20
SELECT AVG(salary)
FROM Employees
WHERE joib_id = 'J3224'

-- Group by clause
-- 21
SELECT COUNT(*)
FROM Employees
GROUP BY department_id

-- 22
SELECT COUNT(*)
FROM Employees
GROUP BY department_id
HAVING department_id IN (
    SELECT department_id
    FROM Departments NATURAL JOIN Locations
    WHERE city = 'Hanoi'
)

-- 23
SELECT AVG(salary)
FROM Employees
GROUP BY department_id
HAVING department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING COUNT(department_id) = 50
)

-- 24
SELECT *
FROM Countries
WHERE country_id IN (
    SELECT country_id
    FROM Locations NATURAL JOIN Departments
    GROUP BY country_id
    HAVING COUNT(department_id) > 30
)

-- 25
SELECT *
FROM Countries
WHERE country_id IN (
    SELECT country_id
    FROM Locations NATURAL JOIN Departments NATURAL JOIN Countries
    WHERE department_name ='ZARA'
        INTERSECT
    SELECT country_id
    FROM Locations NATURAL JOIN Departments NATURAL JOIN Countries
    WHERE department_name ='H&M'
)

-- 26
SELECT *
FROM Countries
WHERE country_id IN (
    SELECT country_id
    FROM Locations NATURAL JOIN Departments NATURAL JOIN Countries
    WHERE department_name IN ('ZARA', 'H&M')
)

-- OTHERS
-- 27
SELECT *
FROM Employees
WHERE salary > (
    SELECT MIN(salary)
    FROM Employees NATURAL JOIN Departments
    WHERE department_id = 60
)

-- 28
SELECT *
FROM Employees
WHERE salary < (
    SELECT AVG(salary)
    FROM Employees
) AND department_id IN (
    SELECT department_id
    FROM Employees
    WHERE first_name = 'Kevin'
)

-- 29
SELECT *
FROM Countries
WHERE country_id NOT IN (
    SELECT country_id
    FROM Locations NATURAL JOIN Departments
    WHERE department_name = 'ZARA'
)

-- 30
SELECT *
FROM Countries
WHERE country_id IN (
    SELECT country_id
    FROM Departments NATURAL JOIN Locations NATURAL JOIN Countries
    GROUP BY country_id
    HAVING COUNT(department_id) >= ALL(
        SELECT Count(department_id)
        FROM Departments NATURAL JOIN Locations NATURAL JOIN Countries
        GROUP BY country_id
    )
)
