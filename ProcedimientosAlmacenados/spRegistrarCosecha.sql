USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarCosecha
@agricultorID INT, @bodega VARCHAR(100), @fecha DATETIME, @tdetalle DetalleCosecha READONLY
AS
	BEGIN TRANSACTION
		DECLARE @err INT = 0;
		DECLARE @cosechaID INT, @bodegaID INT;

		SELECT @cosechaID = ISNULL(MAX(CosechaID), 0) + 1 FROM CosechaAgricultor;

		SELECT @bodegaID = BodegaID FROM Bodega WHERE Nombre = @bodega;

		INSERT INTO CosechaAgricultor (CosechaID, AgricultorID, BodegaID, Fecha, Monto)
		VALUES (@cosechaID, @agricultorID, @bodegaID, @fecha, 0.00);
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;
		
		INSERT INTO CosechaDetalleAgricultor (CosechaID, ProductoID, Cantidad, Precio)
		SELECT @cosechaID, CAST(RIGHT(Codigo, 3) AS INT), Cantidad, Precio FROM @tdetalle;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @total FLOAT;

		SELECT @total = SUM(Precio * Cantidad) FROM @tdetalle;

		UPDATE CosechaAgricultor SET Monto = @total
		WHERE CosechaID = @cosechaID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO