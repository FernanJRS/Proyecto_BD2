USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarLiquidacionAgricultor
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

		DECLARE @saldo FLOAT, @deduccionInsumos FLOAT = 0;

		SELECT @saldo = (SELECT dbo.fLiquidacionPendienteAgricultorPorCosecha(@cosechaID, @agricultorID));

		DECLARE @tAgricultorInsumos TABLE (AgricultorInsumoID INT);

		INSERT INTO @tAgricultorInsumos (AgricultorInsumoID) 
		SELECT AgricultorInsumoID FROM AgricultorInsumos WHERE AgricultorID IN (SELECT AgricultorInsumoID FROM dbo.ftInsumosPendientesAgricultor(@agricultorID, @saldo));
		
		IF (SELECT COUNT(*) FROM @tAgricultorInsumos) > 0 
			BEGIN
				SELECT @deduccionInsumos = SUM(ISNULL(SubTotal, 0) + ISNULL(Impuesto, 0) - ISNULL(Descuento, 0)) FROM AgricultorInsumos 
				WHERE AgricultorInsumoID IN (SELECT AgricultorInsumoID FROM @tAgricultorInsumos);
			END

		DECLARE @montoPendiente FLOAT;

		SELECT @montoPendiente = @saldo - @deduccionInsumos;

		IF @montoPendiente <> @monto SELECT @err = 1;

		INSERT INTO PagoAgricultores (PagoID, AgricultorID, CosechaID, Fecha, Tipo, MetodoPago, Monto)
		VALUES (@pagoID, @agricultorID, @cosechaID, @fecha, 'L', @metodo, @monto);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		UPDATE CosechaAgricultor SET Estado = 'L'
		WHERE CosechaID = @cosechaID AND AgricultorID = @agricultorID AND Estado = 'P';
	
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;
	
		IF (SELECT COUNT(*) FROM @tAgricultorInsumos) > 0 
			BEGIN
				UPDATE AgricultorInsumos SET Estado = 'C'
				WHERE AgricultorInsumoID IN (SELECT AgricultorInsumoID FROM @tAgricultorInsumos);
				
				IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;
			END

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO