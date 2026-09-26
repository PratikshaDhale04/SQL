USE sql_practice;

-- ============================================
-- DAY 01: SQL BASICS - 25 QUERY CHALLENGE
-- ============================================


-- Q1. Display all employees
SELECT *
FROM emp;


-- Q2. Display only employee names
SELECT name
FROM emp;


-- Q3. Display employee names and salaries
SELECT name, salary
FROM emp;


-- Q4. Find employees whose salary is greater than 50000
SELECT name, salary
FROM emp
WHERE salary > 50000;


-- Q5. Find employees whose salary is less than 50000
SELECT name, salary
FROM emp
WHERE salary < 50000;


-- Q6. Find employees whose salary is exactly 50000
SELECT name, salary
FROM emp
WHERE salary = 50000;


-- Q7. Find employees whose salary is greater than or equal to 50000
SELECT name, salary
FROM emp
WHERE salary >= 50000;


-- Q8. Find employees whose salary is between 40000 and 60000
SELECT name, salary
FROM emp
WHERE salary BETWEEN 40000 AND 60000;


-- Q9. Find employees whose salary is NOT between 40000 and 60000
SELECT name, salary
FROM emp
WHERE salary NOT BETWEEN 40000 AND 60000;


-- Q10. Find employees from the IT department
SELECT *
FROM emp
WHERE department = 'IT';


-- Q11. Find employees from IT or HR
SELECT *
FROM emp
WHERE department IN ('IT', 'HR');


-- Q12. Find employees who are NOT from IT
SELECT *
FROM emp
WHERE department != 'IT';


-- Q13. Find employees whose name starts with A
SELECT *
FROM emp
WHERE name LIKE 'A%';


-- Q14. Find employees whose name ends with a
SELECT *
FROM emp
WHERE name LIKE '%a';


-- Q15. Find employees whose name contains 'an'
SELECT *
FROM emp
WHERE name LIKE '%an%';


-- Q16. Find employees whose name has exactly 5 characters
SELECT *
FROM emp
WHERE name LIKE '_____';


-- Q17. Find IT employees earning more than 50000
SELECT *
FROM emp
WHERE department = 'IT'
AND salary > 50000;


-- Q18. Find employees from IT OR HR
SELECT *
FROM emp
WHERE department = 'IT'
OR department = 'HR';


-- Q19. Find employees who are NOT from IT or HR
SELECT *
FROM emp
WHERE department NOT IN ('IT', 'HR');


-- Q20. Find employees whose salary is greater than 50000
-- and less than 100000
SELECT *
FROM emp
WHERE salary > 50000
AND salary < 100000;


-- Q21. Display unique departments
SELECT DISTINCT department
FROM emp;


-- Q22. Find employees whose salary is NULL
SELECT *
FROM emp
WHERE salary IS NULL;


-- Q23. Find employees whose salary is NOT NULL
SELECT *
FROM emp
WHERE salary IS NOT NULL;


-- Q24. Find IT employees earning more than 50000
-- OR employees from HR
SELECT *
FROM emp
WHERE (department = 'IT' AND salary > 50000)
OR department = 'HR';


-- Q25. Find employees whose name starts with A
-- and salary is greater than 50000
SELECT name, salary
FROM emp
WHERE name LIKE 'A%'
AND salary > 50000;