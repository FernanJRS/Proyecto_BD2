USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeleteDetalleProductos ON CosechaDetalleAgricultor FOR DELETE
AS
	DECLARE @cosechaID INT, @productoID INT;

	DECLARE crsProducto CURSOR FOR
	SELECT CosechaID, ProductoID FROM deleted;

	OPEN crsProducto;
	
	FETCH NEXT FROM crsProducto INTO @cosechaID, @productoID;
	
	DECLARE @tProductosEliminados TABLE (ProductoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

	INSERT INTO @tProductosEliminados
	SELECT ProductoID, Precio, Existencias FROM ProductosAgricolas WHERE ProductoID IN (SELECT ProductoID FROM deleted);

	DECLARE @precioGuardado FLOAT, @precioEliminado FLOAT, @existGuardado FLOAT, @existEliminadas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardado = Existencias, @precioGuardado = Precio FROM ProductosAgricolas WHERE ProductoID = @productoID;

			SELECT @existEliminadas = Cantidad, @precioEliminado = Precio FROM deleted WHERE CosechaID = @cosechaID AND ProductoID = @productoID

			UPDATE ProductosAgricolas SET Existencias = @existGuardado - @existEliminadas,
			Precio = ((@precioGuardado * @existGuardado) - (@precioEliminado * @existEliminadas)) / (@existGuardado - @existEliminadas)
			WHERE ProductoID = @productoID;

			FETCH NEXT FROM crsProducto INTO @cosechaID, @productoID;
		END

	DEALLOCATE crsProducto;
GO