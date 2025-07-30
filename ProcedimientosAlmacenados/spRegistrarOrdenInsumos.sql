USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spRegistrarOrdenInsumos 
@proveedorID INT, @fechaCompra DATETIME, @fechaVencimiento DATETIME, @tDetalle DetalleInsumo READONLY
AS
	BEGIN TRANSACTION
		
		DECLARE @err INT = 0;
		DECLARE @compraID INT;

		SELECT @compraID = ISNULL(MAX(CompraInsumosID), 0) + 1 FROM CompraInsumos;
		
		INSERT INTO CompraInsumos (CompraInsumosID, ProveedorID, FechaCompra, FechaVencimiento, SubTotal, Descuento)
		VALUES (@compraID, @proveedorID, @fechaCompra, @fechaVencimiento, 0.00, 0.00);

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		INSERT INTO CompraDetalleInsumos (CompraInsumoID, InsumoID, Cantidad, Unidad, Precio, Descuento)
		SELECT @compraID, CAST(RIGHT(Codigo, 3) AS INT), Cantidad, Unidad, Precio, Descuento FROM @tDetalle;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

		DECLARE @subTotal FLOAT, @descuento FLOAT;

		SELECT @subTotal = SUM(Cantidad * Precio), @descuento = SUM(Cantidad * Precio * Descuento)
		FROM @tDetalle;

		UPDATE CompraInsumos SET SubTotal = @subTotal, Descuento = @descuento
		WHERE CompraInsumosID = @compraID;

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO