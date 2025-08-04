USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.ftAgricultorFincasLotes(@agricultor VARCHAR(100) = NULL, @finca VARCHAR(100) = NULL) RETURNS
@tAgricultores TABLE (Nombre VARCHAR(100), Finca VARCHAR(100), ExtensionFinca VARCHAR(100), Lote VARCHAR(100), ProductoEnLote VARCHAR(100), 
ExtensionLote VARCHAR(100), TipoSuelo VARCHAR(100), TipoRiego VARCHAR(100), CantidadCosechas VARCHAR(100))
AS
	BEGIN
		DECLARE @agricultorID INT, @fincaID INT;

		SELECT @agricultorID = AgricultorID FROM Agricultor WHERE Nombre = @agricultor;

		DECLARE @tAgricultorElegido TABLE (AgricultorID INT, Nombre VARCHAR(100));

		INSERT INTO @tAgricultorElegido
		SELECT AgricultorID, Nombre FROM Agricultor WHERE AgricultorID = @agricultorID OR @agricultorID IS NULL;

		SELECT @fincaID = FincaID FROM Fincas WHERE AgricultorID = @agricultorID AND Nombre = @finca;

		DECLARE @tFincasAgricultor TABLE (AgricultorID INT, NombreAgricultor VARCHAR(100), FincaID INT, NombreFinca VARCHAR(100), Extension NUMERIC(11,2));

		INSERT INTO @tFincasAgricultor
		SELECT A.AgricultorID, A.Nombre, F.FincaID, F.Nombre, F.Extension FROM Fincas F
		INNER JOIN @tAgricultorElegido A ON F.AgricultorID = A.AgricultorID
		WHERE FincaID = @fincaID OR @fincaID IS NULL

		INSERT INTO @tAgricultores
		SELECT A.Nombre, F.NombreFinca AS NombreFinca, F.Extension AS ExtensionFinca, 
		L.Nombre AS NombreLote, PA.Nombre AS Producto, L.Extension AS ExtensionLote, TS.Nombre AS TipoSuelo, TR.Nombre AS TipoRiego, L.CantidadCosechas
		FROM @tAgricultorElegido A INNER JOIN @tFincasAgricultor F ON A.AgricultorID = F.AgricultorID
		INNER JOIN Lotes L ON F.FincaID = L.FincaID
		INNER JOIN ProductosAgricolas PA ON L.ProductoID = PA.ProductoID
		INNER JOIN TipoRiego TR ON L.TipoRiegoID = TR.TipoID
		INNER JOIN TipoSuelo TS ON L.TipoSueloID = TS.TipoID
		ORDER BY A.Nombre

		RETURN;
	END
GO