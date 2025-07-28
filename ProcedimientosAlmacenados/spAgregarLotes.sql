USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarLoteFinca
@fincaID INT, @codigoProducto VARCHAR(10), @nombre VARCHAR(100),
@extension FLOAT, @tipoSuelo VARCHAR(100), @tipoRiego VARCHAR(100)
AS
	DECLARE @loteID INT, @sueloID INT, @riegoID INT, @productoID INT, @areaFinca FLOAT, @otrosLotes FLOAT;
	
	SELECT @loteID = ISNULL(MAX(LoteID), 0) + 1 FROM Lotes WHERE FincaID = @fincaID;

	SELECT @sueloID = TipoID FROM TipoSuelo WHERE Nombre = @tipoSuelo;

	SELECT @riegoID = TipoID FROM TipoRiego WHERE Nombre = @tipoRiego;

	SELECT @productoID = RIGHT(@codigoProducto, 3);

	SELECT @areaFinca = Extension FROM Fincas WHERE FincaID = @fincaID;

	SELECT @otrosLotes = ISNULL(SUM(Extension), 0) FROM Lotes WHERE FincaID = @fincaID

	IF @extension < (@areaFinca - @otrosLotes)
		BEGIN
			INSERT INTO Lotes (FincaID, LoteID, ProductoID, Nombre, Extension, TipoSueloID, TipoRiegoID)
			VALUES (@fincaID, @loteID, @productoID, @nombre, @extension, @sueloID, @riegoID);
		END
	
	IF @extension > (@areaFinca - @otrosLotes)
		INSERT INTO Lotes VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
		
GO
