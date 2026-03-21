/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    EXTRACT, YEAR, AGE, CURRENT_DATE
===============================================================================
*/

-- Find the date of the first and last order
-- How many Years of sales are available
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) AS order_range_years,
	EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date)))*12 + EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS order_range_months
FROM gold.fact_sales

-- Find the youngest and oldest customer

SELECT
	MIN(birthdate) AS oldest_customer,
	MAX(birthdate) AS youngest_customer,
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, MIN(birthdate))) AS oldest_age,
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, MAX(birthdate))) AS youngest_age
FROM gold.dim_customers
