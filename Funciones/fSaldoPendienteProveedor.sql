USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fSaldoPendienteProveedor (@ProveedorID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @Saldo MONEY;
    SELECT @Saldo = SUM(ci.SubTotal - ci.Descuento) - SUM(ISNULL(pp.Monto,0))
    FROM   CompraInsumos  ci
    LEFT  JOIN PagoProveedores pp ON pp.CompraInsumoID = ci.CompraInsumosID
    WHERE  ci.ProveedorID = @ProveedorID;
    RETURN @Saldo;
END;
GO