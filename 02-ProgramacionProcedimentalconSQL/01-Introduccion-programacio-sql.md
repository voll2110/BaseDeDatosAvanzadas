
# Fundamentos Programables

1. ¿Que es l aparte programable de T-SQL?

Es todo lo que permite:

- Usar variables
- Control de Flujo
- Crear Procedimientos Almacenados (Store Procedures)
- Manejar Errores
- Crear Funciones
- Usar Transacciones
- Disparadores (Triggers)

Nota: Es convertir SQL en un lenguaje casi como C/Java pero dentro del motor

2. Variable:
Una Variable almacena un valor temporal

```sql
/*==========================Variables====================*/
DECLARE @Edad INT
SET @Edad = 42

SELECT @Edad AS Edad
PRINT CONCAT ('La edad es: ',' ', @Edad)

/*=========================Ejecucion con Variables===============*/

/*
1. Declarar una variable llamada precio
2. Asignarle el valor de 150
3. Calcular el iva del 16%
4. Mostrar el total


*/

DECLARE @Precio MONEY = 150 --Se declara un valor inicial
DECLARE @Total MONEY

SET @Total = @Precio * 1.16

SELECT @Total AS [Total]

```

3. IF/ELSE

Permite ejecutar el codigo segun un condicion
```sql
/*=========================IF/ELSE===============*/
DECLARE @Edad2 INT
SET @Edad2 = 18

IF @Edad2 >= 18
BEGIN
PRINT 'Es mayor de edad'
PRINT 'Felicidades'
END
ELSE 
PRINT 'Es Menor'

/*=========================Ejercicio IF/ELSE===============*/

/*
1. Crear Una Variable
2. Evaluar si es mayor a 70 impriir "Aprobado", si no "Reprobado"
*/
DECLARE @promedio INT
SET @promedio = 80

IF @promedio >= 70
PRINT 'Aprobado'
ELSE
PRINT 'REPROBADO'
```


4. WHILE 
```sql
-- EJERCICIOS WHILE
DECLARE @contador INT;
SET @contador =1;
DECLARE @contador2 INT =1;


WHILE @contador <= 5
BEGIN
	WHILE @contador2 <=5
	BEGIN
	PRINT CONCAT(@contador,'-',@contador2);
	SET @contador2 = @contador2 +1
	END;
	SET @contador2 = 1
	SET @contador = @contador +1;
END;
GO

--imprime los numeros del 10al 1
DECLARE @contadoR3 INT =10

WHILE @contadoR3 >=1
BEGIN
PRINT @contadoR3
SET @contadoR3 = @contadoR3 -1
END;
GO
```

## Procedimientos almacenados (Stored Procedures)

5. ¿Que es un Stored Procedure😫🥱🥱?

Es un bloque de codigo guardado en una base de datos que se puede ejecutar cuando quieres y lo necesites

```sql
CREATE PROCEDURE usp_objeto_accion
[Parametrs]
AS 
BEGIN
 -- Body

END;

CREATE PROC usp_objeto_accion
[Parametrs]
AS 
BEGIN
 -- Body
END;

CREATE OR ALTER PROCEDURE usp_objeto_accion
[Parametrs]
AS 
BEGIN
 -- Body
END;

CREATE PROC usp_objeto_accion
[Parametrs]
AS 
BEGIN
 -- Body
END;
```
