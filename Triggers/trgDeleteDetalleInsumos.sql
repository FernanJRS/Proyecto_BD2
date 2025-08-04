USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeleteDetalleInsumos ON CompraDetalleInsumos FOR DELETE
AS
	DECLARE @compraID INT, @insumoID INT;

	DECLARE @existAnterior FLOAT, @existNuevas FLOAT;

	DECLARE crsInsumosEliminados CURSOR FOR
	SELECT CompraInsumoID, InsumoID FROM deleted;

	OPEN crsInsumosEliminados;

	FETCH NEXT FROM crsInsumosEliminados INTO @compraID, @insumoID;
	
	DECLARE @tInsumosEliminados TABLE (InsumoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

	INSERT INTO @tInsumosEliminados
	SELECT InsumoID, Precio, ISNULL(Existencias, 0) FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM deleted);

	DECLARE @precioGuardado FLOAT, @precioEliminado FLOAT, @existGuardado FLOAT, @existEliminadas FLOAT;
	DECLARE @diferencia FLOAT, @dividiendo FLOAT;

	IF (SELECT EstadoEntrega FROM CompraInsumos WHERE CompraInsumosID = @compraID) = 'E'
		BEGIN
			WHILE @@FETCH_STATUS = 0
				BEGIN
					SELECT @existGuardado = Existencias, @precioGuardado = Precio FROM InsumosAgricolas WHERE InsumoID = @insumoID;

					SELECT @existEliminadas = Cantidad, @precioEliminado = Precio FROM deleted WHERE CompraInsumoID = @compraID AND InsumoID = @insumoID;

					SELECT @diferencia = @existGuardado - @existEliminadas, @dividiendo = (@precioGuardado * ISNULL(@existGuardado, 1)) - (@precioEliminado * ISNULL(@existEliminadas, 1));

					IF @diferencia = 0 SELECT @diferencia = 1;
					IF @dividiendo = 0 SELECT @dividiendo = 1;

					UPDATE InsumosAgricolas SET Existencias = ISNULL(@existGuardado, 1) - ISNULL(@existEliminadas, 1),
					Precio = (@dividiendo) / (@diferencia)
					WHERE InsumoID = @insumoID;

					FETCH NEXT FROM crsInsumosEliminados INTO @compraID, @insumoID;
				END
			
		END
	DEALLOCATE crsInsumosEliminados;
GO