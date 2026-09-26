-- ============================================================
-- DATA ENGINEERING SQL CHALLENGE - DAY 02
-- AGGREGATE FUNCTIONS - 50 DIFFERENT QUERY TYPES
-- PostgreSQL / MySQL 8+
-- ============================================================


-- ============================================================
-- SETUP
-- ============================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    age INT,
    joining_date DATE
);

INSERT INTO employees
(emp_id, emp_name, department, salary, city, age, joining_date)
VALUES
(101, 'Amit', 'IT', 60000, 'Pune', 24, '2023-01-15'),
(102, 'Priya', 'HR', 50000, 'Mumbai', 26, '2022-06-20'),
(103, 'Rahul', 'IT', 75000, 'Pune', 28, '2021-03-10'),
(104, 'Sneha', 'Finance', 65000, 'Delhi', 25, '2023-08-12'),
(105, 'Neha', 'IT', 70000, 'Mumbai', 27, '2022-11-05'),
(106, 'Rohan', 'Sales', 45000, 'Pune', 23, '2024-01-18'),
(107, 'Kiran', 'HR', 55000, 'Delhi', 29, '2021-09-25'),
(108, 'Anita', 'Finance', 80000, 'Mumbai', 31, '2020-05-14'),
(109, 'Vikas', 'Sales', 48000, 'Pune', 26, '2023-04-22'),
(110, 'Pooja', 'Marketing', 58000, 'Delhi', 24, '2024-02-10');


-- ============================================================
-- BASIC AGGREGATE FUNCTIONS
-- ============================================================

-- Q1. Find the total number of employees.
SELECT COUNT(*) AS total_employees
FROM employees;


-- Q2. Count employee IDs.
SELECT COUNT(emp_id) AS employee_count
FROM employees;


-- Q3. Find the total salary paid to all employees.
SELECT SUM(salary) AS total_salary
FROM employees;


-- Q4. Find the average salary.
SELECT AVG(salary) AS average_salary
FROM employees;


-- Q5. Find the highest salary.
SELECT MAX(salary) AS highest_salary
FROM employees;


-- Q6. Find the lowest salary.
SELECT MIN(salary) AS lowest_salary
FROM employees;


-- Q7. Find the salary difference between highest and lowest.
SELECT MAX(salary) - MIN(salary) AS salary_difference
FROM employees;


-- Q8. Find the average age of employees.
SELECT AVG(age) AS average_age
FROM employees;


-- Q9. Find the total age of all employees.
SELECT SUM(age) AS total_age
FROM employees;


-- Q10. Find the number of different departments.
SELECT COUNT(DISTINCT department) AS department_count
FROM employees;


-- ============================================================
-- GROUP BY
-- ============================================================

-- Q11. Count employees in each department.
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Q12. Find total salary of each department.
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;


-- Q13. Find average salary of each department.
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department;


-- Q14. Find maximum salary in each department.
SELECT
    department,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department;


-- Q15. Find minimum salary in each department.
SELECT
    department,
    MIN(salary) AS minimum_salary
FROM employees
GROUP BY department;


-- Q16. Find average age in each department.
SELECT
    department,
    AVG(age) AS average_age
FROM employees
GROUP BY department;


-- Q17. Find total employees in each city.
SELECT
    city,
    COUNT(*) AS employee_count
FROM employees
GROUP BY city;


-- Q18. Find total salary paid in each city.
SELECT
    city,
    SUM(salary) AS total_salary
FROM employees
GROUP BY city;


-- Q19. Find average salary in each city.
SELECT
    city,
    AVG(salary) AS average_salary
FROM employees
GROUP BY city;


-- Q20. Find highest salary in each city.
SELECT
    city,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY city;


-- ============================================================
-- GROUP BY MULTIPLE COLUMNS
-- ============================================================

-- Q21. Count employees by department and city.
SELECT
    department,
    city,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department, city;


-- Q22. Find total salary by department and city.
SELECT
    department,
    city,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department, city;


-- Q23. Find average salary by department and city.
SELECT
    department,
    city,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department, city;


-- Q24. Find maximum salary by department and city.
SELECT
    department,
    city,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department, city;


