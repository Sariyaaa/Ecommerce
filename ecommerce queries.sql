USE ecommerce;

-- Query 1: Sales by Category
SELECT category, SUM(sales) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Total_Sales DESC;

-- Query 2: Top 5 Customers
SELECT customer_name, SUM(sales) AS Total
FROM ecommerce_cleaned
GROUP BY customer_name
ORDER BY Total DESC
LIMIT 5;

-- Query 3: Region Performance
SELECT region, SUM(sales) AS Sales
FROM ecommerce_cleaned
GROUP BY region
ORDER BY Sales DESC;

-- Query 4: Profit by Category
SELECT category, SUM(profit) AS Total_Profit
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Total_Profit DESC;

-- Query 5: Profit Margin by Category
SELECT
    category,
    ROUND(SUM(sales), 2)  AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS Profit_Margin_Pct
FROM ecommerce_cleaned
GROUP BY category
ORDER BY Profit_Margin_Pct DESC;

-- Query 6: Categories Above 2 Million Sales (HAVING)
SELECT
    category,
    ROUND(SUM(sales), 2) AS Total_Sales
FROM ecommerce_cleaned
GROUP BY category
HAVING Total_Sales > 2000000
ORDER BY Total_Sales DESC;

-- Query 7: Discount Impact on Profit (CASE WHEN)
SELECT
    CASE
        WHEN discount = 0        THEN 'No Discount'
        WHEN discount <= 0.20    THEN 'Low Discount'
        ELSE                          'High Discount'
    END AS Discount_Label,
    COUNT(*)                     AS Total_Orders,
    ROUND(AVG(profit), 2)        AS Avg_Profit,
    SUM(CASE WHEN profit < 0
        THEN 1 ELSE 0 END)       AS Loss_Orders
FROM ecommerce_cleaned
GROUP BY Discount_Label
ORDER BY Avg_Profit DESC;