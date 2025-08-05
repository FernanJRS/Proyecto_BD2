USE GrupoNo4
GO

CREATE OR ALTER VIEW vw_ProductosPorAgricultor
AS
	SELECT A.AgricultorID AS AgricultorID, A.Nombre AS Agricultor, PA.Nombre AS Producto, PA.Codigo AS CodigoProducto, SUM(CDA.Cantidad) AS Quintales, SUM(CDA.Cantidad * CDA.Precio) AS ValorTotal FROM Agricultor A
	INNER JOIN CosechaAgricultor CA ON A.AgricultorID = CA.AgricultorID
	INNER JOIN CosechaDetalleAgricultor CDA ON CA.CosechaID = CDA.CosechaID
	INNER JOIN ProductosAgricolas PA ON CDA.ProductoID = PA.ProductoID
	GROUP BY A.AgricultorID, A.Nombre, PA.Nombre, PA.Codigo
GO