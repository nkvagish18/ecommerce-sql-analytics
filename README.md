# Brazilian E-Commerce Sales & Customer Analytics Using MySQL

## 📌 Project Overview

This project focuses on analyzing Brazilian e-commerce business data using **MySQL**. The goal is to build a relational database and eventually extract meaningful business insights about customers, orders, products, sellers, payments, reviews, and delivery performance.

The project uses the Brazilian E-Commerce Public Dataset by Olist, which contains real-world e-commerce records from 2016–2018.

The project is being developed step by step, from database design and CSV data loading to data-quality checks, advanced SQL analysis, and business reporting.

## 🎯 Project Objectives

- Design a relational database using MySQL.
- Import and validate real-world e-commerce data.
- Understand primary keys, foreign keys, constraints, and table relationships.
- Analyze sales, customer behavior, product performance, and payment methods.
- Investigate customer reviews and delivery performance.
- Practise SQL from beginner to advanced levels.
- Develop business insights for a portfolio project.
- Prepare the data for a potential Power BI dashboard.

## 🛠️ Technology Stack

- **Database:** MySQL 8.0
- **SQL Environment:** MySQL Workbench
- **Programming Language:** SQL
- **Data Source:** Brazilian E-Commerce Public Dataset by Olist
- **Operating System:** Windows
- **Version Control:** Git and GitHub
- **Future Visualization:** Power BI (planned)

## 📂 Dataset Information

The dataset is available on Kaggle:

**Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

It contains multiple related CSV files covering customers, orders, products, sellers, payments, reviews, and product categories.

### Dataset Files

| CSV File | Description |
|---|---|
| `olist_customers_dataset.csv` | Customer identifiers and location details |
| `olist_orders_dataset.csv` | Order status and timestamps |
| `olist_order_items_dataset.csv` | Products, sellers, prices, and freight charges per order item |
| `olist_order_payments_dataset.csv` | Payment types, installments, and payment values |
| `olist_order_reviews_dataset.csv` | Review scores and customer comments |
| `olist_products_dataset.csv` | Product categories and physical attributes |
| `olist_sellers_dataset.csv` | Seller identifiers and location details |
| `product_category_name_translation.csv` | Portuguese product categories translated into English |
| `olist_geolocation_dataset.csv` | Geolocation information; reserved for a possible future extension |

The geolocation file is not part of the initial analysis workflow.

## 🗄️ Database Design

The project database is named `olist_ecommerce`.

Eight relational tables have been designed:

1. `customers`
2. `sellers`
3. `products`
4. `category_translation`
5. `orders`
6. `order_items`
7. `order_payments`
8. `order_reviews`

### Table Relationships

- A customer can have multiple orders.
- An order can contain multiple order items.
- An order item references a product and a seller.
- An order can have multiple payment records.
- An order can have associated review records.
- Product category translations connect Portuguese category names with their English equivalents.

Primary keys and foreign keys are used to maintain data integrity and model relationships between the tables.

## 📁 Project Structure

```text
Brazilian E-Commerce Analytics/
│
├── README.md
├── .gitignore
│
├── data/
│   └── Local Olist CSV files (not committed to GitHub)
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_create_tables.sql
│   ├── 03_data_loading.sql
│   ├── 04_data_quality_checks.sql
│   ├── 05_basic_analysis.sql
│   ├── 06_sales_analysis.sql
│   ├── 07_customer_analysis.sql
│   ├── 08_product_analysis.sql
│   ├── 09_payment_and_review_analysis.sql
│   └── 10_advanced_sql.sql
│
├── screenshots/
│   └── SQL results and project evidence
│
└── dashboard/
    └── Future Power BI dashboard files
```

*Some folders and SQL files listed above are planned and will be added as development progresses.*

## ⚙️ Setup and Execution

### Prerequisites

- MySQL Server 8.0
- MySQL Workbench
- The Olist dataset downloaded from Kaggle
- Windows environment for the current import workflow

