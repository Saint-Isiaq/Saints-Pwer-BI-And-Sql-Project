 SELECT * FROM coffee_shop_sales; -- This to get all the data available from the coffee_shop_sales Table

 SELECT
	product_type
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY product_type 
ORDER BY SUM(unit_price*transaction_qty) DESC
LIMIT 10 ;     -- This is a query to Get the Bottom 10 product in our database
      -- Query made Under the chart Requirement
