/*
Author:
	Patrick McKown

Date:
	CurrentDate

Purpose:
	To retrieve a master list of products, including key details about each product, its model, subcategory, and category, from the AdventureWorks2014 database. 
	This query is useful for comprehensive product analysis and reporting.

Database:
	AdventureWorks2014

Dependencies:
	None.

Notes:
	The query consolidates data from the Product, ProductModel, ProductSubcategory, and ProductCategory tables into a single master view called ProductMaster. 
	This master view is used to retrieve detailed information about each product, including its category hierarchy and pricing details.

Returns:
	A single table containing:

	+-----------------------+------------------------------------------------------------+-------------------+
	| Field                 | Description                                                | Data Type         |
	+-----------------------+------------------------------------------------------------+-------------------+
	| ProductID             | Unique identifier for the product                          | int               |
	| ProductName           | Name of the product                                        | nvarchar(50)      |
	| ProductNumber         | Unique product number                                      | nvarchar(25)      |
	| MakeFlag              | Indicates if the product is manufactured internally        | bit               |
	| DaysToManufacture     | Number of days required to manufacture the product         | int               |
	| SafetyStockLevel      | Minimum inventory quantity before a reorder is triggered   | smallint          |
	| ReorderPoint          | Inventory level at which a reorder is triggered            | smallint          |
	| StandardCost          | Standard cost of the product                               | money             |
	| ListPrice             | List price of the product                                  | money             |
	| ProductCategoryName   | Name of the product's category                             | nvarchar(50)      |
	| ProductSubcategoryName| Name of the product's subcategory                          | nvarchar(50)      |
	| ProductModelName      | Name of the product's model                                | nvarchar(50)      |
	+-----------------------+------------------------------------------------------------+-------------------+

Usage:
	This query is designed for generating detailed reports on product information, including hierarchical data from categories to individual products. 
	It can be exported for further analysis in Excel, Power BI, or other analytical tools.

Assumptions:
	The database schema follows the AdventureWorks2014 standard.
	Each product belongs to a product model, subcategory, and category, although some products might not have a model or subcategory linked.

Modifications and Maintenance:
	None.

Challenges and Solutions:
	None.

Revision History:
	2024-08-22: Initial creation by Patrick McKown
*/


WITH DimProducts AS (
	SELECT
		ProductID
		, [Name] --ProductName
		, ProductNumber
		, MakeFlag
		, DaysToManufacture
		, SafetyStockLevel
		, ReorderPoint
		, StandardCost
		, ListPrice
		, ProductSubcategoryID
		, ProductModelID
	FROM
		Production.Product
)
, DimModels AS (
	SELECT
		ProductModelID
		, [Name] --ProductName
	FROM
		Production.ProductModel
)
, DimSubcategories AS (
	SELECT
		ProductSubcategoryID
		, ProductCategoryID
		, [Name] --ProductSubcategoryName
	FROM
		Production.ProductSubcategory
)
, DimCategories AS (
	SELECT
		ProductCategoryID
		, [Name] --ProductCategoryName
	FROM
		Production.ProductCategory
)
, ProductMaster AS (
	SELECT
		dp.ProductID
		, dp.[Name] AS ProductName
		, dp.ProductNumber
		, dp.MakeFlag
		, dp.DaysToManufacture
		, dp.SafetyStockLevel
		, dp.ReorderPoint
		, dp.StandardCost
		, dp.ListPrice
		, dc.[Name] AS ProductCategoryName
		, ds.[Name] AS ProductSubcategoryName
		, dm.[Name] AS ProductModelName
	FROM
		DimProducts AS dp
	LEFT JOIN
		DimModels AS dm ON dp.ProductModelID = dm.ProductModelID
	LEFT JOIN
		DimSubcategories AS ds ON dp.ProductSubcategoryID = ds.ProductSubcategoryID
	LEFT JOIN
		DimCategories AS dc ON ds.ProductCategoryID = dc.ProductCategoryID
)

SELECT
	*
FROM
	ProductMaster