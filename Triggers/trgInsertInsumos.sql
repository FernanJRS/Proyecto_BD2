USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgInsertInsumos ON CompraDetalleInsumos FOR INSERT
AS
	DECLARE @insumoID INT;

	DECLARE @tPrecioGuardado TABLE (InsumoID INT, Precio NUMERIC(11,2));

	INSERT INTO @tPrecioGuardado
	SELECT InsumoID, Precio FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM inserted);

	DECLARE crsInsumos CURSOR FOR
	SELECT InsumoID FROM inserted;

	OPEN crsInsumos;
	
	FETCH NEXT FROM crsInsumos INTO @insumoID;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (SELECT Precio FROM inserted WHERE InsumoID = @insumoID) > (SELECT Precio FROM @tPrecioGuardado WHERE InsumoID = @insumoID)
				BEGIN
					UPDATE InsumosAgricolas SET Precio = (SELECT Precio FROM inserted WHERE InsumoID = @insumoID), 
					Existencias = Existencias + (SELECT Cantidad FROM inserted WHERE InsumoID = @insumoID)
					WHERE InsumoID = @insumoID;
				END
			ELSE
				BEGIN
					UPDATE InsumosAgricolas SET Existencias = Existencias + (SELECT Cantidad FROM inserted WHERE InsumoID = @insumoID)
					WHERE InsumoID = @insumoID
				END

			FETCH NEXT FROM crsInsumos INTO @insumoID;
		END

	DEALLOCATE crsInsumos;
GO