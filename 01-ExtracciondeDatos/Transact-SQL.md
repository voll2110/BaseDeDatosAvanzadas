# Transact-SQL (T-SQL)

Transact-SQL es la extensión del lenguaje SQL utilizada por Microsoft SQL Server. 
Permite realizar consultas, manipular datos y programar lógica dentro del motor de base de datos mediante variables, estructuras de control, transacciones y objetos reutilizables.

---

# **Declaración de Variables**

En T-SQL las variables se declaran con `DECLARE` y comienzan con `@`.

```sql
DECLARE @Edad INT;
DECLARE @Nombre VARCHAR(50);
SET @Edad = 25;
```

También se pueden declarar y asignar en la misma línea:

```sql
DECLARE @Activo BIT = 1;
```

---

# **Tipos de Datos en SQL Server**

## Numéricos
1. INT  
2. BIGINT  
3. DECIMAL(p,s)  
4. FLOAT  
5. MONEY  

## Cadenas
1. CHAR(n)  
2. VARCHAR(n)  
3. NVARCHAR(n)  

## Fecha y Hora
1. DATE  
2. DATETIME  
3. DATETIME2  
4. TIME  

## Booleano
SQL Server utiliza:

```sql
BIT
```

Donde 1 = Verdadero y 0 = Falso.

---

# **Operadores**

## Aritméticos
```sql
+  -  *  /  %
```

## Relacionales
```sql
=  <>  >  <  >=  <=
```

## Lógicos
```sql
AND
OR
NOT
```

Ejemplo:

```sql
SELECT *
FROM Clientes
WHERE Edad >= 18 AND Ciudad = 'CDMX';
```

---

# **Estructuras de Control**

## IF...ELSE

```sql
DECLARE @Edad INT = 20;

IF @Edad >= 18
    PRINT 'Mayor de edad';
ELSE
    PRINT 'Menor de edad';
```

## WHILE

```sql
DECLARE @Contador INT = 1;

WHILE @Contador <= 5
BEGIN
    PRINT @Contador;
    SET @Contador = @Contador + 1;
END
```

---

# **Manejo de Excepciones (TRY...CATCH)**

```sql
BEGIN TRY
    SELECT 10/0;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
```

---

# **Transacciones**

```sql
BEGIN TRANSACTION;

UPDATE Cuentas
SET Saldo = Saldo - 100
WHERE IdCuenta = 1;

COMMIT;
```

Para revertir cambios:

```sql
ROLLBACK;
```

---

# **Funciones Definidas por el Usuario (UDF)**

## Función Escalar

```sql
CREATE FUNCTION dbo.CalcularIVA(@Precio DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Precio * 0.16;
END;
```

---

# **Stored Procedures**

```sql
CREATE PROCEDURE sp_ObtenerClientes
AS
BEGIN
    SELECT * FROM Clientes;
END;
```

Ejecución:

```sql
EXEC sp_ObtenerClientes;
```

---

# **Triggers**

```sql
CREATE TRIGGER trg_InsertCliente
ON Clientes
AFTER INSERT
AS
BEGIN
    PRINT 'Nuevo cliente insertado';
END;
```

---

# **Funciones de Cadena**

```sql
LEN()
UPPER()
LOWER()
SUBSTRING()
REPLACE()
TRIM()
```

---

# **Funciones de Fecha**

```sql
GETDATE()
DATEADD()
DATEDIFF()
YEAR()
MONTH()
DAY()
```

---

# **Funciones para Valores Nulos**

```sql
ISNULL()
COALESCE()
NULLIF()
```

---

# **FORMAT**

```sql
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy');
```

---

# **CASE**

```sql
SELECT 
    Nombre,
    CASE 
        WHEN Edad >= 18 THEN 'Mayor'
        ELSE 'Menor'
    END AS Clasificacion
FROM Clientes;
```

---

# **Conclusion**

Transact-SQL amplía el SQL tradicional incorporando programación estructurada, control de flujo, manejo de errores y automatización mediante funciones, procedimientos y triggers.