WITH FactVendors AS (
	SELECT
		BusinessEntityID
		, AccountNumber
		, [Name]
	FROM Purchasing.Vendor
)
, FactCustomers AS (
	SELECT
		CustomerID
		, StoreID
		, TerritoryID
	FROM Sales.Customer
)
, DimAddressID AS (
	SELECT
		BusinessEntityID
		, AddressID
		, AddressTypeID
	FROM Person.BusinessEntityAddress
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
		*
	FROM
		FactCustomers AS fc
	LEFT JOIN
		DimAddressID AS daid ON fc.CustomerID = daid.BusinessEntityID
)

SELECT
	*
FROM Person.BusinessEntityContact