/*3.2.1a Pivot Tables with CASE
    If you've worked with Excel for any period of time, you've probably used pivot tables. They're versatile and give an easy to digest summary.

    If we're working in Snowflake SQL, there are a couple of ways to produce pivot tables, a simple version of which we'll look at below. 

    We want a pivot table style report that shows a summary of total sales and regional sales. 

    TABLE NAME: "Sales"
    +--------+-------------+--------+--------+------------+
    | SaleID | Salesperson | Region | Amount | SaleDate   |
    +--------+-------------+--------+--------+------------+
    | 1      | Alice       | West   | 200    | 2025-01-01 |
    | 2      | Bob         | East   | 150    | 2025-01-01 |
    | 3      | Alice       | West   | 300    | 2025-01-02 |
    | 4      | Bob         | East   | 250    | 2025-01-02 |
    | 5      | Alice       | West   | 100    | 2025-01-03 |
    | 6      | Charlie     | West   | 400    | 2025-01-03 |
    | 7      | Bob         | East   | 200    | 2025-01-03 |
    +--------+-------------+--------+--------+------------+

    CHALLENGE: For each salesperson, show total sales broken down by region (East and West) in separate columns, along with their overall total sales. 

    RETURN: Salesperson, WestSales, EastSales, TotalSales.*/

/*Step One

    First part is selecting any columns that already exist in the table*/

        SELECT
            Salesperson
        FROM
            Sales

    /*That will return the following table
    
    +-------------+
    | Salesperson |
    +-------------+
    | Alice       |
    | Bob         |
    | Alice       |
    | Bob         |
    | Alice       |
    | Charlie     |
    | Bob         |
    +-------------+*/

/*Step Two

    Next is the aggregation of the total by salesperson, which we can get with SUM. And since it's by Salesperson, we will add GROUPBY*/

    SELECT
        Salesperson,
        SUM(Amount) AS "TotalSales"
    FROM
        Sales
    GROUP BY
        Salesperson

    /*That will return the following

    +-------------+-------------+
    | Salesperson | TotalAmount |
    +-------------+-------------+
    | Alice       | 600         |
    | Bob         | 600         |
    | Charlie     | 400         |
    +-------------+-------------+*/       

/*Step Three

    Next is adding a column for the total sales by west. 
    
    We can use CASE WHEN...END to get only the sales when the 'Region' field has the 'West' value, else we can return 0.
    
    We can then wrap it in SUM to create an aggregation
    */

    SELECT
        Salesperson,
        SUM(CASE WHEN Region = 'West' THEN Amount ELSE 0 END) "WestSales",
        SUM(Amount) AS "TotalSales"
    FROM
        Sales
    GROUP BY
        Salesperson

    /*Don't forget to alias the new column, remember double quotes for field names

    That will return the following

    +-------------+-----------+------------+
    | Salesperson | WestSales | TotalSales |
    +-------------+-----------+------------+
    | Alice       | 600       | 600        |
    | Bob         | 0         | 600        |
    | Charlie     | 400       | 400        |
    +-------------+-----------+------------+*/   

/*Step Four

    Last, repeat the logic but change the condition to equal 'East'*/

    SELECT
        Salesperson,
        SUM(CASE WHEN Region = 'West' THEN Amount ELSE 0 END) AS "WestSales", 
        SUM(CASE WHEN Region = 'East' THEN Amount ELSE 0 END) AS "EastSales", 
        SUM(Amount) AS "TotalSales"
    FROM
        Sales
    GROUP BY
        Salesperson

    /*That will return the following

    +-------------+-----------+-----------+------------+
    | Salesperson | WestSales | EastSales | TotalSales |
    +-------------+-----------+-----------+------------+
    | Alice       | 600       | 0         | 600        |
    | Bob         | 0         | 600       | 600        |
    | Charlie     | 400       | 0         | 400        |
    +-------------+-----------+-----------+------------+
    
    We have something that will look exactly like an Excel pivot table*/  

/*SOLUTION*/
    SELECT
        Salesperson,
        SUM(CASE WHEN Region = 'West' THEN Amount ELSE 0 END) AS "WestSales", 
        SUM(CASE WHEN Region = 'East' THEN Amount ELSE 0 END) AS "EastSales", 
        SUM(Amount) AS "TotalSales"
    FROM
        Sales
    GROUP BY
        Salesperson
