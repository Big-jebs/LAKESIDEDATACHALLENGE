--Objective 3: Market Segmentation
--Aim: Identify geographic performance.
--SALES PERFORMANCE BY COUNTRY AND REGION

SELECT Country, Region, SUM((D.Quantity * D.UnitPrice * (1 - D.Discount))) TotalRevenue, COUNT(DISTINCT C.CustomerID) NumberOfCustomers, COUNT(DISTINCT O.OrderID) NumberOfOrders, SUM((D.Quantity * D.UnitPrice * (1 - D.Discount))) / NULLIF(COUNT(DISTINCT O.OrderID), 0) AvgOrderValue,
SUM(
        CASE WHEN YEAR(O.OrderDate) = 1996 
        THEN D.Quantity * D.UnitPrice * (1 - D.Discount) 
        END
    ) AS Revenue1996,

    -- Revenue in 1997
    SUM(
        CASE WHEN YEAR(O.OrderDate) = 1997 
        THEN D.Quantity * D.UnitPrice * (1 - D.Discount) 
        END
    ) AS Revenue1997,

    -- YoY Growth %
    (
        (
            SUM(CASE WHEN YEAR(O.OrderDate) = 1997 
                     THEN D.Quantity * D.UnitPrice * (1 - D.Discount) END)
            -
            SUM(CASE WHEN YEAR(O.OrderDate) = 1996 
                     THEN D.Quantity * D.UnitPrice * (1 - D.Discount) END)
        )
        /
        NULLIF(
            SUM(CASE WHEN YEAR(O.OrderDate) = 1996 
                     THEN D.Quantity * D.UnitPrice * (1 - D.Discount) END),
            0
        ) * 100
    ) AS YoYGrowthPercent
FROM [Order Details] D
JOIN Orders O
ON D.OrderID = O.OrderID
JOIN Customers C
ON O.CustomerID = C.CustomerID
GROUP BY Country, Region


select * from [Order Details]