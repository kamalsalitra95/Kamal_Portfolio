# US Household Income – Exploratory Data Analysis

# view household income table
SELECT * 
FROM us_house_project.us_household_income;

# view income statistics table
SELECT * 
FROM us_house_project.us_household_income_statistics;


# Top 10 largest states by land area
SELECT State_Name,
	SUM(ALand) AS total_land_area
FROM us_house_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

#let's look at just the state level the average mean income and median
SELECT u.State_Name,
    ROUND(AVG(us.Mean),2) AS avg_mean_income,
    ROUND(AVG(us.Median),2) AS avg_median_income
FROM us_house_project.us_household_income u
JOIN us_house_project.us_household_income_statistics us
ON u.id = us.id
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY avg_mean_income DESC;


# Income distribution by place type
SELECT `Type`, COUNT(`Type`) AS record_count,
    ROUND(AVG(us.Mean),1) AS avg_mean_income,
    ROUND(AVG(us.Median),1)AS avg_median_income
FROM us_house_project.us_household_income AS u
JOIN us_house_project.us_household_income_statistics AS us
ON u.id = us.id
WHERE Mean <> 0
GROUP BY `Type`
HAVING COUNT(`Type`) > 100
ORDER BY 4 DESC;


# Analyze income patterns by location type and primary classification
SELECT `Type`, `Primary`, 
    ROUND(AVG(us.Mean), 2)   AS avg_mean_income,
    ROUND(AVG(us.Median), 2) AS avg_median_income
FROM us_house_project.us_household_income AS u
JOIN us_house_project.us_household_income_statistics AS us
ON u.id = us.id
WHERE Mean <> 0
GROUP BY `Type`, `Primary`
ORDER BY 3;


# Top 10 Cities with highest average income
SELECT u.State_Name, u.City,
    ROUND(AVG(us.Mean),1) AS avg_mean_income,
    ROUND(AVG(us.Median),1) AS avg_median_income
FROM us_house_project.us_household_income u
JOIN us_house_project.us_household_income_statistics us
ON u.id = us.id
WHERE us.Mean <> 0
GROUP BY u.State_Name, u.City
ORDER BY avg_mean_income DESC
LIMIT 10;


# Identify regions with high income inequality
SELECT u.State_Name,
       ROUND(AVG((us.Mean - us.Median) / NULLIF(us.Median,0)), 2) AS income_gap_ratio
FROM us_house_project.us_household_income u
JOIN us_house_project.us_household_income_statistics us
ON u.id = us.id
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY income_gap_ratio DESC;

# Rank cities by median income within each state
SELECT u.State_Name, u.City,
    ROUND(AVG(Median), 2) AS avg_median_income,
    DENSE_RANK() OVER (PARTITION BY u.State_Name ORDER BY AVG(us.Median) DESC) AS state_income_rank
FROM us_house_project.us_household_income u
JOIN us_house_project.us_household_income_statistics us
ON u.id = us.id
WHERE us.Median <> 0
GROUP BY State_Name, City;

# Identify high-income areas based on median income percentile
SELECT State_Name, City,avg_median_income
FROM ( SELECT u.State_Name, u.City,
        ROUND(AVG(us.Median),2) AS avg_median_income,
        NTILE(10) OVER (ORDER BY AVG(us.Median) DESC) AS income_bucket
    FROM us_house_project.us_household_income u
    JOIN us_house_project.us_household_income_statistics us
	ON u.id = us.id
    WHERE us.Median <> 0
    GROUP BY u.State_Name, u.City) ranked
WHERE income_bucket = 1;


# Income generated per unit of land area
SELECT u.State_Name,
       ROUND(AVG(us.Mean / NULLIF(u.ALand, 0)), 6) AS income_per_land_unit
FROM us_house_project.us_household_income u
JOIN us_house_project.us_household_income_statistics us
ON u.id = us.id
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY income_per_land_unit DESC;




