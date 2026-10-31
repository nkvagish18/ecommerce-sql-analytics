
USE olist_ecommerce;

CREATE OR REPLACE VIEW vw_review_performance AS
SELECT
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    SUM(review_score = 5) AS five_star_reviews,
    SUM(review_score <= 2) AS negative_reviews
FROM order_reviews
WHERE review_score BETWEEN 1 AND 5;
