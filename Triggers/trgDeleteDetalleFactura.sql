USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeleteDetalleFactura ON FacturaDetalle FOR DELETE
AS
	DECLARE @facturaID INT, @productoID INT;

	DECLARE crsFacturaDetalle CURSOR FOR
	SELECT FacturaID, ProductoID FROM deleted;

	OPEN crsFacturaDetalle;

	FETCH NEXT FROM crsFacturaDetalle INTO @facturaID, @productoID;
	
	DECLARE @tProductosDevueltos TABLE (ProductoID INT, Existencias FLOAT);

	INSERT INTO @tProductosDevueltos
	SELECT ProductoID, ISNULL(Existencias, 0) FROM ProductosAgricolas WHERE ProductoID IN (SELECT ProductoID FROM deleted);

	DECLARE @existGuardado FLOAT, @existDevueltas FLOAT;
	
	DECLARE @devuelto FLOAT;	
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardado = Existencias FROM @tProductosDevueltos WHERE ProductoID = @productoID;

			SELECT @existDevueltas = Cantidad FROM deleted WHERE FacturaID = @facturaID AND ProductoID = @productoID;

			SELECT @devuelto = @existGuardado + @existDevueltas;

			UPDATE ProductosAgricolas SET Existencias = @devuelto
			WHERE ProductoID = @productoID;
			
			FETCH NEXT FROM crsFacturaDetalle INTO @facturaID, @productoID;
		END
	
	DEALLOCATE crsFacturaDetalle;
GO