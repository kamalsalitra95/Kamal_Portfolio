# US Household Income Data Cleaning

## Project Overview
This project focuses on cleaning and preparing US household income data using SQL.
The goal of this project is to handle common real-world data issues such as duplicate
records, inconsistent text values, missing data, and CSV import errors.

The cleaned data can be used for further analysis and reporting.

---

## Datasets Used
This project uses two CSV datasets:

1. **US Household Income**
   - Contains location-level information such as state, county, city, land area,
     and water area.
   - Includes geographic and regional identifiers.

2. **US Household Income Statistics**
   - Contains income-related metrics such as mean, median, and standard deviation.
   - Linked to the first dataset using a common `id` column.

---

## Data Cleaning Steps Performed
The following data cleaning steps were performed using MySQL:

- Inspected raw data to understand structure and quality
- Fixed column name issues caused by CSV encoding (BOM characters)
- Identified and removed duplicate records using window functions
- Standardized state names and corrected spelling inconsistencies
- Cleaned categorical fields such as location type
- Handled NULL, empty, and invalid values in land and water area columns
- Validated data consistency across both tables

---

## Tools Used
- SQL (Window Functions, Joins, Data Cleaning Queries)

---

## Key Learnings
- Real-world data often contains inconsistencies and encoding issues
- Proper data cleaning is critical before any analysis
- Window functions are useful for safely handling duplicate records
- Consistent formatting improves data reliability
