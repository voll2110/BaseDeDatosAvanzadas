--Consultas Simples
use Northwnd;

--Seleccionar cada una de la tablas de la bd northwind

SELECT *
FROM Customers;
GO

SELECT *
FROM Employees;
GO

SELECT *
FROM Orders;
GO

SELECT *
FROM OrderDetails;
GO

SELECT * 
FROM Shippers;
GO

SELECT * 
FROM Suppliers;
GO

SELECT * 
FROM Products;
GO

-- Proyección de la tabla

SELECT ProductName, UnitsInStock, UnitPrice
FROM Products;

-- Alias de Columna

SELECT ProductName AS NombreProducto, 
UnitPrice 'Unidades Medida', 
UnitPrice AS [Precio Unitario]
FROM Products;

-- Campo calculado y Alias de tabla

SELECT 
		[Order Details].OrderID AS [NUMERO DE ORDEN], 
		Products.ProductID AS [NUMERO DE PRODUCTO],
		ProductName AS 'NOMBRE DE PRODUCTO', 
		Quantity CANTIDAD,
		Products.UnitPrice AS PRECIO, 
		(Quantity * [Order Details].UnitPrice) AS SUBTOTAL
FROM [Order Details]
INNER JOIN 
Products
ON Products.ProductID = [Order Details].ProductID;


SELECT 
		od.OrderID AS [NUMERO DE ORDEN], 
		pr.ProductID AS [NUMERO DE PRODUCTO],
		ProductName AS 'NOMBRE DE PRODUCTO', 
		Quantity CANTIDAD,
		od.UnitPrice AS PRECIO, 
		(Quantity * od.UnitPrice) AS SUBTOTAL
FROM [Order Details] AS od
INNER JOIN 
Products pr
ON pr.ProductID = od.ProductID;

--Operadores Relacionales (<, >, <=, >=, =, != o <>)
--Mostrar todos los productos con un precio mayor a 20
SELECT 
	ProductName AS [Nombre Producto], 
	QuantityPerUnit AS [Descripción],
	UnitPrice AS [Precio]
FROM Products
WHERE UnitPrice > 20;

--Seleccionar todos los clientes que no sean de Mexico
SELECT *
FROM Customers
WHERE Country <> 'Mexico';

--Seleccionar todas aquellas ordenes realizadas en  1997
SELECT 
	OrderID AS [Número de Orden], 
	OrderDate AS [Fecha de Orden],
	YEAR (OrderDate) AS [Año con Year],
	DATEPART (YEAR, OrderDate) AS [Año con DATEPART]
FROM Orders
WHERE YEAR(OrderDate) = 1997;

--Operadores Lógicos (AND OR NOT)
SELECT * FROM Products

SELECT 
	OrderID AS [Número de Orden], 
	OrderDate AS [Fecha de Orden],
	YEAR (OrderDate) AS [Año con Year],
	DATEPART (YEAR, OrderDate) AS [Año con DATEPART],
	DATEPART (QUARTER, OrderDate) AS Trimestre,
	DATEPART (WEEKDAY, OrderDate) AS [Dia Semana],
	DATENAME (WEEKDAY, OrderDate) AS [Nombre Dia Semana]
FROM Orders
WHERE YEAR(OrderDate) = 1997;

SET LANGUAGE Spanish
SELECT 
	OrderID AS [Número de Orden], 
	OrderDate AS [Fecha de Orden],
	YEAR (OrderDate) AS [Año con Year],
	DATEPART (YEAR, OrderDate) AS [Año con DATEPART],
	DATEPART (QUARTER, OrderDate) AS Trimestre,
	DATEPART (WEEKDAY, OrderDate) AS [Dia Semana],
	DATENAME (WEEKDAY, OrderDate) AS [Nombre Dia Semana]
FROM Orders
WHERE YEAR(OrderDate) = 1997;

--seleccionar los productos que tngan un precio mayor a 20y un stock mayor a 30
SELECT 
ProductID AS [Numero Producto],
ProductName AS [Nombre Prodcuto],
UnitsInStock AS[Existencia],
UnitPrice AS [Precio],
(UnitPrice * UnitsInStock) AS [Costo Inventario]
FROM Products
WHERE UnitPrice > 20
AND UnitsInStock>30;

-- SELECCIONAR A LOS CLIENTES DE ESTADOS UNIDOS O CANADA
SELECT 
CustomerID AS [ID],
City,
Region,
Country
FROM Customers
WHERE Country = 'USA' OR Country = 'Canada';
-- SELECCIONAR LOS CLIENTES DE Brazil, rio de jainero y que tengan region
SELECT 
CustomerID AS [ID],
City,
Region,
Country
FROM Customers
WHERE Country = 'Brazil' AND City = 'Rio de Janeiro ' AND Region IS NOT NULL;

