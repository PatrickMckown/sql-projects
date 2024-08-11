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
| 43659        | 5/31/2011    | 29825        | 23153.23     |
| 43660        | 5/31/2011    | 29672        | 1457.33      |
| 43661        | 5/31/2011    | 29734        | 36865.80     |
| 43662        | 5/31/2011    | 29994        | 32474.93     |
| 43663        | 5/31/2011    | 29565        | 472.31       |
+--------------+--------------+--------------+--------------+

Selecting a Column
- In Excel: This is similar to highlighting the entire column labeled SalesOrderID. You click on the header of the SalesOrderID column, which highlights all the cells in that column. SELECT always comes before FROM.
- In SQL: SELECT SalesOrderID

Specifying the Table
- In Excel: This is equivalent to specifying that the data you are interested in is in a table named SalesOrderHeader within your Excel workbook. You navigate to the tab and range where the table is contained. FROM always comes after SELECT.
- In SQL: FROM Sales.SalesOrderHeader

So, if we write "SELECT SalesOrderID FROM Sales.SalesOrderHeader" we get the following:

+--------------+
| SalesOrderID |
+--------------+
| 43659        |
| 43660        |
| 43661        |
| 43662        |
| 43663        |
+--------------+

Explain
1. Explain what's so important about keywords
2. Explain two keywords in SQL, what do they do?
3. Explain which keyword is like telling the database which columns you want
*/

SELECT SalesOrderID FROM Sales.SalesOrderHeader;
GO


/*
SELECT Multiple Columns

To ask for more than one column, just separate the column names with a comma. 

Excel Analogy
Imagine we have the same table as above in our Excel workbook.

+--------------+--------------+--------------+--------------+
| SalesOrderID | OrderDate    | CustomerID   | TotalDue     |
+--------------+--------------+--------------+--------------+
| 43659        | 5/31/2011    | 29825        | 23153.23     |
| 43660        | 5/31/2011    | 29672        | 1457.33      |
| 43661        | 5/31/2011    | 29734        | 36865.80     |
| 43662        | 5/31/2011    | 29994        | 32474.93     |
| 43663        | 5/31/2011    | 29565        | 472.31       |
+--------------+--------------+--------------+--------------+

Selecting Multiple Columns
- In Excel: This is equivalent to holding down the "CTRL" button on the keyboard, left clicking on SalesOrderID column and then left clicking the OrderDate column
- In SQL: To select more than we column, we write "SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader" 

So, if we write "SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader" we get the following:

+--------------+--------------+
| SalesOrderID | OrderDate    |
+--------------+--------------+
| 43659        | 5/31/2011    |
| 43660        | 5/31/2011    |
| 43661        | 5/31/2011    |
| 43662        | 5/31/2011    |
| 43663        | 5/31/2011    |
+--------------+--------------+

Explain
1. Explain which punctuation mark(s) are used to seperate column names
2. Explain what "SELECT SalesOrderID, TotalDue FROM Sales.SalesOrderHeader" would look like if done in Excel
3. Explain how I would select the 3 left-most columns in both SQL and Excel
*/

SELECT SalesOrderID, OrderDate FROM Sales.SalesOrderHeader;
GO

/*
WHERE

WHERE is the third keyword that makes up most SQL statements. WHERE goes after FROM.

- WHERE: This keyword tells the database what specific values you want to see when you ask for data from the datasbase with SELECT and FROM.

Excel Analogy
Imagine you have the same Excel spreadsheet with the table below in it.

+----------------+---------------+--------------+--------------+
| SalesOrderID ▼ | OrderDate ▼   | CustomerID ▼ | TotalDue ▼   |
+----------------+---------------+--------------+--------------+
| 43659          | 5/31/2011     | 29825        | 23153.23     |
| 43660          | 5/31/2011     | 29672        | 1457.33      |
| 43661          | 5/31/2011     | 29734        | 36865.80     |
| 43662          | 5/31/2011     | 29994        | 32474.93     |
| 43663          | 5/31/2011     | 29565        | 472.31       |
+----------------+---------------+--------------+--------------+

Now imagine you only want to see the orders that have a SalesOrderID of "43659".

Filtering for a Value
- In Excel: This is equivalent to clicking on the filter in the SalesOrderID column header and only filtering for "43659".
- In SQL: To filter for a value we add the WHERE keyword, specify the column and then specify the value using a "=" sign

So, if we write "SELECT SalesOrderID, TotalDue FROM Sales.SalesOrderHeader WHERE SalesOrderID = 43659" we get the following:

+----------------+--------------+
| SalesOrderID ▼ | TotalDue ▼   |
+----------------+--------------+
| 43659          | 23153.23     |
+----------------+--------------+

*/

SELECT SalesOrderID, TotalDue FROM Sales.SalesOrderHeader WHERE SalesOrderID = 43659;
GO
