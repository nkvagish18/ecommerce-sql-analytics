
-- ============================================================
-- Project: Brazilian E-Commerce Analytics
-- File: 09_analytics_views.sql
-- Purpose: Create reusable analytical views
-- Database: olist_ecommerce
-- ============================================================

USE olist_ecommerce;


-- VIEW 1: Monthly sales performance

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m');


-- VIEW 2: Product category performance

CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS category,
    COUNT(*) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY category;


-- VIEW 3: Delivery performance

CREATE OR REPLACE VIEW vw_delivery_performance AS
SELECT
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ), 2
    ) AS avg_delivery_days,
    ROUND(
        100.0 * SUM(
            order_delivered_customer_date >
            order_estimated_delivery_date
        ) / COUNT(*), 2
    ) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- VIEW 4: Customer purchasing metrics

CREATE OR REPLACE VIEW vw_customer_metrics AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    MAX(o.order_purchase_timestamp) AS last_order_date,
    ROUND(SUM(oi.price), 2) AS total_product_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY c.customer_unique_id;


-- VIEW 5: Seller performance

CREATE OR REPLACE VIEW vw_seller_performance AS
SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY s.seller_id, s.seller_state;
