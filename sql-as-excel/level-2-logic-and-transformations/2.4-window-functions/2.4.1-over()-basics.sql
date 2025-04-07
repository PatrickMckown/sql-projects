/*2.4.1a OVER() Basics 
    
    In this case, we'll use OVER() to find the running total of a table using it in conjunction with SUM().  

    Let's imagine we have the following table in Excel.

            A           B           C         D         E
       +----------+-------------+----------+--------+------------+
    1  | SaleID   | Employee    | Region   | Amount | SaleDate   |
       +----------+-------------+----------+--------+------------+
    2  | 101      | Alice       | North    | 500    | 2025-01-01 |
    3  | 102      | Bob         | North    | 300    | 2025-01-01 |
    4  | 103      | Alice       | North    | 700    | 2025-01-02 |
    5  | 104      | Dana        | South    | 400    | 2025-01-02 |
    6  | 105      | Bob         | North    | 250    | 2025-01-03 |
    7  | 106      | Charlie     | South    | 600    | 2025-01-03 |
    8  | 107      | Alice       | North    | 300    | 2025-01-04 |
    9  | 108      | Dana        | South    | 350    | 2025-01-04 |
       +----------+-------------+----------+--------+------------+

    If we want to find the running total of "Amount" in column F, we might first make sure the "SaleDate" column is sorted ascending and insert a formula like this.

           A           B           C         D         E             F
       +----------+-------------+----------+--------+------------+-------------------------------+
    1  | SaleID   | Employee    | Region   | Amount | SaleDate   | RunningTotal                  |
       +----------+-------------+----------+--------+------------+-------------------------------+
    2  | 101      | Alice       | North    | 500    | 2025-01-01 | =SUM(INDIRECT("E2:E"&ROW(A2)))|
    3  | 102      | Bob         | North    | 300    | 2025-01-01 | =SUM(INDIRECT("E2:E"&ROW(A3)))|
    4  | 103      | Alice       | North    | 700    | 2025-01-02 | =SUM(INDIRECT("E2:E"&ROW(A4)))|
    5  | 104      | Dana        | South    | 400    | 2025-01-02 | =SUM(INDIRECT("E2:E"&ROW(A5)))|
    6  | 105      | Bob         | North    | 250    | 2025-01-03 | =SUM(INDIRECT("E2:E"&ROW(A6)))|
    7  | 106      | Charlie     | South    | 600    | 2025-01-03 | =SUM(INDIRECT("E2:E"&ROW(A7)))|
    8  | 107      | Alice       | North    | 300    | 2025-01-04 | =SUM(INDIRECT("E2:E"&ROW(A8)))|
    9  | 108      | Dana        | South    | 350    | 2025-01-04 | =SUM(INDIRECT("E2:E"&ROW(A9)))|
       +----------+-------------+----------+--------+------------+-------------------------------+

    That will return the following

            A           B           C         D         E             F
       +----------+-------------+----------+--------+------------+-------------+
    1  | SaleID   | Employee    | Region   | Amount | SaleDate   | RunningTotal|
       +----------+-------------+----------+--------+------------+-------------+
    2  | 101      | Alice       | North    | 500    | 2025-01-01 | 500         |
    3  | 102      | Bob         | North    | 300    | 2025-01-01 | 800         |
    4  | 103      | Alice       | North    | 700    | 2025-01-02 | 1500        |
    5  | 104      | Dana        | South    | 400    | 2025-01-02 | 1900        |
    6  | 105      | Bob         | North    | 250    | 2025-01-03 | 2150        |
    7  | 106      | Charlie     | South    | 600    | 2025-01-03 | 2750        |
    8  | 107      | Alice       | North    | 300    | 2025-01-04 | 3050        |
    9  | 108      | Dana        | South    | 350    | 2025-01-04 | 3400        |
       +----------+-------------+----------+--------+------------+-------------+

    This allows us to view the cummulative change over time starting from the earliest date.

    Well we can achieve a similar result in SQL using OVER().

    We can think of OVER() as a cousin to GROUP BY. It combines similar elements to create an aggregation.

    But in the case of OVER() we don't need to specify which columns to group by nor will we lose columns.

    Imagine we have the same table in SQL and want to add the same running total as a column to this table.

    TABLE: "Sales"
    +----------+-------------+----------+--------+------------+
    | SaleID   | Employee    | Region   | Amount | SaleDate   |
    +----------+-------------+----------+--------+------------+
    | 101      | Alice       | North    | 500    | 2025-01-01 |
    | 102      | Bob         | North    | 300    | 2025-01-01 |
    | 103      | Alice       | North    | 700    | 2025-01-02 |
    | 104      | Dana        | South    | 400    | 2025-01-02 |
    | 105      | Bob         | North    | 250    | 2025-01-03 |
    | 106      | Charlie     | South    | 600    | 2025-01-03 |
    | 107      | Alice       | North    | 300    | 2025-01-04 |
    | 108      | Dana        | South    | 350    | 2025-01-04 |
    +----------+-------------+----------+--------+------------+

    We can utilize OVER() in conjunction with SUM() to achieve this.

    The basic structure of OVER() with SUM() is below.

    SUM(<column>) OVER ([ORDER BY <column>])
    
    So if we want to sum up the Amount column and ensure the SaleDate is ordered earliest to latest, what can we do?

    CHALLENGE: Show a running total of sales broken from the earliest date to the latest. 

    RETURN: SaleID, Employee, Region, Amount, SaleDate, RunningTotal.
    */

/*Step One

    First part is selecting any columns that already exist in the table*/

        SELECT
            SaleID,
            Employee,
            Region,
            Amount,
            SaleDate
        FROM
            Sales

/*Step Two

    Next is to add the running total of sales and order the table ascending by SaleDate
    
    Recall that the structure of OVER() with SUM() is:

    SUM(<column>) OVER ([ORDER BY <column>])
    
    So let's pass in the column Amount in the SUM() function and the SaleDate in the OVER() function and ORDER BY ascending.
    */

    SELECT
        SaleID,
        Employee,
        Region,
        Amount,
        SaleDate,
        SUM(Amount) OVER(ORDER BY SaleDate ASC) AS "RunningTotal"
    FROM
        Sales

    /*That will return the following

   +----------+-------------+----------+--------+------------+-------------+
   | SaleID   | Employee    | Region   | Amount | SaleDate   | RunningTotal|
   +----------+-------------+----------+--------+------------+-------------+
   | 101      | Alice       | North    | 500    | 2025-01-01 | 500         |
   | 102      | Bob         | North    | 300    | 2025-01-01 | 800         |
   | 103      | Alice       | North    | 700    | 2025-01-02 | 1500        |
   | 104      | Dana        | South    | 400    | 2025-01-02 | 1900        |
   | 105      | Bob         | North    | 250    | 2025-01-03 | 2150        |
   | 106      | Charlie     | South    | 600    | 2025-01-03 | 2750        |
   | 107      | Alice       | North    | 300    | 2025-01-04 | 3050        |
   | 108      | Dana        | South    | 350    | 2025-01-04 | 3400        |
   +----------+-------------+----------+--------+------------+-------------+*/       

/*SOLUTION*/
    SELECT
        SaleID,
        Employee,
        Region,
        Amount,
        SaleDate,
        SUM(Amount) OVER(ORDER BY SaleDate ASC) AS "RunningTotal"
    FROM
        Sales
