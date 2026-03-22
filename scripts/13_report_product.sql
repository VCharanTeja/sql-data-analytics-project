/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- Drop view if it exists (PostgreSQL way)
DROP VIEW IF EXISTS gold.report_products;

-- Create the view
CREATE VIEW gold.report_products AS

-- ============================================================
-- 1) Base Query
--   - Joins fact_sales and dim_products
--   - Filters valid order records
-- ============================================================
WITH base_query AS (
    SELECT
        f.order_number,            -- Unique order ID
        f.order_date,              -- Order date
        f.customer_key,            -- Customer identifier
        f.sales_amount,            -- Revenue per order
        f.quantity,                -- Units sold

        p.product_key,             -- Product identifier
        p.product_name,            -- Product name
        p.category,                -- Product category
        p.subcategory,             -- Product subcategory
        p.cost                     -- Product cost

    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key

    -- Only valid sales records
    WHERE f.order_date IS NOT NULL
),

-- ============================================================
-- 2) Product Aggregations
--   - Aggregates metrics at product level
--   - Calculates lifespan and performance metrics
-- ============================================================
product_aggregations AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,

        -- Lifespan in months (PostgreSQL replacement for DATEDIFF)
        (
            EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
            EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date)))
        ) AS lifespan,

        -- Most recent sale date
        MAX(order_date) AS last_sale_date,

        -- Total unique orders
        COUNT(DISTINCT order_number) AS total_orders,

        -- Total unique customers
        COUNT(DISTINCT customer_key) AS total_customers,

        -- Total revenue
        SUM(sales_amount) AS total_sales,

        -- Total quantity sold
        SUM(quantity) AS total_quantity,

        -- Average selling price per unit
        ROUND(
            AVG(sales_amount::NUMERIC / NULLIF(quantity, 0)),
            1
        ) AS avg_selling_price

    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)

-- ============================================================
-- 3) Final Query
--   - Adds segmentation and derived metrics
-- ============================================================
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,

    -- Recency: months since last sale
    (
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, last_sale_date)) * 12 +
        EXTRACT(MONTH FROM AGE(CURRENT_DATE, last_sale_date))
    ) AS recency_in_months,

    -- Product performance segmentation
    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,

    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average Order Revenue (AOR)
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue

FROM product_aggregations;
