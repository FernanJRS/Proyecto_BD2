USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeleteDetalleInsumos ON CompraDetalleInsumos FOR DELETE
AS
	DECLARE @compraID INT, @insumoID INT;

	DECLARE @existAnterior FLOAT, @existNuevas FLOAT;

	DECLARE crsInsumos CURSOR FOR
	SELECT CompraInsumoID, InsumoID FROM deleted;

	OPEN crsInsumos;

	FETCH NEXT FROM crsInsumos INTO @compraID, @insumoID;
	
	DECLARE @tInsumosEliminados TABLE (InsumoID INT, Precio NUMERIC(11,2), Existencias FLOAT);

	INSERT INTO @tInsumosEliminados
	SELECT InsumoID, Precio, Existencias FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM deleted);

	DECLARE @precioGuardado FLOAT, @precioEliminado FLOAT, @existGuardado FLOAT, @existEliminadas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardado = Existencias, @precioGuardado = Precio FROM InsumosAgricolas WHERE InsumoID = @insumoID;

			SELECT @existEliminadas = Cantidad, @precioEliminado = Precio FROM deleted WHERE CompraInsumoID = @compraID AND InsumoID = @insumoID;

			UPDATE InsumosAgricolas SET Existencias = @existGuardado - @existEliminadas,
			Precio = ((@precioGuardado * @existGuardado) - (@precioEliminado * @existEliminadas)) / (@existGuardado - @existEliminadas)
			WHERE InsumoID = @insumoID;

			FETCH NEXT FROM crsInsumos INTO @compraID, @insumoID;
		END

	DEALLOCATE crsInsumos;
GO