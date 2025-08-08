CREATE OR ALTER PROCEDURE spBuscarOrden
	@Codigo VARCHAR(50)
AS
BEGIN
	SELECT P.Nombre, I.Codigo, I.Nombre AS Insumo, CD.Precio,CD.Cantidad,CD.Unidad,CD.Descuento,(CD.Precio * CD.Cantidad) AS Total, C.EstadoEntrega FROM CompraInsumos C
	INNER JOIN CompraDetalleInsumos CD ON C.CompraInsumosID = CD.CompraInsumoID
	INNER JOIN InsumosAgricolas I ON CD.InsumoID = I.InsumoID 
	INNER JOIN ProveedorInsumos P ON C.ProveedorID = P.ProveedorID 
	WHERE C.CompraInsumosID = @Codigo 
END

EXEC spBuscarOrden 1