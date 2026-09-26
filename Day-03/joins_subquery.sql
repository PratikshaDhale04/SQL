-- ============================================================
-- DATA ENGINEERING SQL CHALLENGE - DAY 03
-- JOINS + SUBQUERIES - 50 DIFFERENT QUERY TYPES
-- PostgreSQL / MySQL 8+
-- ============================================================


-- ============================================================
-- SETUP
-- ============================================================

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;


CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    manager_id INT
);


CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT
);


INSERT INTO departments
(dept_id, dept_name, location)
VALUES
(1, 'IT', 'Pune'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Sales', 'Bangalore'),
(5, 'Marketing', 'Hyderabad');


INSERT INTO employees
(emp_id, emp_name, dept_id, salary, manager_id)
VALUES
(101, 'Amit', 1, 60000, NULL),
(102, 'Priya', 1, 75000, 101),
(103, 'Rahul', 2, 50000, NULL),
(104, 'Sneha', 2, 55000, 103),
(105, 'Neha', 3, 80000, NULL),
(106, 'Rohan', 3, 65000, 105),
(107, 'Kiran', 4, 45000, NULL),
(108, 'Anita', 4, 70000, 107),
(109, 'Vikas', NULL, 40000, NULL);


INSERT INTO projects
(project_id, project_name, dept_id)
VALUES
(201, 'Data Platform', 1),
(202, 'Recruitment System', 2),
(203, 'Financial Analytics', 3),
(204, 'Sales Dashboard', 4),
(205, 'Marketing Campaign', 5);


-- ============================================================
-- INNER JOIN
-- ============================================================

-- Q1. Display employees with their department names.
SELECT
    e.emp_name,
    d.dept_name
FROM employees e
INNER JOIN departments d
    ON e.dept_id = d.dept_id;


-- Q2. Display employee name, salary and department location.
SELECT
    e.emp_name,
    e.salary,
    d.dept_name,
    d.location
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id;


-- Q3. Find employees working in IT.
SELECT
    e.emp_name,
    d.dept_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';


-- Q4. Find employees working in Pune.
SELECT
    e.emp_name,
    d.location
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.location = 'Pune';


-- Q5. Display employees earning more than 60000
-- with their department.
SELECT
    e.emp_name,
    e.salary,
    d.dept_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE e.salary > 60000;


-- ============================================================
-- LEFT JOIN
-- ============================================================

-- Q6. Display all departments and their employees.
SELECT
    d.dept_name,
    e.emp_name
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id;


-- Q7. Find departments having no employees.
SELECT
    d.dept_name
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;


-- Q8. Display all employees including employees
-- without a department.
SELECT
    e.emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
    ON e.dept_id = d.dept_id;


-- Q9. Find employees who do not belong to any department.
SELECT
    e.emp_name
FROM employees e
LEFT JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;


-- ============================================================
-- RIGHT JOIN
-- ============================================================

-- Q10. Display all departments and matching employees.
SELECT
    e.emp_name,
    d.dept_name
FROM employees e
RIGHT JOIN departments d
    ON e.dept_id = d.dept_id;


-- Q11. Find departments without employees using RIGHT JOIN.
SELECT
    d.dept_name
FROM employees e
RIGHT JOIN departments d
    ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;


-- ============================================================
-- MULTIPLE JOINS
-- ============================================================

-- Q12. Display employees and their department projects.
SELECT
    e.emp_name,
    d.dept_name,
    p.project_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
JOIN projects p
    ON d.dept_id = p.dept_id;


-- Q13. Find employees working in departments
-- that have projects.
SELECT DISTINCT
    e.emp_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
JOIN projects p
    ON d.dept_id = p.dept_id;


-- Q14. Display project name, department and location.
SELECT
    p.project_name,
    d.dept_name,
    d.location
FROM projects p
JOIN departments d
    ON p.dept_id = d.dept_id;


-- Q15. Find employees working on the
-- Data Platform project.
SELECT
    e.emp_name
FROM employees e
JOIN projects p
    ON e.dept_id = p.dept_id
WHERE p.project_name = 'Data Platform';


-- ============================================================
-- JOIN + AGGREGATE
-- ============================================================

-- Q16. Count employees in each department.
SELECT
    d.dept_name,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- Q17. Find total salary of each department.
SELECT
    d.dept_name,
    COALESCE(SUM(e.salary), 0) AS total_salary
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- Q18. Find average salary of each department.
SELECT
    d.dept_name,
    AVG(e.salary) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- Q19. Find the highest salary in each department.
SELECT
    d.dept_name,
    MAX(e.salary) AS highest_salary
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- Q20. Find departments having average salary
-- greater than 60000.
SELECT
    d.dept_name,
    AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 60000;


-- ============================================================
-- SELF JOIN
-- ============================================================

-- Q21. Display employees with their managers.
SELECT
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;


-- Q22. Find employees who have a manager.
SELECT
    e.emp_name,
    m.emp_name AS manager
FROM employees e
JOIN employees m
    ON e.manager_id = m.emp_id;


-- Q23. Find employees who do not have a manager.
SELECT
    emp_name
FROM employees
WHERE manager_id IS NULL;


-- Q24. Find managers and the number of employees
-- reporting to them.
SELECT
    m.emp_name AS manager,
    COUNT(e.emp_id) AS team_size
FROM employees m
JOIN employees e
    ON m.emp_id = e.manager_id
GROUP BY m.emp_name;


-- Q25. Find managers whose team has more than
-- one employee.
SELECT
    m.emp_name AS manager,
    COUNT(e.emp_id) AS team_size
FROM employees m
JOIN employees e
    ON m.emp_id = e.manager_id
GROUP BY m.emp_name
HAVING COUNT(e.emp_id) > 1;


-- ============================================================
-- SIMPLE SUBQUERIES
-- ============================================================

-- Q26. Find employees earning more than
-- the company average salary.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- Q27. Find the employee with the highest salary.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- Q28. Find the employee with the lowest salary.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);


