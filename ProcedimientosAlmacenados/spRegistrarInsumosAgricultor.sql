USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarInsumosAgricultor
@agricultorID INT, @fecha DATETIME, @tDetalle DetalleInsumo READONLY
AS
	BEGIN TRANSACTION
		
		DECLARE @err INT = 0;

		DECLARE @agricultorInsumoID INT;

		SELECT @agricultorInsumoID = ISNULL(MAX(AgricultorInsumoID), 0) + 1 FROM AgricultorInsumos;

		INSERT INTO AgricultorInsumos (AgricultorInsumoID, AgricultorID, Fecha, SubTotal, Descuento)
		VALUES (@agricultorInsumoID, @agricultorID, @fecha, 0.00, 0.00);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		INSERT INTO AgricultorInsumosDetalle (AgricultorInsumoID, InsumoID, Cantidad, Precio, Descuento)
		SELECT @agricultorInsumoID, CAST(RIGHT(Codigo, 3) AS INT), Cantidad, Precio, Descuento FROM @tDetalle

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @subTotal FLOAT, @desc FLOAT;

		SELECT @subTotal = SUM(Cantidad * Precio), @desc = SUM(Cantidad * Precio * Descuento) FROM @tDetalle;

		UPDATE AgricultorInsumos SET SubTotal = @subTotal, Descuento = @desc
		WHERE AgricultorInsumoID = @agricultorInsumoID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO