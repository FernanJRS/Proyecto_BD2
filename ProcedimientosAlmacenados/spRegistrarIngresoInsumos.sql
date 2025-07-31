USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarIngresoInsumos @compraID INT
AS
	DECLARE @estadoEntrega VARCHAR(50);

	SELECT @estadoEntrega = EstadoEntrega FROM CompraInsumos WHERE CompraInsumosID = @compraID;

	IF @estadoEntrega = 'Entregado'
	BEGIN
		DECLARE @tCompraDetalle TABLE (CompraID INT, InsumoID INT, Cantidad FLOAT, Precio FLOAT, Descuento FLOAT, Unidad VARCHAR(50));

		INSERT INTO @tCompraDetalle (CompraID, InsumoID, Cantidad, Precio, Descuento, Unidad)
		SELECT * FROM CompraDetalleInsumos WHERE CompraInsumoID = @compraID;
		
		DECLARE @insumoID INT;

		DECLARE @tInsumosGuardados TABLE (InsumoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

		INSERT INTO @tInsumosGuardados
		SELECT InsumoID, Precio, Existencias FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM @tCompraDetalle);

		DECLARE crsInsumos CURSOR FOR
		SELECT InsumoID FROM @tCompraDetalle;

		OPEN crsInsumos;
		
		FETCH NEXT FROM crsInsumos INTO @insumoID;

		DECLARE @precioAnterior FLOAT, @precioNuevo FLOAT, @existenciasNuevas FLOAT;

		WHILE @@FETCH_STATUS = 0
			BEGIN				
				SELECT @precioAnterior = Precio, 
				@existenciasNuevas = Existencias + (SELECT Cantidad FROM @tCompraDetalle WHERE InsumoID = @insumoID) FROM @tInsumosGuardados WHERE InsumoID = @insumoID;
				
				SELECT @precioNuevo = Precio FROM @tCompraDetalle WHERE InsumoID = @insumoID;
				
				UPDATE InsumosAgricolas SET Precio = ((Existencias * @precioAnterior)+((@existenciasNuevas - Existencias) * @precioNuevo))/(@existenciasNuevas), 
				Existencias = @existenciasNuevas
				WHERE InsumoID = @insumoID;
				
				FETCH NEXT FROM crsInsumos INTO @insumoID;
			END

		DEALLOCATE crsInsumos;
	END
GO