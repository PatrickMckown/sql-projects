/*3.2.1b Pivot Tables with CASE
    So we've covered making a pivot table with CASE, but what if we have a table with somewhat more complicated logic.

    Consider the table below, and imagine the sales in the 'South' region are few in number. 

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
    | 8      | Dana        | South  | 180    | 2025-01-02 |
    +--------+-------------+--------+--------+------------+

    These sales aren't monetarily significant, but they mess up the logic of our previous query (see 3.2.1a if confused).

    CHALLENGE: For each salesperson, show total sales broken down by region (East and West) in separate columns, along with their overall total sales. Add a separate column to aggregate all other regions. 

    RETURN: Salesperson, WestSales, EastSales, OtherSales, TotalSales.*/

/*Step One

    First let's recall the previous lesson and the query that generated the result.*/

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
    +-------------+-----------+-----------+------------+*/

/*Step Two

    Next let's account for all other sales that don't fall into the West or East category
    
    In this case, we'll group all the non-West and non-East sales into a column we'll call "OtherSales", we can accomplish this with NOT IN*/
    
    SELECT
        Salesperson,
        SUM(CASE WHEN Region = 'West' THEN Amount ELSE 0 END) AS "WestSales", 
        SUM(CASE WHEN Region = 'East' THEN Amount ELSE 0 END) AS "EastSales",
        SUM(CASE WHEN REGION NOT IN ('West', 'East') THEN Amount ELSE 0 END) AS "OtherSales", 
        SUM(Amount) AS "TotalSales"
    FROM
        Sales
    GROUP BY
        Salesperson

    /*That exclude everything that is not part of East or West sales.
    
    A note that it's best practice to use such a method when the Other category won't have a significant impact on the total*/

    /*This will return the following table

    +-------------+-----------+-----------+------------+------------+
    | Salesperson | WestSales | EastSales | OtherSales | TotalSales |
    +-------------+-----------+-----------+------------+------------+
    | Alice       | 600       | 0         | 0          | 600        |
    | Bob         | 0         | 600       | 0          | 600        |
    | Charlie     | 400       | 0         | 0          | 400        |
    | Dana        | 0         | 0         | 180        | 180        |
    +-------------+-----------+-----------+------------+------------+*/       
