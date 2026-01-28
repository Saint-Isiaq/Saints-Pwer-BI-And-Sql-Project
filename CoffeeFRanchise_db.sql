 SELECT * FROM coffee_shop_sales; -- This to get all the data available from the coffee_shop_sales Table

 /* --CHART REQUIREMENTS:CODE FOR VISUALIZATION INSIGHTS */

 	/* --CALENDAR TABLE–DAILY SALES,QUANTITY and TOTAL ORDERS */
SELECT 
     SUM(unit_price*transaction_qty) AS Total_sales
    ,SUM(transaction_qty) AS Total_quantity_sold
    ,COUNT(transaction_id) AS Total_order
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-15'  -- 4 15th of may mnth
