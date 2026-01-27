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

 SELECT
	product_type
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY product_type 
ORDER BY SUM(unit_price*transaction_qty)
LIMIT 10 ;     -- This is a query to Get the Top 10 product in our database
      -- Query made Under the chart Requirement
