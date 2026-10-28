
-- ============================================================
-- Project: Brazilian E-Commerce Analytics
-- File: 06_advanced_analysis.sql
-- Purpose: Advanced business analysis
-- Database: olist_ecommerce
-- ============================================================

USE olist_ecommerce;


-- QUERY 1: Monthly revenue trends

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(AVG(oi.price), 2) AS avg_item_price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- QUERY 2: Delivery performance

SELECT
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(DATEDIFF(
            order_delivered_customer_date,
            order_purchase_timestamp
        )), 2
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


-- QUERY 3: Top 10 product categories by revenue

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY category
ORDER BY product_revenue DESC
LIMIT 10;


-- QUERY 4: Seller review performance

WITH order_review_summary AS (
    SELECT
        order_id,
        AVG(review_score) AS avg_review_score
    FROM order_reviews
    WHERE review_score BETWEEN 1 AND 5
    GROUP BY order_id
)
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(AVG(r.avg_review_score), 2) AS avg_review_score
FROM order_items oi
JOIN order_review_summary r
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT oi.order_id) >= 20
ORDER BY avg_review_score ASC;


-- QUERY 5: Top 3 sellers in each state

WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        ROUND(SUM(oi.price), 2) AS product_revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY s.seller_state, s.seller_id
),
ranked_sellers AS (
    SELECT
        seller_state,
        seller_id,
        product_revenue,
        DENSE_RANK() OVER (
            PARTITION BY seller_state
            ORDER BY product_revenue DESC
        ) AS seller_rank
    FROM seller_revenue
)
SELECT *
FROM ranked_sellers
WHERE seller_rank <= 3
ORDER BY seller_state, seller_rank;
