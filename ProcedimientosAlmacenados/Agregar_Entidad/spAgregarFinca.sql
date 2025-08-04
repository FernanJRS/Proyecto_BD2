USE GrupoNo4
GO

-- Agregar Finca a Agricultor
CREATE OR ALTER PROCEDURE spAgregarFinca
@agricultorID INT, @nombre VARCHAR(100), @ubicacion VARCHAR(50), @extension FLOAT
AS
	DECLARE @fincaID INT;

	SELECT @fincaID = ISNULL(MAX(FincaID), 0) + 1 FROM Fincas;

	INSERT INTO Fincas (FincaID, AgricultorID, Nombre, Ubicacion, Extension) VALUES
	(@fincaID, @agricultorID, @nombre, @ubicacion, @extension)
GO