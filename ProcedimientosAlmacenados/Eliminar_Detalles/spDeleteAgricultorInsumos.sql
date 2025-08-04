USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spDeleteAgricultorInsumos
@agricultorInsumosID INT
AS
	BEGIN TRANSACTION
		
		DELETE FROM AgricultorInsumosDetalle WHERE AgricultorInsumoID = @agricultorInsumosID;

		DELETE FROM AgricultorInsumos WHERE AgricultorInsumoID = @agricultorInsumosID;
		
	IF @@ERROR = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO