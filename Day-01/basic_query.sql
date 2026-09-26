-- ============================================================
-- DATA ENGINEERING SQL CHALLENGE - DAY 01
-- BASIC SQL - 50 DIFFERENT QUERY PATTERNS
-- PostgreSQL
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
-- BASIC SELECT
-- ============================================================

-- Q1. Display all employees.
SELECT *
FROM employees;


-- Q2. Display only employee names.
SELECT emp_name
FROM employees;


-- Q3. Display employee name and salary.
SELECT emp_name, salary
FROM employees;


-- Q4. Display employee name, department and city.
SELECT emp_name, department, city
FROM employees;


-- Q5. Display unique departments.
SELECT DISTINCT department
FROM employees;


-- Q6. Display unique cities.
SELECT DISTINCT city
FROM employees;


-- ============================================================
-- WHERE CONDITIONS
-- ============================================================

-- Q7. Find employees working in IT.
SELECT *
FROM employees
WHERE department = 'IT';


-- Q8. Find employees from Pune.
SELECT *
FROM employees
WHERE city = 'Pune';


-- Q9. Find employees with salary greater than 60000.
SELECT *
FROM employees
WHERE salary > 60000;


-- Q10. Find employees with salary less than 50000.
SELECT *
FROM employees
WHERE salary < 50000;


-- Q11. Find employees with salary equal to 55000.
SELECT *
FROM employees
WHERE salary = 55000;


-- Q12. Find employees aged 25 or more.
SELECT *
FROM employees
WHERE age >= 25;


-- Q13. Find employees aged below 25.
SELECT *
FROM employees
WHERE age < 25;


-- ============================================================
-- AND / OR / NOT
-- ============================================================

-- Q14. Find IT employees earning more than 65000.
SELECT *
FROM employees
WHERE department = 'IT'
AND salary > 65000;


-- Q15. Find employees from Pune or Mumbai.
SELECT *
FROM employees
WHERE city = 'Pune'
OR city = 'Mumbai';


-- Q16. Find employees who are not from IT.
SELECT *
FROM employees
WHERE department <> 'IT';


-- Q17. Find employees from IT and Pune.
SELECT *
FROM employees
WHERE department = 'IT'
AND city = 'Pune';


-- Q18. Find employees from HR or Finance.
SELECT *
FROM employees
WHERE department IN ('HR', 'Finance');


-- ============================================================
-- IN / NOT IN
-- ============================================================

-- Q19. Find employees from Pune, Delhi or Mumbai.
SELECT *
FROM employees
WHERE city IN ('Pune', 'Delhi', 'Mumbai');


-- Q20. Find employees not working in IT or HR.
SELECT *
FROM employees
WHERE department NOT IN ('IT', 'HR');


-- ============================================================
-- BETWEEN
-- ============================================================

-- Q21. Find employees with salary between 50000 and 70000.
SELECT *
FROM employees
WHERE salary BETWEEN 50000 AND 70000;


-- Q22. Find employees aged between 24 and 27.
SELECT *
FROM employees
WHERE age BETWEEN 24 AND 27;


-- ============================================================
-- LIKE
-- ============================================================

-- Q23. Find employees whose name starts with A.
SELECT *
FROM employees
WHERE emp_name LIKE 'A%';


-- Q24. Find employees whose name ends with 'a'.
SELECT *
FROM employees
WHERE emp_name LIKE '%a';


-- Q25. Find employees whose name contains 'an'.
SELECT *
FROM employees
WHERE emp_name LIKE '%an%';


-- Q26. Find employees whose name has exactly 5 characters.
SELECT *
FROM employees
WHERE emp_name LIKE '_____';


-- ============================================================
-- ORDER BY
-- ============================================================

-- Q27. Display employees by salary from lowest to highest.
SELECT *
FROM employees
ORDER BY salary ASC;


-- Q28. Display employees by salary from highest to lowest.
SELECT *
FROM employees
ORDER BY salary DESC;


-- Q29. Display employees alphabetically by name.
SELECT *
FROM employees
ORDER BY emp_name ASC;


-- Q30. Display employees from youngest to oldest.
SELECT *
FROM employees
ORDER BY age ASC;


-- Q31. Sort employees by department and then salary descending.
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;


-- ============================================================
-- LIMIT
-- ============================================================

-- Q32. Display the top 5 highest-paid employees.
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;


-- Q33. Display the 3 youngest employees.
SELECT *
FROM employees
ORDER BY age ASC
LIMIT 3;


-- Q34. Display the 5 most recently joined employees.
SELECT *
FROM employees
ORDER BY joining_date DESC
LIMIT 5;


-- ============================================================
-- CASE
-- ============================================================

-- Q35. Categorize employees based on salary.
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees;


-- Q36. Categorize employees based on age.
SELECT
    emp_name,
    age,
    CASE
        WHEN age < 25 THEN 'Young'
        WHEN age <= 30 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category
FROM employees;


-- ============================================================
-- STRING FUNCTIONS
-- ============================================================

-- Q37. Convert employee names to uppercase.
SELECT
    emp_name,
    UPPER(emp_name) AS uppercase_name
FROM employees;


-- Q38. Convert employee names to lowercase.
SELECT
    emp_name,
    LOWER(emp_name) AS lowercase_name
FROM employees;


-- Q39. Find the length of each employee name.
SELECT
    emp_name,
    LENGTH(emp_name) AS name_length
FROM employees;


-- Q40. Display the first 3 characters of each employee name.
SELECT
    emp_name,
    LEFT(emp_name, 3) AS first_three_characters
FROM employees;


-- ============================================================
-- NUMERIC CALCULATIONS
-- ============================================================

-- Q41. Increase every salary by 10%.
SELECT
    emp_name,
    salary,
    salary * 1.10 AS increased_salary
FROM employees;


-- Q42. Calculate annual salary.
SELECT
    emp_name,
    salary,
    salary * 12 AS annual_salary
FROM employees;


-- Q43. Calculate 5% bonus.
SELECT
    emp_name,
    salary,
    salary * 0.05 AS bonus
FROM employees;


-- ============================================================
-- DATE FUNCTIONS
-- ============================================================

-- Q44. Display employee joining year.
SELECT
    emp_name,
    joining_date,
    EXTRACT(YEAR FROM joining_date) AS joining_year
FROM employees;


-- Q45. Display employee joining month.
SELECT
    emp_name,
    joining_date,
    EXTRACT(MONTH FROM joining_date) AS joining_month
FROM employees;


-- Q46. Find employees who joined after January 1, 2023.
SELECT *
FROM employees
WHERE joining_date > '2023-01-01';


-- Q47. Find employees who joined during 2023.
SELECT *
FROM employees
WHERE joining_date >= '2023-01-01'
AND joining_date < '2024-01-01';


-- ============================================================
-- PLACEMENT-STYLE BASIC QUESTIONS
-- ============================================================

-- Q48. Find the employee with the highest salary.
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;


-- Q49. Find the employee with the lowest salary.
SELECT *
FROM employees
ORDER BY salary ASC
LIMIT 1;


-- Q50. Find employees whose salary is greater than 60000
-- and who live in Mumbai or Pune.
SELECT *
FROM employees
WHERE salary > 60000
AND city IN ('Mumbai', 'Pune');


-- ============================================================
-- END OF DAY 01
-- ============================================================