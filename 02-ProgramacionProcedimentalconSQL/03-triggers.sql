CREATE DATABASE db_triggers;
GO
CREATE TABLE Productos
(
id INT PRIMARY KEY,
nombre VARCHAR(50),
precio DECIMAL(10,2)

);
GO

-- EJERCICIO 1. EVENTO insert(TRIGGER)
CREATE OR ALTER TRIGGER trg_test_insert --SE CREA EL TRIGGER
ON Productos -- Tabla que se asocia el trigger
AFTER INSERT --Evento con el que se va a disparar
AS 
BEGIN 

SELECT * FROM inserted;
SELECT * FROM Productos;
SELECT * FROM deleted;
END;
GO

--	Evaluar

INSERT INTO Productos(id,nombre,precio)
VALUES(1,'Bacalao',300);

INSERT INTO Productos(id,nombre,precio)
VALUES(2,'REYES',300);

INSERT INTO Productos(id,nombre,precio)
VALUES(3,'BUCAÑAS',9570);

INSERT INTO Productos(id,nombre,precio)
VALUES(4,'30X30',18),
(5,'CHARRANDA',5.50);

INSERT INTO Productos(id,nombre,precio)
VALUES(6,'Don Peter',100),
(7,'Presimuerte',98);
GO
-- Evento DELETE

CREATE OR ALTER TRIGGER trg_test_delete
ON Productos
AFTER DELETE
AS
BEGIN
SELECT* FROM deleted;
SELECT * FROM inserted;
SELECT * FROM Productos;
END;

DELETE FROM Productos WHERE id = 1;
GO
--EVENTO UPDATE

CREATE OR ALTER TRIGGER trg_test_update
ON Productos
AFTER UPDATE
AS
BEGIN

	SELECT * FROM inserted;
	SELECT * FROM deleted;

END;

UPDATE Productos 
SET precio = 600
WHERE id =2;

--REALIZAR UN TRIGGER QUE PERMITA CANCELAR LA OPERACION 
CREATE TABLE Productos2
(
id INT PRIMARY KEY,
nombre VARCHAR(50),
precio DECIMAL(10,2)

);
GO

CREATE OR ALTER TRIGGER trg_un_solo_registro
ON Productos2
AFTER INSERT
AS
BEGIN
	IF(SELECT COUNT(*) FROM inserted) > 1
	BEGIN
	RAISERROR('SOLO SE PERMITE INSERTAR UN REGISTRO A LA VEZ',16,1);
	ROLLBACK TRANSACTION;
	END;
END;


INSERT INTO Productos2(id,nombre,precio)
VALUES(6,'Don Peter',100),
(7,'Presimuerte',98);

GO
-- REALIXAR UN TRIGGER QUE DETECTE UN CAMBIO EN EL PRECIO Y MANDE UN MENSAJE DE QUE EL PRECIO CAMBO


CREATE OR ALTER TRIGGER trg_validar_cambio
ON Productos2
AFTER UPDATE
AS
BEGIN
IF EXISTS (
	SELECT 1
	FROM inserted AS i
	INNER JOIN 
	deleted AS d
	ON i.id=d.id
	WHERE i.precio <> d.precio
	)
	BEGIN
	PRINT 'EL PRECIO FUE CAMBIADO';
	END
END;


--TRIGGER QUE EVITE QUE CAMBIE EL PRECIO

