-- ============================================================
-- DATA ENGINEERING SQL CHALLENGE - DAY 04
-- ADVANCED SQL - 50 DIFFERENT QUERY TYPES
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
(102, 'Priya', 'IT', 75000, 'Mumbai', 26, '2022-06-20'),
(103, 'Rahul', 'IT', 90000, 'Pune', 28, '2021-03-10'),
(104, 'Sneha', 'HR', 50000, 'Delhi', 25, '2023-08-12'),
(105, 'Neha', 'HR', 55000, 'Mumbai', 27, '2022-11-05'),
(106, 'Rohan', 'Finance', 65000, 'Pune', 23, '2024-01-18'),
(107, 'Kiran', 'Finance', 80000, 'Delhi', 29, '2021-09-25'),
(108, 'Anita', 'Finance', 85000, 'Mumbai', 31, '2020-05-14'),
(109, 'Vikas', 'Sales', 45000, 'Pune', 26, '2023-04-22'),
(110, 'Pooja', 'Sales', 48000, 'Pune', 24, '2024-02-10'),
(111, 'Ravi', 'Marketing', 58000, 'Delhi', 30, '2022-12-15'),
(112, 'Meena', 'Marketing', 62000, 'Mumbai', 27, '2023-06-10');


-- ============================================================
-- WINDOW FUNCTIONS
-- ============================================================

-- Q1. Assign a row number to every employee based on salary.
SELECT
    emp_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- Q2. Rank employees based on salary.
SELECT
    emp_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- Q3. Rank employees without gaps after ties.
SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM employees;


-- Q4. Assign row numbers separately inside each department.
SELECT
    emp_name,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_row
FROM employees;


-- Q5. Rank employees separately within each department.
SELECT
    emp_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;


