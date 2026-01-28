 SELECT * FROM coffee_shop_sales; -- This to get all the data available from the coffee_shop_sales Table

   --To CONVERT(transaction_date)COLUMN TO PROPER DATE FORMAT
UPDATE coffee_shop_sales
SET transaction_date = str_to_date( transaction_date,'%d/%m/%Y');

 	--To ALTER(transaction_date)COLUMN TO DATE DATA TYPE
ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;

 	--To CONVERT(transaction_time)COLUMN TO PROPER TIME FORMAT
UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

 	--To ALTER(transaction_time)COLUMN TO DATE DATA TYPE
ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

 	--To Check DATA TYPES OF DIFFERENT COLUMNS
DESCRIBE coffee_shop_sales;

 	--To CHANGE COLUMN NAME `ï»¿transaction_id` to transaction_id
ALTER TABLE coffee_shop_sales
CHANGE COLUMN ï»¿transaction_id transaction_id INT;

    -- PROBLEM STATEMENT :- KPI'S REQUIREMENT

 	-- To Query TOTAL SALES
SELECT ROUND(SUM(unit_price*transaction_qty)) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 2  -- for month of feb ;

 	-- To Query TOTAL SALES KPI:-  M-O-M DIFFERENCE AND M-O-M GROWTH
SELECT
    MONTH(transaction_date) AS Month
    ,ROUND(SUM(unit_price*transaction_qty)) AS Total_sales
    ,(SUM(unit_price*transaction_qty)-LAG(SUM(unit_price*transaction_qty),1) 
    OVER(ORDER BY MONTH(transaction_date)))/ LAG(SUM(unit_price*transaction_qty),1) 
   OVER(ORDER BY MONTH(transaction_date)) *100 AS M_O_M_Increase_percent
FROM coffee_shop_sales
WHERE  MONTH(transaction_date) IN (3,4)   -- For Mnth of Mar & Apr
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

 	--To Query TOTAL ORDERS
SELECT COUNT(transaction_id) AS Total_orders
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6 -- for mnth of jun;

 	--To Query TOTAL ORDERS KPI – M_O_M DIFFERENCE AND M_O_M GROWTH
SELECT
    MONTH(transaction_date) AS Month
    ,ROUND(COUNT(transaction_id)) AS Total_orders
    ,(COUNT(transaction_id)-LAG(COUNT(transaction_id),1) 
    OVER (ORDER BY MONTH(transaction_date)))/LAG(COUNT(transaction_id),1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS M_O_M_Increase_Percent
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (5,6) -- Mnth of May & jun
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

 	--To Query TOTAL QUANTITY SOLD
SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 2 -- mnth of feb;

 	--To Query TOTAL QUANTITY SOLD KPI – M_O_M DIFFERENCE AND M_O_M GROWTH
SELECT 
	MONTH(transaction_date) AS Month
	,SUM(transaction_qty) AS Total_Quantity_Sold
	,(SUM(transaction_qty)-LAG(SUM(transaction_qty),1) 
	OVER(ORDER BY MONTH(transaction_date)))/ LAG(SUM(transaction_qty),1) 
	OVER(ORDER BY MONTH(transaction_date)) * 100 AS M_O_M_Percent_increase
FROM coffee_shop_sales
WHERE MONTH(transaction_date) IN (2,3) -- mnth of feb & Mar
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

 SELECT
	product_type
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY product_type 
ORDER BY SUM(unit_price*transaction_qty)
LIMIT 10 ;     -- This is a query to Get the Top 10 product in our database
      -- Query made Under the chart Requirement
