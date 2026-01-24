-- basic table size check
SELECT COUNT(*) AS total_events FROM ad_events;
SELECT COUNT(*) AS total_ads FROM ads;
SELECT COUNT(*) AS total_campaigns FROM campaigns;
SELECT COUNT(*) AS total_users FROM users;


-- checking total engagement events
SELECT COUNT(*) AS engagements
FROM ad_events
WHERE event_type IN ('click','comment','share');


-- checking distribution of all event types
SELECT 
    event_type,
    COUNT(*) AS total_events
FROM ad_events
GROUP BY event_type
ORDER BY total_events DESC;


--  Facebook top KPI cards
SELECT
    ROUND(COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) / 1000.0, 1) AS impressions_K,
    ROUND(COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) / 1000.0, 1) AS clicks_K,
    ROUND(COUNT(CASE WHEN e.event_type = 'Share' THEN 1 END) / 1000.0, 1) AS shares_K,
    ROUND(COUNT(CASE WHEN e.event_type = 'Comment' THEN 1 END) / 1000.0, 1) AS comments_K,
    ROUND(COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) / 1000.0, 1) AS purchases_K,
    ROUND(COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) / 1000.0, 1) AS engagements_K,

    ROUND(100.0 * COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) /
          NULLIF(COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END),0), 2) AS ctr_pct,

    ROUND(100.0 * COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) /
          NULLIF(COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END),0), 2) AS engagement_rate_pct,

    ROUND(100.0 * COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) /
          NULLIF(COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END),0), 2) AS conversion_rate_pct,

    ROUND(100.0 * COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) /
          NULLIF(COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END),0), 2) AS purchase_rate_pct,

    (SELECT ROUND(SUM(total_budget),2) FROM campaigns) AS total_budget,
    (SELECT ROUND(SUM(total_budget)/COUNT(*),2) FROM campaigns) AS avg_budget_per_campaign

FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook';


-- validating donut chart (impressions by target gender)
SELECT
    a.target_gender,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN e.event_type = 'Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN e.event_type = 'Comment' THEN 1 END) AS comments,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook'
GROUP BY a.target_gender
ORDER BY impressions DESC;


-- validating age group analysis
SELECT
    u.age_group,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN e.event_type = 'Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN e.event_type = 'Comment' THEN 1 END) AS comments,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
JOIN users u ON e.user_id = u.user_id
WHERE a.ad_platform = 'Facebook'
GROUP BY u.age_group
ORDER BY impressions DESC;


-- validating country level distribution
SELECT
    u.country,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN e.event_type = 'Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN e.event_type = 'Comment' THEN 1 END) AS comments,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
JOIN users u ON e.user_id = u.user_id
WHERE a.ad_platform = 'Facebook'
  AND u.country IS NOT NULL
GROUP BY u.country
ORDER BY impressions DESC;


-- validating hourly impressions trend
SELECT
    DATEPART(HOUR, e.[timestamp]) AS hour_of_day,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook'
GROUP BY DATEPART(HOUR, e.[timestamp])
ORDER BY hour_of_day;


-- validating weekly activity pattern
SELECT
    e.day_of_week,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook'
GROUP BY e.day_of_week
ORDER BY impressions DESC;


-- validating calendar heatmap data
SELECT
    CAST(e.[timestamp] AS DATE) AS event_date,
    COUNT(*) AS total_events,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook'
GROUP BY CAST(e.[timestamp] AS DATE)
ORDER BY event_date;


-- validating ad format performance table
SELECT
    a.ad_type,
    COUNT(CASE WHEN e.event_type = 'Impression' THEN 1 END) AS impressions,
    COUNT(CASE WHEN e.event_type = 'Click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN e.event_type = 'Share' THEN 1 END) AS shares,
    COUNT(CASE WHEN e.event_type = 'Comment' THEN 1 END) AS comments,
    COUNT(CASE WHEN e.event_type = 'Purchase' THEN 1 END) AS purchases,
    COUNT(CASE WHEN e.event_type IN ('Click','Share','Comment') THEN 1 END) AS engagements
FROM ad_events e
JOIN ads a ON e.ad_id = a.ad_id
WHERE a.ad_platform = 'Facebook'
GROUP BY a.ad_type
ORDER BY impressions DESC;
