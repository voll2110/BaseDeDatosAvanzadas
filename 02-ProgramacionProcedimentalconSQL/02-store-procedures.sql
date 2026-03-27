-- Store Procedure
CREATE DATABASE dbstored;
GO
USE dbstored;
GO

CREATE OR ALTER PROC spu_persona_saludar
    @nombre VARCHAR (50) -- Parametro de entrada 
AS
BEGIN
    PRINT 'Hola �Como Estas? ' + @nombre;
END;

EXEC spu_persona_saludar 'Arcadio';
EXEC spu_persona_saludar 'Roberta';
EXEC spu_persona_saludar 'Joseluisa';
EXEC spu_persona_saludar 'Monico';
GO

SELECT CustomerID, CompanyName, City, Country
INTO customers
FROM NORTHWND.dbo.Customers;
GO


-- Realizar un store que reciba un parametro de un cliente en particular y lo muestre
CREATE OR ALTER PROC spu_cliente_consultarporid
@Id NCHAR(10)
AS
BEGIN
SELECT CustomerID AS [Numero],
CompanyName AS [Cliente],
City AS [Ciudad],
Country AS [Pais]
FROM customers
WHERE CustomerID = @Id;
END;
GO

EXEC spu_cliente_consultarporid 'ANTON';
GO

SELECT * FROM customers
WHERE EXISTS (SELECT 1
FROM customers
WHERE CustomerID = 'ANTONT');
GO

DECLARE @valor int
SET @valor=(SELECT 1
FROM customers
WHERE CustomerID = 'ANTONt');
IF @valor= 1
BEGIN
PRINT 'Existe'
END
ELSE
BEGIN 
PRINT 'No Existe'
END;
GO


CREATE OR ALTER PROC spu_cliente_consultarporid2
@Id NVARCHAR(10)

AS
BEGIN
IF LEN(@Id)>5
    BEGIN
    RAISERROR('El id del cliente debe ser menor o igual a 5',16,1);
    RETURN
 --   ;THROW 5001, 'El numero del cliente debe ser menor o igual a 5', 1
    
    END;
    IF EXISTS(SELECT 1 FROM customers WHERE CustomerID = @Id)
    BEGIN
SELECT CustomerID AS [Numero],
CompanyName AS [Cliente],
City AS [Ciudad],
Country AS [Pais]
FROM customers
WHERE CustomerID = @Id;
END

ELSE
PRINT 'No existe'

END;

EXEC spu_cliente_consultarporid2 'ANTONT';
GO

/* ========================LOGICA DENTRO DEL SP================*/
-- Crear un SP que evalue la edad de una persona
CREATE OR ALTER PROC usp_Persona_EvaluarEdad
@edad int
AS BEGIN
IF @edad >=18 AND @edad<=45
BEGIN
PRINT('Eres un adulto sin pension')
END
ELSE
BEGIN
PRINT ('Eres menor de edad')
END
END;
GO

EXEC usp_Persona_EvaluarEdad 22 ;
EXEC usp_Persona_EvaluarEdad 50;
GO

CREATE OR ALTER PROC usp_valores_imprimir
@n as INT
AS
BEGIN 
IF @n<=0
BEGIN
PRINT('ERROR: VALOR NO VALIDO')
RETURN;
END
DECLARE @i AS INT;
SET @i =1
WHILE(@i<=@n)
BEGIN
PRINT CONCAT('Este es el numero: ' ,@i);
SET @i = @i +1; 
END
END;
GO

-- EJECUTAR
EXEC usp_valores_imprimir 400;
GO

CREATE OR ALTER PROC usp_valores_Tabla
@n as INT
AS
BEGIN 
IF @n<=0
BEGIN
    PRINT('ERROR: VALOR NO VALIDO')
    RETURN;
END
DECLARE @i AS INT;
DECLARE @j INT = 1;
SET @i =1
WHILE(@i<=@n)
BEGIN
    WHILE(@j<=10)
    BEGIN 
    PRINT CONCAT(@i, '*', @j,'=',@i*@j  );
    SET @j = @j + 1;
    END 
    PRINT(CHAR(13) +CHAR(10))
    SET @i = @i+1;
    SET @j =1;
END
END;
GO

--Ejecutar
EXEC usp_valores_Tabla 12;
GO

/* ========================CASE================*/
-- Sirve para evaluar condiciones como switch o if multiple

CREATE OR ALTER PROC usp_calificacion_evaluar

    @calificacion INT
AS
BEGIN 
    SELECT
    CASE
        WHEN @calificacion >=90 THEN 'EXELENTE'
        WHEN @calificacion >=70 THEN 'APROBADO'
        WHEN @calificacion >= 60 THEN 'REGULAR'
        ELSE 'No Acreditado'
    END AS Resultado
END;
GO

EXEC usp_calificacion_evaluar 89;
GO

USE NORTHWND;

SELECT 
ProductName, 
UnitPrice,
CASE    
    WHEN UnitPrice>=200 THEN 'CARO'
    WHEN UnitPrice>100 THEN 'MEDIO'
    ELSE 'BARATO'
END AS [Categoria]
FROM Products;
GO


CREATE OR ALTER PROC usp_comision_ventas
    @idCliente nchar(10)
    AS
