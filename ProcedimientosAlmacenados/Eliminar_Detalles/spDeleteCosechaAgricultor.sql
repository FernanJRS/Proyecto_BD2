USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spDeleteCosechaAgricultor
@cosechaID INT
AS
	BEGIN TRANSACTION
		
		DELETE CosechaDetalleAgricultor WHERE CosechaID = @cosechaID;

		DELETE CosechaAgricultor WHERE CosechaID = @cosechaID;

	IF @@ERROR = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO