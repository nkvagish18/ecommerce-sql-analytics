
-- ============================================================
-- Project: Brazilian E-Commerce Sales & Customer Analytics
-- File: 07_customer_analysis.sql
-- Database: olist_ecommerce
-- Purpose: Customer behavior and purchasing analysis
-- ============================================================

USE olist_ecommerce;


-- ============================================================
-- QUERY 1: TOTAL UNIQUE CUSTOMERS
-- Business question:
-- How many distinct real-world customers are represented?
-- ============================================================

SELECT
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;


-- ============================================================
-- QUERY 2: CUSTOMERS BY STATE
-- Business question:
-- Which Brazilian states have the most customer records?
-- ============================================================

SELECT
    customer_state,
    COUNT(*) AS customer_records
FROM customers
GROUP BY customer_state
ORDER BY customer_records DESC;


-- ============================================================
-- QUERY 3: TOP 10 CITIES BY CUSTOMER RECORDS
-- Business question:
-- Which cities have the most customer records?
-- ============================================================

SELECT
    customer_city,
    customer_state,
    COUNT(*) AS customer_records
FROM customers
GROUP BY customer_city, customer_state
ORDER BY customer_records DESC
LIMIT 10;


-- ============================================================
-- QUERY 4: REPEAT CUSTOMERS
-- Business question:
-- How many unique customers have multiple orders?
-- ============================================================

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) AS repeat_customer_summary;


-- ============================================================
-- QUERY 5: ORDERS PER CUSTOMER
-- Business question:
-- How many customers have placed 1, 2, 3, or more orders?
-- ============================================================

SELECT
    total_orders,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_order_summary
GROUP BY total_orders
ORDER BY total_orders;


-- ============================================================
-- QUERY 6: TOP 10 CUSTOMERS BY PRODUCT SPENDING
-- Business question:
-- Which customers have the highest total product spending?
-- ============================================================

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_product_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY total_product_spending DESC
LIMIT 10;


-- ============================================================
-- QUERY 7: AVERAGE PRODUCT SPENDING PER CUSTOMER
-- Business question:
-- What is the average product spending per purchasing customer?
-- ============================================================

SELECT
    ROUND(AVG(customer_spending), 2)
        AS average_spending_per_customer
FROM (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS customer_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
) AS customer_totals;


-- ============================================================
-- QUERY 8: CUSTOMER ORDER FREQUENCY
-- Business question:
-- What percentage of purchasing customers placed multiple orders?
-- ============================================================

SELECT
    COUNT(*) AS purchasing_customers,
    SUM(total_orders > 1) AS repeat_customers,
    ROUND(
        100.0 * SUM(total_orders > 1) / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_order_summary;


-- ============================================================
-- QUERY 9: MONTHLY NEW CUSTOMER ACQUISITION
-- Business question:
-- How many distinct customers made their first recorded purchase
-- in each month?
-- ============================================================

SELECT
    DATE_FORMAT(first_order_date, '%Y-%m') AS acquisition_month,
    COUNT(*) AS new_customers
FROM (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_order_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS first_customer_orders
GROUP BY DATE_FORMAT(first_order_date, '%Y-%m')
ORDER BY acquisition_month;


-- ============================================================
-- QUERY 10: CUSTOMER SPENDING SEGMENTATION
-- Business question:
-- How many customers fall into basic spending groups?
-- Segments are illustrative and can be adjusted.
-- ============================================================

SELECT
    spending_segment,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_unique_id,
        total_spending,
        CASE
            WHEN total_spending >= 1000 THEN 'High Spending'
            WHEN total_spending >= 500 THEN 'Medium Spending'
            ELSE 'Low Spending'
        END AS spending_segment
    FROM (
        SELECT
            c.customer_unique_id,
            SUM(oi.price) AS total_spending
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY c.customer_unique_id
    ) AS spending_totals
) AS segmented_customers
GROUP BY spending_segment
ORDER BY number_of_customers DESC;
