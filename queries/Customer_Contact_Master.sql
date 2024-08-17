/*
Documentation

	Author: Patrick McKown
	Date: 2024-08-17
	Purpose: Retrieve detailed information on addresses, including associated business entities, contact details, and regional data.
	Database: AdventureWorks2014
	Dependencies: None
	Notes:
		There are a small number of BusinessEntityIDs with more than one AddressID. Some customers have both their 'Home' address and 'Shipping' address.

	Returns:
		A single table containing:

		+-----------------------+---------------------------------------------+-------------------+
		| Field                 | Description                                 | Data Type         |
		+-----------------------+---------------------------------------------+-------------------+
		| pa.AddressID          | Unique identifier for the address           | int               |
		| pbea.BusinessEntityID | Unique identifier for the business entity   | int               |
		| pa.AddressLine1       | First line of the address                   | nvarchar(60)      |
		| pa.City               | City name                                   | nvarchar(30)      |
		| pa.PostalCode         | Postal code                                 | nvarchar(15)      |
		| psp.Name              | Name of the province or state               | nvarchar(50)      |
		| pat.Name              | Type of address (e.g., Home, Work)          | nvarchar(50)      |
		| pea.EmailAddress      | Email address associated with the entity    | nvarchar(50)      |
		| ppp.PhoneNumber       | Phone number associated with the entity     | nvarchar(25)      |
		| pp.FirstName          | First name of the person                    | nvarchar(50)      |
		| pp.LastName           | Last name of the person                     | nvarchar(50)      |
		| sst.CountryRegionCode | Country or region code                      | nchar(3)          |
		| pcr.Name              | Name of the country                         | nvarchar(50)      |
		| sst.Group             | Country group (e.g., North America)         | nvarchar(50)      |
		+-----------------------+---------------------------------------------+-------------------+

	Usage:
		This query is designed for extracting detailed address and contact information for use in reporting or integration with other systems.
		The data can be exported to Excel or other tools for further analysis or used directly in applications.
		
	Assumptions:
		The database schema adheres to the AdventureWorks2014 standard.
		Each BusinessEntityID is uniquely associated with an address, email, and phone number.

	Modifications and Maintenance:
		None.

	Revision History:
		2024-08-17: Initial creation by Patrick Mckown.
*/

SELECT
	pa.AddressID
	, pbea.BusinessEntityID
	, pa.AddressLine1
	, pa.City
	, pa.PostalCode
	, psp.[Name] AS ProvinceStateName
	, pat.[Name] AS AddressType
	, pea.EmailAddress
	, ppp.PhoneNumber
	, pp.FirstName
	, pp.LastName
	, sst.CountryRegionCode
	, pcr.[Name] AS CountryName
	, sst.[Group] AS CountryGroup
FROM 
	Person.[Address] AS pa
INNER JOIN
	Person.BusinessEntityAddress AS pbea ON pa.AddressID = pbea.AddressID
INNER JOIN
        Person.StateProvince AS psp ON pa.StateProvinceID = psp.StateProvinceID
INNER JOIN
	Person.AddressType AS pat ON pbea.AddressTypeID = pat.AddressTypeID 
INNER JOIN
	Person.EmailAddress AS pea ON pbea.BusinessEntityID = pea.BusinessEntityID
INNER JOIN
	Person.Person AS pp ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN
	Person.PersonPhone AS ppp ON pbea.BusinessEntityID = ppp.BusinessEntityID
INNER JOIN
	Sales.SalesTerritory AS sst ON psp.TerritoryID = sst.TerritoryID
INNER JOIN
	Person.CountryRegion AS pcr ON sst.CountryRegionCode = pcr.CountryRegionCode;
