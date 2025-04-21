/*1.5.2 GROUP BY and HAVING

    In this lesson we're going to cover HAVING.

    People like to complicate HAVING, but it's deceptively simple: HAVING does the same thing as WHERE, it filters a table by certain values.

    So why have two functions that do the same thing? Seems a bit redundant, right?

    You might have noticed one shortcoming with WHERE: it doesn't accept any aggregations. If you ever use SUM() in the table then you can't filter the table by the result of the sum, even if you alias the field.

    Consider the below table.

    TABLE: "DepartmentSales"
        +-------------+----------+--------+
        |  Department | Employee | Sales  |
        +-------------+----------+--------+
        | Electronics | Alice    | 1200   |
        | Clothing    | Bob      | 800    |
        | Electronics | Charlie  | 1500   |
        | Clothing    | Dana     | 700    |
        | Furniture   | Emma     | 600    |
        | Furniture   | Frank    | 400    |
        | Electronics | Grace    | 1000   |
        +-------------+----------+--------+

    Think back to the previous lesson about aggregating by a certain value and using SUM(), if you wanted to do that, it would look something like the below.

    SELECT
        Department,
        SUM(Sales) AS TotalSales
    FROM
        DepartmentSales
    GROUP BY
        Department

    But what if I only want to see the SUM(Sales) where the value is greater than a certain value? We can't use WHERE but we can definitely use HAVING.

    CHALLENGE: Group the table by Department, sum up the total sales, and use HAVING to filter where the total sales is greater than 2000. 

    RETURN: Department, TotalSales
*/

/*Step One

    First, let's get fields mentioned in the challenge above. This will return the Department and TotalSales, which is an aggregation*/

    SELECT
        Department,
        SUM(Sales) AS "TotalSales"
    FROM
        DepartmentSales
    GROUP BY
        Department

    /*That will return the following

    +-------------+------------+
    | Department  | TotalSales |
    +-------------+------------+
    | Electronics | 3700       |
    | Clothing    | 1500       |
    | Furniture   | 1000       |
    +-------------+------------+*/  

/*Step Two

    Next we need to actually filter the table where the TotalSales is greater than 2000.
    
    The structure of HAVING:
    HAVING [aggregate_function](<column>) [operator] [value]  
    
    Consider if we wanted to find where the SUM() of the field Taxes is less than 100. It would be written like this:

    HAVING SUM(Taxes) < 100

    HAVING is written after the GROUP BY clause and also after the WHERE clause if one exists in your query. Refer to the correct order of SQL clauses.

    +------------+------------------------------------------------------+
    | Clause     | Purpose                                              |
    +------------+------------------------------------------------------+
    | SELECT     | Choose columns to return                             |
    | FROM       | Specify the source table(s)                          |
    | JOIN       | Combine rows from multiple tables                    |
    | WHERE      | Filter rows before grouping                          |
    | GROUP BY   | Group rows for aggregation                           |
    | HAVING     | Filter aggregated/grouped results                    |
    | ORDER BY   | Sort the final result set                            |
    | LIMIT      | Restrict the number of rows returned                 |
    +------------+------------------------------------------------------+

    So let's follow the structure of HAVING and filter where the SUM(Sales) is greater than 2000
    */

    SELECT
    Department,
    SUM(Sales) AS "TotalSales"
    FROM
    DepartmentSales
    GROUP BY
    Department
    HAVING
    SUM(Sales) > 2000

    /*That will return the following

    +-------------+------------+
    | Department  | TotalSales |
    +-------------+------------+
    | Electronics | 3700       |
    +-------------+------------+*/    

/*SOLUTION*/
    SELECT
        Department,
        SUM(Sales) AS "TotalSales"
    FROM
        DepartmentSales
    GROUP BY
        Department
    HAVING
        SUM(Sales) > 2000


