 
 SELECT 
	W.StockItemID,
	W.StockItemName,
	W.Brand,
	W.UnitPrice, 
	COUNT(*) OVER (PARTITION BY LEFT(W.StockItemName,1) ORDER BY (W.StockItemName) RANGE UNBOUNDED PRECEDING) AS [CountByName],
	COUNT(*) OVER ( ORDER BY (W.StockItemName) RANGE UNBOUNDED PRECEDING) AS [CountAll],
	ROW_NUMBER() OVER (PARTITION BY LEFT(W.StockItemName,1) ORDER BY W.StockItemName) AS [Number],
	COUNT(*)OVER(PARTITION	BY LEFT(W.StockItemName,1)) AS [CountByName],
	LEAD(W.StockItemID) OVER (ORDER BY (W.StockItemName) ) as [Follow],
	LAG(W.StockItemID) OVER (ORDER BY (W.StockItemName) ) as [Previous],
	LAG(W.StockItemName, 2, 'No Items') OVER (ORDER BY (W.StockItemName) ) as [Previous2],
	NTILE(30)  OVER (ORDER BY W.TypicalWeightPerUnit desc) AS [WeightGroup]
FROM Warehouse.StockItems AS W
ORDER BY W.StockItemName;
