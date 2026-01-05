#Project: Business Sales Analysis

-- Overall business performance metrics
SELECT 'Total Sales' AS metric, SUM(sales_amount) AS value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', ROUND(AVG(price),2) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_key) FROM gold.fact_sales;

-- Identify top 5 performing products by revenue
SELECT *
FROM (SELECT p.product_name, SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS product_rank
    FROM gold.fact_sales f
    JOIN gold.dim_products p
	ON f.product_key = p.product_key
    GROUP BY p.product_name) ranked_products
WHERE product_rank <= 5;

-- Track sales performance over time
SELECT
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY order_month
ORDER BY order_month;

-- Running total and moving average of sales
SELECT
    order_month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_month) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (ORDER BY order_month),2) AS moving_avg_price
FROM (SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    GROUP BY order_month) t;

-- Contribution of each product category to total sales
WITH category_sales AS (SELECT p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    JOIN gold.dim_products p
	ON f.product_key = p.product_key
    GROUP BY p.category)
SELECT category, total_sales,
    ROUND(total_sales / SUM(total_sales) OVER () * 100, 2) AS contribution_pct
FROM category_sales
ORDER BY contribution_pct DESC;

-- Segment products based on cost range
SELECT CASE
        WHEN cost < 100 THEN 'Below 100'
        WHEN cost BETWEEN 100 AND 500 THEN '100-500'
        WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
        ELSE 'Above 1000'
    END AS cost_range,
    COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY cost_range
ORDER BY total_products DESC;

-- Segment customers based on spending and activity
WITH customer_spending AS 
	(SELECT customer_key,
        SUM(sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales
    GROUP BY customer_key)
SELECT customer_segment,
    COUNT(*) AS total_customers
FROM (SELECT customer_key,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending) t
GROUP BY customer_segment;

-- Identify customers generating the highest revenue
SELECT c.customer_key,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key, customer_name
ORDER BY total_revenue DESC
LIMIT 10



/* ------------------------SUMMARY--------------------------------------
   Summary
   - Analyzed business performance using transactional sales data
   - Identified top products, customers, and revenue drivers
   - Applied window functions, CTEs, and ranking logic
   - Performed trend, cumulative, segmentation, and contribution analysis
   - Demonstrated real-world SQL analytics skills used in business reporting
-----------------------------------------------------------------------------*/












