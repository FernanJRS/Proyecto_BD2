USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spModificarCosechaLote 
@fincaID INT, @loteID INT, @fechaSiembra DATETIME
AS
	IF @fechaSiembra < GETDATE()
		UPDATE Lotes SET FechaSiembra = @fechaSiembra
		WHERE FincaID = @fincaID AND LoteID = @loteID;

	IF @fechaSiembra > GETDATE()
		THROW 50000, 'La fecha de siembra no puede ser mayor que la fecha actual', 1;
GO