-- Q29. Find employees earning exactly the
-- average salary.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary = (
    SELECT AVG(salary)
    FROM employees
);


-- Q30. Find employees earning more than 65000.
-- Use a subquery to calculate the threshold.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary > (
    SELECT 65000
);


-- ============================================================
-- SUBQUERY WITH IN
-- ============================================================

-- Q31. Find employees belonging to departments
-- located in Pune.
SELECT
    emp_name,
    dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location = 'Pune'
);


-- Q32. Find employees belonging to departments
-- having a project.
SELECT
    emp_name
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM projects
);


-- Q33. Find employees belonging to IT or HR.
SELECT
    emp_name
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE dept_name IN ('IT', 'HR')
);


-- ============================================================
-- NOT IN
-- ============================================================

-- Q34. Find employees who do not belong to
-- departments having projects.
SELECT
    emp_name
FROM employees
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM projects
);


-- Q35. Find departments that have no employees.
SELECT
    dept_name
FROM departments
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM employees
    WHERE dept_id IS NOT NULL
);


-- ============================================================
-- CORRELATED SUBQUERIES
-- ============================================================

-- Q36. Find employees earning more than
-- their department average.
SELECT
    e.emp_name,
    e.salary,
    e.dept_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


-- Q37. Find the highest-paid employee
-- in each department.
SELECT
    e.emp_name,
    e.salary,
    e.dept_id
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


-- Q38. Find employees earning the minimum salary
-- in their department.
SELECT
    e.emp_name,
    e.salary,
    e.dept_id
FROM employees e
WHERE e.salary = (
    SELECT MIN(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


-- Q39. Find employees who earn more than
-- every employee in their department.
SELECT
    e.emp_name,
    e.salary,
    e.dept_id
FROM employees e
WHERE e.salary >= ALL (
    SELECT e2.salary
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


-- ============================================================
-- EXISTS
-- ============================================================

-- Q40. Find departments that have at least
-- one employee.
SELECT
    d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);


-- Q41. Find departments that have no employees.
SELECT
    d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);


-- Q42. Find employees whose department
-- has at least one project.
SELECT
    e.emp_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.dept_id = e.dept_id
);


-- Q43. Find departments that have at least
-- one employee earning above 70000.
SELECT
    d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
    AND e.salary > 70000
);


-- ============================================================
-- NTH HIGHEST SALARY
-- ============================================================

-- Q44. Find the second-highest salary.
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


-- Q45. Find employees having the second-highest salary.
SELECT
    emp_name,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);


-- Q46. Find the third-highest salary.
SELECT MAX(salary) AS third_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);


-- ============================================================
-- SUBQUERY IN FROM
-- ============================================================

-- Q47. Find departments whose average salary
-- is greater than 60000.
SELECT *
FROM (
    SELECT
        dept_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY dept_id
) AS department_average
WHERE average_salary > 60000;


-- Q48. Find the highest average salary
-- among all departments.
SELECT MAX(average_salary) AS highest_department_average
FROM (
    SELECT
        dept_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY dept_id
) AS department_average;


-- ============================================================
-- SUBQUERY + JOIN
-- ============================================================

-- Q49. Find employees whose salary is greater than
-- the average salary of their department,
-- along with the department name.
SELECT
    e.emp_name,
    e.salary,
    d.dept_name
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);


-- Q50. Find the department containing the
-- highest-paid employee.
SELECT
    d.dept_name,
    e.emp_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
);


-- ============================================================
-- END OF DAY 03
-- ============================================================