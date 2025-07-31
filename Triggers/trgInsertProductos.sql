USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgInsertProductos ON CosechaDetalleAgricultor FOR INSERT
AS
	DECLARE @productoID INT;

	DECLARE @tProductosGuardados TABLE (ProductoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

	INSERT INTO @tProductosGuardados
	SELECT ProductoID, Precio, Existencias FROM ProductosAgricolas WHERE ProductoID IN (SELECT ProductoID FROM inserted);

	DECLARE crsProductos CURSOR FOR
	SELECT ProductoID FROM inserted;

	OPEN crsProductos;
	
	FETCH NEXT FROM crsProductos INTO @productoID;

	DECLARE @precioAnterior FLOAT, @precioNuevo FLOAT, @existenciasNuevas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @precioAnterior = Precio, 
			@existenciasNuevas = Existencias + (SELECT Cantidad FROM inserted WHERE ProductoID = @productoID) FROM @tProductosGuardados WHERE ProductoID = @productoID;
			
			SELECT @precioNuevo = Precio FROM inserted WHERE ProductoID = @productoID;

			UPDATE ProductosAgricolas SET Precio = ((Existencias * @precioAnterior)+((@existenciasNuevas - Existencias) * @precioNuevo))/(@existenciasNuevas), 
			Existencias = @existenciasNuevas
			WHERE ProductoID = @productoID
	

			FETCH NEXT FROM crsProductos INTO @productoID;
		END

	DEALLOCATE crsProductos;
GO