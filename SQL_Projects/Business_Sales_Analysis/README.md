# Business Sales Analysis (SQL)

## Project Overview
This project focuses on analyzing business sales data using SQL to extract
meaningful, decision-oriented insights. The analysis is performed on curated,
analytics-ready data that follows a modern **data warehousing (medallion)
architecture**.

The objective of this project is to demonstrate not only SQL querying skills,
but also an understanding of how analytical data is structured and consumed
in real-world data platforms.

---

## Data Warehousing Context (Medallion Architecture)

This project works on the **Gold layer** of a data warehouse, which represents
clean, curated, and business-ready data.

The overall data flow follows the standard medallion architecture:

### 🥉 Bronze Layer (Raw Data)
- Contains raw transactional data ingested from source systems
- Data may include duplicates, missing values, or inconsistencies
- Minimal transformations are applied at this stage

### 🥈 Silver Layer (Cleaned & Enriched Data)
- Raw data is cleaned, standardized, and validated
- Duplicates are removed and data quality checks are applied
- Business keys and relationships are established

### 🥇 Gold Layer (Analytics & Reporting)
- Data is transformed into fact and dimension tables
- Optimized for analytics, reporting, and BI tools
- Contains aggregated, business-friendly datasets

This project specifically uses **Gold-layer tables**, ensuring the analysis is
performed on trusted, high-quality data.

---

## Dataset Description
The analysis uses a star-schema style data model from the Gold layer:

- **fact_sales** – transactional sales data including revenue, quantity, and order dates
- **dim_products** – product attributes such as name, category, and cost
- **dim_customers** – customer demographic and identification details

This structure reflects a typical enterprise data warehouse design.

---

## Analysis Objectives
The key goals of this project were to:

- Analyze business performance using curated Gold-layer data
- Extract actionable insights for decision-making
- Apply advanced SQL techniques used in analytics teams
- Demonstrate understanding of data warehousing concepts
- Build queries that can directly support BI dashboards

---

## Key Insights & Analysis

### 1. Business Performance Snapshot
A consolidated KPI view was created to provide a high-level overview of the
business, including total sales, orders, customers, and pricing metrics.

### 2. Top Performing Products
Products were ranked by total revenue using window functions to identify the
top revenue contributors.

### 3. Sales Trend Over Time
Monthly sales trends were analyzed to understand revenue growth, customer
activity, and volume patterns.

### 4. Cumulative Sales & Moving Average
Running totals and moving averages were used to evaluate long-term performance
and smooth short-term fluctuations.

### 5. Category Contribution Analysis
A part-to-whole analysis was performed to measure how much each product category
contributes to overall revenue.

### 6. Product Cost Segmentation
Products were grouped into cost ranges to understand pricing distribution across
the catalog.

### 7. Customer Segmentation
Customers were segmented into **VIP**, **Regular**, and **New** groups based on
their spending behavior and lifecycle duration.

### 8. Top Customers by Revenue
High-value customers were identified to understand revenue concentration and
key business relationships.

---

## SQL Techniques Used
- Aggregations (`SUM`, `AVG`, `COUNT`)
- Window functions (`RANK`, `SUM() OVER`)
- Common Table Expressions (CTEs)
- CASE statements for segmentation
- Time-based analysis using date functions
- Part-to-whole percentage calculations

---

## Tools & Environment
- SQL (MySQL)
- Data warehouse tables (Gold layer)
- Star schema (fact and dimension tables)

## Project Structure

Business_Sales_Analysis/
├── Business_Sales_Analysis.sql
│   
├── README.md
│ 
├── gold.dim_customers.csv
│   
├── gold.dim_products.csv
│  
├── gold.fact_sales.csv
│   
├── gold.report_customers.csv
│   


## Key Takeaways
- Performing analysis on Gold-layer data ensures accuracy and consistency
- Understanding data warehousing improves the quality of analytics
- SQL is most powerful when combined with a strong data model
- This project mirrors how analytics is done in real data teams
