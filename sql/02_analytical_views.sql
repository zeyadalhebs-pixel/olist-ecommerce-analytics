-- Staged Fact Table View: Cleaned Sales & Logistics Performance
CREATE OR REPLACE VIEW view_fact_sales AS
SELECT 
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    o.customer_id,
    oi.seller_id,
    o.order_status,
    o.order_purchase_timestamp::DATE AS order_date,
    o.order_approved_at::DATE AS approved_date,
    o.order_delivered_customer_date::DATE AS delivery_date,
    o.order_estimated_delivery_date::DATE AS estimated_delivery_date,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_order_item_value,
    (o.order_delivered_customer_date::DATE - o.order_purchase_timestamp::DATE) AS delivery_lead_time_days,
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 
        ELSE 0 
    END AS is_delayed
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;

-- Staged Dimension View: Customer Geography
CREATE OR REPLACE VIEW view_dim_customer AS
SELECT 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    INITCAP(customer_city) AS customer_city,
    UPPER(customer_state) AS customer_state
FROM olist_customers_dataset;

-- Staged Dimension View: English Products Catalog
CREATE OR REPLACE VIEW view_dim_product AS
SELECT 
    p.product_id,
    COALESCE(
        INITCAP(REPLACE(t.product_category_name_english, '_', ' ')), 
        'Uncategorized'
    ) AS category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t 
    ON p.product_category_name = t.product_category_name;