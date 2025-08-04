USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgInsertInsumos ON CompraInsumos FOR UPDATE
AS
	DECLARE @estadoIN VARCHAR(50), @estadoFI VARCHAR(50);

	SELECT @estadoIN = EstadoEntrega FROM deleted

	SELECT @estadoFI = EstadoEntrega FROM inserted

	IF @estadoIN = 'P' AND @estadoFI = 'E'
	BEGIN
		DECLARE @compraID INT;
		
		SELECT @compraID = CompraInsumosID FROM inserted;

		DECLARE @tCompraDetalle TABLE (CompraID INT, InsumoID INT, Cantidad FLOAT, Precio FLOAT, Descuento FLOAT, Unidad VARCHAR(50));

		INSERT INTO @tCompraDetalle (CompraID, InsumoID, Cantidad, Precio, Descuento, Unidad)
		SELECT * FROM CompraDetalleInsumos WHERE CompraInsumoID = @compraID;
		
		DECLARE @insumoID INT;

		DECLARE @tInsumosGuardados TABLE (InsumoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

		INSERT INTO @tInsumosGuardados
		SELECT InsumoID, Precio, Existencias FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM @tCompraDetalle);

		DECLARE crsInsertInsumos CURSOR FOR
		SELECT InsumoID FROM @tCompraDetalle;

		OPEN crsInsertInsumos;
		
		FETCH NEXT FROM crsInsertInsumos INTO @insumoID;

		DECLARE @precioAnterior FLOAT, @precioNuevo FLOAT, @existenciasNuevas FLOAT;

		WHILE @@FETCH_STATUS = 0
			BEGIN				
				SELECT @precioAnterior = Precio, 
				@existenciasNuevas = Existencias + (SELECT Cantidad FROM @tCompraDetalle WHERE InsumoID = @insumoID) FROM @tInsumosGuardados WHERE InsumoID = @insumoID;
				
				SELECT @precioNuevo = Precio FROM @tCompraDetalle WHERE InsumoID = @insumoID;
				
				UPDATE InsumosAgricolas SET Precio = ((Existencias * @precioAnterior)+((@existenciasNuevas - Existencias) * @precioNuevo))/(@existenciasNuevas), 
				Existencias = @existenciasNuevas
				WHERE InsumoID = @insumoID;
				
				FETCH NEXT FROM crsInsertInsumos INTO @insumoID;
			END

		DEALLOCATE crsInsertInsumos;
	END
GO