-- Q6. Find the highest-paid employee in each department
-- using DENSE_RANK.
SELECT *
FROM (
    SELECT
        emp_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk = 1;


-- Q7. Find the second-highest salary in each department.
SELECT *
FROM (
    SELECT
        emp_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
) x
WHERE rnk = 2;


-- Q8. Find the top 2 employees from every department.
SELECT *
FROM (
    SELECT
        emp_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) x
WHERE rn <= 2;


-- ============================================================
-- LAG AND LEAD
-- ============================================================

-- Q9. Display each employee's salary and
-- the previous salary.
SELECT
    emp_name,
    salary,
    LAG(salary) OVER (
        ORDER BY salary
    ) AS previous_salary
FROM employees;


-- Q10. Display each employee's salary and
-- the next salary.
SELECT
    emp_name,
    salary,
    LEAD(salary) OVER (
        ORDER BY salary
    ) AS next_salary
FROM employees;


-- Q11. Calculate salary difference from previous employee.
SELECT
    emp_name,
    salary,
    salary - LAG(salary) OVER (
        ORDER BY salary
    ) AS salary_difference
FROM employees;


-- Q12. Compare each employee's salary with
-- the next employee's salary.
SELECT
    emp_name,
    salary,
    LEAD(salary) OVER (
        ORDER BY salary
    ) - salary AS difference_to_next
FROM employees;


-- ============================================================
-- FIRST_VALUE / LAST_VALUE
-- ============================================================

-- Q13. Find the highest salary in the complete dataset
-- using FIRST_VALUE.
SELECT
    emp_name,
    salary,
    FIRST_VALUE(salary) OVER (
        ORDER BY salary DESC
    ) AS highest_salary
FROM employees;


-- Q14. Find the lowest salary in the complete dataset
-- using LAST_VALUE.
SELECT
    emp_name,
    salary,
    LAST_VALUE(salary) OVER (
        ORDER BY salary
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_salary
FROM employees;


-- Q15. Find highest salary within each department.
SELECT
    emp_name,
    department,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_highest_salary
FROM employees;


-- ============================================================
-- RUNNING TOTALS
-- ============================================================

-- Q16. Calculate running salary total.
SELECT
    emp_name,
    salary,
    SUM(salary) OVER (
        ORDER BY emp_id
    ) AS running_total
FROM employees;


-- Q17. Calculate running salary total within each department.
SELECT
    emp_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY emp_id
    ) AS department_running_total
FROM employees;


-- Q18. Calculate cumulative average salary.
SELECT
    emp_name,
    salary,
    AVG(salary) OVER (
        ORDER BY emp_id
    ) AS cumulative_average
FROM employees;


-- ============================================================
-- WINDOW AGGREGATES
-- ============================================================

-- Q19. Display total company salary beside every employee.
SELECT
    emp_name,
    salary,
    SUM(salary) OVER () AS company_total_salary
FROM employees;


-- Q20. Display company average salary beside every employee.
SELECT
    emp_name,
    salary,
    AVG(salary) OVER () AS company_average_salary
FROM employees;


-- Q21. Display department total salary beside every employee.
SELECT
    emp_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_total_salary
FROM employees;


-- Q22. Display department average salary beside every employee.
SELECT
    emp_name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_average_salary
FROM employees;


-- Q23. Display percentage contribution of each employee
-- to total company salary.
SELECT
    emp_name,
    salary,
    ROUND(
        salary * 100.0 /
        SUM(salary) OVER (),
        2
    ) AS salary_percentage
FROM employees;


-- ============================================================
-- NTILE
-- ============================================================

-- Q24. Divide employees into 4 salary groups.
SELECT
    emp_name,
    salary,
    NTILE(4) OVER (
        ORDER BY salary DESC
    ) AS salary_quartile
FROM employees;


-- Q25. Divide employees into 3 groups based on age.
SELECT
    emp_name,
    age,
    NTILE(3) OVER (
        ORDER BY age
    ) AS age_group
FROM employees;


-- ============================================================
-- CTE - COMMON TABLE EXPRESSIONS
-- ============================================================

-- Q26. Calculate department average using a CTE.
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_avg;


-- Q27. Find employees earning more than
-- their department average using a CTE.
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employees e
JOIN department_avg d
    ON e.department = d.department
WHERE e.salary > d.avg_salary;


-- Q28. Find departments with total salary
-- greater than 150000.
WITH department_salary AS (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_salary
WHERE total_salary > 150000;


-- Q29. Find the highest-paid employee using a CTE.
WITH ranked_employees AS (
    SELECT
        emp_name,
        salary,
        RANK() OVER (
            ORDER BY salary DESC
        ) AS rnk
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE rnk = 1;


-- Q30. Find the top 2 employees in every department
-- using a CTE.
WITH ranked_employees AS (
    SELECT
        emp_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE rn <= 2;


-- ============================================================
-- MULTIPLE CTEs
-- ============================================================

-- Q31. Compare department average salary
-- with company average salary.
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS department_avg
    FROM employees
    GROUP BY department
),
company_avg AS (
    SELECT
        AVG(salary) AS company_avg
    FROM employees
)
SELECT
    d.department,
    d.department_avg,
    c.company_avg,
    d.department_avg - c.company_avg AS difference
FROM department_avg d
CROSS JOIN company_avg c;


-- Q32. Find departments whose average salary
-- is above company average.
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
),
company_avg AS (
    SELECT
        AVG(salary) AS avg_salary
    FROM employees
)
SELECT
    d.department,
    d.avg_salary
FROM department_avg d
CROSS JOIN company_avg c
WHERE d.avg_salary > c.avg_salary;


-- ============================================================
-- CASE + ADVANCED AGGREGATION
-- ============================================================

-- Q33. Count high, medium and low salary employees.
SELECT
    COUNT(
        CASE WHEN salary >= 70000 THEN 1 END
    ) AS high_salary,
    COUNT(
        CASE
            WHEN salary >= 50000
            AND salary < 70000
            THEN 1
        END
    ) AS medium_salary,
    COUNT(
        CASE WHEN salary < 50000 THEN 1 END
    ) AS low_salary
FROM employees;


-- Q34. Calculate average salary separately
-- for employees above and below 60000.
SELECT
    AVG(
        CASE
            WHEN salary > 60000 THEN salary
        END
    ) AS avg_above_60000,
    AVG(
        CASE
            WHEN salary <= 60000 THEN salary
        END
    ) AS avg_60000_or_below
FROM employees;


-- Q35. Find total salary for each salary category.
SELECT
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,
    SUM(salary) AS total_salary
FROM employees
GROUP BY
    CASE
        WHEN salary >= 70000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END;


-- ============================================================
-- STRING ADVANCED QUERIES
-- ============================================================

-- Q36. Extract first character of employee names.
SELECT
    emp_name,
    LEFT(emp_name, 1) AS first_character
FROM employees;


-- Q37. Extract last character of employee names.
SELECT
    emp_name,
    RIGHT(emp_name, 1) AS last_character
FROM employees;


-- Q38. Reverse employee names.
SELECT
    emp_name,
    REVERSE(emp_name) AS reversed_name
FROM employees;


-- Q39. Create a formatted employee label.
SELECT
    CONCAT(
        emp_id,
        ' - ',
        emp_name,
        ' - ',
        department
    ) AS employee_label
FROM employees;


-- Q40. Find employees whose name contains exactly
-- the letter 'a' twice or more.
SELECT
    emp_name
FROM employees
WHERE LENGTH(LOWER(emp_name))
      - LENGTH(REPLACE(LOWER(emp_name), 'a', '')) >= 2;


-- ============================================================
-- DATE ANALYSIS
-- ============================================================

-- Q41. Find employees who joined in 2023.
SELECT
    emp_name,
    joining_date
FROM employees
WHERE EXTRACT(YEAR FROM joining_date) = 2023;


-- Q42. Count employees who joined in each year.
SELECT
    EXTRACT(YEAR FROM joining_date) AS joining_year,
    COUNT(*) AS employee_count
FROM employees
GROUP BY EXTRACT(YEAR FROM joining_date)
ORDER BY joining_year;


-- Q43. Find the earliest joining date.
SELECT MIN(joining_date) AS earliest_joining_date
FROM employees;


-- Q44. Find the latest joining date.
SELECT MAX(joining_date) AS latest_joining_date
FROM employees;


-- ============================================================
-- PERCENTAGE / DISTRIBUTION
-- ============================================================

-- Q45. Calculate percentage of employees in each department.
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS employee_percentage
FROM employees
GROUP BY department;


-- Q46. Calculate each department's contribution
-- to total salary.
SELECT
    department,
    SUM(salary) AS department_salary,
    ROUND(
        SUM(salary) * 100.0 /
        SUM(SUM(salary)) OVER (),
        2
    ) AS salary_percentage
FROM employees
GROUP BY department;


-- ============================================================
-- ADVANCED FILTERING
-- ============================================================

-- Q47. Find the top 3 highest-paid employees
-- without using LIMIT.
SELECT
    emp_name,
    salary
FROM (
    SELECT
        emp_name,
        salary,
        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) x
WHERE rn <= 3;


-- Q48. Find employees whose salary is
-- above their department's median salary.
SELECT
    e.emp_name,
    e.department,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);


-- ============================================================
-- ADVANCED WINDOW FRAME
-- ============================================================

-- Q49. Calculate the average salary of the
-- current employee and previous employee.
SELECT
    emp_name,
    salary,
    AVG(salary) OVER (
        ORDER BY emp_id
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS two_row_average
FROM employees;


-- Q50. Calculate the moving average of the
-- current employee and previous two employees.
SELECT
    emp_name,
    salary,
    AVG(salary) OVER (
        ORDER BY emp_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average
FROM employees;


-- ============================================================
-- END OF DAY 04
-- ============================================================