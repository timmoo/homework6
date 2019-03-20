WITH CTE AS 
	( SELECT IL.*,W.StockItemID, W.StockItemName, I.*, ROW_NUMBER()  OVER(PARTITION BY MONTH(I.InvoiceDate), YEAR(I.InvoiceDate)ORDER BY IL.Quantity desc) AS NUMBER FROM Sales.InvoiceLines  AS IL 
INNER JOIN Sales.Invoices AS I
ON IL.InvoiceID=I.InvoiceID
INNER JOIN Warehouse.StockItems AS W
ON IL.StockItemID=W.StockItemID
WHERE I.InvoiceDate>='2016-01-01' AND  I.InvoiceDate<='2016-12-31'
)
 Select CTE_.* FROM Sales.InvoiceLines AS IL
  INNER JOIN CTE AS CTE_
  ON IL.InvoiceID=CTE_.InvoiceID
   where CTE_.NUMBER<=2;
