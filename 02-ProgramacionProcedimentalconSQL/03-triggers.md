# Triggers (Disparadores)

## ¿Que es un tigger?

Es un bloque de codigo SQL que se ejecuta automaticamente cuando ocurre un evento en un tabla:

🦂 Eventos
- Insert
- Update
- Delete

🕷️No se ejecutan manualmente, se activan solos.

## 👠 ¿Para que sirve?

- Validaciones
- Auditoria (Guardar Historial)
- Reglas del negocio
- Automatizacion

## 🐈‍⬛ Tipos de Triggers en SQL SERVER

- AFTER TRIGGER 

Se ejecuta despues del evento

- INSTEAD OF

Reemplaza la operacion original

## 🦨 Sintaxis Basica 

```sql
    CREATE TRIGGER nombre_trigger
    ON nombre_tabla
    AFTER INSERT

    AS
    BEGIN
    -- CODIGO
    END;
```

## Tablas Especiales

| Tabla  | Contenido |
| :--- | :--- |
| INSERTED | Nuevos datos |
| DELETED | Datos Anteriores |

