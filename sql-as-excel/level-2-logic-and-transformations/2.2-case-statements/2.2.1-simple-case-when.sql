/*2.2.1 Simple CASE WHEN
    
    In this lesson we're going to learn the basics of CASE WHEN.

    We all know and love IF statements in Excel. They are the backbone of almost every Excel project you'll undertake. 

    And in SQL we have almost the exact same structure in SQL. The syntax might look a little different, but it packs the same amount of power as IF.

    Let's imagine we have the following table in Excel.

            A           B
        +----------+--------+
    1   | OrderID  | Amount |
        +----------+--------+
    2   | 1001     | 50     |
    3   | 1002     | 300    |
    4   | 1003     | 120    |
    5   | 1004     | 600    |
    6   | 1005     | 80     |
        +----------+--------+

    Let's imagine that we need to group the orders in 3 categories based on their amounts using a formula: 
        "Small" for anything less than 100
        "Medium" for anything between 100 to 500
        "Large" for anything greater than 500

    We can write something like the below.

        A         B              C
      +----------+--------+----------------------------------------------------+
    1 | OrderID  | Amount |              OrderSize                             |
      +----------+--------+----------------------------------------------------+
    2 | 1001     | 50     | =IF(B2<100,"Small",IF(B2<=500,"Medium","Large"))   |
    3 | 1002     | 300    | =IF(B3<100,"Small",IF(B3<=500,"Medium","Large"))   |
    4 | 1003     | 120    | =IF(B4<100,"Small",IF(B4<=500,"Medium","Large"))   |
    5 | 1004     | 600    | =IF(B5<100,"Small",IF(B5<=500,"Medium","Large"))   |
    6 | 1005     | 80     | =IF(B6<100,"Small",IF(B6<=500,"Medium","Large"))   |
      +----------+--------+----------------------------------------------------+

    That will return the following

            A         B              C
         +----------+--------+-----------+
    1    | OrderID  | Amount | OrderSize |
         +----------+--------+-----------+
    2    | 1001     | 50     | Small     |
    3    | 1002     | 300    | Medium    |
    4    | 1003     | 120    | Medium    |
    5    | 1004     | 600    | Large     |
    6    | 1005     | 80     | Small     |
         +----------+--------+-----------+

    This allows us to get an easier to digest summary of the different order sizes.

    Well we can achieve a similar result in SQL using CASE WHEN.

    The basic structure of CASE WHEN is below.

    CASE 
        WHEN <condition1> THEN <result1>
        WHEN <condition2> THEN <result2>
        ...
        ELSE <default_result>
    END AS <column_name>
    
    With CASE WHEN, CASE initiates the IF statement

    WHEN is like IF in an IF formula, THEN is like the comma
    ELSE is like the default end result when none of the conditions are met

    Let's use the table below to 

    TABLE: Inventory
    +----------+------------------+--------+
    | ItemID   | ItemName         | Stock  |
    +----------+------------------+--------+
    | 201      | Wireless Mouse   | 25     |
    | 202      | USB-C Charger    | 5      |
    | 203      | Laptop Stand     | 0      |
    | 204      | Webcam           | 8      |
    | 205      | Headphones       | 0      |
    | 206      | Keyboard         | 15     |
    +----------+------------------+--------+

    CHALLENGE: Classify the items by their stock level following the logic below
        "Out of Stock" when Stock is 0
        "Low Stock" when Stock is less than 10
        "Sufficient Stock" when Stock is greater than 10

    RETURN: ItemID, ItemName, Stock, StockStatus
    */

/*Step One

    First part is selecting any columns that already exist in the table*/

        SELECT
            ItemID,
            ItemName,
            Stock
        FROM
            Inventory

/*Step Two

    Next is to add the column that classifies the items into different statuses.
    
    Recall that the structure for CASE WHEN is like the below:

    CASE 
        WHEN <condition1> THEN <result1>
        WHEN <condition2> THEN <result2>
        ...
        ELSE <default_result>
    END AS <column_name>
    
    First let's address the initial step, which is classifying the materials as 'Out of Stock':

    CASE 
        WHEN Stock = 0 THEN 'Out of Stock'
        WHEN <condition2> THEN <result2>
        ...
        ELSE <default_result>
    END AS <column_name>

    Then we have a second condition that classifies the materials as 'Low Stock' if Stock less than 10

    We can accomplish this using BETWEEN or a less than operator, in this case I will use less than.

    CASE 
        WHEN Stock = 0 THEN 'Out of Stock'
        WHEN Stock < 10 THEN 'Low Stock'
        ...
        ELSE <default_result>
    END AS <column_name>

    Next we'll insert the default value which the statement will default to if none of the conditions are met. 

    CASE 
        WHEN Stock = 0 THEN 'Out of Stock'
        WHEN Stock < 10 THEN 'Low Stock'
        ELSE 'Sufficient Stock'
    END AS "StockStatus"
    */

    SELECT
        ItemID,
        ItemName,
        Stock,
        CASE 
            WHEN Stock = 0 THEN 'Out of Stock'
            WHEN Stock < 10 THEN 'Low Stock'
            ELSE 'Sufficient Stock'
        END AS "StockStatus"
    FROM
        Inventory

    /*That will return the following

    +----------+------------------+--------+------------------+
    | ItemID   | ItemName         | Stock  | StockStatus      |
    +----------+------------------+--------+------------------+
    | 201      | Wireless Mouse   | 25     | Sufficient Stock |
    | 202      | USB-C Charger    | 5      | Low Stock        |
    | 203      | Laptop Stand     | 0      | Out of Stock     |
    | 204      | Webcam           | 8      | Low Stock        |
    | 205      | Headphones       | 0      | Out of Stock     |
    | 206      | Keyboard         | 15     | Sufficient Stock |
    +----------+------------------+--------+------------------+

*/       

/*SOLUTION*/
    SELECT
        ItemID,
        ItemName,
        Stock,
        CASE 
            WHEN Stock = 0 THEN 'Out of Stock'
            WHEN Stock < 10 THEN 'Low Stock'
            ELSE 'Sufficient Stock'
        END AS "StockStatus"
    FROM
        Inventory