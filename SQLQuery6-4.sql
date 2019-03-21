 
 
 
 SELECT  P.PersonID, P.FullName, I.CustomerID, C.CustomerName
	  FROM Application.People AS P
	 INNER JOIN Sales.Invoices AS I
	 ON P.PersonID=I.SalespersonPersonID
	 INNER JOIN Sales.Customers AS C
	 ON C.CustomerID=I.CustomerID
	WHERE I.CustomerID not  exists (select distinct (LAST_VALUE ( I.CustomerID) OVER (PARTITION BY P.PersonID 	ORDER BY P.PersonID 
						ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)) AS ID, P.PersonID, P.FullName, I.CustomerID,C.CustomerName
						 FROM Application.People AS P
	 INNER JOIN Sales.Invoices AS I
	 ON P.PersonID=I.SalespersonPersonID
	 INNER JOIN Sales.Customers AS C
	 ON C.CustomerID=I.CustomerID);

						SELECT  P.PersonID, P.FullName, I.CustomerID,C.CustomerName
	  FROM Application.People AS P
	 INNER JOIN Sales.Invoices AS I
	 ON P.PersonID=I.SalespersonPersonID
	 INNER JOIN Sales.Customers AS C
	 ON C.CustomerID=I.CustomerID;