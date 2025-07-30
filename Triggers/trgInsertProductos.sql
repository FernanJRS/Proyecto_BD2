USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgInsertProductos ON CosechaDetalleAgricultor FOR INSERT
AS
	DECLARE @productoID INT;

	DECLARE @tPrecioGuardado TABLE (ProductoID INT, Precio NUMERIC(11,2));

	INSERT INTO @tPrecioGuardado
	SELECT ProductoID, Precio FROM ProductosAgricolas WHERE ProductoID IN (SELECT ProductoID FROM inserted);

	DECLARE crsProductos CURSOR FOR
	SELECT ProductoID FROM inserted;

	OPEN crsProductos;
	
	FETCH NEXT FROM crsProductos INTO @productoID;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (SELECT Precio FROM inserted WHERE ProductoID = @productoID) > (SELECT Precio FROM @tPrecioGuardado WHERE ProductoID = @productoID)
				BEGIN
					UPDATE ProductosAgricolas SET Precio = (SELECT Precio FROM inserted WHERE ProductoID = @productoID), 
					Existencias = Existencias + (SELECT Cantidad FROM inserted WHERE ProductoID = @productoID)
					WHERE ProductoID = @productoID
				END
			ELSE
				BEGIN
					UPDATE ProductosAgricolas SET Existencias = Existencias + (SELECT Cantidad FROM inserted WHERE ProductoID = @productoID)
					WHERE ProductoID = @productoID
				END

			FETCH NEXT FROM crsProductos INTO @productoID;
		END

	DEALLOCATE crsProductos;
GO