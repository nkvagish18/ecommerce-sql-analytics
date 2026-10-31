
CREATE OR REPLACE VIEW vw_review_score_distribution AS
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
WHERE review_score BETWEEN 1 AND 5
GROUP BY review_score
ORDER BY review_score;
