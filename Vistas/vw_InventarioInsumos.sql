CREATE OR ALTER VIEW vInventarioInsumos
AS
SELECT 
    i.Codigo AS Codigo,
    i.Nombre AS Producto,
    ti.Nombre AS TipoInsumo,
    i.Existencias,
    i.Precio,
    (i.Existencias * i.Precio) AS ValorInventario
FROM InsumosAgricolas i
INNER JOIN TipoInsumo ti ON i.TipoInsumoID = ti.TipoID;
GO