﻿/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT MAX(IL.Quantity) OVER(PARTITION BY MONTH(I.InvoiceDate)), W.StockItemName, IL.Quantity
  FROM Sales.InvoiceLines AS IL
  JOIN Sales.Invoices AS I
  ON IL.InvoiceID=I.InvoiceID
   JOIN Warehouse.StockItems AS W
  ON IL.StockItemID=W.StockItemID

  Where I.InvoiceDate>='2016-01-01' AND  I.InvoiceDate<='2016-12-31'
  ORDER BY IL.Quantity desc,  W.StockItemName desc;

WITH CTE AS 
	(SELECT ROW_NUMBER()  OVER(PARTITION BY MONTH(I.InvoiceDate)ORDER BY IL.Quantity) AS NUMBER, W.StockItemName, IL.Quantity, W.StockItemID 
  FROM Sales.InvoiceLines AS IL
  JOIN Sales.Invoices AS I
  ON IL.InvoiceID=I.InvoiceID
   JOIN Warehouse.StockItems AS W
  ON IL.StockItemID=W.StockItemID
  Where I.InvoiceDate>='2016-01-01' AND  I.InvoiceDate<='2016-12-31'
  )
  Select * from Sales.InvoiceLines AS IL
 JOIN CTE AS CTE_ 
 ON IL.StockItemID=CTE_.StockItemID
 where CTE_.NUMBER<=2
 ORDER BY IL.Quantity desc;
