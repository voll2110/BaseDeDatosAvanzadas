# Subqueries (Subconsultas)

Una Subconsulta anidada dentro de otra consulta que
permite resolver problemas en varios niveles de informavcion.

Dependiendo de donde se coloque y que retorne , cambia su comportamiento 

**Clasificacion**

1. Subconsultas escalares
2. Subconsultas con IN, ANY , ALL
3. Subconsultas en SELECT 
5. Subconsultas FROM (Tablas derivadas)

## Escalares
Devuelven un unico valor , es por ello que pueden utilizar operadores =,<,>

EJEMPLO:
```sql
SELECT *
FROM pedidos
WHERE total = (SELECT MAX (total)
FROM pedidos
);
```
Orden de ejecucion:

1. Se ejecuta la subconsulta
2. Devuelve 1500
3. La consulta principal ejecuta ese valor

# Subconsultas de una columna (IN, ANY, ALL)

**Instruccion IN**
```sql
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

-- Seleccionar los pedidos de los clientes que viven en la ciudad de mexico

SELECT *
FROM clientes
WHERE ciudad = 'CDMX';


--Consulta Principal
SELECT p.id_cliente,c.ciudad,p.fecha,c.nombre,p.total
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente=c.id_cliente
WHERE p.id_cliente IN (
SELECT id_cliente
FROM clientes
WHERE ciudad = 'CDMX'
);

--Seleccionaaar todos aquellos cliuentes que no han echo pedidos
SELECT id_cliente
FROM pedidos;;

--principal
SELECT *
FROM clientes
WHERE id_cliente NOT IN (
SELECT id_cliente
FROM pedidos
);

SELECT *
FROM clientes
WHERE id_cliente IN (
SELECT id_cliente
FROM pedidos
);

SELECT DISTINCT p.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
INNER JOIN pedidos AS p 
ON c.id_cliente = p.id_cliente;

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
LEFT JOIN pedidos AS p 
ON c.id_cliente = p.id_cliente
WHERE p.id_cliente IS NULL;

```
**Instruccion ANY**
>Compara un  valor de una **Lista**. La condicion  se cumple si almenos uno se cumple 

```sql
valor> ANY (subconsulta)
```
Es como decir:
"mayor que almenos uno de los valores"



Devuelve varios valores pero una sola columna 
1. CLientes que ha echo pedidos

```sql
SELECT * FROM  clientes 
WHERE id_cliente IN (
SELECT id_cliente 
FROM pedidos
);
```