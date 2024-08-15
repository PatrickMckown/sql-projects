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
