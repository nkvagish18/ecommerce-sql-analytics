
-- ============================================================
-- Project: Brazilian E-Commerce Sales & Customer Analytics
-- File: 05_basic_analysis.sql
-- Database: olist_ecommerce
-- Purpose: Basic business analysis using SQL
-- ============================================================

USE olist_ecommerce;


-- ============================================================
-- QUERY 1: ORDER STATUS DISTRIBUTION
-- Business question:
-- How many orders are in each status?
-- Concepts: GROUP BY, COUNT, ORDER BY
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================
-- QUERY 2: PAYMENT METHOD ANALYSIS
-- Business question:
-- Which payment methods have the highest total payment value?
-- Concepts: GROUP BY, COUNT, SUM, ROUND
-- Note: These are payment records, not unique orders.
-- ============================================================

SELECT
    payment_type,
    COUNT(*) AS payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- ============================================================
-- QUERY 3: CUSTOMER REVIEW ANALYSIS
-- Business question:
-- What are the average, lowest, and highest review scores?
-- Concepts: AVG, MIN, MAX, ROUND
-- ============================================================

SELECT
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_score), 2) AS average_review_score,
    MIN(review_score) AS lowest_review_score,
    MAX(review_score) AS highest_review_score
FROM order_reviews;


-- ============================================================
-- QUERY 4: TOP 10 PRODUCT CATEGORIES BY PRODUCT COUNT
-- Business question:
-- Which categories contain the most products?
-- Concepts: LEFT JOIN, COALESCE, GROUP BY, LIMIT
-- ============================================================

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS category,
    COUNT(*) AS total_products
FROM products p
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )
ORDER BY total_products DESC
LIMIT 10;


-- ============================================================
-- QUERY 5: MONTHLY ORDER TREND
-- Business question:
-- How many orders were placed in each month?
-- Concepts: DATE_FORMAT, GROUP BY, ORDER BY
-- ============================================================

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;
