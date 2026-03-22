# sql-data-analytics-project

# 📊 Data Analytics Project (PostgreSQL)

## 📌 Overview

This project demonstrates end-to-end data analysis using **PostgreSQL**, covering the full analytics lifecycle from data exploration to advanced reporting.

The goal is to analyze sales, customer behavior, and product performance to generate meaningful business insights.

---

## 🛠️ Tech Stack

* PostgreSQL

```

---

## 🔍 Key Analysis Performed

### 1. Exploratory Data Analysis (EDA)

* Database structure and data validation
* Dimension and measure exploration
* Date range and time-based insights

### 2. Advanced Analytics

* Trend analysis (monthly/yearly sales)
* Cumulative metrics (running totals)
* Ranking (Top/Bottom products & customers)
* Performance analysis (growth, comparisons)

### 3. Segmentation

* Customer segmentation (VIP, Regular, New)
* Product segmentation (High/Mid/Low performers)
* Age group classification

### 4. Business Metrics

* Total sales and revenue trends
* Average order value (AOV)
* Customer lifespan & recency
* Product performance metrics

---

## 📈 Key Insights

* A small group of customers contributes a large portion of total revenue (Pareto principle).
* High-performing products generate the majority of sales.
* Customer lifecycle and recency significantly impact spending behavior.
* Sales trends show clear time-based patterns useful for forecasting.

---

## 🧠 Key Concepts Used

* Common Table Expressions (CTEs)
* Window Functions (`LAG`, `AVG`, `SUM OVER`)
* Date functions (`AGE`, `EXTRACT`, `DATE_TRUNC`)
* Conditional logic (`CASE WHEN`)
* Aggregations & grouping
* Data segmentation techniques

---

## 🚀 How to Run

1. Clone the repository
2. Open PostgreSQL (pgAdmin / psql)
3. Execute scripts in order:

```
00_init_database.sql → 13_report_product.sql
```

4. Query final views:

```sql
SELECT * FROM gold.report_customers;
SELECT * FROM gold.report_products;
```

---

## 🎯 Project Outcome

This project simulates real-world analytics workflows by:

* Transforming raw data into structured insights
* Building reusable reporting views
* Applying business logic for decision-making

---

## 💡 Future Enhancements

* Build Power BI / Tableau dashboards
* Add RFM (Recency, Frequency, Monetary) segmentation
* Implement predictive analytics
* Automate pipeline using ETL tools

---

