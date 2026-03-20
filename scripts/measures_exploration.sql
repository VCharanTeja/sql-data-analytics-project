/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the total sales
SELECT
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Find how many items sold
SELECT
	SUM(quantity) AS items_sold
FROM gold.fact_sales;

-- Find the avg selling price
SELECT
	ROUND(AVG(price)) AS avg_price
FROM gold.fact_sales;

-- Find the total number of orders
SELECT
	COUNT(order_number) AS total_orders
FROM gold.fact_sales;

SELECT 
	COUNT(DISTINCT order_number) AS total_distinct_orders
FROM gold.fact_sales;

-- Find the total no of products
SELECT
	COUNT(product_name) AS total_products
FROM gold.dim_products;

-- Find total number of customers
SELECT
	COUNT(customer_key) AS total_customers
FROM gold.dim_customers;

-- Find total no of customers that has placed an order
SELECT
	COUNT(DISTINCT customer_key) AS total_distinct_customers
FROM gold.fact_sales;

-- Generate report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' ,ROUND(AVG(price))  FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
