USE ecommerce_analytics;

-- 1. Sales Analysis
SELECT * FROM order_items;
-- What is the total revenue generated?
SELECT SUM(quantity * unit_price) as Total_revenue FROM order_items; --  '1280010976.00'
-- Total Orders
select count(*) FROM orders;
-- find the Average Order Value (AOV)
-- Average Order Value = Total Value of Each Order → Then Average of Those Order Totals
SELECT AVG(order_total) AS Average_Order_Value
FROM
(
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS orders_total;


select * from customers;
select * from orders;
select * from order_items;


-- top 10 customer 
SELECT
    c.customer_id,
    c.name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- Best Selling Categories

select * from categories;
select * from orders;
select * from order_items;
select * from products;

-- Which product categories have sold the highest quantity?
SELECT
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_quantity_sold DESC;


-- Which product categories have sold the highest quantity?
SELECT
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_quantity_sold DESC;
-- Lowest Selling Products
SELECT 
     c.category_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_quantity_sold;


-- Revenue by Category
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;

-- Repeat Customers
SELECT
    c.customer_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    RANK() OVER(
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS product_rank
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;