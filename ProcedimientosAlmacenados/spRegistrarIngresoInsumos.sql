USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarIngresoInsumos @compraID INT
AS
	DECLARE @estado VARCHAR(50) = 'Entregado'
	
	UPDATE CompraInsumos SET EstadoEntrega = @estado
	WHERE CompraInsumosID = @compraID
GO