### Step 1: Download the Dataset

Download the dataset from:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Extract the CSV files into your local project directory.

### Step 2: Create the Database

Execute:

```sql
CREATE DATABASE IF NOT EXISTS olist_ecommerce;

USE olist_ecommerce;
```

### Step 3: Create the Tables

Run the script:

`sql/02_create_tables.sql`

This creates the eight tables and defines their data types, primary keys, and foreign-key relationships.

### Step 4: Load the CSV Data

The current Windows setup uses MySQL's server-side `LOAD DATA INFILE` command.

CSV files must first be copied into the directory allowed by the MySQL server configuration. In the current environment, this is:

```text
C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
```

The import commands are maintained in:

`sql/03_data_loading.sql`

Execute each import only when its destination table is ready for loading. Avoid rerunning imports into populated tables because primary-key duplicates may occur.

### Step 5: Validate the Data

The next development stage will include row-count checks, missing-value checks, duplicate checks, and relationship validation.

## 📊 Current Development Status

### Completed

- [x] Downloaded and extracted the Olist dataset.
- [x] Inspected the CSV column names and sample records.
- [x] Created the `olist_ecommerce` database.
- [x] Designed eight relational tables.
- [x] Created the SQL database setup script.
- [x] Created the table creation script.
- [x] Configured the Windows MySQL environment for server-side CSV imports.
- [x] Imported the customer dataset.
- [x] Verified **99,441 customer records**.
- [x] Imported product data; the product table contains **32,951 records**.

### In Progress

- [ ] Confirm and validate the seller import.
- [ ] Import and verify product category translations.
- [ ] Import orders, order items, payments, and reviews.
- [ ] Complete data-quality checks.
- [ ] Develop analytical SQL queries.
- [ ] Document business insights.

### Planned

- [ ] Basic SQL analysis.
- [ ] Sales and revenue analysis.
- [ ] Customer segmentation and repeat-purchase analysis.
- [ ] Product and category performance analysis.
- [ ] Payment and review analysis.
- [ ] Advanced SQL using CTEs and window functions.
- [ ] Power BI dashboard.
- [ ] Final project documentation and screenshots.

## 🔍 Planned Business Questions

After the remaining tables are loaded and validated, the project will investigate questions such as:

- How many orders were placed over time?
- What is the distribution of order statuses?
- Which product categories generate the most sales?
- Which payment methods are most frequently used?
- How do customer reviews relate to delivery performance?
- Which sellers and products perform best?
- How many customers place repeat orders?
- How does delivery time compare with the estimated delivery date?
- What trends can be identified through monthly and yearly analysis?

These are planned analyses; results will be added after the corresponding SQL queries are completed and validated.

## 📚 SQL Concepts Practised

The project is intended to cover:

- Database creation and table design
- Primary keys and foreign keys
- Data types and constraints
- CSV data loading
- `SELECT`, `WHERE`, and `ORDER BY`
- Aggregate functions
- `GROUP BY` and `HAVING`
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- Date and time functions
- Conditional logic using `CASE`
- Data-quality validation
- Business-oriented analytical queries

## 📈 Future Enhancements

- Build a Power BI dashboard for sales and customer analytics.
- Add visualizations for order trends and product performance.
- Create a documented set of business recommendations.
- Extend the project with geolocation analysis if needed.
- Improve data validation and query performance.

## 📖 Data Source and Attribution

This project uses the Brazilian E-Commerce Public Dataset by Olist, available on Kaggle:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Please refer to the original dataset page for its terms of use and attribution requirements.

## 👨‍💻 Author

**N K Vagish**

Third-year Artificial Intelligence and Machine Learning student, building practical database and analytics projects to strengthen SQL, data analysis, and problem-solving skills.

---

*This project is under active development. Sections describing future analysis and visualization will be updated as the implementation progresses.*
