SELECT
	PurchaseOrderID
	, PurchaseOrderDetailID
	, CAST(DueDate AS date) AS DueDate
	, OrderQty
	, ProductID
	, UnitPrice
	, LineTotal
	, ReceivedQty
	, RejectedQty
	, StockedQty
FROM
	Purchasing.PurchaseOrderDetail;
