USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.ftFiltrarProductosPorAgricultor(@agricultor VARCHAR(100)) RETURNS 
@tProductos TABLE (Producto VARCHAR(100), Codigo VARCHAR(20), Quintales NUMERIC(11,2))
AS
	BEGIN
		INSERT INTO @tProductos
		SELECT Producto, CodigoProducto, Quintales FROM vw_ProductosPorAgricultor
		WHERE Agricultor LIKE CONCAT('%',@agricultor,'%')
		
		RETURN
	END
GO