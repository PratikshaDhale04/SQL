USE sql_practice;

-- Display all employees
SELECT * FROM emp;

-- Display employee names
SELECT name
FROM emp;

-- Employees with salary greater than 50000
SELECT name
FROM emp
WHERE salary > 50000;