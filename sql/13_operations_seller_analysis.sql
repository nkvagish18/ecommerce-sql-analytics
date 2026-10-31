USE olist_ecommerce;

-- Check available analytics views
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

DESCRIBE vw_delivery_performance;

SELECT *
FROM vw_delivery_performance
LIMIT 5;

DESCRIBE vw_seller_performance;

SELECT *
FROM vw_seller_performance
LIMIT 5;