-- ============================================================
-- DATA ENGINEERING SQL CHALLENGE - DAY 05
-- E-COMMERCE SALES & CUSTOMER ANALYTICS PROJECT
-- PostgreSQL / MySQL 8+
-- ============================================================


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


-- ============================================================
-- CUSTOMERS TABLE
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);


-- ============================================================
-- PRODUCTS TABLE
-- ============================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


-- ============================================================
-- ORDERS TABLE
-- ============================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    discount DECIMAL(5,2),
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ============================================================
-- CUSTOMER DATA
-- ============================================================

INSERT INTO customers
(customer_id, customer_name, city, state, signup_date)
VALUES
(1, 'Amit', 'Pune', 'Maharashtra', '2023-01-10'),
(2, 'Priya', 'Mumbai', 'Maharashtra', '2023-02-15'),
(3, 'Rahul', 'Delhi', 'Delhi', '2023-03-20'),
(4, 'Sneha', 'Pune', 'Maharashtra', '2023-04-12'),
(5, 'Neha', 'Bangalore', 'Karnataka', '2023-05-18'),
(6, 'Rohan', 'Mumbai', 'Maharashtra', '2023-06-25'),
(7, 'Kiran', 'Delhi', 'Delhi', '2023-07-05'),
(8, 'Anita', 'Hyderabad', 'Telangana', '2023-08-14'),
(9, 'Vikas', 'Pune', 'Maharashtra', '2023-09-10'),
(10, 'Pooja', 'Bangalore', 'Karnataka', '2023-10-22');


-- ============================================================
-- PRODUCT DATA
-- ============================================================

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 30000),
(103, 'Headphones', 'Electronics', 3000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800),
(106, 'Office Chair', 'Furniture', 8000),
(107, 'Desk', 'Furniture', 12000),
(108, 'Monitor', 'Electronics', 15000),
(109, 'Backpack', 'Accessories', 2000),
(110, 'Table Lamp', 'Furniture', 2500);


-- ============================================================
-- ORDER DATA
-- discount is percentage
-- ============================================================

INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity, discount, status)
VALUES
(1001, 1, 101, '2024-01-05', 1, 5, 'Completed'),
(1002, 2, 102, '2024-01-08', 2, 10, 'Completed'),
(1003, 3, 103, '2024-01-12', 3, 5, 'Completed'),
(1004, 4, 106, '2024-01-15', 1, 0, 'Completed'),
(1005, 5, 108, '2024-01-18', 2, 10, 'Completed'),
(1006, 6, 104, '2024-01-20', 3, 5, 'Completed'),
(1007, 7, 107, '2024-01-22', 1, 15, 'Completed'),
(1008, 8, 105, '2024-01-25', 4, 0, 'Completed'),
(1009, 9, 109, '2024-01-28', 2, 5, 'Completed'),
(1010, 10, 110, '2024-02-02', 3, 10, 'Completed'),

(1011, 1, 102, '2024-02-05', 1, 5, 'Completed'),
(1012, 2, 103, '2024-02-08', 2, 0, 'Completed'),
(1013, 3, 108, '2024-02-12', 1, 5, 'Completed'),
(1014, 4, 105, '2024-02-15', 5, 10, 'Completed'),
(1015, 5, 101, '2024-02-18', 1, 5, 'Completed'),
(1016, 6, 106, '2024-02-20', 2, 0, 'Completed'),
(1017, 7, 104, '2024-02-22', 2, 5, 'Completed'),
(1018, 8, 107, '2024-02-25', 1, 10, 'Completed'),
(1019, 9, 103, '2024-02-27', 3, 0, 'Completed'),
(1020, 10, 109, '2024-02-28', 2, 5, 'Completed'),

