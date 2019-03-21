  WITH CTE AS
  (
   SELECT *,COUNT(*) OVER (PARTITION BY (W.StockItemName) ORDER BY (W.StockItemName) RANGE UNBOUNDED PRECEDING) AS [COUNT_by NAME]
   FROM Warehouse.StockItems  AS W 
  )
 SELECT CTE.StockItemID,
	CTE.StockItemName,
	CTE.Brand,
	CTE.UnitPrice, 
	COUNT(*) OVER ( ORDER BY (CTE.StockItemID) RANGE UNBOUNDED PRECEDING) AS [COUNT_ALL],
		ROW_NUMBER()  OVER (ORDER BY CTE.StockItemID desc) AS [NUMBER], CTE.[COUNT_by NAME],
	LAG(CTE.StockItemID) OVER (ORDER BY (CTE.StockItemName) ) as PRevious,
	LAG(CTE.StockItemID, 2) OVER (ORDER BY (CTE.StockItemName) ) as PRevious2,
	LEAD(CTE.StockItemID) OVER (ORDER BY (CTE.StockItemName) ) as Follow,
	NTILE(30)  OVER (ORDER BY CTE.TypicalWeightPerUnit desc) AS [weightgroup]
	  FROM CTE
	ORDER BY NUMBER, COUNT_ALL, CTE.StockItemID
	
	-- В запросе со смещением на 2 назад не удалось заменить NULL на NO Items с ошибкой данных не INT. Как исправить?
	--Так же вопрос по выборке по имени с различной начальной букве CTE.[COUNT_by NAME], как сделать фильтр?
