USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fLiquidacionPendienteAgricultorPorCosecha(@cosechaID INT, @agricultorID INT) RETURNS NUMERIC(11,2)
AS
	BEGIN
		DECLARE @saldoPendiente FLOAT, @abonosPrevios FLOAT;

		SELECT @saldoPendiente = Monto FROM CosechaAgricultor
		WHERE CosechaID = @cosechaID AND AgricultorID = @agricultorID AND Estado = 'P';

		SELECT @abonosPrevios = SUM(ISNULL(Monto, 0)) FROM PagoAgricultores
		WHERE AgricultorID = @agricultorID AND CosechaID = @cosechaID AND Tipo = 'A';

		DECLARE @saldo FLOAT = 0;

		SELECT @saldo = @saldoPendiente - ISNULL(@abonosPrevios, 0);

		RETURN @saldo
	END
GO