(1021, 1, 108, '2024-03-02', 1, 0, 'Completed'),
(1022, 2, 101, '2024-03-05', 1, 10, 'Completed'),
(1023, 3, 102, '2024-03-08', 2, 5, 'Completed'),
(1024, 4, 103, '2024-03-10', 4, 0, 'Completed'),
(1025, 5, 107, '2024-03-12', 1, 5, 'Completed'),
(1026, 6, 110, '2024-03-15', 2, 10, 'Completed'),
(1027, 7, 106, '2024-03-18', 1, 0, 'Completed'),
(1028, 8, 109, '2024-03-20', 3, 5, 'Completed'),
(1029, 9, 105, '2024-03-22', 4, 10, 'Completed'),
(1030, 10, 104, '2024-03-25', 2, 0, 'Completed');


-- ============================================================
-- REVENUE FORMULA
-- ============================================================
-- Gross amount = price * quantity
-- Discount amount = gross amount * discount / 100
-- Net amount = gross amount - discount amount
--
-- ============================================================


-- ============================================================
-- BASIC PROJECT QUERIES
-- ============================================================

-- Q1. Display all customers.
SELECT *
FROM customers;


-- Q2. Display all products.
SELECT *
FROM products;


-- Q3. Display all orders.
SELECT *
FROM orders;


-- Q4. Display customers from Maharashtra.
SELECT *
FROM customers
WHERE state = 'Maharashtra';


-- Q5. Display products costing more than 10000.
SELECT *
FROM products
WHERE price > 10000;


-- ============================================================
-- JOIN ANALYSIS
-- ============================================================

-- Q6. Display order details with customer name.
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.quantity,
    o.status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;


-- Q7. Display order details with product name.
SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    o.order_date
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- Q8. Display complete order information.
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    o.discount,
    o.order_date
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;


-- ============================================================
-- REVENUE CALCULATION
-- ============================================================

-- Q9. Calculate gross amount for every order.
SELECT
    o.order_id,
    p.product_name,
    p.price,
    o.quantity,
    p.price * o.quantity AS gross_amount
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- Q10. Calculate discount amount for every order.
SELECT
    o.order_id,
    p.product_name,
    p.price * o.quantity AS gross_amount,
    o.discount,
    (p.price * o.quantity * o.discount / 100) AS discount_amount
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- Q11. Calculate net revenue for every order.
SELECT
    o.order_id,
    p.product_name,
    (
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS net_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- ============================================================
-- SALES AGGREGATION
-- ============================================================

-- Q12. Find total revenue.
SELECT
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS total_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;


-- Q13. Find total number of orders.
SELECT COUNT(*) AS total_orders
FROM orders;


-- Q14. Find total quantity sold.
SELECT SUM(quantity) AS total_quantity
FROM orders;


-- Q15. Find average order quantity.
SELECT AVG(quantity) AS average_quantity
FROM orders;


-- Q16. Find highest-value order.
SELECT
    o.order_id,
    p.product_name,
    p.price * o.quantity AS gross_amount
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
ORDER BY gross_amount DESC
LIMIT 1;


-- ============================================================
-- PRODUCT ANALYSIS
-- ============================================================

-- Q17. Find total quantity sold for each product.
SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name;


-- Q18. Find total revenue generated by each product.
SELECT
    p.product_name,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name;


-- Q19. Find the best-selling product by quantity.
SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;


-- Q20. Find the highest-revenue product.
SELECT
    p.product_name,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;


-- Q21. Find average selling quantity for each product.
SELECT
    p.product_name,
    AVG(o.quantity) AS average_quantity
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_name;


-- ============================================================
-- CATEGORY ANALYSIS
-- ============================================================

-- Q22. Find total revenue by category.
SELECT
    p.category,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category;


-- Q23. Find total quantity sold by category.
SELECT
    p.category,
    SUM(o.quantity) AS quantity_sold
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category;


-- Q24. Find average product price by category.
SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category;


-- Q25. Find the category with the highest revenue.
SELECT
    p.category,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM products p
JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;


-- ============================================================
-- CUSTOMER ANALYSIS
-- ============================================================

-- Q26. Find total orders made by each customer.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name;


-- Q27. Find total spending by each customer.
SELECT
    c.customer_name,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name;


-- Q28. Find the highest-spending customer.
SELECT
    c.customer_name,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 1;


-- Q29. Find customers who placed more than 2 orders.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 2;


-- Q30. Find customers who spent more than 50000.
SELECT
    c.customer_name,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING SUM(
    p.price * o.quantity
    - (p.price * o.quantity * o.discount / 100)
) > 50000;


-- ============================================================
-- CITY / STATE ANALYSIS
-- ============================================================

-- Q31. Find total revenue by city.
SELECT
    c.city,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.city;


-- Q32. Find total revenue by state.
SELECT
    c.state,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY c.state;


-- Q33. Find number of customers in each city.
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city;


-- ============================================================
-- DATE ANALYSIS
-- ============================================================

-- Q34. Find monthly revenue.
SELECT
    EXTRACT(YEAR FROM o.order_date) AS order_year,
    EXTRACT(MONTH FROM o.order_date) AS order_month,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date)