BEGIN
    IF LEN(@idCliente)> 5 
    BEGIN
    PRINT('El tamaño del id del cliente debe ser de 5');
    RETURN;
    END

    IF NOT EXISTS(SELECT 1 FROM customers WHERE CustomerID = @idCliente)
    BEGIN
    PRINT ('Cliente no exite');
    END

    DECLARE @comision DECIMAL(10,2);
    DECLARE @total MONEY

    SET @total = (SELECT SUM (UnitPrice * Quantity)
    FROM [Order Details] AS od
    INNER JOIN Orders AS o
    ON o.OrderID = od.OrderID
    WHERE o.CustomerID = @idCliente);

    SET @comision = 
    CASE 
        WHEN @total>= 19000 THEN 5000
        WHEN @total >= 15000 THEN 2000
        WHEN @total >= 10000 THEN 1000
        ELSE 500

        END;
    PRINT CONCAT('TOTAL DE VENTAS: ' , @total, CHAR(13)+CHAR(10), 'Comision: ' , @comision , ' Ventas mas comision: ',(@total +@comision));
END;
GO

EXEC usp_comision_ventas @idCliente = 'ANTON';
GO

SELECT o.CustomerID, SUM(od.Quantity * od.UnitPrice) AS [Total]
FROM [Order Details] AS od
INNER JOIN Orders AS o
ON o.OrderID = od.OrderID
GROUP BY o.CustomerID;

/*================ CRUD ==================*/

-- EJEMPLO INSERT

USE dbstored;

CREATE TABLE productos
(
id INT IDENTITY,
nombre VARCHAR(50),
precio DECIMAL (10,2)
);
GO
/*===================SP PARA INSERT=================*/
CREATE OR ALTER PROC usp_insertarCliente
@nombre VARCHAR(50),
@precio DECIMAL(10,2)

AS
BEGIN
    INSERT INTO productos (nombre,precio)
    VALUES (@nombre, @precio);
END;
GO

EXEC usp_insertarCliente @nombre ='Coca De Linea' , @precio =22.5;
EXEC usp_insertarCliente @nombre ='Coca Rosa' , @precio =7.0;

SELECT * FROM productos;
GO 

--SP para UPDATE
CREATE OR ALTER PROC usp_Actualizar_precio
@id INT,
@precio DECIMAL(10,2)
AS
BEGIN
IF EXISTS (SELECT 1 FROM productos WHERE id = @id)
BEGIN
    UPDATE productos
    SET precio = @precio
    WHERE id = @id;
    RETURN;
    END

    PRINT 'El ID del producto no existe, no se realizo la modificacion';
END;
GO
--EJECUTARLO

EXEC usp_Actualizar_precio 12, 5000;
EXEC usp_Actualizar_precio 1 , 5;
GO
-- SP PARA DELETE
CREATE OR ALTER PROC usp_Eliminar_Producto
@id AS INT 
AS

BEGIN
    DELETE productos
    WHERE id= @id;
END;

/*================ MANEJO DE ERRORES ==================*/
-- Sin manejo de errores
SELECT 10/0;
--Esto genera un error o una exepcion y detiene la ejecucion

--ERROR CONTROLADO

BEGIN TRY
    SELECT 10/0;
END TRY
BEGIN CATCH
    PRINT 'OCURRIO EL ERROR';
END CATCH

BEGIN TRY
    SELECT 10/0;

END TRY
BEGIN CATCH
    PRINT 'Mensaje: '+ ERROR_MESSAGE();
    PRINT 'NUMERO: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'LINEA: ' + CAST(ERROR_LINE() AS VARCHAR)
END CATCH;
GO
USE dbstored;
-- USO CON INSERT
CREATE TABLE productos2
(
id int primary Key ,
nombre varchar(50),
precio DECIMAL(10,2)
);
DROP TABLE productos2
GO

INSERT INTO productos2
VALUES (1,'Pitufo',359.0);
GO


BEGIN TRY
    INSERT INTO productos2
    VALUES (1, 'Quemadita', 65.0)
END TRY
BEGIN CATCH
    PRINT 'ERROR AL INSERTAR: ' + ERROR_MESSAGE();
    PRINT 'GRAVEDAD: '+ ERROR_SEVERITY(); 
    PRINT 'NUMERO: ' + CAST(ERROR_NUMBER() AS VARCHAR);

END CATCH;
GO

-- Ejemplo de uso de una transaccion
BEGIN TRANSACTION;

SELECT * FROM productos2;

INSERT INTO productos2
VALUES (2,'Pitufina',56.8);

ROLLBACK;--Esto permite que se cancele la transaccion, pemite que la DB no quede inconsistente
COMMIT;--El commit confirma la transaccion, por que todo fue atomico o se cumplio

/* =================== USO DE TRANSACCIONES =========================*/

-- EJERCICIO PARA VERIFICAR EN DONDE EL TRY CATCH SE VUELEVE PODEROSO
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO productos2
    VALUES(3, 'Charro Negro',123.0);

    INSERT INTO productos2
    VALUES (3, 'PANTERA ROSA',345.6);

    COMMIT;
END TRY 
BEGIN CATCH
    ROLLBACK;
    PRINT 'SE HIO UN ROLLBACK CON ERROR'
    PRINT 'ERROR' + ERROR_MESSAGE();
END CATCH;


-- VALIDAR SI UNA TRANSACCION ESTA ACTIVA

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO productos2
    VALUES(3, 'Charro Negro',123.0);

    INSERT INTO productos2
    VALUES (3, 'PANTERA ROSA',345.6);

    COMMIT;
END TRY 
BEGIN CATCH
   IF @@TRANCOUNT > 0
    ROLLBACK
    PRINT 'SE HIO UN ROLLBACK CON ERROR'
    PRINT 'ERROR' + ERROR_MESSAGE();
END CATCH;

--  EJERCICIO
