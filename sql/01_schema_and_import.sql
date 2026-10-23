-- 1. Orders table
CREATE TABLE IF NOT EXISTS olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- 2. Order items table
CREATE TABLE IF NOT EXISTS olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2)
);

-- 3. Customers table
CREATE TABLE IF NOT EXISTS olist_customers_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);

-- 4. Products table
CREATE TABLE IF NOT EXISTS olist_products_dataset (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- 5. Category translation table
CREATE TABLE IF NOT EXISTS product_category_name_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);