-- Q25. Find employee count by city and age.
SELECT
    city,
    age,
    COUNT(*) AS employee_count
FROM employees
GROUP BY city, age;


-- ============================================================
-- HAVING
-- ============================================================

-- Q26. Find departments having more than 1 employee.
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


-- Q27. Find departments whose total salary is greater than 120000.
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 120000;


-- Q28. Find departments whose average salary is greater than 60000.
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;


-- Q29. Find cities having more than 2 employees.
SELECT
    city,
    COUNT(*) AS employee_count
FROM employees
GROUP BY city
HAVING COUNT(*) > 2;


-- Q30. Find departments where the highest salary is greater than 70000.
SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department
HAVING MAX(salary) > 70000;


-- ============================================================
-- WHERE + GROUP BY
-- ============================================================

-- Q31. Find average salary by department only for employees
-- earning more than 50000.
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
WHERE salary > 50000
GROUP BY department;


-- Q32. Count IT employees by city.
SELECT
    city,
    COUNT(*) AS employee_count
FROM employees
WHERE department = 'IT'
GROUP BY city;


-- Q33. Find total salary of employees aged 25 or above
-- for each department.
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
WHERE age >= 25
GROUP BY department;


-- Q34. Find average salary in each city for employees
-- earning at least 55000.
SELECT
    city,
    AVG(salary) AS average_salary
FROM employees
WHERE salary >= 55000
GROUP BY city;


-- Q35. Find departments with more than one employee
-- whose salary is above 50000.
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 50000
GROUP BY department
HAVING COUNT(*) > 1;


-- ============================================================
-- DISTINCT + AGGREGATES
-- ============================================================

-- Q36. Count distinct cities.
SELECT COUNT(DISTINCT city) AS unique_cities
FROM employees;


-- Q37. Count distinct departments.
SELECT COUNT(DISTINCT department) AS unique_departments
FROM employees;


-- Q38. Count distinct department-city combinations.
SELECT COUNT(DISTINCT (department, city)) AS unique_combinations
FROM employees;


-- ============================================================
-- CONDITIONAL AGGREGATION
-- ============================================================

-- Q39. Count employees earning more than 60000.
SELECT
    COUNT(CASE WHEN salary > 60000 THEN 1 END) AS high_salary_employees
FROM employees;


-- Q40. Count employees earning less than 60000.
SELECT
    COUNT(CASE WHEN salary < 60000 THEN 1 END) AS low_salary_employees
FROM employees;


-- Q41. Count IT employees and non-IT employees.
SELECT
    COUNT(CASE WHEN department = 'IT' THEN 1 END) AS it_employees,
    COUNT(CASE WHEN department <> 'IT' THEN 1 END) AS non_it_employees
FROM employees;


-- Q42. Calculate total salary of IT employees.
SELECT
    SUM(CASE
        WHEN department = 'IT' THEN salary
        ELSE 0
    END) AS it_total_salary
FROM employees;


-- Q43. Calculate total salary of HR employees.
SELECT
    SUM(CASE
        WHEN department = 'HR' THEN salary
        ELSE 0
    END) AS hr_total_salary
FROM employees;


-- Q44. Calculate average salary of employees earning
-- more than 60000.
SELECT
    AVG(CASE
        WHEN salary > 60000 THEN salary
    END) AS average_high_salary
FROM employees;


-- ============================================================
-- AGGREGATE + EXPRESSIONS
-- ============================================================

-- Q45. Calculate total annual salary expense.
SELECT
    SUM(salary * 12) AS annual_salary_expense
FROM employees;


-- Q46. Calculate average annual salary.
SELECT
    AVG(salary * 12) AS average_annual_salary
FROM employees;


-- Q47. Calculate total 10% bonus expense.
SELECT
    SUM(salary * 0.10) AS total_bonus
FROM employees;


-- ============================================================
-- ORDER AGGREGATED RESULTS
-- ============================================================

-- Q48. Display departments ordered by total salary,
-- highest first.
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;


-- Q49. Display departments ordered by average salary,
-- lowest first.
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary ASC;


-- Q50. Display the department having the highest
-- total salary.
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1;


-- ============================================================
-- END OF DAY 02
-- ============================================================