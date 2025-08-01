USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spFacturarProductos
@clienteID INT, @tipo VARCHAR(50), @fecha DATETIME, @tDetalle DetalleVenta READONLY
AS
	BEGIN TRANSACTION

		DECLARE @err INT = 0;

		DECLARE @facturaID INT, @tipoFactura CHAR(1);

		SELECT @facturaID = ISNULL(MAX(FacturaID), 0) + 1 FROM Factura;

		SELECT @tipoFactura = CASE @tipo
										WHEN 'Credito' THEN 'R'
										WHEN 'Contado' THEN 'C'
										END;

		INSERT INTO Factura (FacturaID, ClienteID, Fecha, Tipo, SubTotal, Descuento)
		VALUES (@facturaID, @clienteID, @fecha, @tipoFactura, 0.00, 0.00);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		INSERT INTO FacturaDetalle (FacturaID, ProductoID, Cantidad, Unidad, Precio, Descuento)
		SELECT @facturaID, CAST(RIGHT(Codigo, 3) AS INT), Cantidad, Unidad, Precio, Descuento FROM @tDetalle
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @subTotal FLOAT, @desc FLOAT;

		SELECT @subTotal = SUM(Cantidad * Precio), @desc = SUM(Cantidad * Precio * Descuento) FROM @tDetalle;

		UPDATE Factura SET SubTotal = @subTotal, Descuento = @desc
		WHERE FacturaID = @facturaID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO