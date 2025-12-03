# Sistema de Gestión de Ventas y Facturación (SQL) 🛒

## Descripción del Proyecto
Este proyecto consiste en el diseño e implementación de una base de datos relacional para simular el sistema de facturación de un comercio minorista. El objetivo fue modelar el flujo de datos desde el registro de clientes y productos hasta la generación de ventas detalladas.

## Tecnologías y Conceptos Aplicados
* **Lenguaje:** SQL (Compatible con SQL Server / T-SQL).
* **Modelado de Datos:** Diagrama Entidad-Relación (DER) y Normalización para evitar redundancia.
* **Integridad de Datos:** Uso de Primary Keys (PK), Foreign Keys (FK) y restricciones Unique.
* **Automatización:**
    * **Stored Procedures:** Creación de procedimientos para la inserción segura de nuevos productos validando duplicados.
    * **Vistas (Views):** Generación de reportes automáticos de facturación unificando 4 tablas.
* **Consultas Complejas:** Uso de JOINs múltiples y campos calculados.

## Estructura de la Base de Datos
El sistema cuenta con las siguientes tablas interconectadas:
1.  **Localidades:** Tabla padre para normalización geográfica.
2.  **Clientes:** Información personal y contacto.
3.  **Productos:** Catálogo de artículos con control de stock y precios.
4.  **Ventas:** Encabezados de facturas (Transaccional).
5.  **Detalle_Venta:** Renglones de productos por venta (Relación 1:N).

## Cómo probar este proyecto
1. Descarga el archivo `Script_Sistema_Ventas.sql`.
2. Ejecútalo en tu motor de base de datos preferido (SQL Server Management Studio o Azure Data Studio).
3. El script incluye la creación de tablas y la carga de datos de prueba (Dummy Data).
