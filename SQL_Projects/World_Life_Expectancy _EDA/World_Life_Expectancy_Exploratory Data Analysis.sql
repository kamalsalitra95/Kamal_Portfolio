# World Life Expectancy Project (Exploratory Data Analysis)

# Review dataset structure
SELECT * 
FROM world_life_expectancy;

# Measure change in life expectancy over time by country
SELECT Country,
    MIN(`Life expectancy`) AS min_life_expectancy,
    MAX(`Life expectancy`) AS max_life_expectancy,
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS life_expectancy_increase
FROM world_life_expectancy
WHERE `Life expectancy` > 0
GROUP BY Country
ORDER BY life_expectancy_increase DESC;

# Global average life expectancy trend
SELECT Year,
    ROUND(AVG(`Life expectancy`), 2) AS avg_life_expectancy
FROM world_life_expectancy
WHERE `Life expectancy` > 0
GROUP BY Year
ORDER BY Year;

SELECT * 
FROM world_life_expectancy;

# Relationship between GDP and life expectancy
SELECT Country,
       ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy,
       ROUND(AVG(GDP), 1) AS avg_gdp
FROM world_life_expectancy
WHERE GDP > 0
GROUP BY Country
HAVING avg_life_expectancy > 0
ORDER BY avg_gdp DESC;

# Compare life expectancy between high and low GDP groups
SELECT SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS high_gdp_count,
       ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` END),2) AS high_gdp_life_expectancy,
       SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) AS low_gdp_count,
       ROUND(AVG(CASE WHEN GDP < 1500 THEN `Life expectancy` END),2) AS low_gdp_life_expectancy
FROM world_life_expectancy
WHERE `Life expectancy` > 0;

# Average life expectancy by development status
SELECT Status,
       COUNT(DISTINCT Country) AS country_count,
       ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy
FROM world_life_expectancy
WHERE `Life expectancy` > 0
GROUP BY Status;

# Relationship between BMI and life expectancy
SELECT Country,
       ROUND(AVG(`Life expectancy`), 2) AS avg_life_expectancy,
	   ROUND(AVG(BMI), 2) AS avg_bmi
FROM world_life_expectancy
WHERE BMI > 0
GROUP BY Country
HAVING avg_life_expectancy > 0
ORDER BY avg_bmi;


# Rolling adult mortality trend for selected countries
SELECT Country, Year, `Adult Mortality`,
	SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS cumulative_adult_mortality
FROM world_life_expectancy
WHERE Country LIKE '%United%';

#Impact of schooling on life expectancy
SELECT Country,
       ROUND(AVG(Schooling), 2) AS avg_schooling,
       ROUND(AVG(`Life expectancy`), 2) AS avg_life_expectancy
FROM world_life_expectancy
WHERE Schooling > 0
GROUP BY Country
HAVING avg_life_expectancy > 0
ORDER BY avg_schooling DESC;

#Impact of HIV/AIDS on life expectancy
SELECT Country,
       ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy,
       ROUND(AVG(`HIV/AIDS`), 2) AS avg_hiv_rate
FROM world_life_expectancy
GROUP BY Country
HAVING avg_hiv_rate > 0
ORDER BY avg_hiv_rate DESC;

# Segment countries by life expectancy percentile
SELECT Country, avg_life_expectancy
FROM (SELECT Country,
        ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy,
        NTILE(4) OVER (ORDER BY AVG(`Life expectancy`) DESC) AS life_expectancy_quartile
    FROM world_life_expectancy
    WHERE `Life expectancy` > 0
    GROUP BY Country) ranked
WHERE life_expectancy_quartile = 1;

#Impact of vaccination coverage on life expectancy
SELECT Country,
    ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy,
    ROUND(AVG(Polio), 1) AS avg_polio_coverage,
    ROUND(AVG(Diphtheria), 1) AS avg_diphtheria_coverage
FROM world_life_expectancy
GROUP BY Country
HAVING avg_life_expectancy > 0
ORDER BY avg_polio_coverage DESC;




























































































