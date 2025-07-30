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

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existAnterior = (SELECT Existencias FROM InsumosAgricolas WHERE InsumoID = @insumoID);

			SELECT @existNuevas = @existAnterior - ISNULL((SELECT Cantidad FROM deleted WHERE CompraInsumoID = @compraID AND InsumoID = @insumoID), 0)

			UPDATE InsumosAgricolas SET Existencias = @existNuevas
			WHERE InsumoID = @insumoID;

			FETCH NEXT FROM crsInsumos INTO @compraID, @insumoID;
		END

	DEALLOCATE crsInsumos;
GO