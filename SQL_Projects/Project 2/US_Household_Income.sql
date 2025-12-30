# US Household Income Data Cleaning 

# view location-level household income data
SELECT * 
FROM us_house_project.us_household_income;

# view income statistics data
SELECT * 
FROM us_house_project.us_household_income_statistics;

# Rename incorrectly encoded column name
ALTER TABLE us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`;

# Count records in both tables
SELECT COUNT(id)
FROM us_house_project.us_household_income;

SELECT COUNT(id)
FROM us_house_project.us_household_income_statistics;

# Find duplicate IDs in household income table
SELECT id, COUNT(id)
FROM us_house_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

# Remove duplicate records while keeping one row per ID
DELETE FROM us_house_project.us_household_income
WHERE row_id IN (
   SELECT row_id
   FROM (SELECT row_id, id,
		     ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) row_num
		 FROM us_house_project.us_household_income) AS duplicates
    WHERE row_num > 1);

# Check uniqueness of IDs in income statistics table
SELECT id, COUNT(id)
FROM us_house_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;

# Review distinct state names for inconsistencies
SELECT DISTINCT state_name
FROM us_house_project.us_household_income
ORDER BY 1;

# Correct state name
UPDATE us_house_project.us_household_income
SET state_name = 'Georgia'
WHERE state_name = 'georia';

# Standardize casing
UPDATE us_house_project.us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama';

# Identify records with missing place names
SELECT *
FROM us_house_project.us_household_income
WHERE Place = ''
ORDER BY 1;

# Fill missing place using county and city information
UPDATE us_house_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

# Review category distribution
SELECT Type, COUNT(Type)
FROM us_house_project.us_household_income
GROUP BY Type;

# Standardize inconsistent category names
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

# Identify invalid water area values
SELECT DISTINCT AWater
FROM us_house_project.us_household_income
WHERE AWater = 0
  OR AWater = ''
  OR AWater IS NULL;

# Identify records with both land and water area missing or zero
SELECT ALand, AWater
FROM us_house_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
  AND (ALand = 0 OR ALand = '' OR ALand IS NULL);



/* ------------SUMMARY ---------------------------------------

   - Cleaned and standardized US household income data using SQL
   - Removed duplicate records using window functions
   - Fixed spelling, casing, and category inconsistencies
   - Handled NULL, empty, and invalid values in key columns
   - Prepared clean, analysis-ready tables for further use
   ---------------------------------------------------------------*/
















