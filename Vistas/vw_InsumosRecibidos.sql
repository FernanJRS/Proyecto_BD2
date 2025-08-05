USE GrupoNo4
GO

CREATE OR ALTER VIEW vw_InsumosRecibidos
AS
	SELECT P.Nombre AS Proveedor, IA.Codigo AS CodigoInsumo, IA.Nombre AS Insumo, SUM(CDI.Cantidad) AS Recibidos, IA.Unidad AS UnidadMedida  FROM ProveedorInsumos P
	INNER JOIN CompraInsumos CI ON P.ProveedorID = CI.ProveedorID
	INNER JOIN CompraDetalleInsumos CDI ON CI.CompraInsumosID = CDI.CompraInsumoID
	INNER JOIN InsumosAgricolas IA ON CDI.InsumoID = IA.InsumoID
	GROUP BY P.Nombre, IA.Nombre, IA.Unidad, IA.Codigo
GO