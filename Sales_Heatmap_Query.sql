/*
Documentation

	Author: Patrick Mckown
    Date: 2024-06-30
    Purpose: Retrieve the total sales amount by various levels (country, city, etc.) for 2011-05-31 to 2014-05-31
    Database: AdventureWorks2014
    Dependencies: None
    Notes: This query is used in the quarterly sales report. Ensure the data is up-to-date before running the query.

Returns:
	A single table "main"
	
Usage:
	1. This query is designed for exporting data to Excel or Power BI for visualization and analysis.

Assumptions:
	1. The database schema follows the AdventureWorks2014 standard.
	2. Currency conversion rates are accurate up to 2014-05-31.

Modifications and Maintenance:
	1. None

Challenges and Solutions:
	1. Sales data needs to be shown at various levels depending on the BillToAddress: country, state/province, customer, longitude, and latitude for different granularity views when visualizing in Power BI.
	2. Sales are conducted in various currencies depending on the BillToAddress country and sales order origination date.
	3. Country code to currency mapping can result in double counting due to duplicate values of countries that switched to Euro, with the date of switch to Euro from previous currency being invalid.
	   Solution: Partition by CountryCode, filter where the CountryCodeCount > 1 and CurrencyCode = 'EUR' or CountryCodeCount = 1.
	   More permanent and robust solution: Update DBMS to exclude defunct currencies, as no sales were done before all countries switched over to the Euro.
	4. Currency exchange history only goes up to 2014-05-31, whereas order creation dates go up to 2014-06-30.
	   Solution: Constrain order creation date to between 2011-05-31, the minimum order creation date, and 2014-05-31 to show a 3-year history.
	5. The CurrencyRateID in the Sales.SalesOrderHeader table has a limited relationship with the Sales.CurrencyRate table.
	   Solution: Used the average exchange rate on the day of the sales order creation date instead.
	6. There is no direct local currency to USD exchange rate available.
	   Solution: Calculated the inverse of the USD to local currency exchange rate by dividing 1 by the local currency to USD exchange rate.

Revision History:
    - 2024-06-30: Initial creation by Patrick McKown.
*/

WITH FactSalesHeader AS (
	SELECT
		SalesOrderID
		, CAST (OrderDate AS date) AS OrderDate
		, CAST(ShipDate AS date) AS ShipDate
		, CustomerID
		, ShipToAddressID
		, BillToAddressID
		, SubTotal
		, TaxAmt
		, Freight
	FROM Sales.SalesOrderHeader
)
, DimCustomerAddress AS (
	SELECT
		AddressID
		, AddressLine1
		, City
		, StateProvinceID
		, PostalCode
	FROM Person.Address
)
, DimCustomerState AS (
	SELECT
		StateProvinceID
		, [Name]
	FROM Person.StateProvince
)
, DimCustomerTerritory AS (
	SELECT
		CustomerID
		, TerritoryID
	FROM Sales.Customer
)
, DimCustomerName AS (
	SELECT
		BusinessEntityID
		, [Name]
	FROM
		Sales.Store
)
, DimCustomerCountry AS (
	SELECT
		TerritoryID
		, CountryRegionCode
	FROM Sales.SalesTerritory
)
, DimCountryNames AS (
	SELECT
		CountryRegionCode
		, [Name]
	FROM Person.CountryRegion
)
, DimCountryCurrency AS (
	SELECT 
		CountryRegionCode
		, CurrencyCode
		, ModifiedDate
	FROM (
		SELECT CountryRegionCode, CurrencyCode, ModifiedDate,
			   COUNT(*) OVER (PARTITION BY CountryRegionCode) as CodeCount
		FROM Sales.CountryRegionCurrency
	) AS subquery
	WHERE (CodeCount > 1 AND CurrencyCode = 'EUR')
	OR (CodeCount = 1)
)
, DimExchangeRate AS (
	SELECT
		CAST(CurrencyRateDate AS date) AS CurrencyRateDate
		, ToCurrencyCode
		, CASE
			WHEN ToCurrencyCode = 'USD' THEN 1
			ELSE 1 / AverageRate
		END AS "LCtoUSDExchangeRate"
		FROM Sales.CurrencyRate
)
, main AS (
	SELECT
		fsh.SalesOrderID
		, fsh.OrderDate
		, fsh.ShipDate
		, fsh.CustomerID
		, dcn1.[Name] AS "CustomerName"
		, fsh.BillToAddressID
		, dcn.[Name] AS "CountryName"
		, da.AddressLine1 AS "Address"
		, da.City
		, ds.[Name] AS "Province/State"
		, da.PostalCode
		, (fsh.SubTotal * dex.LCtoUSDExchangeRate) AS "SubTotal (USD)"
		, (fsh.TaxAmt * dex.LCtoUSDExchangeRate) AS "TaxAmt (USD)"
		, (fsh.Freight * dex.LCtoUSDExchangeRate) AS "Freight (USD)"
	FROM FactSalesHeader AS fsh
	LEFT JOIN DimCustomerAddress AS da ON fsh.BillToAddressID = da.AddressID
	LEFT JOIN DimCustomerState AS ds ON ds.StateProvinceID = da.StateProvinceID
	LEFT JOIN DimCustomerName AS dcn1 ON fsh.BillToAddressID = dcn1.BusinessEntityID
	LEFT JOIN DimCustomerTerritory AS dct ON fsh.CustomerID = dct.CustomerID
	LEFT JOIN DimCustomerCountry AS dcc ON dct.TerritoryID = dcc.TerritoryID
	LEFT JOIN DimCountryNames AS dcn ON dcc.CountryRegionCode = dcn.CountryRegionCode
	LEFT JOIN DimCountryCurrency AS dcc2 ON dcc.CountryRegionCode = dcc2.CountryRegionCode
	LEFT JOIN DimExchangeRate AS dex ON fsh.OrderDate = dex.CurrencyRateDate AND dcc2.CurrencyCode = dex.ToCurrencyCode
	WHERE
		fsh.OrderDate >= '2011-05-31'
		AND fsh.OrderDate <= '2014-05-31'
)


SELECT *
FROM main;


/*, main_unpivoted AS (
    SELECT *
    FROM main
    UNPIVOT
        (Value FOR ValueType IN (SubTotal, TaxAmt, Freight)) AS unpvt
)*/