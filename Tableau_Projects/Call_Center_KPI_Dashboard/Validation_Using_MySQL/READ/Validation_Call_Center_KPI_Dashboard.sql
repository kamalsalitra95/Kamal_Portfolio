SELECT * FROM call_center_kpi_data.call_center_data;

SELECT DAYNAME(`Date`) AS day_name,
       COUNT(call_id) AS total_calls
FROM call_center_data
WHERE `Date` >= DATE_FORMAT((SELECT MAX(`Date`) FROM call_center_data), '%Y-%m-01')
    AND `Date` <= (SELECT MAX(`Date`) FROM call_center_data)
GROUP BY DAYNAME(`Date`), DAYOFWEEK(`Date`)
ORDER BY DAYOFWEEK(`Date`);

SELECT satisfaction_rating,
       COUNT(call_id) AS total_calls
FROM call_center_data
WHERE satisfaction_rating IS NOT NULL
  AND DATE_FORMAT(`Date`, '%Y-%m') = (
        SELECT DATE_FORMAT(MAX(`Date`), '%Y-%m') 
        FROM call_center_data
  )
GROUP BY satisfaction_rating
ORDER BY satisfaction_rating;

SELECT 
    COUNT(call_id) AS inbound_calls_today
FROM call_center_data
WHERE `Date` = (SELECT MAX(`Date`) FROM call_center_data);

SELECT ROUND(
	 SUM(CASE WHEN Resolved = 'Y' THEN 1 ELSE 0 END) * 100
     / COUNT(call_id), 2) AS resolution_rate_percentage
FROM call_center_data
WHERE DATE_FORMAT(`Date`, '%Y-%m') = (
        SELECT DATE_FORMAT(MAX(`Date`), '%Y-%m')
        FROM call_center_data);
	
SELECT Agent,
    ROUND(SUM(CASE WHEN Resolved = 'Y' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(call_id), 2) AS resolution_rate_percentage
FROM call_center_data
WHERE DATE_FORMAT(`Date`, '%Y-%m') = (
        SELECT DATE_FORMAT(MAX(`Date`), '%Y-%m')
        FROM call_center_data)
GROUP BY Agent
ORDER BY resolution_rate_percentage DESC;

SELECT Agent,
    COUNT(call_id) AS resolved_calls
FROM call_center_data
WHERE Resolved = 'Y'
AND DATE_FORMAT(`Date`, '%Y-%m') =
        (SELECT DATE_FORMAT(MAX(`Date`), '%Y-%m')
        FROM call_center_data)
GROUP BY Agent
ORDER BY resolved_calls DESC;

SELECT t.Agent, ROUND(AVG(t.speed_answer_sec), 2) AS median_speed_answer_sec
FROM (SELECT Agent, speed_answer_sec,
        ROW_NUMBER() OVER (PARTITION BY Agent ORDER BY speed_answer_sec) AS rn,
        COUNT(*) OVER (PARTITION BY Agent) AS cnt
    FROM call_center_data
    WHERE speed_answer_sec IS NOT NULL
      AND Resolved = 'Y'
      AND DATE_FORMAT(`Date`, '%Y-%m') = (
            SELECT DATE_FORMAT(MAX(`Date`), '%Y-%m')
            FROM call_center_data)) t
WHERE t.rn IN (FLOOR((t.cnt + 1)/2), FLOOR((t.cnt + 2)/2))
GROUP BY t.Agent
ORDER BY median_speed_answer_sec;










