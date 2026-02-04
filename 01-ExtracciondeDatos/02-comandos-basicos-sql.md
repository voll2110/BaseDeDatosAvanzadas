# Comandos Basicos SQL

```sql
CREATE DATABASE pruebadb;
GO

USE pruebadb;
GO

CREATE TABLE tbl1(
id int not null identity (1,1),
nombre nvarchar(100) not null,
constraint pk_tbl1
primary key (id)
);

INSERT INTO tbl1
VALUES('Docker'),
('Git'),
('GITHUB'),
('SQL SERVER');
GO

SELECT *
FROM tbl1;

```