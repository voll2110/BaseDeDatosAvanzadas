CREATE TABLE VENTA
(
idVenta INT IDENTITY(1,1),
fecha DATETIME,
idCliente NCHAR(5),
CONSTRAINT pk_Ventas
PRIMARY KEY (idVenta),
FOREIGN KEY (idCliente)
REFERENCES Cliente(CustomerID)
);

CREATE TABLE DetalleVenta
(
idVenta INT NOT NULL,
idProducto INT NOT NULL,
precioVenta MONEY NOT NULL,
cantidad INT NOT NULL,

CONSTRAINT PK_DetalleVenta 
PRIMARY KEY (idVenta,idProducto),

CONSTRAINT fk_DV_Venta
FOREIGN KEY (idVenta)
REFERENCES VENTA(idVenta),

CONSTRAINT fk_DV_Producto
FOREIGN KEY (idProducto)
REFERENCES Productos(ProductID)
);
SELECT 
ProductID,
ProductName,
UnitPrice,
UnitsInStock
INTO Productos
FROM NORTHWND.dbo.Products;

SELECT 
CustomerID,
CompanyName,
Country,
City
INTO Cliente
FROM NORTHWND.dbo.Customers

DROP TABLE VENTA;

SELECT * FROM Productos;

SELECT * FROM Cliente;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarVenta
    @idCliente NCHAR(5),
    @idProducto INT,
    @cantidad INT
AS
BEGIN
    BEGIN TRY

        -- === VALIDAR CLIENTE ===
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE CustomerID = @idCliente)
        BEGIN
            PRINT 'El cliente no existe';
            RETURN;
        END

        -- === VALIDAR PRODUCTO ===
        IF NOT EXISTS (SELECT 1 FROM Productos WHERE ProductID = @idProducto)
        BEGIN
            PRINT 'El producto no existe';
            RETURN;
        END

        DECLARE @precio MONEY;
        DECLARE @stock INT;

        SELECT 
            @precio = UnitPrice,
            @stock = UnitsInStock
        FROM Productos
        WHERE ProductID = @idProducto;

        -- === VALIDAR EXISTENCIA ===
        IF @stock < @cantidad
        BEGIN
            PRINT 'No hay suficiente existencia';
            RETURN;
        END

        BEGIN TRANSACTION;

        -- === DECLARAR VARIABLE ===
        DECLARE @idVenta INT;

        -- === INSERTAR VENTA ===
        INSERT INTO VENTA (fecha, idCliente)
        VALUES (GETDATE(), @idCliente);

        -- === OBTENER ID ===
        SET @idVenta = SCOPE_IDENTITY();

        -- === INSERTAR DETALLE ===
        INSERT INTO DetalleVenta (idVenta, idProducto, precioVenta, cantidad)
        VALUES (@idVenta, @idProducto, @precio, @cantidad);

        -- === ACTUALIZAR STOCK ===
        UPDATE Productos
        SET UnitsInStock = UnitsInStock - @cantidad
        WHERE ProductID = @idProducto;

        COMMIT;

        PRINT 'Venta registrada correctamente';

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK;

        PRINT 'ERROR: ' + ERROR_MESSAGE();

    END CATCH
END;

EXEC sp_RegistrarVenta 'ALFKI',1,5;