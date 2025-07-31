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

	DECLARE @precioAnterior FLOAT, @precioNuevo FLOAT, @existenciasNuevas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN				
			SELECT @precioAnterior = Precio, 
			@existenciasNuevas = Existencias + (SELECT Cantidad FROM inserted WHERE InsumoID = @insumoID) FROM InsumosAgricolas WHERE InsumoID = @insumoID;
			
			SELECT @precioNuevo = Precio FROM inserted WHERE InsumoID = @insumoID;
			
			UPDATE InsumosAgricolas SET Precio = ((Existencias * @precioAnterior)+((@existenciasNuevas - Existencias) * @precioNuevo))/(@existenciasNuevas), 
			Existencias = @existenciasNuevas
			WHERE InsumoID = @insumoID;
			
			FETCH NEXT FROM crsInsumos INTO @insumoID;
		END

	DEALLOCATE crsInsumos;
GO