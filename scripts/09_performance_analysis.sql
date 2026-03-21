/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

-- Analyze the yearly performance of products by comparing each products sales
-- to both its average sales performance and the previous years sales.
WITH yearly_product_sales AS (
SELECT 
	EXTRACT(YEAR FROM f.order_date) AS order_year,
	p.product_name,
	SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM f.order_date), p.product_name
)

SELECT
	order_year,
	product_name,
	current_sales,
	-- Avg sales per product
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	-- Diff from avg
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name)  AS diff_avg,
	CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
		 WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
		 ELSE 'Avg'
	END avg_change,
	--Year over year Analysis(YoY)
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) AS py_sales,
	current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) AS diff_year,
	CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
		 WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
		 ELSE 'No Change'
	END py_change
FROM yearly_product_sales
ORDER BY product_name, order_year
