
WITH TotalSummCTE AS 
	(SELECT MONTH(INV.InvoiceDate) AS Mesyac1, 
	YEAR(INV.InvoiceDate) as God1, 
	SUM(INVL.Quantity*INVL.UnitPrice) AS TotalSumm
	FROM Sales.InvoiceLines AS INVL
	JOIN Sales.Invoices AS INV ON INV.InvoiceID=INVL.InvoiceID AND INV.InvoiceID<=INVL.InvoiceID  WHERE INV.InvoiceDate >= '2015-01-01'
	GROUP BY MONTH(INV.InvoiceDate), YEAR(INV.InvoiceDate)
	)
SELECT DISTINCT
I.InvoiceID, 
C.CustomerName,
I.InvoiceDate, 
SUM(S.Quantity*S.UnitPrice) AS Summ,
SUM(TCTE.TotalSumm)
FROM Sales.InvoiceLines AS S 
JOIN Sales.Invoices AS I ON I.InvoiceID=S.InvoiceID
JOIN Sales.Customers AS C ON I.CustomerID=C.CustomerID
JOIN TotalSummCTE AS TCTE ON TCTE.Mesyac1=MONTH(I.InvoiceDate) and TCTE.God1=YEAR(I.InvoiceDate)
WHERE I.InvoiceDate >= '2015-01-01'
GROUP BY  I.InvoiceID, C.CustomerName, I.InvoiceDate, TCTE.TotalSumm
ORDER BY I.InvoiceID;


WITH TotalSummCTE AS 
(SELECT  DISTINCT I.InvoiceID, 
C.CustomerName,
S.InvoiceDate, 
SUM(I.Quantity*I.UnitPrice) OVER (ORDER BY YEAR(S.InvoiceDate), MONTH(S.InvoiceDate) RANGE UNBOUNDED PRECEDING) AS TotalSumm  
FROM Sales.Invoices AS S
JOIN Sales.InvoiceLines AS I ON S.InvoiceID=I.InvoiceID
JOIN Sales.Customers AS C ON S.CustomerID=C.CustomerID
WHERE S.InvoiceDate >= '2015-01-01'
GROUP BY  I.InvoiceID, C.CustomerName, S.InvoiceDate, I.Quantity, I.UnitPrice
)
SELECT DISTINCT S.InvoiceID, 
TCTE.CustomerName,
TCTE.InvoiceDate,
SUM(S.Quantity*S.UnitPrice) AS Summ,
TCTE.TotalSumm 
FROM Sales.InvoiceLines AS S
JOIN TotalSummCTE AS TCTE ON TCTE.InvoiceID =S.InvoiceID
GROUP BY S.InvoiceID, TCTE.TotalSumm, TCTE.CustomerName, TCTE.InvoiceDate
ORDER BY S.InvoiceID
set statistics time on;