    CREATE TABLE LOCALIDADES(
        ID_LOCALIDAD INT PRIMARY KEY,
        NOMBRE_LOCALIDAD VARCHAR (50),
    );
    
    CREATE TABLE CLIENTES(
        ID_Cliente INT PRIMARY KEY,
        NOMBRE VARCHAR(50),
        APELLIDO VARCHAR(50),
        ID_LOCALIDAD INT,
        MAIL VARCHAR(100) UNIQUE,
        FOREIGN KEY(ID_LOCALIDAD) REFERENCES LOCALIDADES(ID_LOCALIDAD)
    );

    CREATE TABLE PRODUCTOS(
        ID_Producto INT PRIMARY KEY,
        NOMBRE VARCHAR (50),
        PRECIO DECIMAL(10,2),
        STOCK INT
    );

    CREATE TABLE VENTAS(
        ID_Venta INT PRIMARY KEY,
        ID_Cliente INT,
        FECHA DATE,
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTES(ID_Cliente)
         
    )
    CREATE TABLE DETALLE_VENTA(
        ID_DETALLE_VENTA INT PRIMARY KEY,
        ID_Venta INT,
        ID_Producto INT,
        CANTIDAD INT,
        PRECIO_UNITARIO DECIMAL,
        FOREIGN KEY(ID_Venta) REFERENCES VENTAS(ID_Venta),
        FOREIGN KEY(ID_Producto) REFERENCES PRODUCTOS(ID_Producto)
    );

    INSERT INTO LOCALIDADES(ID_LOCALIDAD, NOMBRE_LOCALIDAD) VALUES
    (1,'Capital federal'),
    (2,'Lanus'),
    (3,'Vicente Lopez')
    ;

    INSERT INTO CLIENTES(ID_Cliente,NOMBRE, APELLIDO, MAIL,ID_LOCALIDAD) VALUES 
    (1,'Lionel', 'Messi', 'leo@seleccion.com', 1),
    (2,'Julian', 'Alvarez','juli@mail.com',2),
    (3,'Emiliano','Martinez','emi@seleccion.com',3),
    (5, 'Rodrigo', 'De paul', 'motor@seleccion.com',1),
    (4,'Angel','Di Maria','fideo@mail.com',1)
    ;

    INSERT INTO PRODUCTOS(ID_Producto, NOMBRE, PRECIO, STOCK) VALUES 
    (10, 'Martillo Galponero', 5500.00, 50),
    (20, 'Destornillador Phillips', 3200.00,100),
    (30,'Taladro Percutor', 45000.00,10),
    (40, 'Caja Tornillos', 1200.00, 200),
    (50, 'LLave Inglesa', 8500.00, 30)
    ;

    INSERT INTO VENTAS (ID_Venta,FECHA, ID_Cliente) VALUES
    (1001,'2025-01-05',1),
    (1002,'2025-01-06',2),
    (1003,'2025-01-07',1),
    (1004,'2025-01-08',3),
    (1005,'2025-01-10',4),
    (1006,'2025-01-12',5),
    (1007,'2025-01-15',2),
    (1008,'2025-01-20',1),
    (1009,'2025-01-25',3),
    (1010,'2025-01-30',5);


    INSERT INTO DETALLE_VENTA(ID_DETALLE_VENTA, ID_Venta,ID_Producto, CANTIDAD,PRECIO_UNITARIO) VALUES
    (1,1001,10,1,5500.00),
    (2,1001,40,2,1200.00),
    (3,1002,30,1,45000.00),
    (4,1003,50,1,8500.00),
    (5,1004,20,3,3200.00),
    (6,1005,10,1,5500.00),
    (7, 1006, 40, 5, 1200.00),
    (8, 1007, 20, 1, 3200.00),
    (9, 1008, 30, 1, 45000.00),
    (10, 1009, 50, 2, 8500.00),
    (11, 1010, 10, 1, 5500.50); 
GO
    CREATE VIEW REPORTE_FACTURACION AS
    
    SELECT 
        V.ID_Venta AS Ticket,
        V.FECHA,
        C.APELLIDO,
        P.NOMBRE AS Producto,
        D.CANTIDAD,
        D.PRECIO_UNITARIO,
        (D.CANTIDAD * D.PRECIO_UNITARIO) AS 'TOTAL FINAL'
    
    FROM VENTAS V
    
    JOIN CLIENTES C ON V.ID_Cliente = C.ID_Cliente
    JOIN DETALLE_VENTA D ON V.ID_Venta = D.ID_Venta
    JOIN PRODUCTOS P ON D.ID_Producto = P.ID_Producto
    ;

GO
    CREATE PROCEDURE NuevoProducto
    @ID INT,
    @Nombre VARCHAR(50),
    @Precio DECIMAL(10,2),
    @Stock INT
    AS
    BEGIN
   
            IF EXISTS(SELECT 1 FROM PRODUCTOS WHERE ID_Producto = @ID)
            BEGIN
                PRINT '¡Error! El producto ya existe.'
            END
        ELSE
            BEGIN
                INSERT INTO PRODUCTOS (ID_Producto, NOMBRE, PRECIO, STOCK)
                VALUES (@ID, @Nombre, @Precio, @Stock);
            
                PRINT 'Producto guardado exitosamente.';
            END
    END;
GO

    EXEC NuevoProducto 60, 'Sierra Circular', 12500.00, 5;            
    
   SELECT 
        C.NOMBRE, 
        C.APELLIDO, 
        SUM(D.CANTIDAD * D.PRECIO_UNITARIO) AS TOTAL_GASTADO
    FROM CLIENTES C
    JOIN VENTAS V ON C.ID_Cliente = V.ID_Cliente
    JOIN DETALLE_VENTA D ON V.ID_Venta = D.ID_Venta
    GROUP BY C.NOMBRE, C.APELLIDO
    ORDER BY TOTAL_GASTADO DESC;
