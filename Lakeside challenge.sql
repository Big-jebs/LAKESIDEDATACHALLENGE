
select * from [Order Details]

select * from Orders


SELECT  D.OrderID, COUNT(D.OrderID) OrderNumber, SUM((Quantity * UnitPrice * (1 - Discount))) TotalRevenue 
FROM Orders O
JOIN [Order Details] D
ON O.OrderID = D.OrderID
GROUP BY D.OrderID;

SELECT YEAR(O.OrderDate)  Year, MONTH(O.OrderDate)  Month, SUM(D.Quantity * D.UnitPrice * (1 - D.Discount)) TotalRevenue, COUNT(DISTINCT O.OrderID) AS NumberOfOrders, SUM(D.Quantity * D.UnitPrice * (1 - D.Discount)) / COUNT(DISTINCT O.OrderID) AS AvgOrderValue
FROM Orders O
JOIN [Order Details] D
ON O.OrderID = D.OrderID
WHERE O.OrderDate BETWEEN '1996-01-01' AND '1998-12-31'
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
ORDER BY YEAR(O.OrderDate), MONTH(O.OrderDate);



SELECT * FROM Products

SELECT TOP 10 P.ProductName, C.CategoryName, SUM((D.Quantity * D.UnitPrice * (1 - D.Discount))) TotalRevenue, COUNT(D.Quantity) TotalQty
FROM [Order Details] D
JOIN Products P
ON D.ProductID = P.ProductID
JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY P.ProductName, C.CategoryName
ORDER BY TotalRevenue DESC;


SELECT * FROM Customers


SELECT TOP 10 C.CompanyName, C.Country, SUM((D.Quantity * D.UnitPrice * (1 - D.Discount))) TotalRevenue, COUNT( DISTINCT O.OrderID) NumberOfOrders
FROM [Order Details] D
JOIN Orders O
ON D.OrderID = O.OrderID
JOIN Customers C
ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName, C.Country
ORDER BY TotalRevenue DESC;


SELECT Title, HireDate, Country, SUM((D.Quantity * D.UnitPrice * (1 - D.Discount))) TotalRevenue
FROM [Order Details] D
JOIN Orders O
ON D.OrderID = O.OrderID
JOIN Employees E
ON O.EmployeeID = E.EmployeeID
GROUP BY Title, HireDate, Country
ORDER BY TotalRevenue DESC;