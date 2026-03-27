use NORTHWND;

SELECT TOP 0 CategoryID, CategoryName
INTO categoriesnew
FROM Categories;

ALTER TABLE categoriesnew
ADD CONSTRAINT pk_categories_new
PRIMARY KEY (Categoryid);

SELECT TOP 0 productid, ProductName, CategoryID
INTO productsnew
FROM Products;

ALTER TABLE productsnew
ADD CONSTRAINT pk_products_new
PRIMARY KEY (productid);

ALTER TABLE productsnew
ADD CONSTRAINT pk_products_categories2
FOREIGN KEY (Categoryid)
REFERENCES categoriesnew(Categoryid)
ON DELETE CASCADE;

INSERT INTO categoriesnew
VALUES
('C1'),
('C2'),
('C3'),
('C4');

INSERT INTO productsnew
VALUES
('P1', 1),
('P2', 1),
('P3', 2),
('P4', 2),
('P5', 4),
('P6', NULL);

SELECT *
 FROM categoriesnew;

SELECT *
FROM productsnew;

SELECT *
FROM categoriesnew AS c
INNER JOIN 
productsnew AS p
ON p.CategoryID=c.CategoryID;

SELECT *
FROM categoriesnew AS c
LEFT JOIN 
productsnew AS p
ON p.CategoryID=c.CategoryID;

SELECT *
FROM categoriesnew AS c
LEFT JOIN 
productsnew AS p
ON p.CategoryID=c.CategoryID
WHERE ProductID is NULL;

SELECT *
FROM categoriesnew AS c
RIGHT JOIN 
productsnew AS p
ON p.CategoryID=c.CategoryID;

SELECT *
FROM productsnew AS p
LEFT JOIN 
categoriesnew AS c
ON p.CategoryID=c.CategoryID;

SELECT *
FROM productsnew AS p
LEFT JOIN 
categoriesnew AS c
ON p.CategoryID=c.CategoryID
WHERE c.CategoryID is NULL;

SELECT CategoryID AS [Numero de la Categoria],
CategoryName AS[Nombre],
[Description] AS [Descripcion]
FROM Categories;


SELECT TOP 0 
CategoryID AS [Numero de la Categoria],
CategoryName AS[Nombre],
[Description] AS [Descripcion]
INTO categoriesnuevas
FROM Categories;

ALTER TABLE categoriesnuevas
ADD CONSTRAINT pk_categorias_nuevas
PRIMARY KEY ([Numero de la Categoria]);

SELECT *
FROM categoriesnuevas;

INSERT INTO Categories
VALUES ('Ropa', 'Ropa de Paca',NULL),
('Linea Blanca','Ropá de Robin', NULL);

SELECT *
FROM Categories AS c
INNER JOIN categoriesnuevas AS cn
ON c.CategoryID = cn.[Numero de la Categoria];


SELECT *
FROM Categories AS c
LEFT JOIN categoriesnuevas AS cn
ON c.CategoryID = cn.[Numero de la Categoria];

SELECT *
FROM Categories;

SELECT*
FROM categoriesnuevas;

INSERT INTO categoriesnuevas
SELECT C.CategoryName,C.Description
FROM Categories AS c
LEFT JOIN categoriesnuevas AS cn
ON c.CategoryID = cn.[Numero de la Categoria]
WHERE cn.[Numero de la Categoria] IS NULL;

INSERT INTO Categories
VALUES ('Bebidas', 'Bebidas Corrientes',NULL),
('Deportes','Para los que pierden', NULL);

SELECT C.CategoryName,C.Description
FROM Categories AS c
LEFT JOIN categoriesnuevas AS cn
ON c.CategoryID = cn.[Numero de la Categoria]
WHERE cn.[Numero de la Categoria] IS NULL;

DELETE FROM categoriesnuevas;

INSERT INTO categoriesnuevas
SELECT 
UPPER (c.CategoryName) AS [Categories],UPPER(CAST(c.Description AS varchar)) AS [Descripccion]
FROM Categories AS c
LEFT JOIN categoriesnuevas AS cn
ON c.CategoryID = cn.[Numero de la Categoria]
WHERE cn.[Numero de la Categoria] IS NULL;

SELECT *
FROM Categories AS c
INNER JOIN categoriesnuevas AS cn
ON c.CategoryID =cn.[Numero de la Categoria];

DELETE categoriesnuevas;

--Reiniciar los identity ( Cuando las tablas tienen integridad referencial, sin usar truncate
DBCC CHECKIDENT ('categoriesnuevas', RESEED , 0);

-- El tuncate elimina los datos de la tabloa al igual que el deletew pero solomante funciona si no tiene integridad referencial, y ademas reinicia los identity
TRUNCATE TABLE categoriesnuevas;

-- FULL JOIN
SELECT *FROM
categoriesnew AS c
FULL JOIN 
productsnew AS p
ON c.CategoryID = p.CategoryID;

--Croos Join
SELECT * FROM
categoriesnew AS c
CROSS JOIN
productsnew AS p ;