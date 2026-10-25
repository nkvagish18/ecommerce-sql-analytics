
-- =========================================================
-- Project: Brazilian E-Commerce Analytics
-- File: 04_data_quality_checks.sql
-- Purpose: Validate data quality and table relationships
-- Database: olist_ecommerce
-- =========================================================

USE olist_ecommerce;


-- =========================================================
-- CHECK 1: CUSTOMER DATA
-- Check total customers, missing IDs, and unique IDs
-- =========================================================

SELECT
    COUNT(*) AS total_customers,
    SUM(customer_id IS NULL) AS missing_customer_ids,
    COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM customers;


-- =========================================================
-- CHECK 2: ORDER UNIQUENESS
-- Check for duplicate order IDs
-- =========================================================

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;


-- =========================================================
-- CHECK 3: ORDER-CUSTOMER RELATIONSHIP
-- Find orders without a matching customer
-- =========================================================

SELECT COUNT(*) AS orders_without_customers
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- =========================================================
-- CHECK 4: REVIEW SCORE VALIDATION
-- Review scores should be between 1 and 5
-- =========================================================

SELECT COUNT(*) AS invalid_review_scores
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5
   OR review_score IS NULL;
