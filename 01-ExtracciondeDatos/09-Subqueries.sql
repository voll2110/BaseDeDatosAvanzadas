CREATE DATABASE dbsubquer;


CREATE TABLE clientes (
	id_cliente int not null identity (1,1) primary key,
	nombre varchar (50)not null,
	ciudad varchar (50) not null
	
);

CREATE TABLE pedidos(
id_pedido int not null identity(1,1) primary key,
id_cliente int not null,
total money not null,
fecha date not null
CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
ON DELETE CASCADE

);

INSERT INTO clientes(nombre, ciudad) VALUES
('Ana', 'CDMX'),
('Luis', 'Guadalajara'),
('Marta', 'CDMX'),
('Pedro', 'Monterrey'),
('Sofia', 'Puebla'),
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz');


INSERT INTO pedidos(id_cliente,total,fecha) VALUES
(1, 1000.00, '2024-01-10'),
(1, 500.00,  '2024-02-10'),
(2, 300.00,  '2024-01-05'),
(3, 1500.00, '2024-03-01'),
(3, 700.00,  '2024-03-15'),
(1, 1200.00, '2024-04-01'),
(2, 800.00,  '2024-02-20'),
(3, 400.00,  '2024-04-10');

SELECT * FROM clientes;
SELECT * FROM pedidos;

-- Subconsulta

SELECT MAX (total)
FROM pedidos;

-- Consulta principal
SELECT *
FROM pedidos
WHERE total = (SELECT MAX (total)
FROM pedidos
);


SELECT TOP 1 *
FROM pedidos
ORDER BY total DESC
-- Seleccionar el cliente que hizo el pedido mas caro
-- Subconsulta
SELECT id_cliente
FROM pedidos
WHERE total = (SELECT MAX(total) FROM pedidos);

-- Consulta Principal
SELECT TOP 1 p.id_pedido, c.nombre, p.total, p.fecha
FROM  pedidos AS p 
INNER JOIN 
clientes AS c 
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente = (
SELECT id_cliente
FROM pedidos
WHERE total = (SELECT MAX (total) FROM PEDIDOS)
);
SELECT TOP 1 p.id_cliente, c.nombre, p.total,MAX (p.fecha)  AS [MAXIMO]
FROM pedidos AS p
INNER JOIN 
clientes AS c
ON p.id_cliente = c.id_cliente
GROUP BY p.id_pedido, c.nombre , p.total, p.fecha
ORDER BY TOTAL DESC;


-- Seleccionar los pedidos mayores al promedio
SELECT AVG(total)
FROM pedidos;

SELECT *
FROM pedidos
WHERE total>(SELECT AVG(total)
FROM pedidos
);
-- Mostrar el cliente con menor id
SELECT MIN(id_cliente)
FROM pedidos;

SELECT p.fecha,p.id_cliente
FROM pedidos AS p
INNER JOIN 
clientes AS c
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente= (SELECT MIN(id_cliente)
FROM pedidos
);
--Mostrar el ultimo pedido realizado
SELECT MAX(fecha)
FROM pedidos;

SELECT p.id_pedido, p.fecha, c.nombre , p.total
FROM pedidos AS p
INNER JOIN
clientes AS c
ON p.id_cliente = c.id_cliente
WHERE fecha = ( 
SELECT MAX(fecha)
FROM pedidos
);
--Mostrar el pedido con un total mas abajo

SELECT MIN(total)
FROM pedidos;

SELECT *
FROM pedidos
WHERE total = (SELECT MIN(total)
FROM pedidos
);

--Seleccionar  los pedidos con el nombre del clienre cuyo total de la carga (Freight) sea
-- Mayo al promedio general de Freight

SELECT AVG(Freight)
FROM Orders;

SELECT o.OrderID,
c.CompanyName,
o.Freight
FROM Orders AS o
INNER JOIN 
Customers AS c
ON o.CustomerID = c.CustomerID
WHERE o.Freight> (

SELECT AVG(Freight)
FROM Orders
)
ORDER BY Freight DESC;

--Clientes que ha ech pedidos

SELECT id_cliente
FROM pedidos;

SELECT * FROM  clientes 
WHERE id_cliente IN (
SELECT id_cliente 
FROM pedidos
);

SELECT DISTINCT c.id_cliente, c.nombre , c.ciudad
FROM clientes AS c
LEFT JOIN pedidos AS p
ON c.id_cliente = p.id_cliente;


-- SELECCIONAR clientes de CDMX que han echo pedidos
SELECT id_cliente
FROM clientes;

SELECT * 
FROM clientes
WHERE ciudad = 'CDMX'
AND id_cliente IN (SELECT id_cliente
FROM clientes
);
