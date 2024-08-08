WITH FactVendors AS (
	SELECT
		BusinessEntityID
		, AccountNumber
		, [Name]
	FROM
		Purchasing.Vendor
)
, FactCustomers AS (
	SELECT
		CustomerID
		, StoreID
		, TerritoryID
	FROM
		Sales.Customer
)
, DimAddressID AS (
	SELECT
		BusinessEntityID
		, AddressID
		, AddressTypeID
	FROM
		Person.BusinessEntityAddress
)
, DimAddressTypeID AS (
	SELECT
		AddressTypeID
		, [Name] -- Address Description
	FROM
		Person.AddressType
)
, DimPersonContactID AS (
	SELECT
		BusinessEntityID
		, PersonID
		, ContactTypeID
	FROM
		Person.BusinessEntityContact
)
, CustomerContactMaster AS (
	SELECT
		fc.CustomerID
		, fc.StoreID
		, fc.TerritoryID
		, daid.AddresstypeID
		, datid.[Name] AS AddressDescription
	FROM
		FactCustomers AS fc
	LEFT JOIN
		DimAddressID AS daid ON fc.CustomerID = daid.BusinessEntityID
	LEFT JOIN
		DimAddressTypeID AS datid ON daid.AddressTypeID = datid.AddressTypeID
		
)

SELECT
	*
FROM CustomerContactMaster
