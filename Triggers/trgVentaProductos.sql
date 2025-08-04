USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgVentaProductos ON FacturaDetalle FOR INSERT
AS
	DECLARE @tProductosVendidos TABLE (ProductoID INT, Existencias FLOAT);

	INSERT INTO @tProductosVendidos
	SELECT ProductoID, Existencias FROM ProductosAgricolas WHERE ProductoID IN (SELECT ProductoID FROM inserted);

	DECLARE @facturaID INT, @productoID INT;

	DECLARE crsProductos CURSOR FOR
	SELECT FacturaID, ProductoID FROM inserted;

	OPEN crsProductos;

	FETCH NEXT FROM crsProductos INTO @facturaID, @productoID;

	DECLARE @existGuardadas FLOAT, @existFacturadas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardadas = Existencias FROM @tProductosVendidos WHERE ProductoID = @productoID;

			SELECT @existFacturadas = CASE Unidad
										   WHEN 'Fardos' THEN Cantidad * 0.20
										   WHEN 'Arrobas' THEN Cantidad * 0.25
										   WHEN 'Quintales' THEN Cantidad
										   END 
										   FROM inserted
			WHERE FacturaID = @facturaID AND ProductoID = @productoID;

			UPDATE ProductosAgricolas SET Existencias = @existGuardadas - @existFacturadas
			WHERE ProductoID = @productoID;

			FETCH NEXT FROM crsProductos INTO @facturaID, @productoID;
		END

	DEALLOCATE crsProductos;
GO