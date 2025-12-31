# US Household Income – Exploratory Data Analysis

## Project Overview
This project focuses on exploratory data analysis (EDA) of US household income data
using SQL. The goal is to understand income distribution patterns across states,
cities, and different location types, and to identify high-income regions and
inequality trends.

The analysis is performed on already cleaned data and demonstrates intermediate
to advanced SQL skills, including joins, aggregations, and window functions.

## Datasets Used
The project uses two CSV datasets:

1. **US Household Income**
   - Contains geographic and location-level information such as state, county,
     city, land area, and water area.
   - Provides the context for income analysis.

2. **US Household Income Statistics**
   - Contains income-related metrics such as mean and median household income.
   - Linked to the location dataset using a common `id` column.

---

## Analysis Objectives
The main objectives of this analysis are:

- Compare household income levels across US states
- Analyze income distribution by location type (e.g., city, CDP, municipality)
- Identify cities with the highest average income
- Examine income inequality using mean vs median income
- Segment cities into income percentiles to identify top income groups

---

## Key Analysis Performed

### 1. State-Level Income Analysis
- Calculated average mean and median household income by state
- Identified states with the highest and lowest income levels

### 2. Income by Location Type
- Analyzed income patterns by location type
- Filtered out categories with small sample sizes to avoid skewed results

### 3. City-Level Income Comparison
- Identified cities with the highest average household income
- Compared income levels across cities within states

### 4. Income Inequality Measurement
- Measured income inequality using the ratio between mean and median income
- Highlighted states with higher income disparity

### 5. Advanced SQL Analysis
The project includes advanced SQL techniques such as:
- Window functions (`DENSE_RANK`, `NTILE`)
- Percentile-based segmentation to identify top 10% income cities
- Ratio-based metrics (income relative to land area)
- NULL-safe calculations for accurate results

---

## Tools & Technologies
- SQL (Window Functions and Aggregations)

---

## Key Takeaways
- Income distribution varies significantly across states and cities
- Certain location types show higher income levels but may have limited data points
- Mean vs median income comparisons help identify income inequality
- Percentile-based analysis provides a clearer view of top income regions

---
## Notes
This project is focused purely on exploratory analysis and insight generation.
Further steps could include deeper outlier investigation, visualization, or
integration with Python-based analysis.

