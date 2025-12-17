--Objective 2: Profitability & Cost Analysis
--Product Profitability Ranking

SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT ProductName, SUM((D.UnitPrice * Quantity * (1 - Discount) - (D.UnitPrice * Quantity))) GrossProfit
FROM [Order Details] D
JOIN Products P
ON D.ProductID = P.ProductID
GROUP BY ProductName
ORDER BY GrossProfit DESC

