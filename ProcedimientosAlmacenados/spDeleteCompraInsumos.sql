USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spDeleteCompraInsumos 
@compraInsumoID INT
AS
	BEGIN TRANSACTION

		DELETE FROM CompraDetalleInsumos WHERE CompraInsumoID = @compraInsumoID;

		DELETE FROM CompraInsumos WHERE CompraInsumosID = @compraInsumoID;

	IF @@ERROR = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO