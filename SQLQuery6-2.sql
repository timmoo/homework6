/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT MAX(IL.Quantity) OVER(PARTITION BY MONTH(I.InvoiceDate)), W.StockItemName, IL.Quantity
  FROM Sales.InvoiceLines AS IL
  JOIN Sales.Invoices AS I
  ON IL.InvoiceID=I.InvoiceID
   JOIN Warehouse.StockItems AS W
  ON IL.StockItemID=W.StockItemID

  Where I.InvoiceDate>='2016-01-01' AND  I.InvoiceDate<='2016-12-31'
  ORDER BY IL.Quantity desc,  W.StockItemName desc;

