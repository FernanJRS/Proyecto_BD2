USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeleteDetalleProductos ON CosechaDetalleAgricultor FOR DELETE
AS
	DECLARE @cosechaID INT, @productoID INT;

	DECLARE @existAnterior FLOAT, @existNuevas FLOAT;

	DECLARE crsProducto CURSOR FOR
	SELECT CosechaID, ProductoID FROM deleted;

	OPEN crsProducto;

	FETCH NEXT FROM crsProducto INTO @cosechaID, @productoID;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existAnterior = (SELECT Existencias FROM ProductosAgricolas WHERE ProductoID = @productoID);

			SELECT @existNuevas = @existAnterior - ISNULL((SELECT Cantidad FROM deleted WHERE CosechaID = @cosechaID AND ProductoID = @productoID), 0)

			UPDATE ProductosAgricolas SET Existencias = @existNuevas
			WHERE ProductoID = @productoID;

			FETCH NEXT FROM crsProducto INTO @cosechaID, @productoID;
		END

	DEALLOCATE crsProducto;
GO