/*
Una vista (view) una tabla virtual basada en una consulta.
Sirve para reutilizar logica, simplificar consultas y controlar
acceso.

Existen dos tios de vista:
-Vista Almacenada
-Vistas Materializadas (SQL SERVER Vistas Indexadas)

Sintaxis:

- 

CREATE OR ALTER VIEW vw_nombre
AS 
DEFINICION DE LA VISTA


*/
use dbexercices;
-- Seleccionar toda la ventas por cliente
-- Fecha e venta 

-- Buenas practicas:
-- Nombre de las vistas vw_
-- Evitar el SELECT *	dentro de la vista
-- Si se necesita ordenar hazlo al consultaqr la vista 


CREATE VIEW vw_ventas_totales
AS
SELECT 
v.VentaId,
v.ClienteId,
v.FechaVenta,
v.Estado,
SUM (dv.Cantidad* dv.PrecioUnit * (1-dv.Descuento/100)) AS [Total]
FROM Ventas AS v
INNER JOIN DetalleVenta AS dv
ON v.VentaId = dv.VentaId
GROUP BY v.VentaId,
v.ClienteId,
v.FechaVenta,
v.Estado ;
GO

--Trabajar con la vista 

SELECT vt.VentaId, 
vt.ClienteId,
c.Nombre,
total,
DATEPART(MONTH, FechaVenta) AS [MES]
FROM vw_ventas_totales AS vt
INNER JOIN Clientes AS c
ON vt.ClienteId = c.ClienteId
WHERE DATEPART(MONTH,FechaVenta) = 01
AND Total >= 3130;

-- Realizar una vista que se llame vw_detalle_extendido 
-- que muestre la ventaid , cliente(Nombre) , producto,
--Categoria (nombre), cantidad vendida, precio de la venta, descuento
-- y  total de cada transaccion

-- En la vista seleccionar 50 lineas ordenadas por la ventaid de forma acendente

SELECT * 
FROM Clientes;

SELECT *
FROM Ventas;

SELECT * 
FROM Productos;

SELECT *
FROM DetalleVenta AS dv;
INNER JOIN |