ORDER BY order_year, order_month;


-- Q35. Find number of orders per month.
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    COUNT(*) AS order_count
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;


-- Q36. Find revenue generated in February 2024.
SELECT
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS february_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
WHERE o.order_date >= '2024-02-01'
AND o.order_date < '2024-03-01';


-- ============================================================
-- SUBQUERIES
-- ============================================================

-- Q37. Find products whose price is above
-- the average product price.
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);


-- Q38. Find customers whose spending is above
-- average customer spending.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_spending
WHERE spending > (
    SELECT AVG(spending)
    FROM customer_spending
);


-- Q39. Find products that have never been ordered.
SELECT
    p.product_name
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;


-- Q40. Find customers who have placed at least one order.
SELECT
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- ============================================================
-- WINDOW FUNCTIONS
-- ============================================================

-- Q41. Rank products by total revenue.
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS revenue
    FROM products p
    JOIN orders o
        ON p.product_id = o.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_revenue;


-- Q42. Rank customers by spending.
WITH customer_spending AS (
    SELECT
        c.customer_name,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    spending,
    DENSE_RANK() OVER (
        ORDER BY spending DESC
    ) AS spending_rank
FROM customer_spending;


-- Q43. Find top 3 products by revenue.
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS revenue
    FROM products p
    JOIN orders o
        ON p.product_id = o.product_id
    GROUP BY p.product_name
)
SELECT *
FROM (
    SELECT
        product_name,
        revenue,
        ROW_NUMBER() OVER (
            ORDER BY revenue DESC
        ) AS rn
    FROM product_revenue
) x
WHERE rn <= 3;


-- Q44. Calculate running revenue by order date.
WITH daily_revenue AS (
    SELECT
        o.order_date,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS revenue
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_revenue;


-- ============================================================
-- BUSINESS ANALYSIS
-- ============================================================

-- Q45. Find the average order value.
WITH order_values AS (
    SELECT
        o.order_id,
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
        AS order_value
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
)
SELECT AVG(order_value) AS average_order_value
FROM order_values;


-- Q46. Find orders whose value is above
-- the average order value.
WITH order_values AS (
    SELECT
        o.order_id,
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
        AS order_value
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
)
SELECT *
FROM order_values
WHERE order_value > (
    SELECT AVG(order_value)
    FROM order_values
);


-- Q47. Find the percentage of total revenue
-- contributed by each product.
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(
            p.price * o.quantity
            - (p.price * o.quantity * o.discount / 100)
        ) AS revenue
    FROM products p
    JOIN orders o
        ON p.product_id = o.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM product_revenue;


-- Q48. Find the most expensive product
-- in each category.
SELECT *
FROM (
    SELECT
        product_name,
        category,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS rn
    FROM products
) x
WHERE rn = 1;


-- Q49. Find the customer who purchased
-- the largest quantity of products.
SELECT
    c.customer_name,
    SUM(o.quantity) AS total_quantity
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_quantity DESC
LIMIT 1;


-- Q50. Create a customer summary containing:
-- customer name, city, total orders,
-- total quantity and total spending.
SELECT
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(
        p.price * o.quantity
        - (p.price * o.quantity * o.discount / 100)
    ) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city
ORDER BY total_spending DESC;


-- ============================================================
-- END OF DAY 05
-- ============================================================