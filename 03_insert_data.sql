USE ecommerce_analytics;

INSERT INTO customers
(customer_id, customer_name, email, city, state, signup_date)
VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', 'Bangalore', 'Karnataka', '2025-01-15'),
(2, 'Priya Nair', 'priya@gmail.com', 'Kochi', 'Kerala', '2025-02-20'),
(3, 'Rahul Verma', 'rahul@gmail.com', 'Mumbai', 'Maharashtra', '2025-03-10'),
(4, 'Sneha Rao', 'sneha@gmail.com', 'Bangalore', 'Karnataka', '2025-04-05'),
(5, 'Arjun Patel', 'arjun@gmail.com', 'Ahmedabad', 'Gujarat', '2025-05-18');

INSERT INTO products
(product_id, product_name, category, price, cost)
VALUES
(101, 'Wireless Headphones', 'Electronics', 2999.00, 1800.00),
(102, 'Mechanical Keyboard', 'Electronics', 5499.00, 3500.00),
(103, 'Running Shoes', 'Fashion', 3999.00, 2400.00),
(104, 'Backpack', 'Fashion', 1999.00, 1100.00),
(105, 'Smart Watch', 'Electronics', 7999.00, 5200.00),
(106, 'Coffee Maker', 'Home Appliances', 4999.00, 3000.00),
(107, 'Desk Lamp', 'Home Appliances', 1499.00, 800.00),
(108, 'Yoga Mat', 'Sports', 999.00, 500.00);

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, '2026-01-10', 'Completed'),
(1002, 2, '2026-01-15', 'Completed'),
(1003, 3, '2026-02-05', 'Completed'),
(1004, 1, '2026-02-20', 'Completed'),
(1005, 4, '2026-03-02', 'Completed'),
(1006, 5, '2026-03-15', 'Cancelled'),
(1007, 2, '2026-04-01', 'Completed'),
(1008, 3, '2026-04-12', 'Completed');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity)
VALUES
(1, 1001, 101, 2),
(2, 1001, 108, 1),
(3, 1002, 105, 1),
(4, 1003, 103, 1),
(5, 1003, 104, 2),
(6, 1004, 102, 1),
(7, 1005, 106, 1),
(8, 1005, 107, 2),
(9, 1006, 105, 1),
(10, 1007, 101, 1),
(11, 1007, 104, 1),
(12, 1008, 102, 1),
(13, 1008, 108, 2);

INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, amount, payment_status)
VALUES
(501, 1001, '2026-01-10', 'UPI', 6997.00, 'Paid'),
(502, 1002, '2026-01-15', 'Card', 7999.00, 'Paid'),
(503, 1003, '2026-02-05', 'UPI', 7997.00, 'Paid'),
(504, 1004, '2026-02-20', 'Card', 5499.00, 'Paid'),
(505, 1005, '2026-03-02', 'UPI', 7997.00, 'Paid'),
(506, 1006, '2026-03-15', 'UPI', 7999.00, 'Refunded'),
(507, 1007, '2026-04-01', 'Card', 4998.00, 'Paid'),
(508, 1008, '2026-04-12', 'UPI', 7497.00, 'Paid');

INSERT INTO reviews
(review_id, customer_id, product_id, rating, review_date)
VALUES
(1, 1, 101, 5, '2026-01-20'),
(2, 2, 105, 4, '2026-01-25'),
(3, 3, 103, 5, '2026-02-15'),
(4, 3, 104, 4, '2026-02-16'),
(5, 1, 102, 3, '2026-03-01'),
(6, 4, 106, 5, '2026-03-10'),
(7, 2, 101, 4, '2026-04-10'),
(8, 3, 102, 2, '2026-04-20');