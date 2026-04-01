CREATE OR ALTER usp_insertarVenta
@idCliente NCHAR(5),
@idProducto INT,
@cantidad INT
AS
BEGIN
    DECLARE @existencia INT
    
    BEGIN TRY
    IF  NOT EXISTS(SELECT 1 FROM cliente WHERE idCliente = @idCliente)
    BEGIN
        THROW 50001, 'El cliente no existe',1;
    END

    -- Validar si el producto existe
    -- VERIFICAR STOCK CON LA CANTIDAD SOLICITADA

    BEGIN TRANSACTION

    -- INSERTAR VENTAS
    -- VERIFICAR EL PRECIO DEL PRODUCTO
    -- Insertar en detalleVentas
    -- Actualizar STOCK EN PRODUCTO

    COMMIT;
    END TRY
    BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK;
    PRINT 'Error'+ ERROR_MESSAGE();
    END CATCH
END ;
GO
CREATE OR ALTER TRIGGER trg_cambio_precio
ON VENTA
AFTER UPDATE 
AS
BEGIN
IF 
END;

