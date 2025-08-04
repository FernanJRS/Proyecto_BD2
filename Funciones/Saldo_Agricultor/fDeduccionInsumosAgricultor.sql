USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fDeduccionInsumosAgricultor(@tInsumos InsumosDeducidos READONLY) RETURNS NUMERIC(11,2)
AS
	BEGIN
		DECLARE @deduccionInsumos FLOAT;

		IF (SELECT COUNT(*) FROM @tInsumos) > 0 
			BEGIN
				SELECT @deduccionInsumos = SUM(ISNULL(SubTotal, 0) + ISNULL(Impuesto, 0) - ISNULL(Descuento, 0)) FROM AgricultorInsumos 
				WHERE AgricultorInsumoID IN (SELECT AgricultorInsumoID FROM @tInsumos);
			END

		RETURN @deduccionInsumos;
	END
GO