-- 1. Monthly Sales Trend
SELECT year_month, SUM(sales) as total_sales, SUM(profit) as total_profit
FROM fact_sales
GROUP BY year_month
ORDER BY year_month;

-- 2. Top 10 Customers by Profit
SELECT c.customer_name, SUM(f.profit) as total_profit
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- 3. Category-wise Profitability
SELECT p.category, p.sub_category,
       SUM(f.sales) as sales,
       SUM(f.profit) as profit,
       ROUND(AVG(f.profit_margin_percent),2) as avg_profit_margin
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category, p.sub_category
ORDER BY profit DESC;

-- 4. Worst Performing Products (Negative Profit)
SELECT p.product_name, SUM(f.profit) as total_profit
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(f.profit) < 0
ORDER BY total_profit ASC
LIMIT 15;
