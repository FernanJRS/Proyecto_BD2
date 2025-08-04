USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgDeteleDetalleAgricultorInsumos ON AgricultorInsumosDetalle FOR DELETE
AS
	DECLARE @agricultorInsumoID INT, @insumoID INT;

	DECLARE crsAgricultorInsumos CURSOR FOR
	SELECT AgricultorInsumoID, InsumoID FROM deleted;

	OPEN crsAgricultorInsumos;

	FETCH NEXT FROM crsAgricultorInsumos INTO @agricultorInsumoID, @insumoID;
	
	DECLARE @tInsumosDevueltos TABLE (InsumoID INT, Existencias FLOAT);

	INSERT INTO @tInsumosDevueltos
	SELECT InsumoID, ISNULL(Existencias, 0) FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM deleted);

	DECLARE @existGuardado FLOAT, @existDevueltas FLOAT;
	
	DECLARE @devuelto FLOAT;	
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardado = Existencias FROM @tInsumosDevueltos WHERE InsumoID = @insumoID;

			SELECT @existDevueltas = Cantidad FROM deleted WHERE AgricultorInsumoID = @agricultorInsumoID AND InsumoID = @insumoID;

			SELECT @devuelto = @existGuardado + @existDevueltas;

			UPDATE InsumosAgricolas SET Existencias = @devuelto
			WHERE InsumoID = @insumoID;

			FETCH NEXT FROM crsAgricultorInsumos INTO @agricultorInsumoID, @insumoID;
		END
	
	DEALLOCATE crsAgricultorInsumos;
GO