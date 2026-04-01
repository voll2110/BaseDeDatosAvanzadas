USE bdejercicio;

CREATE TYPE DetalleVentaType AS TABLE
(
    idProducto INT,
    precioVenta MONEY,
    cantidad INT
);
GO


CREATE OR ALTER PROC usp_ventas_insertar
(
    @idCliente NCHAR(5),
    @fecha DATETIME,
    @detalle DetalleVentaType READONLY
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

DECLARE @idVenta INT;
        --Validar cliente
        IF NOT EXISTS (SELECT 1 FROM Cliente WHERE CustomerID = @idCliente)
BEGIN
            RAISERROR('El cliente no existe',16,1);
            ROLLBACK TRAN;
            RETURN;
        END
        --Validar que hay productos
        IF NOT EXISTS (SELECT 1 FROM @detalle)
BEGIN
            RAISERROR('No hay productos en la venta',16,1);
            ROLLBACK TRAN;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM @detalle WHERE cantidad <= 0)
        BEGIN
            RAISERROR('Cantidad invalida',16,1);
            ROLLBACK TRAN;
            RETURN;
        END
IF EXISTS (
            SELECT 1
            FROM @detalle d
            INNER JOIN Productos p ON p.ProductID = d.idProducto
            WHERE d.cantidad > p.UnitsInStock
        )
BEGIN
            RAISERROR('Stock insuficiente',16,1);
            ROLLBACK TRAN;
            RETURN;
 END
        --Insertar venta
        INSERT INTO VENTA(fecha, idCliente)
        VALUES(@fecha, @idCliente);

        SET @idVenta = SCOPE_IDENTITY();

        --Insertar detalle
        INSERT INTO DetalleVenta(idVenta, idProducto, precioVenta, cantidad)
        SELECT 
            @idVenta,
            idProducto,
            precioVenta,
            cantidad
        FROM @detalle;

        UPDATE p
        SET p.UnitsInStock = p.UnitsInStock - d.cantidad
        FROM Productos p
        INNER JOIN @detalle d ON p.ProductID = d.idProducto;
        COMMIT TRAN;
        SELECT 
            1 AS Resultado,
            'Venta registrada' AS Mensaje,
            @idVenta AS idVenta;
    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        SELECT 
            0 AS Resultado,
            ERROR_MESSAGE() AS Mensaje,
            0 AS idVenta;
    END CATCH
END;
GO