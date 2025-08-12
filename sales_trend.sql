create database sales_trend;
CREATE TABLE details (
    order_id VARCHAR(20),
    amount DECIMAL(10,2),
    profit DECIMAL(10,2),
    quantity INT,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    payment_mode VARCHAR(50)
);


CREATE TABLE orders (
    order_id VARCHAR(20),
    order_date VARCHAR(20),
    customer_name VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50)
);
show tables;
select * from details;
select * from orders;
SELECT * FROM orders o INNER JOIN details d ON o.order_id = d.order_id;
SELECT 
    o.order_id,
    o.order_date,
    d.amount,
    d.profit,
    d.quantity,
    d.category,
    d.sub_category,
    d.payment_mode
FROM orders o
INNER JOIN details d
    ON o.order_id = d.order_id;
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS order_year
FROM orders o;
SELECT 
    EXTRACT(MONTH FROM STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS order_month
FROM orders o;
select * from details;
SELECT 
    COUNT(DISTINCT d.order_id) AS total_orders
FROM details d;
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS order_month,
    SUM(d.amount) AS total_revenue,
    COUNT(DISTINCT d.order_id) AS total_orders
FROM orders o
INNER JOIN details d
    ON o.order_id = d.order_id
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
SELECT 
    order_year,
    month_name,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM (
    SELECT 
        d.order_id,
        d.amount,
        EXTRACT(YEAR FROM STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS order_year,
        
        MONTHNAME(STR_TO_DATE(o.order_date, '%d-%m-%Y')) AS month_name
    FROM orders o
    INNER JOIN details d
        ON o.order_id = d.order_id
) AS derived
GROUP BY order_year,  month_name
ORDER BY order_year;

