# 📊 SQL Data Analytics Project (PostgreSQL)

## 📌 Overview

This project demonstrates **end-to-end data analysis using PostgreSQL**, covering the full analytics lifecycle — from raw data exploration to advanced business reporting.

The goal is to analyze **sales, customer behavior, and product performance** to generate meaningful, decision-ready business insights using structured SQL workflows.

> **Dataset:** AdventureWorks-style sales database with fact and dimension tables covering customers, products, orders, and time dimensions.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **PostgreSQL** | Primary database engine |
| **pgAdmin** | Query execution & database management |

---



---

## 🔍 Key Analysis Performed

### 1. Exploratory Data Analysis (EDA)
- Database structure inspection and data validation
- Dimension and measure profiling
- Date range and time-based coverage checks

### 2. Advanced Analytics
- **Trend analysis** — monthly and yearly sales patterns
- **Cumulative metrics** — running totals and moving averages
- **Ranking** — Top/Bottom products and customers by revenue
- **Performance analysis** — period-over-period growth comparisons

### 3. Segmentation
- **Customer segmentation** — VIP, Regular, and New customers
- **Product segmentation** — High, Mid, and Low performers
- **Age group classification** — demographic-based groupings

### 4. Business Metrics
- Total sales and revenue trends over time
- Average Order Value (AOV)
- Customer lifespan and recency scoring
- Product-level performance metrics

---

## 📈 Key Insights

- 💡 A small group of customers drives the majority of revenue **(Pareto principle in action)**
- 💡 Top-performing products account for a disproportionate share of total sales
- 💡 Customer recency and lifecycle stage are strong predictors of spending behavior
- 💡 Sales show clear seasonal and monthly patterns — useful for forecasting and planning

---

## 🧠 Key SQL Concepts Used

```sql
-- Common Table Expressions
WITH cte AS (SELECT ...)

-- Window Functions
LAG(), AVG() OVER(), SUM() OVER(PARTITION BY ...)

-- Date Functions
AGE(), EXTRACT(), DATE_TRUNC()

-- Conditional Logic
CASE WHEN ... THEN ... END

-- Aggregations
GROUP BY, HAVING, COUNT(), SUM(), AVG()
```

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/sql-data-analytics-project.git
   ```

2. **Open pgAdmin** and connect to your PostgreSQL server

3. **Execute scripts in order:**
   ```
   00_init_database.sql → 13_report_product.sql
   ```

4. **Query the final reporting views:**
   ```sql
   SELECT * FROM gold.report_customers;
   SELECT * FROM gold.report_products;
   ```

---

## 🎯 Project Outcome

This project simulates real-world analytics workflows by:
- Transforming raw transactional data into structured, layered insights
- Building reusable and queryable reporting views
- Applying business logic to support data-driven decision-making

---

## 💡 Future Enhancements

- [ ] Build Power BI / Tableau dashboards on top of reporting views
- [ ] Add RFM (Recency, Frequency, Monetary) segmentation model
- [ ] Implement predictive analytics using regression techniques
- [ ] Automate the pipeline using ETL tools (dbt, Airflow)

---

> ⭐ If you found this project useful, consider starring the repository — it helps others discover it!
