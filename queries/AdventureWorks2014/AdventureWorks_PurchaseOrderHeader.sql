
WITH FactPOHeader AS (
	SELECT
		PurchaseOrderID
		, EmployeeID
		, VendorID
		, ShipMethodID
		, OrderDate
		, ShipDate
		, SubTotal
		, TaxAmt
		, Freight
		, TotalDue
	FROM
		Purchasing.PurchaseOrderHeader
)
, DimShipMethod AS (
	SELECT
		ShipMethodID
		, [Name] --ShipMethod
	FROM
		Purchasing.ShipMethod
)
, PurchaseOrderHeader AS (
	SELECT
		fph.PurchaseOrderID
		, fph.EmployeeID
		, fph.VendorID
		, dsm.[Name] AS ShipMethod
		, CAST(fph.OrderDate AS date) AS OrderDate
		, CAST(fph.ShipDate AS date) AS ShipDate
		, fph.SubTotal
		, fph.TaxAmt
		, fph.Freight
		, fph.TotalDue
	FROM
		FactPOHeader AS fph
	LEFT JOIN
		DimShipMethod AS dsm ON fph.ShipMethodID = dsm.ShipMethodID
)

SELECT
	*
FROM
	PurchaseOrderHeader;
