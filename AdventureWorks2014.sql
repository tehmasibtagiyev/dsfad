use AdventureWorks2014

-- Question 1
SELECT HumanResources.Employee.JobTitle AS BBB
FROM HumanResources.Employee
ORDER BY BBB ASC

SELECT HumanResources.Employee.JobTitle,
COUNT(HumanResources.Employee.JobTitle)
FROM HumanResources.Employee
GROUP BY HumanResources.Employee.JobTitle
	
-- Question 2
SELECT * FROM Person.Person 
ORDER BY Person.Person.LastName 

-- Question 3
SELECT Person.FirstName, Person.LastName, Person.BusinessEntityID 
AS Employee_Id FROM Person.Person
ORDER BY Person.LastName ASC

-- Question 4
SELECT Production.Product.ProductID, Production.Product.ProductNumber, 
Production.Product.Name
FROM Production.[Product] WHERE Production.Product.ProductLine LIKE 'T%' 
AND Production.Product.SellStartDate IS NOT NULL
ORDER BY Production.Product.Name

-- Question 5
SELECT Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.CustomerID
,Sales.SalesOrderHeader.OrderDate, Sales.SalesOrderHeader.SubTotal,
(Sales.SalesOrderHeader.TaxAmt / Sales.SalesOrderHeader.SubTotal) * 100 AS Tax_Percentage
FROM Sales.SalesOrderHeader
ORDER BY Sales.SalesOrderHeader.SubTotal DESC

-- Question 6
SELECT DISTINCT HumanResources.Employee.JobTitle FROM HumanResources.Employee
ORDER BY HumanResources.Employee.JobTitle ASC

-- Question 7
SELECT Sales.SalesOrderHeader.CustomerID, SUM(Sales.SalesOrderHeader.Freight)
FROM Sales.SalesOrderHeader
GROUP BY Sales.SalesOrderHeader.CustomerID
ORDER BY Sales.SalesOrderHeader.CustomerID ASC

SELECT CustomerID FROM Sales.SalesOrderHeader

-- Question 8
SELECT Sales.SalesOrderHeader.CustomerID,
Sales.SalesOrderHeader.SalesPersonID,
AVG(Sales.SalesOrderHeader.SubTotal), 
SUM(Sales.SalesOrderHeader.Subtotal)
FROM Sales.SalesOrderHeader
GROUP BY Sales.SalesOrderHeader.CustomerID, Sales.SalesOrderHeader.SalesPersonID 
ORDER BY Sales.SalesOrderHeader.CustomerID DESC

-- Question 9
SELECT Production.ProductInventory.ProductID,
SUM(Production.ProductInventory.Quantity)
FROM Production.ProductInventory 
WHERE Production.ProductInventory.Shelf IN('A', 'C', 'H')
GROUP BY Production.ProductInventory.ProductID
HAVING SUM(Production.ProductInventory.Quantity) > 500
ORDER BY Production.ProductInventory.ProductID ASC

-- Question 10
SELECT SUM(Production.ProductInventory.Quantity)
FROM Production.ProductInventory
GROUP BY Production.ProductInventory.LocationID

-- Question 11
SELECT ph.BusinessEntityID,
pp.FirstName,
pp.LastName,
ph.PhoneNumber
FROM Person.PersonPhone ph 
JOIN Person.Person pp
ON ph.BusinessEntityID = pp.BusinessEntityID
WHERE pp.LastName LIKE 'Lal%'
ORDER BY pp.FirstName, pp.LastName

-- Question 12
SELECT Sales.SalesOrderHeader.SalesPersonID,
Sales.SalesOrderHeader.CustomerID,
SUM(Sales.SalesOrderHeader.Subtotal)
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP(Sales.SalesOrderHeader.SalesPersonID, Sales.SalesOrderHeader.CustomerID)
ORDER BY Sales.SalesOrderHeader.SalesPersonID, Sales.SalesOrderHeader.CustomerID

-- Question 13
SELECT Production.ProductInventory.LocationID, 
Production.ProductInventory.Shelf,
SUM(Production.ProductInventory.Quantity)
FROM Production.ProductInventory
GROUP BY CUBE(Production.ProductInventory.Shelf, Production.ProductInventory.LocationID)

-- Question 14
SELECT Production.ProductInventory.LocationID, 
Production.ProductInventory.Shelf,
SUM(Production.ProductInventory.Quantity)
FROM Production.ProductInventory
GROUP BY GROUPING SETS (ROLLUP(LocationID, Shelf), CUBE(LocationID, Shelf))

