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
		
		DECLARE @saldoMenosAbonos FLOAT = (SELECT dbo.fLiquidacionPendienteAgricultorPorCosecha(@cosechaID, @agricultorID));

		DECLARE @saldo FLOAT = (SELECT dbo.fSaldoPendienteAgricultorPorCosecha(@cosechaID, @agricultorID));

		DECLARE @montoMasAbono FLOAT = ISNULL((SELECT SUM(Monto) FROM PagoAgricultores WHERE AgricultorID = @agricultorID AND CosechaID = @cosechaID AND Tipo = 'A'), 0) + @monto;

		IF (@montoMasAbono / @saldo) > 0.60 SELECT @err = 1;

		INSERT INTO PagoAgricultores(PagoID, AgricultorID, CosechaID, Fecha, Tipo, MetodoPago, Monto)
		VALUES (@pagoID, @agricultorID, @cosechaID, @fecha, 'A', @metodo, @monto);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @mensajeError VARCHAR(MAX);

		SELECT @mensajeError = CONCAT('Verificar que los abonos totales no sean menor que el 60% del saldo total.', CHAR(10), 'Saldo Total: ',@saldo, CHAR(10), 'Saldo con abonos deducidos: ', @saldoMenosAbonos, CHAR(10), 'Abonos Máximos Permitidos: ', (@saldo * 0.60));
	IF @err = 0
		COMMIT TRANSACTION;
	ELSE IF @err = 1 
		BEGIN
			ROLLBACK TRANSACTION;
			THROW 50000, @mensajeError, 1;
		END
GO