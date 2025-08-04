USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarCosecha
@agricultorID INT, @finca VARCHAR(100), @bodega VARCHAR(100), @fecha DATETIME, @tdetalle DetalleCosecha READONLY
AS
	BEGIN TRANSACTION
		DECLARE @err INT = 0;
		DECLARE @cosechaID INT, @bodegaID INT, @cantidadCosechas FLOAT;

		SELECT @cosechaID = ISNULL(MAX(CosechaID), 0) + 1 FROM CosechaAgricultor;

		SELECT @bodegaID = BodegaID FROM Bodega WHERE Nombre = @bodega;

		INSERT INTO CosechaAgricultor (CosechaID, AgricultorID, BodegaID, Fecha, Monto)
		VALUES (@cosechaID, @agricultorID, @bodegaID, @fecha, 0.00);
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;
		
		DECLARE @verifCodigo VARCHAR(10);
		DECLARE crsVerificarProductos CURSOR FOR
		SELECT Codigo FROM @tdetalle;

		OPEN crsVerificarProductos;

		FETCH NEXT FROM crsVerificarProductos INTO @verifCodigo;
		
		DECLARE @tProductosAgricultor TABLE (Codigo VARCHAR(10));
		
		INSERT INTO @tProductosAgricultor
		SELECT DISTINCT PA.Codigo FROM ProductosAgricolas PA INNER JOIN Lotes L ON PA.ProductoID = L.ProductoID 
		INNER JOIN Fincas F ON L.FincaID = F.FincaID WHERE F.AgricultorID = @agricultorID;
		
		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF ((SELECT Codigo FROM @tProductosAgricultor WHERE Codigo = @verifCodigo) IS NULL) SELECT @err = 1;

				FETCH NEXT FROM crsVerificarProductos INTO @verifCodigo;
			END

		DEALLOCATE crsVerificarProductos;

		INSERT INTO CosechaDetalleAgricultor (CosechaID, ProductoID, Cantidad, Precio)
		SELECT @cosechaID, CAST(RIGHT(Codigo, 3) AS INT), Cantidad, Precio FROM @tdetalle;
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;
		
		DECLARE @total FLOAT;

		SELECT @total = SUM(Precio * Cantidad) FROM @tdetalle;

		UPDATE CosechaAgricultor SET Monto = @total
		WHERE CosechaID = @cosechaID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @codigo VARCHAR(10);

		DECLARE crsCosechas CURSOR FOR
		SELECT Codigo FROM @tdetalle;

		OPEN crsCosechas;

		FETCH NEXT FROM crsCosechas INTO @codigo;
		
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @cantidadCosechas = SUM(Cantidad) FROM @tdetalle WHERE Codigo = @codigo;
				
				UPDATE Lotes SET CantidadCosechas = @cantidadCosechas
				WHERE FincaID = (SELECT FincaID FROM Fincas WHERE Nombre = @finca AND AgricultorID = @agricultorID) AND ProductoID = CAST(RIGHT(@codigo, 3) AS INT);
				
				IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

				FETCH NEXT FROM crsCosechas INTO @codigo;
			END

		DEALLOCATE crsCosechas;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO