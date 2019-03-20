WITH CTE AS 
	( SELECT  I.InvoiceID AS [InvoiceID],IL1.Quantity AS [Quantity], I.InvoiceDate AS [DATE], W.StockItemName AS StockNAME,w.StockItemID AS StockID, ROW_NUMBER()  OVER(PARTITION BY MONTH(I.InvoiceDate), YEAR(I.InvoiceDate)ORDER BY IL1.Quantity desc) AS NUMBER FROM Sales.InvoiceLines  AS IL1
INNER JOIN Sales.Invoices AS I
ON IL1.InvoiceID=I.InvoiceID
INNER JOIN Warehouse.StockItems AS W
ON IL1.StockItemID=W.StockItemID
WHERE I.InvoiceDate>='2016-01-01' AND  I.InvoiceDate<='2016-12-31'
)
 Select DISTINCT CTE_.* FROM Sales.InvoiceLines AS IL
  INNER JOIN CTE AS CTE_
  ON IL.InvoiceID=CTE_.InvoiceID
   where CTE_.NUMBER<=2
   ORDER BY [NUMBER]
