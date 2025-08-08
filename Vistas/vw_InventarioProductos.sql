USE GrupoNo4
GO

CREATE OR ALTER VIEW dbo.vw_InventarioProductos
AS
WITH Entradas AS (
    SELECT cd.ProductoID, SUM(cd.Cantidad) AS CantEntradas
    FROM   CosechaDetalleAgricultor cd
    GROUP  BY cd.ProductoID
),
Salidas AS (
    SELECT fd.ProductoID, SUM(CASE fd.Unidad
								WHEN 'Fardos' THEN Cantidad * 0.20
								WHEN 'Arrobas' THEN Cantidad * 0.25
								WHEN 'Quintales' THEN Cantidad
								END) AS CantSalidas
    FROM   FacturaDetalle fd
    GROUP  BY fd.ProductoID
) 
SELECT p.Codigo,
       p.Nombre AS Producto,
       ISNULL(e.CantEntradas,0) AS Entradas,
	   ISNULL(s.CantSalidas, 0) AS Salida,
	   SUM(ISNULL(e.CantEntradas ,0) - ISNULL(s.CantSalidas, 0)) AS Existencias
FROM   ProductosAgricolas p
LEFT  JOIN Entradas e ON e.ProductoID = p.ProductoID
LEFT  JOIN Salidas s ON s.ProductoID = p.ProductoID
GROUP BY p.Codigo, p.Nombre, e.CantEntradas, s.CantSalidas;
GO