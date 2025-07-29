USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spModificarCosechaLote 
@fincaID INT, @loteID INT, @cosechas INT, @fechaSiembra DATETIME
AS
	IF @fechaSiembra < GETDATE()
		UPDATE Lotes SET CantidadCosechas = @cosechas, FechaSiembra = @fechaSiembra
		WHERE FincaID = @fincaID AND LoteID = @loteID;

	IF @fechaSiembra > GETDATE()
		INSERT INTO Lotes VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
GO