-- Question 15
SELECT LocationID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY GROUPING SETS ( locationid,())

SELECT EmailAddressID, EmailAddress FROM Person.EmailAddress
ORDER BY EmailAddressID ASC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

SELECT COALESCE(Sales.SalesTaxRate.[Name],' Total'),
SUM(Sales.SalesTaxRate.TaxRate)
FROM Sales.SalesTaxRate
GROUP BY ROLLUP(Sales.SalesTaxRate.[Name])

SELECT EmailAddressID as b, 
EmailAddress 
FROM Person.EmailAddress
ORDER BY b DESC
OFFSET 10 ROW
FETCH NEXT 5 ROWS ONLY

-- QUESTION 1
SELECT sso.SalesOrderID, 
sso.OrderDate, 
sso.TotalDue AS td 
FROM Sales.SalesOrderHeader AS sso
ORDER BY td DESC

SELECT Freight FROM Sales.SalesOrderHeader

-- QUESTION 2
SELECT hre.BusinessEntityID,
hre.JobTitle,
hre.HireDate AS hd,
hre.SalariedFlag AS sf
FROM HumanResources.Employee AS hre
ORDER BY sf DESC, hd ASC

-- QUESTION 3
SELECT so.SalesOrderID AS sld,
SUM(so.LineTotal) AS lt
FROM Sales.SalesOrderDetail AS so
GROUP BY so.SalesOrderID
ORDER BY lt DESC

SELECT COUNT(DISTINCT SalesOrderID) FROM Sales.SalesOrderDetail

SELECT TOP(5) * FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC

SELECT TOP(10) 
BusinessEntityID, 
HireDate 
FROM HumanResources.Employee
ORDER BY HireDate DESC

SELECT TOP(5) ProductID, 
[Name],
ListPrice
FROM Production.[Product]
ORDER BY ListPrice DESC

-- QUESTION 1 => AND
SELECT BusinessEntityID,
JobTitle,
HireDate,
SalariedFlag
FROM HumanResources.Employee
WHERE SalariedFlag = 1 AND YEAR(HireDate) > 2009-01-01

SELECT SalesOrderID,
OrderDate,
TotalDue,
OnlineOrderFlag
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1 AND TotalDue > 3500

-- QUESTION 2 => OR
SELECT BusinessEntityID,
JobTitle,
SalariedFlag
FROM HumanResources.Employee

SELECT AVG(TotalDue), SUM(TotalDue) FROM Sales.SalesOrderHeader

-- QUESTION 3 => BETWEEN
SELECT BusinessEntityID,
HireDate
FROM HumanResources.Employee
WHERE YEAR(HireDate) BETWEEN 2010 AND 2014

SELECT SalesOrderID,
TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue BETWEEN 1000 AND 5000

-- QUESTION 4 => IN
SELECT * FROM HumanResources.Employee
WHERE JobTitle 
IN('Research and Development Manager', 
'Chief Executive Officer', 
'Marketing Assistant')

SELECT * FROM Sales.SalesOrderHeader
WHERE TerritoryID IN (1, 3, 5)

-- QUESTION 5 => LIKE
SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager'

SELECT * FROM Production.Product
WHERE Name LIKE '%Crankarm'

SELECT LEN(AddressLine1) FROM Person.Address
SELECT UPPER(rowguid) FROM Person.Address
SELECT LOWER(rowguid) FROM Person.Address
--------
SELECT AddressID, TRIM('[1,9,5]%' FROM AddressLine1) FROM Person.Address
ORDER BY AddressID ASC
--------
SELECT AddressID, SUBSTRING(rowguid, 1, 3) FROM Person.Address
ORDER BY AddressID
--------
-- CONCAT
SELECT AddressID, 
CONCAT(AddressLine1,'-',City,'-',PostalCode) 
FROM Person.Address
ORDER BY AddressID
--CONCAT_WS
SELECT AddressID,
CONCAT_WS(' ',AddressLine1, City, PostalCode)
FROM Person.Address
ORDER BY AddressID
--------
SELECT AddressID,
REPLACE(rowguid, 'A', '$')
FROM Person.Address
ORDER BY AddressID
--------
SELECT TRY_CAST(SpatialLocation AS NVARCHAR) 
FROM Person.Address

SELECT CONVERT(VARCHAR, PostalCode) FROM Person.Address
--------
SELECT * FROM Person.Address



SELECT BusinessEntityID, 
HireDate 
FROM HumanResources.Employee WITH(NOLOCK)
ORDER BY BusinessEntityID ASC

