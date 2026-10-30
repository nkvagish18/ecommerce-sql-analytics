
USE olist_ecommerce;

-- Unique customers and repeat customer rate

CREATE OR REPLACE VIEW vw_customer_dashboard AS
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS unique_customers,
    SUM(total_orders >= 2) AS repeat_customers,
    ROUND(
        100.0 * SUM(total_orders >= 2) / COUNT(*), 2
    ) AS repeat_customer_rate,
    ROUND(AVG(total_spending), 2) AS avg_customer_spending
FROM customer_orders;
