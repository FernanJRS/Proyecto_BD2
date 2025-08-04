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
SELECT p.ProductoID,
       p.Nombre,
       ISNULL(e.CantEntradas,0) AS Entradas,
	   ISNULL(s.CantSalidas, 0) AS Salida
FROM   ProductosAgricolas p
LEFT  JOIN Entradas e ON e.ProductoID = p.ProductoID
LEFT  JOIN Salidas s ON s.ProductoID = p.ProductoID;
GO