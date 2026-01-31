  SELECT * FROM coffee_shop_sales; -- This to get all the data available from the coffee_shop_sales Table

 /* --CHART REQUIREMENTS:QUERY CODE FOR VISUALIZATION INSIGHTS */

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

 	 /* -- To Query "SALES TREND ANALYSIS OVER A PERIOD" [A] */
SELECT  AVG(Total_sales) AS AVG_Sales
FROM(
SELECT 
     SUM(unit_price*transaction_qty) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY transaction_date
) AS T;

	/* --[B]DAILY SALES FOR MONTH SELECTED */
SELECT
	DAY(transaction_date) AS Daily
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date);

	/* -- [C] COMPARISON OF DAILY SALES WITH AVERAGE SALES – USING   “ABOVE AVERAGE” IF > and  IF < “BELOW AVERAGE” */

SELECT Daily
    ,Total_sales
    ,CASE 
          WHEN Total_sales > AVG_Sales THEN 'Above Average'
          WHEN Total_sales < AVG_Sales THEN 'Below Average'
     ELSE 'Average'
     END AS Status_of_sales

FROM(
SELECT
         DAY(transaction_date) AS Daily
         ,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
         ,AVG(SUM(unit_price*transaction_qty)) OVER() AS AVG_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date)
)Sales_data ;

    /* --To Query SALES BY PRODUCT CATEGORY */

SELECT
	product_category
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY product_category 
ORDER BY SUM(unit_price*transaction_qty) DESC;

 	/* --To Query SALES BY PRODUCTS ANALYSIS(TOP 10) */       
SELECT
	product_type
	,ROUND(SUM(unit_price*transaction_qty),1) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6   -- mnth O'June 
GROUP BY product_type 
ORDER BY SUM(unit_price*transaction_qty) DESC
LIMIT 10 ;

 	/* --To Query SALES BY DAY | HOUR [A] */

SELECT
	 SUM(transaction_qty) AS Total_quantity
	,ROUND(SUM(unit_price*transaction_qty)) AS Total_sales
    ,COUNT(*) AS Total_Orders
FROM coffee_shop_sales
WHERE 
 DAYOFWEEK(transaction_date) = 6 -- Fri (1 is sunday, 2 monday, 7 saturday etc.)
 AND HOUR(transaction_time) = 6 -- The hour at the time of the week 
 AND MONTH(transaction_date) = 6 -- mnth O'June   ;

       /* --[B] TO QUERY SALES FROM MONDAY TO SUNDAY FOR MONTH O’ JUNE */
SELECT
  CASE 
       WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
       WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
       WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
       WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
       WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
       WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
  ELSE 'Sunday'
  END AS Week_Days
	,ROUND(SUM(unit_price*transaction_qty)) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6 -- mnth O'June
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
  ELSE 'Sunday'
  END ;

     /* -- TO QUERY SALES FOR ALL HOURS FOR MONTH OF MAY */
SELECT
     CONCAT(HOUR(transaction_time),'th','  ','Hr') AS Hour_of_Week
	,ROUND(SUM(unit_price*transaction_qty)) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6 -- mnth O'June
GROUP BY CONCAT(HOUR(transaction_time),'th','  ','Hr')
ORDER BY CONCAT(HOUR(transaction_time),'th','  ','Hr')  

