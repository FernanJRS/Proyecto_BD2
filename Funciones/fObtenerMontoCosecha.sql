USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fObtenerMontoCosecha(@tdetalle DetalleCosecha READONLY) RETURNS NUMERIC(11,2)
AS
	BEGIN
		DECLARE @monto NUMERIC(11,2);

		SELECT @monto = SUM(Precio * Cantidad) FROM @tdetalle

		RETURN @monto
	END
GO