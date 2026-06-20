USE ecommerce;

-- Query 1: Total sales by category
SELECT category, ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Total_Sales DESC;

-- Query 2: Total profit by category
SELECT category, ROUND(SUM(profit), 2) AS Total_Profit
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Total_Profit DESC;

-- Query 3: Profit margin by category
SELECT
    category,
    ROUND(SUM(sales), 2)                     AS Total_Sales,
    ROUND(SUM(profit), 2)                    AS Total_Profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS Profit_Margin_Pct
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Profit_Margin_Pct DESC;

-- Query 4: Categories above $2M in sales (HAVING)
SELECT category, ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY category
HAVING Total_Sales > 2000000
ORDER BY Total_Sales DESC;

-- Query 5: Top 5 customers by total sales
SELECT customer_name, ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 5;

-- Query 6: Sales by region
SELECT region, ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY region
ORDER BY Total_Sales DESC;

-- Query 7: Discount impact on profit
SELECT
    CASE
        WHEN discount = 0     THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        ELSE                       'High Discount'
    END AS Discount_Label,
    COUNT(*)                                    AS Total_Orders,
    ROUND(AVG(profit), 2)                       AS Avg_Profit,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS Loss_Orders
FROM ecommerce_cleaned
GROUP BY Discount_Label
ORDER BY Avg_Profit DESC;

-- Query 8: Year range
SELECT MIN(year) AS Earliest_Year, MAX(year) AS Latest_Year, COUNT(DISTINCT year) AS Num_Years
FROM ecommerce_cleaned;

-- Query 9: Sales by year
SELECT year, COUNT(*) AS Order_Count, ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY year
ORDER BY year;
