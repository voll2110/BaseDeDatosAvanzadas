USE SalesDB;
-- Crear una tabla como una copia de Customers
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers;

SELECT *
FROM Sales.DBCustomers
WHERE CustomerID = 1;

-- Crear a Clustered Index on Sales.DBCustomers usando customerID
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (customerID);
