/*
Documentation

	Author: Patrick Mckown
    Date: 2024-07-14
    Purpose: Retrieve the purchasing history of AdventureWorks, including vendors, shipping modes, products, and total spend
    Database: AdventureWorks2014
    Dependencies: None
    Notes: None

Returns:
	A single table "VendorScorecardQuery"
	
Usage:
	1. This query is designed for exporting data to Excel or Power BI for visualization in the Vendor_Scorecard dashboard.

Assumptions:
	1. The database schema follows the AdventureWorks2014 standard.

Modifications and Maintenance:
	1. None

Challenges and Solutions:

Revision History:
	- 2024-07-14: Initial release by Patrick McKown.
*/

WITH FactPOHeader AS (
	SELECT
		PurchaseOrderID
		, VendorID
		, ShipMethodID
		, OrderDate
		, ShipDate
	FROM
		Purchasing.PurchaseOrderHeader
)
, FactPODetails AS (
	SELECT
		PurchaseOrderID
		, PurchaseOrderDetailID
		, ProductID
		, OrderQty
		, UnitPrice
		, LineTotal
		, ReceivedQty
		, RejectedQty
	FROM
		Purchasing.PurchaseOrderDetail
)
, DimMode AS (
	SELECT
		ShipMethodID
		, [Name]  --Shipping Mode
		, ShipBase
		, ShipRate
	FROM Purchasing.ShipMethod
)
, DimProductVendor AS (
	SELECT
		ProductID
		, BusinessEntityID
		, StandardPrice
		, LastReceiptCost
	FROM Purchasing.ProductVendor
)
, DimVendorName AS (
	SELECT
		BusinessEntityID
		, [Name] --Vendor Name
	FROM Purchasing.Vendor
)
, DimProductDesc AS (
	SELECT
		ProductID
		, [Name]
		, ProductNumber
		, StandardCost
		, ListPrice
	FROM Production.Product
)
, VendorScorecardQuery AS (
SELECT
	fpd.PurchaseOrderID
	, fpd.PurchaseOrderDetailID
	, fph.ShipMethodID
	, dm.[Name] AS ShipMode
	, fpd.ProductID
	, dpd.ProductNumber
	, dpd.[Name] AS ProductName
	, dpv.BusinessEntityID
	, dvn.[Name] AS VendorName
	, dpd.StandardCost
	, dpd.ListPrice
FROM FactPODetails AS fpd
LEFT JOIN FactPOHeader AS fph ON fpd.PurchaseOrderID = fph.PurchaseOrderID
INNER JOIN DimProductDesc AS dpd ON fpd.ProductID = dpd.ProductID
LEFT JOIN DimProductVendor AS dpv ON fpd.ProductID = dpv.ProductID
LEFT JOIN DimVendorName AS dvn ON dpv.BusinessEntityID = dvn.BusinessEntityID
LEFT JOIN DimMode AS dm ON fph.ShipMethodID = dm.ShipMethodID
)

SELECT *
FROM VendorScorecardQuery