SELECT SalesPersonID,
rowguid, 
PurchaseOrderNumber,
TerritoryID,
AVG(SubTotal) OVER(PARTITION BY TerritoryID) AS Avg_Salary
FROM Sales.SalesOrderHeader
ORDER BY SalesPersonID ASC

SELECT AVG(SubTotal) FROM Sales.SalesOrderHeader WHERE TerritoryID = 5

SELECT TerritoryID,
AVG(SubTotal)
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID

SELECT * FROM Sales.SalesOrderHeader

--====================================
SELECT SalesOrderID,
CustomerID,
TotalDue,
SUM(TotalDue) OVER() AS CustomerTotalsSum
FROM Sales.SalesOrderHeader
ORDER BY CustomerID

SELECT 
SUM(TotalDue) 
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
CustomerID,
TotalDue,
AVG(TotalDue) OVER(PARTITION BY CustomerID) AS Avf_Of_TotalDue
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
COUNT(*) OVER(PARTITION BY CustomerID) AS Count_Of_Customer
FROM Sales.SalesOrderHeader
ORDER BY CustomerID

SELECT CustomerID,
SUM(TotalDue)
FROM Sales.SalesOrderHeader
GROUP BY CustomerID

SELECT SalesOrderID,
CustomerID,
TotalDue,
SUM(TotalDue) OVER(PARTITION BY CustomerID) AS Sum_Of_TotalDue,
(TotalDue / SUM(TotalDue) OVER(PARTITION BY CustomerID)) * 100 AS OrderContrbute
FROM Sales.SalesOrderHeader	

SELECT SUM(TotalDue) FROM Sales.SalesOrderHeader


SELECT SalesOrderID,
OrderDate,
CustomerID,
SUM(TotalDue) OVER()
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
CustomerID,
ROW_NUMBER() OVER(PARTITION BY CustomerID 
ORDER BY OrderDate) OrderDate_Of_Sequence
FROM Sales.SalesOrderHeader

SELECT CustomerID,
OrderDate,
TaxAmt,
SalesOrderID,
ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC)
FROM Sales.SalesOrderHeader

SELECT SalesOrderID FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID

SELECT * FROM Sales.SalesOrderHeader

SELECT SalesPersonID,
ROW_NUMBER() OVER(PARTITION BY SalesPersonID ORDER BY TerritoryID DESC)
FROM Sales.SalesOrderHeader

SELECT SalesPersonID,
DENSE_RANK() OVER(PARTITION BY SalesPersonID ORDER BY TerritoryID)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID = 279

SELECT SalesPersonID, 
TerritoryID 
FROM Sales.SalesOrderHeader 
WHERE SalesPersonID = 279

SELECT CustomerID, SubTotal FROM Sales.SalesOrderHeader
ORDER BY CustomerID

SELECT ShipMethodID, SubTotal FROM Sales.SalesOrderHeader
ORDER BY ShipMethodID, SubTotal

SELECT ShipMethodID,
DENSE_RANK() OVER(PARTITION BY ShipMethodID ORDER BY Subtotal)
FROM Sales.SalesOrderHeader

SELECT CustomerID,
MAX(TotalDue) OVER(PARTITION BY CustomerID)
FROM Sales.SalesOrderHeader

SELECT CustomerID,
MAX(TotalDue)
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID

SELECT CustomerID,
SalesOrderID,
OrderDate,
TaxAmt
FROM Sales.SalesOrderHeader

SELECT OrderDate,
TaxAmt,
SUM(TaxAmt) OVER(PARTITION BY OrderDate)
FROM Sales.SalesOrderHeader



SELECT * FROM Production.[Product]
SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory

SELECT SalesOrderID,
ProductID,
LineTotal,
COUNT(LineTotal) OVER(PARTITION BY ProductID)
FROM Sales.SalesOrderDetail

SELECT TOP(3) pp.ProductID,
pp.[Name] AS Product_Name, 
ppc.[Name] AS Product_CategoryName,
ppsc.[Name] AS Product_SubCategoryName,
ppsc.ProductSubcategoryID,
ppc.ProductCategoryID,
sso.LineTotal,
COUNT(pp.ProductID) OVER(PARTITION BY ppc.[Name]) AS For_EveryProduct
FROM Production.[Product] pp
JOIN Production.ProductSubcategory ppsc
ON pp.ProductSubcategoryID = ppsc.ProductSubcategoryID
JOIN Production.ProductCategory ppc
ON ppc.ProductCategoryID = ppsc.ProductCategoryID
JOIN Sales.SalesOrderDetail sso
ON sso.ProductID = pp.ProductID

