# World Life Expectancy – Exploratory Data Analysis (SQL)

## Project Overview
This project performs exploratory data analysis (EDA) on a global life expectancy
dataset using SQL. The objective is to understand how life expectancy varies across
countries and over time, and to identify key factors that influence population
health outcomes.

The analysis focuses on economic, health, education, and development indicators
and demonstrates intermediate to advanced SQL querying skills.

---

## Dataset Description
The dataset contains country-level, year-wise information related to life
expectancy and public health. Each record represents a **Country + Year**
combination and includes the following types of data:

- Life expectancy
- Adult, infant, and child mortality
- Economic indicators such as GDP
- Education levels (schooling)
- Health indicators (BMI, HIV/AIDS)
- Vaccination coverage (Polio, Diphtheria)
- Development status (Developed / Developing)

---

## Analysis Objectives
The main goals of this analysis are to:

- Analyze changes in life expectancy over time
- Compare life expectancy across countries and regions
- Examine the relationship between life expectancy and GDP
- Evaluate the impact of education, health, and vaccination coverage
- Compare outcomes between developed and developing countries
- Identify high-performing countries using percentile-based analysis

---

## Key Analysis Performed

### 1. Life Expectancy Trends
- Measured life expectancy improvement by country
- Analyzed global life expectancy trends over time

### 2. Economic Impact
- Studied the relationship between GDP and life expectancy
- Compared life expectancy between high-GDP and low-GDP groups

### 3. Development Status Comparison
- Compared average life expectancy between developed and developing countries

### 4. Health & Lifestyle Factors
- Analyzed the impact of BMI on life expectancy
- Evaluated the effect of HIV/AIDS prevalence
- Studied vaccination coverage and its relationship with life expectancy

### 5. Education Impact
- Assessed how schooling levels correlate with life expectancy outcomes

### 6. Advanced SQL Analysis
- Used window functions to analyze rolling mortality trends
- Applied percentile (NTILE) analysis to identify top life-expectancy countries

---

## SQL Techniques Used
- Aggregations (`AVG`, `MIN`, `MAX`)
- Conditional logic (`CASE WHEN`)
- Window functions (`SUM OVER`, `NTILE`)
- Grouping and filtering
- Percentile-based analysis
- Time-based trend analysis
---

## Key Takeaways
- Life expectancy has improved globally over time, but disparities remain
- Economic strength and education show strong positive relationships with life expectancy
- Health factors such as mortality rates and HIV/AIDS significantly affect outcomes
- Vaccination coverage is associated with higher life expectancy
- Advanced SQL techniques help uncover deeper patterns in public health data

