  # Project: World Life Expectancy – Data Cleaning

# view raw dataset
SELECT * 
FROM world_life_expectancy;

# Check for duplicate records using Country + Year as composite key
SELECT Country, Year,
    COUNT(*) AS record_count
FROM world_life_expectancy
GROUP BY Country, Year
HAVING COUNT(*) > 1;

# Identify duplicate rows using window function
SELECT *
FROM (SELECT Row_ID, Country, Year,
          ROW_NUMBER() OVER (PARTITION BY Country, Year ORDER BY Row_ID) AS row_num
       FROM world_life_expectancy) duplicates
WHERE row_num > 1;

# Delete duplicate rows while keeping one record per country-year
DELETE FROM world_life_expectancy
WHERE Row_ID IN (SELECT Row_ID
				 FROM (SELECT Row_ID, ROW_NUMBER() OVER (PARTITION BY Country, Year ORDER BY Row_ID) AS row_num
					   FROM world_life_expectancy) temp
				 WHERE row_num > 1);

# Identify records with missing or empty status
SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
OR Status = '';

# Review existing valid status values
SELECT DISTINCT Status
FROM world_life_expectancy
WHERE Status <> '';

# Populate missing status using existing country records (Developing)
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE (t1.Status IS NULL OR t1.Status = '')
AND t2.Status = 'Developing';

# Populate missing status using existing country records (Developed)
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE (t1.Status IS NULL OR t1.Status = '')
AND t2.Status = 'Developed';

SELECT * 
FROM world_life_expectancy;

# Check records with missing life expectancy
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = '';

# Calculate estimated life expectancy using previous and next year values
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1) AS estimated_life_expectancy
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country = t2.Country
   AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country
   AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = '';

# Update missing life expectancy values
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.Country = t2.Country
   AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
ON t1.Country = t3.Country
   AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)
WHERE t1.`Life expectancy` = '';

# review of cleaned dataset
SELECT *
FROM world_life_expectancy;



/* ------------------Summary--------------------------------
   - Removed duplicate country-year records
   - Standardized missing status values
   - Imputed missing life expectancy using neighboring years
   - Prepared clean, analysis-ready dataset
  ------------------------------------------------------------ */

















