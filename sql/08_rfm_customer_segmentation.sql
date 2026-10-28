
-- ============================================================
-- Project: Brazilian E-Commerce Analytics
-- File: 08_rfm_customer_segmentation.sql
-- Purpose: Customer segmentation using RFM analysis
-- Database: olist_ecommerce
-- ============================================================

USE olist_ecommerce;


-- QUERY 1: Customer RFM metrics and segmentation

WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(oi.price), 2) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        DATEDIFF(
            (SELECT MAX(order_purchase_timestamp)
             FROM orders),
            last_order_date
        ) AS recency_days,
        frequency,
        monetary,

        6 - NTILE(5) OVER (
            ORDER BY last_order_date DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score

    FROM customer_metrics
)
SELECT
    customer_unique_id,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    CASE
        WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
            THEN 'Champions'

        WHEN frequency_score >= 4
            THEN 'Loyal Customers'

        WHEN recency_score >= 4
             AND frequency_score <= 2
            THEN 'Potential Loyalists'

        WHEN recency_score <= 2
             AND frequency_score >= 3
            THEN 'At Risk'

        ELSE 'Regular Customers'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC;


-- QUERY 2: Summary of customer segments

WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price) AS monetary
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        last_order_date,
        frequency,
        monetary,

        6 - NTILE(5) OVER (
            ORDER BY last_order_date DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score

    FROM customer_metrics
),
segmented AS (
    SELECT
        monetary,
        CASE
            WHEN recency_score >= 4
                 AND frequency_score >= 4
                 AND monetary_score >= 4
                THEN 'Champions'

            WHEN frequency_score >= 4
                THEN 'Loyal Customers'

            WHEN recency_score >= 4
                 AND frequency_score <= 2
                THEN 'Potential Loyalists'

            WHEN recency_score <= 2
                 AND frequency_score >= 3
                THEN 'At Risk'

            ELSE 'Regular Customers'
        END AS customer_segment
    FROM rfm_scores
)
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(monetary), 2) AS total_product_spending,
    ROUND(AVG(monetary), 2) AS avg_customer_spending
FROM segmented
GROUP BY customer_segment
ORDER BY total_customers DESC;
           