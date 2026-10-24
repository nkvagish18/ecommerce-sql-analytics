
-- =========================================================
-- Project: Brazilian E-Commerce Sales & Customer Analytics
-- File: 03_data_loading.sql
-- Database: olist_ecommerce
-- Purpose: Import CSV datasets into MySQL tables
-- =========================================================

USE olist_ecommerce;

-- IMPORTANT:
-- Copy CSV files into:
-- C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
--
-- Execute each import only when its destination table
-- is empty. Do not run the entire file repeatedly.


-- =========================================================
-- 1. CUSTOMERS
-- Expected rows: 99,441
-- Status: Imported and verified
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
);


-- =========================================================
-- 2. SELLERS
-- Expected rows: 3,095
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
);


-- =========================================================
-- 3. PRODUCTS
-- Expected rows: 32,951
-- Empty numeric fields are converted to NULL.
-- Status: 32,951 rows reported
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    @product_id,
    @product_category_name,
    @product_name_length,
    @product_description_length,
    @product_photos_qty,
    @product_weight_g,
    @product_length_cm,
    @product_height_cm,
    @product_width_cm
)
SET
    product_id = @product_id,
    product_category_name = NULLIF(@product_category_name, ''),
    product_name_length = NULLIF(@product_name_length, ''),
    product_description_length = NULLIF(@product_description_length, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, '');


-- =========================================================
-- 4. CATEGORY TRANSLATIONS
-- Expected rows: approximately 71
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE category_translation
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    product_category_name,
    product_category_name_english
);




-- =========================================================
-- 5. ORDERS
-- Convert empty date values to NULL
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE olist_ecommerce.orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    @order_id,
    @customer_id,
    @order_status,
    @order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    @order_estimated_delivery_date
)
SET
    order_id = @order_id,
    customer_id = @customer_id,
    order_status = @order_status,
    order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');


-- =========================================================
-- 6. ORDER ITEMS
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE olist_ecommerce.order_items
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
);


-- =========================================================
-- 7. ORDER PAYMENTS
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE olist_ecommerce.order_payments
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
);



-- =========================================================
-- 8. ORDER REVIEWS
-- Handles empty date fields and quoted CSV values
-- =========================================================

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE olist_ecommerce.order_reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    @review_creation_date,
    @review_answer_timestamp
)
SET
    review_creation_date = NULLIF(@review_creation_date, ''),
    review_answer_timestamp = NULLIF(@review_answer_timestamp, '');
