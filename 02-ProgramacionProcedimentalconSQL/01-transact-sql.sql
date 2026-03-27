

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

/*=========================STORED PROCEDURE===============*/
CREATE PROCEDURE usp_mensje_saludar
AS
BEGIN
PRINT ('Hola Mundo SQL')
END;

EXECUTE usp_mensje_saludar;
GO

EXEC usp_mensje_saludar;
GO
--ALTERA
CREATE OR ALTER PROCEDURE usp_mensje_saludar
AS
BEGIN
PRINT ('Hola Mundo SQL2')
END;
GO

-- ELIMINA UN SP 'DROP PROC'

/*=========================EJERCICOS STORED PROCEDURE===============*/
-- CREAR UN SP QUE IMPRIMA LA FECHA ACTUAL

CREATE OR ALTER PROC usp_fecha_fechaactual
AS
BEGIN
SELECT GETDATE() AS [FECHA ACTUAL];
END;
GO

EXEC usp_fecha_fechaactual
GO

-- CREAR UN SP QUE MUESTRE LA DB ACTUAL
CREATE OR ALTER PROCEDURE usp_nombredb_mostrar
AS
BEGIN
SELECT DB_NAME() AS [Nombre_DB]
END;
GO

EXEC usp_nombredb_mostrar
GO