SELECT 
    Il,
    SalesPersonID,
    AdSoyad,
    UmumiSatis,
    Sira
FROM 
(
    SELECT 
        YEAR(SOH.OrderDate) AS Il,
        SOH.SalesPersonID,
        P.FirstName + ' ' + P.LastName AS AdSoyad,
        SUM(SOH.TotalDue) AS UmumiSatis,
        CUME_DIST() OVER (PARTITION BY YEAR(SOH.OrderDate) ORDER BY SUM(SOH.TotalDue) DESC) AS Sira
    FROM Sales.SalesOrderHeader SOH
    INNER JOIN Person.Person P ON SOH.SalesPersonID = P.BusinessEntityID
    WHERE SOH.SalesPersonID IS NOT NULL
    GROUP BY YEAR(SOH.OrderDate), SOH.SalesPersonID, P.FirstName, P.LastName
) AS IllikSatislar
WHERE Sira <= 5
ORDER BY Il, Sira


SELECT pp.ProductID,
pp.[Name],
pp.ProductSubCategoryID,
MAX(sso.LineTotal) OVER(PARTITION BY pp.ProductSubCategoryID)
FROM Production.[Product] pp
JOIN Sales.SalesOrderDetail sso
ON pp.ProductID = sso.ProductID
WHERE pp.ProductID = 712

SELECT * FROM Sales.SalesOrderDetail 
SELECT * FROM Production.[Product]

SELECT sp.BusinessEntityID,
sp.SalesYTD,
NTILE(2) OVER(ORDER BY sp.SalesYTD DESC) AS SalesGroup
FROM Sales.SalesPerson sp

SELECT * FROM Sales.SalesOrderHeader

SELECT TerritoryID FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
TerritoryID,
CustomerID,
ROW_NUMBER() OVER(PARTITION BY TerritoryID ORDER BY CustomerID) AS Total_Customer
FROM Sales.SalesOrderHeader


SELECT SalesOrderID,
OrderDate,
TerritoryID,
CustomerID,
RANK() OVER(PARTITION BY TerritoryID ORDER BY CustomerID) AS Total_Customer
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
TerritoryID,
CustomerID,
DENSE_RANK() OVER(PARTITION BY TerritoryID ORDER BY CustomerID) AS Total_Customer
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
TerritoryID,
CustomerID,
NTILE(10) OVER(PARTITION BY TerritoryID ORDER BY CustomerID) AS Total_Customer
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,
OrderDate,
TerritoryID,
CustomerID,
LEAD(TerritoryID, 1, 8) OVER(PARTITION BY TerritoryID ORDER BY CustomerID) AS Total_Customer
FROM Sales.SalesOrderHeader

--------------------------------------------------
-- Case When

SELECT CustomerID,
CreditCardID,
OrderDate,
CASE
    WHEN TotalDue > 20000 THEN 'Good'
	WHEN TotalDue = 20000 THEN 'Normal'
	ELSE 'Money is decrease'
END AS BB
FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderHeader

----------------------------------
-- CTE
WITH Sales_CTE (SalesOrderID, TotalDue) AS (
SELECT SalesOrderID, 
TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue >= 20000
)	
SELECT * FROM Sales_CTE

SELECT 
    c.CategoryName,
    p.ProductName,
    p.Sales
FROM (
    SELECT 
        CategoryID,
        MAX(Sales) AS MaxSales
    FROM (
        SELECT 
            ProductID,
            CategoryID,
            SUM(Quantity) AS Sales
        FROM Sales.SalesOrderDetail
        GROUP BY ProductID, CategoryID
    ) AS ProductSales
    GROUP BY CategoryID
) AS MaxCategorySales
JOIN (
    SELECT 
        ProductID,
        ProductName,
        CategoryID,
        SUM(Quantity) AS Sales
    FROM OrderDetails
    GROUP BY ProductID, CategoryID
) AS p 
ON MaxCategorySales.CategoryID = p.CategoryID 
   AND MaxCategorySales.MaxSales = p.Sales
JOIN Categories c ON p.CategoryID = c.CategoryID

--Question 1
SELECT * FROM Production.ProductCategory
SELECT * FROM Production.Product 
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Sales.SalesOrderDetail WHERE ProductID = 825

SELECT SUM(sso.OrderQty) FROM Production.Product pr
JOIN Production.ProductSubcategory pps
ON pps.ProductSubcategoryID = pr.ProductSubcategoryID
JOIN Production.ProductCategory ppc
ON ppc.ProductCategoryID = pps.ProductCategoryID
JOIN Sales.SalesOrderDetail sso
ON sso.ProductID = pr.ProductID
WHERE pr.ProductID = 706

