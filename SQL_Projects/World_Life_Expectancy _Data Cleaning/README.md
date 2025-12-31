# World Life Expectancy – Data Cleaning (SQL)

## Project Overview
This project focuses on cleaning and preparing a global life expectancy dataset
using SQL. The objective is to address common real-world data quality issues such
as duplicate records, missing values, and inconsistent categorical data.

The cleaned dataset is structured to be reliable and ready for further analysis
or visualization.

---

## Dataset Description
The dataset contains country-level life expectancy data recorded over multiple
years. Key attributes include:

- Country
- Year
- Life expectancy
- Development status (Developed / Developing)
- Additional health and demographic indicators
---

## Data Cleaning Objectives
The primary goals of this project are to:

- Identify and remove duplicate country-year records
- Handle missing and empty categorical values
- Standardize development status across records
- Impute missing life expectancy values using logical time-based methods
- Ensure the dataset is consistent and analysis-ready

---

## Data Cleaning Steps Performed

### 1. Duplicate Record Removal
- Treated **Country + Year** as a composite key
- Identified duplicate records using `GROUP BY`
- Safely removed duplicates using window functions (`ROW_NUMBER()`)

### 2. Standardizing Development Status
- Identified missing or empty values in the `Status` column
- Filled missing values by referencing existing records for the same country
- Ensured each country consistently belongs to either *Developed* or *Developing*

### 3. Handling Missing Life Expectancy Values
- Identified missing life expectancy entries
- Used values from the previous and next year for the same country
- Imputed missing values using the average of neighboring years
- Applied rounding for consistency

---

## SQL Techniques Used
- Aggregations (`COUNT`, `AVG`)
- Window functions (`ROW_NUMBER`)
- Self joins
- Conditional updates
- NULL and empty value handling
- Composite key logic

---

## Tools Used
- SQL (MySQL)

---

## Key Takeaways
- Real-world datasets often lack a single unique identifier
- Composite keys are useful for identifying duplicates
- Proper handling of NULL and empty values is critical
- Time-based interpolation is an effective method for filling missing values
- Clean data is essential before performing any analysis
