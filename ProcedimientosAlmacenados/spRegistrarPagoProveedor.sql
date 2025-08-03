USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarPagoProveedor
@proveedorID INT, @compraInsumoID INT, @fecha DATETIME, @metodoPago VARCHAR(50), @monto FLOAT
AS
	BEGIN TRANSACTION
		DECLARE @err INT = 0;

		DECLARE @pagoID INT;

		SELECT @pagoID = ISNULL(MAX(PagoID), 0) + 1 FROM PagoProveedores;

		DECLARE @metodo CHAR(1);

		SELECT @metodo = CASE @metodoPago 
							  WHEN 'Cheque' THEN 'C'
							  WHEN 'Deposito' THEN 'D'
							  END;
		DECLARE @saldo FLOAT;

		SELECT @saldo = (SELECT dbo.fSaldoPendienteProveedorPorCompra(@proveedorID, @compraInsumoID));

		IF @monto > @saldo SELECT @err = 1;

		INSERT INTO PagoProveedores (PagoID, ProveedorID, CompraInsumoID, Fecha, MetodoPago, Monto)
		VALUES (@pagoID, @proveedorID, @compraInsumoID, @fecha, @metodo, @monto)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		UPDATE CompraInsumos SET EstadoPago = 'L'
		WHERE CompraInsumosID = @compraInsumoID AND ProveedorID = @proveedorID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		IF @err = 0 
			COMMIT TRANSACTION;
		ELSE
			ROLLBACK TRANSACTION;							
GO