# Automated Data Cleaning – US Household Income (SQL)

## Project Overview
This project focuses on building an automated data cleaning pipeline for a US
household income dataset using SQL. The goal was to simulate a real-world data
cleaning workflow where new data can be cleaned and standardized automatically
as it arrives.

Instead of running manual cleaning queries every time, this project uses a
stored procedure and a trigger to handle data ingestion and cleaning in a
consistent and scalable way.

---

## Dataset Description
The dataset contains location-level household income data across the United
States. It includes geographic information such as state, county, city, land
area, and water area.

Key fields include:
- State and city information
- Location type and classification
- Land and water area measurements
- Geographic coordinates (latitude and longitude)

---

## Project Objectives
The main objectives of this project were to:

- Create a reusable SQL-based data cleaning process
- Prevent duplicate records during data ingestion
- Standardize inconsistent text values
- Automate cleaning whenever new data is inserted
- Validate data quality after cleaning

---

## Data Cleaning Logic

### 1. Automated Ingestion
- A stored procedure copies new records from the raw table into a cleaned table
- Only records that do not already exist in the cleaned table are inserted

### 2. Duplicate Handling
- Duplicate records are identified using the `id` field
- Window functions are used as a safety check to ensure uniqueness

### 3. Data Standardization
The following standardization steps are applied:
- Corrected known spelling issues in state names
- Converted state, county, city, and place names to uppercase
- Standardized inconsistent location types (e.g., CPD → CDP, Boroughs → Borough)

### 4. Automation Using Triggers
- A trigger is created on the raw table
- Whenever a new record is inserted, the cleaning procedure runs automatically
- This ensures the cleaned table is always up to date

---

## Validation Checks
After automation, several validation checks are performed:
- Confirm no duplicate records exist in the cleaned table
- Verify total record counts
- Review state-level distribution to ensure consistent standardization

---

## SQL Techniques Used
- Stored procedures
- Triggers
- Window functions (`ROW_NUMBER`)
- Conditional filtering
- Deduplication logic
- Text standardization

---

## Tools Used
- MySQL

## Key Takeaways
- Automation helps reduce repetitive data cleaning work
- Preventing duplicates is critical in data pipelines
- Triggers are useful for real-time data processing
- Clean, standardized data is essential for reliable analysis

