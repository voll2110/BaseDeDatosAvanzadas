# Registro de venta con varios productos

## Creacion de la base a usar

Primero se selecciona la base de datos donde se va a trabajar. En este caso se usa `bdejercicio`, que es donde estan las tablas del proyecto.

```sql
USE bdejercicio;
```

## Creacion del table type

Despues se crea un `table type` llamado `DetalleVentaType`.  
Este sirve para mandar varios productos al mismo tiempo al stored procedure, junto con su precio y cantidad.

Aqui se define que cada producto enviado va a llevar:

- `idProducto`
- `precioVenta`
- `cantidad`

```sql
CREATE TYPE DetalleVentaType AS TABLE
(
    idProducto INT,
    precioVenta MONEY,
    cantidad INT
);
GO
```

## Creacion del stored procedure

Luego se crea o actualiza el stored procedure llamado `usp_ventas_insertar`.  
Este procedimiento recibe:

- el cliente
- la fecha
- y el detalle de productos

El detalle se recibe por medio del `DetalleVentaType`, para poder insertar varios productos en una sola venta.

```sql
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

        --Validar cantidad
        IF EXISTS (SELECT 1 FROM @detalle WHERE cantidad <= 0)
        BEGIN
            RAISERROR('Cantidad invalida',16,1);
            ROLLBACK TRAN;
            RETURN;
        END

        --Validar stock
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

        --Actualizar stock
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
```
## Explicacion del procedimiento
Este stored procedure hace todo el proceso de guardar una venta.

Primero entra a un `try` para intentar hacer todo sin problemas.  
Tambien se inicia una transaccion para que si algo sale mal, nada se guarde a medias.

Despues se declara la variable `@idVenta`, que servira para guardar el id de la venta nueva.

Luego se hacen varias validaciones:

### Validacion del cliente
Aqui se revisa si el cliente que se envio si existe en la tabla `Cliente`.  
Si no existe, se manda un error y se cancela todo.

### Validacion de productos
Aqui se revisa que si se hayan mandado productos en la venta.  
Si el detalle viene vacio, tambien marca error.
### Validacion de cantidad
En esta parte se revisa que ninguna cantidad sea menor o igual a cero.  
Esto evita guardar ventas con cantidades invalidas.

### Validacion de stock
Aqui se compara la cantidad pedida con el stock disponible en la tabla `Productos`.  
Si algun producto no tiene suficiente stock, se manda el mensaje de error.

## Insercion de la venta
Si todas las validaciones salen bien, entonces se inserta primero la venta en la tabla `VENTA` con la fecha y el cliente.
Despues se usa `SCOPE_IDENTITY()` para guardar el id de esa venta nueva en la variable `@idVenta`.

## Insercion del detalle
Ya con el id de la venta, se insertan todos los productos en la tabla `DetalleVenta`.  
Aqui se toma la informacion desde `@detalle`, o sea, desde la tabla que se mando como parametro.

## Actualizacion del stock
Despues de guardar el detalle, tambien se actualiza la tabla `Productos`.  
Aqui al stock actual se le resta la cantidad vendida de cada producto.

## Confirmacion de la transaccion
Si todo salio bien, se hace `COMMIT TRAN` para guardar los cambios.

Al final el procedimiento regresa:

- `Resultado = 1`
- `Mensaje = Venta registrada`
- `idVenta = id generado`

## Manejo de errores
Si algo falla en cualquier parte, el codigo entra al `catch`.

Ahi se revisa si todavia hay una transaccion abierta y se hace `ROLLBACK TRAN` para cancelar todo.
Despues regresa:

- `Resultado = 0`
- el mensaje del error
- `idVenta = 0`

## Resultado final
Con este procedimiento se logra registrar una venta con varios productos en una sola ejecucion.

Tambien se valida:

- que el cliente exista
- que si haya productos
- que la cantidad sea valida
- que el stock alcance

Y ademas se actualiza el stock automaticamente despues de guardar la venta.