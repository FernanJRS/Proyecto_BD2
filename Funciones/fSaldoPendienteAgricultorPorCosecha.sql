USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fSaldoPendienteAgricultorPorCosecha(@cosechaID INT, @agricultorID INT) RETURNS NUMERIC(11,2)
AS
	BEGIN
		DECLARE @saldoPendiente FLOAT;

		SELECT @saldoPendiente = Monto FROM CosechaAgricultor
		WHERE CosechaID = @cosechaID AND AgricultorID = @agricultorID AND Estado = 'P';
		
		RETURN @saldoPendiente;
	END
GO