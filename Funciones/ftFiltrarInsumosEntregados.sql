USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.ftFiltrarInsumosEntregados(@agricultor VARCHAR(100)) RETURNS 
@tInsumos TABLE (Insumo VARCHAR(100), Codigo VARCHAR(20), Recibidos NUMERIC(11,2), UnidadMedida VARCHAR(100))
AS
	BEGIN
		INSERT INTO @tInsumos
		SELECT Insumo, CodigoInsumo, Recibidos, UnidadMedida FROM vw_InsumosEntregados
		WHERE Agricultor LIKE CONCAT('%',@agricultor,'%')
		
		RETURN
	END
GO