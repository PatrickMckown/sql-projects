/*1.3.1 ORDER BY Basics
    
    In this case, we'll cover the basics of how to user ORDER BY.  

    The ORDER BY clause is used to sort the result set of a SQL query by one or more columns. It appears at the end of the SELECT statement.

    Imagine we have the table below in Excel.

    +--------+-------------+--------+--------+-------------+
    | ItemID | ItemName    | Brand  | Price  | StockDate   |
    +--------+-------------+--------+--------+-------------+
    | 105    | Monitor     | LG     | 210.00 | 2025-03-12  |
    | 102    | Keyboard    | Dell   | 45.00  | 2025-02-18  |
    | 108    | Laptop      | HP     | 950.00 | 2025-03-08  |
    | 101    | Mouse       | RW     | 25.00  | 2025-01-15  |
    | 107    | Webcam      | Razer  | 130.00 | 2025-03-01  |
    | 103    | Headphones  | Sony   | 75.00  | 2025-02-20  |
    +--------+-------------+--------+--------+-------------+

    The data is completely random, there's no logic to which item is shown at the beginning or the end of the table. 

    So, what if we want it a little more orderly? Well, we can click on the filter and sort it by, for example, Price from smallest to largest (ascending).

    TABLE: "ItemSales"
    +--------+-------------+--------+--------+------------+
    | ItemID | ItemName    | Brand  | Price  | StockDate  |
    +--------+-------------+--------+--------+------------+
    | 101    | Mouse       | RW     | 25.00  | 2025-01-15 |
    | 102    | Keyboard    | Dell   | 45.00  | 2025-02-18 |
    | 103    | Headphones  | Sony   | 75.00  | 2025-02-20 |
    | 107    | Webcam      | Razer  | 130.00 | 2025-03-01 |
    | 105    | Monitor     | LG     | 210.00 | 2025-03-12 |
    | 108    | Laptop      | HP     | 950.00 | 2025-03-08 |
    +--------+-------------+--------+--------+------------+

    Looks pretty good, how do we get the same result in SQL?

    The basic syntax for ordering a table is below.

    SELECT column1, column2
    FROM table_name
    ORDER BY column1 [ASC|DESC];

    In this example, ASC means from smallest to largest, DESC means from largest to smallest. 

    CHALLENGE: Order the above table by the ItemID column ascending.  

    RETURN: ItemID (ascending), ItemName, Brand, Price, StockDate
    */

/*Step One

    First part is selecting any columns that already exist in the table*/

        SELECT
            ItemID,
            ItemName,
            Brand,
            Price,
            StockDate
        FROM
            ItemSales;

/*Step Two

    Next is to order the table by one of the columns.

    In the case of this exercise, let's order "ItemID" ascending (from small to largest)
    
    Recall that the structure of ORDER BY:

    SELECT column1, column2
    FROM table_name
    ORDER BY column1 [ASC|DESC];
    
    So we only need to add the ORDER BY statement below the FROM statement
    */

    SELECT
        ItemID,
        ItemName,
        Brand,
        Price,
        StockDate
    FROM
        ItemSales
    ORDER BY
        ItemID ASC;

    /*That will return the following

    +--------+-------------+----------+--------+------------+
    | ItemID | ItemName    | Brand    | Price  | StockDate  |
    +--------+-------------+----------+--------+------------+
    | 101    | Mouse       | RW       | 25.00  | 2025-01-15 |
    | 102    | Keyboard    | Dell     | 45.00  | 2025-02-18 |
    | 103    | Headphones  | Sony     | 75.00  | 2025-02-20 |
    | 105    | Monitor     | LG       | 210.00 | 2025-03-12 |
    | 107    | Webcam      | Razer    | 130.00 | 2025-03-01 |
    | 108    | Laptop      | HP       | 950.00 | 2025-03-08 |
    +--------+-------------+----------+--------+------------+*/       

/*SOLUTION*/
    SELECT
        ItemID,
        ItemName,
        Brand,
        Price,
        StockDate
    FROM
        ItemSales
    ORDER BY
        ItemID ASC;
