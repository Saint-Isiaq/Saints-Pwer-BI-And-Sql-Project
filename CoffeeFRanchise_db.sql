 SELECT * FROM coffee_shop_sales; -- This to get all the data available from the coffee_shop_sales Table

 /* --CHART REQUIREMENTS:CODE FOR VISUALIZATION INSIGHTS */

 	/* --CALENDAR TABLE–DAILY SALES,QUANTITY and TOTAL ORDERS */
SELECT 
     SUM(unit_price*transaction_qty) AS Total_sales
    ,SUM(transaction_qty) AS Total_quantity_sold
    ,COUNT(transaction_id) AS Total_order
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-15'  -- For 15th of may mnth 

   /* FOR MORE ROUNDED VALUES OF THE CODE ABOVE: USE CODE BELOW */

SELECT 
    CONCAT(ROUND(SUM(unit_price*transaction_qty)/1000,1),'K') AS Total_sales
    ,CONCAT(ROUND(SUM(transaction_qty)/1000,1),'K') AS Total_quantity_sold
    ,CONCAT(ROUND(COUNT(transaction_id)/1000,1),'K') AS Total_order
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-15'  -- For 15th of may mnth

 	/* --To Query ANALYSIS OF SALES BY WEEKDAY / WEEKEND */
SELECT 
      CASE 
         WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'WEEKENDS'
         ELSE 'WEEKDAYS'
         END AS Days_type
     ,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June  
GROUP BY 
	 CASE 
         WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'WEEKENDS'
         ELSE 'WEEKDAYS'
         END 
;
 	
	/* To Query SALES BY STORE LOCATION */
SELECT 
      store_location
     ,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY  store_location
ORDER BY SUM(unit_price*transaction_qty) DESC ;

