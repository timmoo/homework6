set statistics time on;
select 
IL.InvoiceID,
I.InvoiceDate,
C.CustomerName,
IL.Quantity*IL.UnitPrice as [Sale Amount],
(select sum(ILInner.Quantity*ILInner.UnitPrice)
from [Sales].[InvoiceLines] as ILInner
join [Sales].[Invoices] as IInner on IInner.InvoiceID = ILInner.InvoiceID
where IInner.InvoiceDate >= '2015-01-01' and IInner.InvoiceDate <= eomonth(I.InvoiceDate)
) as [Sale Amount by Month]
from [Sales].[InvoiceLines] as IL
join [Sales].[Invoices] as I on I.InvoiceID = IL.InvoiceID
join [Sales].[Customers] as C on C.CustomerID = I.CustomerID
where I.InvoiceDate >= '2015-01-01'
order by I.InvoiceDate, [Sale Amount], IL.InvoiceID, C.CustomerName;

SELECT 
I.InvoiceID, 
S.InvoiceDate, 
C.CustomerName,
I.Quantity*I.UnitPrice as [Sale Amount],
SUM(I.Quantity*I.UnitPrice) OVER (ORDER BY YEAR(S.InvoiceDate), 
MONTH(S.InvoiceDate) RANGE UNBOUNDED PRECEDING) AS TotalSumm  
FROM Sales.Invoices AS S
JOIN Sales.InvoiceLines AS I ON S.InvoiceID=I.InvoiceID
JOIN Sales.Customers AS C ON S.CustomerID=C.CustomerID
where S.InvoiceDate >= '2015-01-01' and S.InvoiceDate <= eomonth(S.InvoiceDate)
order by S.InvoiceDate, [Sale Amount], I.InvoiceID, C.CustomerName;

--SQL Server parse and compile time: 
--   CPU time = 78 ms, elapsed time = 80 ms.

-- SQL Server Execution Times:
--   CPU time = 0 ms,  elapsed time = 0 ms.

--(101356 row(s) affected)

 --SQL Server Execution Times:
   --CPU time = 35766 ms,  elapsed time = 37100 ms.

 --SQL Server Execution Times:
   --CPU time = 0 ms,  elapsed time = 0 ms.

--(101356 row(s) affected)

 --SQL Server Execution Times:
   --CPU time = 281 ms,  elapsed time = 1681 ms.
