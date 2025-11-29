-- Create database (PostgreSQL / SQL Server / MySQL compatible)
CREATE TABLE dim_customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name TEXT,
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE fact_sales (
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    product_id VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),
    shipping_duration_days INT,
    profit_margin_percent DECIMAL(5,2),
    year INT,
    month INT,
    year_month VARCHAR(7),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
