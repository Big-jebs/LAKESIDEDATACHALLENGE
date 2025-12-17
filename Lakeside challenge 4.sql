--Objective 4: Operational Efficiency
--Aim: Highlight inefficiencies in shipping and supplier performance.

SELECT * FROM Orders

select * from Shippers 

--AVERAGE SHIPING TIME BY SHIPPER

SELECT S.CompanyName ShipperCompany, S.ShipperID, DATEDIFF(DAY, O.OrderDate, O.ShippedDate) ShippingDays
FROM Orders O
JOIN Shippers S
ON O.ShipVia = S.ShipperID				--I first got the shipping Day, now lets get the avearge for each of the shipper company

SELECT S.CompanyName ShipperCompany, S.ShipperID, AVG(DATEDIFF(DAY, O.OrderDate, O.ShippedDate)) AvgShippingDays
FROM Orders O
JOIN Shippers S
ON O.ShipVia = S.ShipperID
GROUP BY S.CompanyName, S.ShipperID;


--Now lets get the Average Shipping days by Country
SELECT ShipCountry, AVG(DATEDIFF(DAY, O.OrderDate, O.ShippedDate)) AvgShippingDays
FROM Orders O
GROUP BY ShipCountry
ORDER BY AvgShippingDays



--Getting Percentage of Late shippments by Shippers
SELECT * FROM Orders
WHERE ShippedDate > RequiredDate

SELECT S.CompanyName ShipperCompany, 100.0 * COUNT(CompanyName) / COUNT(*) CompanyName
FROM Orders O
JOIN Shippers S
ON O.ShipVia = S.ShipperID
WHERE ShippedDate > RequiredDate
GROUP BY S.CompanyName									--THIS DIDN'T WORK

SELECT 
    S.CompanyName AS Shipper,
    100.0 * SUM(CASE WHEN O.ShippedDate > O.RequiredDate THEN 1 ELSE 0 END) 
         / COUNT(*) AS LateShipmentPercentage
FROM Orders O
JOIN Shippers S 
ON O.ShipVia = S.ShipperID
--WHERE O.ShippedDate IS NOT NULL
GROUP BY S.CompanyName;



--Getting Percentage of Late shippments by Country
SELECT O.ShipCountry,
	100.0 * SUM(CASE WHEN O.ShippedDate > O.RequiredDate THEN 1 ELSE 0 END) / COUNT(*) AS LateShipmentPercentage
FROM Orders O
JOIN Shippers S 
ON O.ShipVia = S.ShipperID
WHERE O.ShippedDate IS NOT NULL
GROUP BY O.ShipCountry
ORDER BY LateShipmentPercentage DESC;






