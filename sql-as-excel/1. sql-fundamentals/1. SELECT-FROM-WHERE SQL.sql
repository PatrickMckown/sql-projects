/*Lesson 1*/

/*
SELECT and FROM

SELECT and FROM are fundamental components of any SQL query. They are called "keywords", which are special words that have specific meanings and functions.

- SELECT: This keyword tells the database that you want to get data from it. Think of it as a standard structure for asking for information.
- FROM: This keyword tells SQL from which table we are retrieving the data from. All SQL is based on tables, as opposed to tables and ranges (ex: "A1:B2") in Excel.

Excel Analogy
Imagine you have an Excel spreadsheet that has a table in it. This table contains various columns, including one named SalesOrderID.

+--------------+--------------+--------------+--------------+
| SalesOrderID | OrderDate    | CustomerID   | TotalDue     |
+--------------+--------------+--------------+--------------+
| 1            | 2024-01-01   | 101          | 1000.00      |
| 2            | 2024-01-02   | 102          | 1500.00      |
| 3            | 2024-01-03   | 103          | 2000.00      |
| 4            | 2024-01-04   | 104          | 2500.00      |
| 5            | 2024-01-05   | 105          | 3000.00      |
+--------------+--------------+--------------+--------------+

Selecting a Column in Excel
- In SQL: SELECT SalesOrderID
- In Excel: This is similar to highlighting the entire column labeled SalesOrderID. You click on the header of the SalesOrderID column, which highlights all the cells in that column. SELECT always comes before FROM.

Specifying the Table in Excel
- In SQL: FROM Sales.SalesOrderHeader
- In Excel: This is equivalent to specifying that the data you are interested in is in a table named SalesOrderHeader within your Excel workbook. You navigate to the tab and range where the table is contained. FROM always comes after SELECT.

So, if we write "SELECT SalesOrderID FROM Sales.SalesOrderHeader" we get the following:

+--------------+
| SalesOrderID | 
+--------------+
| 1            | 
| 2            | 
| 3            |
| 4            | 
| 5            | 
+--------------+

Explain
1. Explain what's so important about keywords
2. Explain two keywords in SQL
3. Explain which keyword is like telling the database which columns you want
*/

SELECT SalesOrderID
FROM Sales.SalesOrderHeader


/*
SELECT Multiple Columns

To ask for more than one column, just separate the column names with a comma. 

Imagine we have the same table as above.

+--------------+--------------+--------------+--------------+
| SalesOrderID | OrderDate    | CustomerID   | TotalDue     |
+--------------+--------------+--------------+--------------+
| 1            | 2024-01-01   | 101          | 1000.00      |
| 2            | 2024-01-02   | 102          | 1500.00      |
| 3            | 2024-01-03   | 103          | 2000.00      |
| 4            | 2024-01-04   | 104          | 2500.00      |
| 5            | 2024-01-05   | 105          | 3000.00      |
+--------------+--------------+--------------+--------------+

So, if we write "SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader" we get the following:

+--------------+--------------+
| SalesOrderID | OrderDate    |
+--------------+--------------+
| 1            | 2024-01-01   |
| 2            | 2024-01-02   |
| 3            | 2024-01-03   |
| 4            | 2024-01-04   |
| 5            | 2024-01-05   |
+--------------+--------------+

Explain
1. Explain which punctuation mark(s) to use to seperate column names
2. Explain what "SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader" would look like if done in Excel

*/

SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader

/*


WHERE

WHERE is the third keyword that makes up most SQL statements.

*/

