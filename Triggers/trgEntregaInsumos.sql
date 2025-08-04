USE GrupoNo4
GO

CREATE OR ALTER TRIGGER trgEntregaInsumos ON AgricultorInsumosDetalle FOR INSERT
AS
	DECLARE @tInsumosAfectados TABLE (InsumoID INT, Existencias FLOAT);

	INSERT INTO @tInsumosAfectados
	SELECT InsumoID, Existencias FROM InsumosAgricolas WHERE InsumoID IN (SELECT InsumoID FROM inserted);

	DECLARE @agricultorInsumoID INT, @insumoID INT;

	DECLARE crsEntregaInsumos CURSOR FOR
	SELECT AgricultorInsumoID, InsumoID FROM inserted;

	OPEN crsEntregaInsumos;

	FETCH NEXT FROM crsEntregaInsumos INTO @agricultorInsumoID, @insumoID;

	DECLARE @existGuardadas FLOAT, @existFacturadas FLOAT;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @existGuardadas = Existencias FROM @tInsumosAfectados WHERE InsumoID = @insumoID;

			SELECT @existFacturadas = Cantidad FROM inserted WHERE InsumoID = @insumoID AND AgricultorInsumoID = @agricultorInsumoID;
			
			UPDATE InsumosAgricolas SET Existencias = @existGuardadas - @existFacturadas
			WHERE InsumoID = @insumoID;

			FETCH NEXT FROM crsEntregaInsumos INTO @agricultorInsumoID, @insumoID;
		END

	DEALLOCATE crsEntregaInsumos;
GO