SELECT * FROM Production.Product




WITH ProductSales AS (
    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        pc.ProductCategoryID,
        SUM(sod.OrderQty) AS TotalOrderQty,
        SUM(sod.LineTotal) AS TotalLineTotal
    FROM Sales.SalesOrderDetail sod
    JOIN Production.Product p 
	ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory psc 
	ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN Production.ProductCategory pc 
	ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY p.ProductID, p.Name, pc.ProductCategoryID
),
CategoryStats AS (
    SELECT 
        pc.ProductCategoryID,
        pc.Name AS CategoryName,
        SUM(ps.TotalOrderQty) AS TotalCategoryQty,
        SUM(ps.TotalLineTotal) AS TotalCategoryAmount,
        AVG(ps.TotalLineTotal) AS AvgCategoryAmount
    FROM ProductSales ps
    JOIN Production.ProductCategory pc 
	ON ps.ProductCategoryID = pc.ProductCategoryID
    GROUP BY pc.ProductCategoryID, pc.Name
),
TopProductPerCategory AS (
    SELECT 
        ps.ProductCategoryID,
        ps.ProductName,
        ps.TotalLineTotal,
        ROW_NUMBER() OVER (PARTITION BY ps.ProductCategoryID ORDER BY ps.TotalLineTotal DESC) AS Ranek
    FROM ProductSales ps
)
SELECT 
    cs.CategoryName,
    cs.TotalCategoryQty AS UmumiSatisMiqdari,
    cs.TotalCategoryAmount AS UmumiSatisMeblegi,
    cs.AvgCategoryAmount AS OrtalamaSatisMeblegi,
    tpp.ProductName AS EnCoxSatilanMehsul
FROM CategoryStats cs
JOIN TopProductPerCategory tpp 
ON cs.ProductCategoryID = tpp.ProductCategoryID
WHERE tpp.Ranek = 1
ORDER BY cs.CategoryName




WITH ProductSales AS 
(
    SELECT pc.ProductCategoryID,
	pp.ProductID,
    SUM(ss.OrderQty) AS TotalOrderQty,
    SUM(ss.LineTotal) AS TotalLineTotal,
	MAX(ss.LineTotal) AS MaxLineTotal
    FROM Sales.SalesOrderDetail ss
	JOIN Production.Product pp
	ON pp.ProductID = ss.ProductID
	JOIN Production.ProductSubcategory ppsc
	ON pp.ProductSubcategoryID = ppsc.ProductSubcategoryID
	JOIN Production.ProductCategory pc
	ON ppsc.ProductCategoryID = pc.ProductCategoryID
	GROUP BY pp.ProductID, pc.ProductCategoryID
),
CategoryEdit AS
(
	SELECT psl.ProductCategoryID,
	ppc.[Name],
	SUM(psl.TotalOrderQty) AS TotalQty,
	SUM(psl.TotalLineTotal) AS SubLineTotal,
	AVG(psl.TotalLineTotal) AS AvgTotalLine
	FROM ProductSales psl 
	JOIN Production.ProductCategory ppc
	ON psl.ProductCategoryID = ppc.ProductCategoryID
	GROUP BY psl.ProductCategoryID, ppc.[Name]
),
NameOfTheCategory AS
(
	SELECT ce.ProductCategoryID
	FROM CategoryEdit ce
)
SELECT * FROM NameOfTheCategory



SELECT pp.ProductID,
pp.[Name],
MAX(ss.LineTotal) OVER(PARTITION BY pc.ProductCategoryID)
FROM Sales.SalesOrderDetail ss
JOIN Production.Product pp
ON pp.ProductID = ss.ProductID
JOIN Production.ProductSubcategory pb
ON pb.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory pc
ON pc.ProductCategoryID = pb.ProductCategoryID



SELECT ss.ProductID, 
pp.[Name],
MAX(ss.LineTotal) OVER(PARTITION BY pc.ProductCategoryID)
FROM Sales.SalesOrderDetail ss
JOIN Production.Product pp 
ON pp.ProductID = ss.ProductID 
JOIN Production.ProductSubcategory prs
ON prs.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory pc
ON pc.ProductCategoryID = prs.ProductCategoryID
GROUP BY pp.ProductID, 
ss.ProductID, 
pp.[Name], 
pc.ProductCategoryID,
prs.ProductSubcategoryID,
pp.ProductSubcategoryID
ORDER BY pp.ProductID, ss.ProductID























































