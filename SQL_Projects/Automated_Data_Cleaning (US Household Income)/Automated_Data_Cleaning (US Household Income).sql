# Project: Automated Data Cleaning (US Household Income)

# View raw data
SELECT *
FROM us_household_income;

# Create Stored Procedure
DELIMITER $$
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data;
CREATE PROCEDURE Copy_and_Clean_Data()
BEGIN

-- CREATING OUR TABLE
	CREATE TABLE IF NOT EXISTS `us_household_income_Cleaned` (
	  `row_id` int DEFAULT NULL,
	  `id` int DEFAULT NULL,
	  `State_Code` int DEFAULT NULL,
	  `State_Name` text,
	  `State_ab` text,
	  `County` text,
	  `City` text,
	  `Place` text,
	  `Type` text,
	  `Primary` text,
	  `Zip_Code` int DEFAULT NULL,
	  `Area_Code` int DEFAULT NULL,
	  `ALand` int DEFAULT NULL,
	  `AWater` int DEFAULT NULL,
	  `Lat` double DEFAULT NULL,
	  `Lon` double DEFAULT NULL,
	  `TimeStamp` TIMESTAMP DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
-- Insert only new records (prevents duplicate loads)
INSERT INTO us_household_income_cleaned
SELECT r.*, CURRENT_TIMESTAMP
FROM us_household_income AS r
LEFT JOIN us_household_income_cleaned  AS c
ON r.id = c.id
WHERE c.id IS NULL;

-- Data Cleaning Steps
	-- 1. Remove Duplicates
 DELETE FROM us_household_income_cleaned
    WHERE row_id IN (
        SELECT row_id
        FROM (SELECT row_id,ROW_NUMBER() OVER (PARTITION BY id
                       ORDER BY TimeStamp) AS rn
            FROM us_household_income_cleaned) t
        WHERE rn > 1);

	-- 2. Standardization
	UPDATE us_household_income_Cleaned
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE us_household_income_Cleaned
	SET County = UPPER(County);

	UPDATE us_household_income_Cleaned
	SET City = UPPER(City);

	UPDATE us_household_income_Cleaned
	SET Place = UPPER(Place);

	UPDATE us_household_income_Cleaned
	SET State_Name = UPPER(State_Name);

	UPDATE us_household_income_Cleaned
	SET `Type` = 'CDP'
	WHERE `Type` = 'CPD';

	UPDATE us_household_income_Cleaned
	SET `Type` = 'Borough'
	WHERE `Type` = 'Boroughs';

END $$
DELIMITER ;

CALL Copy_and_Clean_Data();

-- CREATE TRIGGER
DELIMITER $$
DROP TRIGGER IF EXISTS Transfer_clean_data;
CREATE TRIGGER Transfer_clean_data
AFTER INSERT ON us_household_income
FOR EACH ROW
BEGIN
    CALL Copy_and_Clean_Data();
END$$
DELIMITER ;

INSERT INTO us_household_income
(`row_id`,`id`,`State_Code`,`State_Name`,`State_ab`,`County`,`City`,`Place`,`Type`,`Primary`,`Zip_Code`,`Area_Code`,`ALand`,`AWater`,`Lat`,`Lon`)
VALUES
(121671,37025904,37,'North Carolina','NC','Alamance County','Charlotte','Alamance','Track','Track',28215,980,24011255,98062070,35.2661197,-80.6865346);






-- Validate that no duplicate records exist after cleaning
SELECT
    id,
    COUNT(*) AS record_count
FROM us_household_income_cleaned
GROUP BY id
HAVING COUNT(*) > 1;


-- Check total number of records in cleaned table
SELECT COUNT(*)
FROM us_household_income_Cleaned;

-- Validate state-level distribution after standardization
SELECT State_Name, COUNT(*)
FROM us_household_income_Cleaned
GROUP BY State_Name;