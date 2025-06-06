-- RETAIL SALES ANALYSIS USING SQL
-- CREATE DATABASE Retail_sales_analysis_sqlProject1
-- step1: data cleaning
DROP TABLE IF EXISTS Retail_sales;
CREATE TABLE Retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	VARCHAR(10),
				age	INT,
				category VARCHAR(20),
				quantiy	INT,
				price_per_unit	FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);

SELECT * FROM Retail_Sales
LIMIT 10

SELECT COUNT(*) FROM Retail_sales
--checking null values one by one 
SELECT * FROM Retail_Sales
WHERE transactions_id IS NULL

SELECT * FROM Retail_Sales
WHERE sale_date IS NULL	

-- we can check for all columns in single query 
SELECT * FROM Retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs is NULL
	OR
	total_sale IS NULL

-- delete the rows that contains nullvalues 
DELETE FROM Retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs is NULL
	OR
	total_sale IS NULL
	
-- step2: DATA EXPLORATION
-- how many customers we have ? ( use distict function)
SELECT COUNT(DISTINCT customer_id) FROM Retail_sales 

-- how many categories we have ?
SELECT COUNT(DISTINCT category) FROM Retail_sales 
SELECT DISTINCT category FROM Retail_sales -- gives the name of categories

-- DATA ANALYSIS ( BUSINESS PROBLEMS )
-- q1. write a sql query to retrieve all coulmns for sales made on "2022-11-05"?
SELECT * 
FROM retail_sales
WHERE sale_date ='2022-11-05'

-- q2. write sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of nov-2022?
SELECT * 
FROM Retail_sales
WHERE category='Clothing'
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy>=3

-- q3. write sql query to calculate the total sales for each category

SELECT category,SUM(total_sale) as net_sale,COUNT(*) as no_of_orders
FROM Retail_sales
GROUP BY category
	
-- q4. write sql query to find the average age of customers who purchased items from the 'Beauty' category?
SELECT  
	ROUND(AVG(age),2)
FROM Retail_sales	
WHERE category='Beauty'

-- q5.write sql query to find all transactions where total_sale is greater than 1000
SELECT * 
FROM Retail_sales
WHERE total_sale>1000

-- q6.write sql query to find total number of transactions (transaction_id) made by each gender in each category?
SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM Retail_sales
GROUP BY category,gender
ORDER BY category,gender 

-- q7. write sql query to find the top 5 customers based on highest total sales

SELECT 
	customer_id,
	SUM(total_sale)
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
-- q8.write sql query to find number of unique customers who purchased items from each category?
SELECT 
	category,
	COUNT(DISTINCT customer_id)as UNI_cust
FROM Retail_sales
GROUP BY category

-- q9. write a sql query to create each shift and number of orders(eg.morning<=12,Afternoon btw 12&17,Eveing >17)
WITH hourly_sales
AS
(
	SELECT 
		*,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM Retail_sales
)
SELECT 
	shift,
	COUNT(*)as total_orders
FROM hourly_sales
GROUP By 1
