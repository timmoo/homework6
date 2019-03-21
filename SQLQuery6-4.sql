SELECT 
	I.SalespersonPersonID AS [SalesPersonID], 
	P.FullName AS [SalesPersonName], 
	LAST_VALUE(C.CustomerName) OVER (PARTITION BY C.CustomerName ORDER BY C.CustomerName) AS [LastCustomerName], 
	I.CustomerID, 
	IL.UnitPrice AS [UnitPrice],
	I.InvoiceDate AS [Date]
FROM Sales.Invoices AS I
	JOIN Application.People AS P ON P.PersonID = I.SalespersonPersonID
	JOIN Sales.Customers AS C ON C.CustomerID = I.CustomerID
	JOIN Sales.InvoiceLines AS IL ON IL.InvoiceID = I.InvoiceID
GROUP BY P.FullName, I.CustomerID, C.CustomerName, I.SalespersonPersonID, I.InvoiceDate, IL.UnitPrice
ORDER BY I.InvoiceDate DESC;


SELECT 
	distinct I.SalespersonPersonID, 
	P.FullName, 
	LAST_VALUE(C.CustomerName) OVER (PARTITION BY IL.InvoiceID ORDER BY I.InvoiceDate desc), 
	LAST_VALUE(I.CustomerID) OVER (PARTITION BY IL.InvoiceID ORDER BY I.InvoiceDate desc), 
	LAST_VALUE(IL.UnitPrice) OVER (PARTITION BY IL.InvoiceID ORDER BY I.InvoiceDate desc), 
	LAST_VALUE(I.InvoiceDate) OVER (PARTITION BY IL.InvoiceID ORDER BY I.InvoiceDate desc)
FROM Sales.Invoices AS I
	JOIN Application.People AS P ON P.PersonID = I.SalespersonPersonID
	JOIN Sales.Customers AS C ON C.CustomerID = I.CustomerID
	JOIN Sales.InvoiceLines AS IL ON IL.InvoiceID = I.InvoiceID
GROUP BY P.FullName, I.CustomerID, C.CustomerName, I.SalespersonPersonID, I.InvoiceDate, IL.UnitPrice
ORDER BY P.FullName;
