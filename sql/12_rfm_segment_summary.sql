
USE olist_ecommerce;

-- RFM Segment Summary for Power BI

CREATE OR REPLACE VIEW vw_rfm_segment_summary AS
SELECT
    customer_segment,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    ROUND(SUM(monetary), 2) AS total_spending,
    ROUND(AVG(monetary), 2) AS avg_customer_spending
FROM vw_rfm_customer_segments
GROUP BY customer_segment;
