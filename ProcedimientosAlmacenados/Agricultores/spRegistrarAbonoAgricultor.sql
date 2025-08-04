USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarAbonoAgricultor
@agricultorID INT, @cosechaID INT, @fecha DATETIME, @metodoPago VARCHAR(20), @monto FLOAT
AS
	BEGIN TRANSACTION
		DECLARE @err INT = 0;

		DECLARE @pagoID INT;

		SELECT @pagoID = ISNULL(MAX(PagoID), 0) + 1 FROM PagoAgricultores;

		DECLARE @metodo CHAR(1);

		SELECT @metodo = CASE @metodoPago
							  WHEN 'Cheque' THEN 'C'
							  WHEN 'Deposito' THEN 'D'
							  END;
		
		DECLARE @saldo FLOAT = (SELECT dbo.fSaldoPendienteAgricultorPorCosecha(@cosechaID, @agricultorID));

		DECLARE @montoMasAbono FLOAT = (SELECT SUM(Monto) FROM PagoAgricultores WHERE AgricultorID = @agricultorID AND CosechaID = @cosechaID AND Tipo = 'A') + @monto;

		IF (@montoMasAbono / @saldo) > 0.60 SELECT @err = 1

		INSERT INTO PagoAgricultores(PagoID, AgricultorID, CosechaID, Fecha, Tipo, MetodoPago, Monto)
		VALUES (@pagoID, @agricultorID, @cosechaID, @fecha, 'A', @metodo, @monto);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO