USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.ftInsumosPendientesAgricultor(@agricultorID INT, @saldoPendiente FLOAT) RETURNS 
@tInsumosPendientes TABLE (AgricultorInsumoID INT)
AS
	BEGIN
		DECLARE @tInsumosRequeridos TABLE (AgricultorInsumoID INT, SubTotal FLOAT, Impuesto FLOAT, Descuento FLOAT);

		INSERT INTO @tInsumosRequeridos (AgricultorInsumoID, SubTotal, Impuesto, Descuento)
		SELECT AgricultorInsumoID, SubTotal, Impuesto, Descuento FROM AgricultorInsumos WHERE AgricultorID = @agricultorID AND Estado = 'P';
		
		DECLARE @agricultorInsumoID INT;

		DECLARE crsAgricultorInsumos CURSOR FOR 
		SELECT AgricultorInsumoID FROM @tInsumosRequeridos;

		OPEN crsAgricultorInsumos;

		FETCH NEXT FROM crsAgricultorInsumos INTO @agricultorInsumoID;

		DECLARE @deduccionInsumos FLOAT = 0;

		DECLARE @esMenor INT = 1;

		WHILE @@FETCH_STATUS = 0 AND @esMenor = 1
			BEGIN
				SELECT @deduccionInsumos += (SubTotal + Impuesto - Descuento) FROM @tInsumosRequeridos WHERE AgricultorInsumoID = @agricultorInsumoID;

				IF @saldoPendiente > @deduccionInsumos
					BEGIN
						SELECT @saldoPendiente -= @deduccionInsumos;

						INSERT INTO @tInsumosPendientes
						SELECT @agricultorInsumoID;
					END

				IF @deduccionInsumos > @saldoPendiente
					SELECT @esMenor = 0;

				FETCH NEXT FROM crsAgricultorInsumos INTO @agricultorInsumoID;
			END

		RETURN
	END
GO