USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fSaldoPendienteProveedorPorCompra(@proveedorID INT, @compraInsumosID INT) 
RETURNS NUMERIC(11,2)
AS
	BEGIN
		DECLARE @saldo FLOAT, @fechaVencimiento DATETIME;

		SELECT @saldo = ISNULL(SubTotal, 0) - ISNULL(Descuento, 0), @fechaVencimiento = FechaVencimiento FROM CompraInsumos
		WHERE CompraInsumosID = @compraInsumosID AND ProveedorID = @proveedorID AND EstadoPago = 'Pendiente';

		IF GETDATE() > @fechaVencimiento
			SELECT @saldo = @saldo * 1.05;

		RETURN ISNULL(@saldo, 0)

	END
GO