--Operador IN 

--Seleccionar toddoos los clientes de USA Germany y FRANCH 
SELECT * 
FROM Customers
WHERE Country = 'USA'
OR Country = 'Germany'
OR Country = 'France'
ORDER BY Country;

--Seleccionar toddoos los clientes de USA Germany y FRANCH 
SELECT * 
FROM Customers
WHERE Country IN ('USA','Germany','France')
ORDER BY Country DESC;

--Seleccioanr los nombres de tres categorias especificas 
SELECT *
FROM Categories;

SELECT 
CategoryName AS [Nombre Categoria],
Description AS [Descripccion]
FROM Categories
WHERE CategoryName IN ('Produce','Seafood','Confections')
ORDER BY CategoryName DESC;
-- Seleccionar los pedidos de tres empkeados en especifico 
SELECT e.EmployeeID,
CONCAT(e.FirstName, e.LastName) AS Fullname,
o.OrderDate
FROM Orders AS o
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.EmployeeID IN (5,6,7)
ORDER BY 2 DESC;


SELECT *
FROM Employees
WHERE EmployeeID IN (5,6,7);
--SELECCIONAR QUE NO SEAN DE OTRO QUE NO SEA MEXICO ARGENTINA,ALEMANIA

SELECT *
FROM Customers
WHERE Country NOT IN ('Mexico','Argentina','Germany')
ORDER BY Country;

-- Seleccionar todos los productos que su precio este entre 10 y 30
SELECT ProductName,UnitPrice
FROM Products
WHERE UnitPrice >=10 
AND UnitPrice <=30
ORDER BY 2 DESC;

-- Seleccionar todos los productos que su precio este entre 10 y 30
SELECT ProductName,UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 10 AND 30
ORDER BY 2 DESC;

-- Seleccionar todas las ordenes de 1995 a 1997
SELECT *
FROM Orders
WHERE DATEPART (YEAR, OrderDate) BETWEEN 1995 AND 1997;



SELECT *
FROM Products
WHERE UnitPrice NOT BETWEEN 10 AND 20;

--OPERADOR LIKE 
-- WILDCARDS (%, _, [], [^])

--Seleccionar todos los clientes en donde su nombre commienze con 'a'

SELECT *
FROM Customers
WHERE CompanyName LIKE 'A%';


SELECT *
FROM Customers
WHERE CompanyName LIKE 'An%';

--SELECCIONAR TODOS LOS CLIENTES DE UNA CIUDAD QUE EMPIEZA CON 'L' SEGUIDO DE CUALQUIER CARACGTER DESPUES ND Y QUE TERMINE CON CUALQUIER CARACTERES CUAQUEIRA
SELECT *
FROM Customers
WHERE City LIKE 'L_nd__' -- whilcart 

--SELECCIONAR TODOS LO CLIENTES QUE SU NOMBRE TERMINEN CON A
SELECT *
FROM Customers
WHERE CompanyName LIKE '%a';

-- Devolver todos llo clIentess que en la ciudad contenga la letra L

SELECT CustomerID, CompanyName, City
FROM Customers
WHERE City LIKE '%la%';

-- DEVOLVER TODOS LOS CLIENTES QUE COIENZA CON A O COMIENZA CON B
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE 'a%' OR CompanyName LIKE 'b%';
GO

-- DEVOLVER TODOS LOS CLIENTES QUE COMIENZA CON B Y TERMINA CON S
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE 'b%s';
GO

-- Devolver todoos los clientes que comienzen con a y que tengan almens 3 caracteres de longitud
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE 'a__%';

-- Devolver todos los clientes que tienen r en la segunda posicion
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '_r%';

-- Devolver todos los clientes que contengan a ,b, c al inicio
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '[abc]%'

-- Devolver todos los clientes que no contengan ni A,B,C Al incio
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '[^abc]%'
-- O tambien
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName  NOT LIKE '[abc]%'

SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '[a-f]%'

-- Seleccionar todos los clientes de berlin mostrando solo los tres primeros
SELECT TOP 3 CustomerID, CompanyName, City , Country
FROM Customers
WHERE Country = 'USA';

-- Seleccionar todos los clientes ordenados de forma acendente por su numero de cliente pero saltando las primeras 5 filas (offset)
SELECT CustomerID, CompanyName, City , Country
FROM Customers
ORDER BY CustomerID ASC
OFFSET 5 ROWS;
-- Seleccionar todos los clientes ordenados de forma acendente por su numero de cliente pero saltando las primeras 5 filas y 
-- mostrar las siguientes 10(offset y FETCH)
SELECT CustomerID, CompanyName, City , Country
FROM Customers
ORDER BY CustomerID ASC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY;