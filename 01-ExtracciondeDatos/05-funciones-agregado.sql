	/*
funciones de agregado
COUNT(*);
COUNT(CAMPO)
MAX()
MIN()
AVG()
SUM()

Nota: estas funciones por si sola generan un resultado escalar osea solo un registro

GROUP BY
HAVING
*/
SELECT *
FROM Orders;


SELECT COUNT(*) AS [Numero de Ordenes]
FROM Orders;

 SELECT COUNT(shipregion)
FROM Orders;

SELECT MAX(OrderDate) AS [Ultima Fecha de Compra]
FROM Orders;

SELECT MAX(UnitPrice) AS [Precio mas Alto]
FROM Products;

SELECT MIN(UnitsInStock) AS [Stock Minimo]
FROM Products;

-- total de ventas realizadas
SELECT *,(UnitPrice * Quantity - (1-Discount))AS [Importe]
FROM [Order Details]

-- total de ventas realizadas
SELECT
ROUND(SUM(UnitPrice * Quantity - (1-Discount)),5)
AS [Importe]
FROM [Order Details];
-- Seleccionar el promedio de ventas
SELECT
ROUND(AVG(UnitPrice * Quantity - (1-Discount)),5)
AS [Importe]
FROM [Order Details];


-- Seleccionar el numero de ordenes realizadas A alemania
SELECT *
FROM Orders;

SELECT * 
FROM Orders
WHERE ShipCountry = 'Germany';

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders
WHERE ShipCountry = 'Germany'
AND CustomerID ='LEHMS';


SELECT * 
FROM Customers;

-- Seleccionar la suma de las cantidades vendidas por cada ordenid(agrupada)
SELECT
OrderID,SUM(Quantity) AS [Total de Cantidades]
FROM [Order Details]
GROUP BY OrderID;


--Seleccionar el numero de productos por categoria
SELECT* 
FROM Categories

SELECT* 
FROM Products;

SELECT 
CategoryID, COUNT(ProductID) AS [Numero de Productos]
FROM Products
GROUP BY CategoryID;

SELECT 
c.CategoryName AS [Categoria], 
COUNT(*) AS [Numero de Productos]
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Beverages','Meat/Poultry')
GROUP BY c.CategoryName;


--Obtener el total de pedidos realizados por cada cliente

--Obtener el numero total de pedidos que a tenido cada empleado 
SELECT
e.FirstName,
e.LastName,
COUNT(*) AS [Total de Ordenes]
FROM Orders AS o
INNER JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName,
e.LastName
ORDER BY [TOTAL DE ORDENES] DESC;


SELECT
CONCAT( e.FirstName,' ',e.LastName)AS [Nombre Completo],
COUNT(*) AS [Total de Ordenes]
FROM Orders AS o
INNER JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName,
e.LastName
ORDER BY [TOTAL DE ORDENES] DESC;
--ventas totales por producto

SELECT od.ProductId, ROUND(SUM(od.Quantity * od.UnitPrice * (1- Discount)), 2) AS [Ventas Totales]
FROM [Order Details] as od
WHERE ProductID IN (10,2,6)
GROUP BY od.ProductID;

SELECT p.ProductName, ROUND(SUM(od.Quantity * od.UnitPrice * (1- Discount)), 2) AS [Ventas Totales]
FROM [Order Details] as od
INNER JOIN Products AS p
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY 2 DESC;

SELECT* 
FROM Orders

select * 
from [Order Details]
--Calcular cuntos pedidos se realizaron por año
SELECT DATEPART(YY, OrderDate),COUNT(*) AS [Numero de Pedidos]
FROM Orders
GROUP BY DATEPART(YY, OrderDate);
-- Cuantos productos ofrece cada provedor

SELECT s.CompanyName AS [Proveedor],
COUNT(*) AS [Numero Product]
FROM Products as p
INNER JOIN Suppliers AS s
ON p.SupplierID = s.SupplierID
GROUP BY s.CompanyName
ORDER BY 2 DESC;
--seleccionar el numero de pedidos por cliente que hayan realizado mas de 10 
SELECT c.CompanyName[Cliente] ,COUNT(*) AS [Numero de pedidos]
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(*)>10;

--seleccionar lo empleados que hayan gestionado pedidos por un total superior a 10000 a ventas 
--(Mostrar el ID del empleado, el nombre y total de compras)
SELECT
o.EmployeeID AS [Nombre Empleado]
,CONCAT(e.FirstName,' ' , e.LastName) AS [Nombre Completo],
ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.discount)),2) AS [Total Ventas]
FROM [Order Details] AS od
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
INNER JOIN  Employees AS e
ON e.EmployeeID = o.EmployeeID
GROUP BY o.EmployeeID, e.FirstName, e.LastName;