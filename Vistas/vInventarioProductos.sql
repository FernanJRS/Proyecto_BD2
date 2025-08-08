CREATE OR ALTER VIEW vInventarioProductos
AS
SELECT 
    p.Codigo AS Codigo,
    p.Nombre AS Producto,
    ti.Nombre AS TipoInsumo,
    p.Existencias,
    p.Precio,
    (p.Existencias * p.Precio) AS ValorInventario
FROM ProductosAgricolas p
INNER JOIN TipoInsumo ti ON p.TipoID = ti.TipoID;
GO
