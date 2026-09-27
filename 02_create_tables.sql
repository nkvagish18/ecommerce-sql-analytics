USE ecommerce_analytics;

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

