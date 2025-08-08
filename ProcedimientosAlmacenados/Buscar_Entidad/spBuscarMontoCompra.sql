USE GrupoNo4
CREATE OR ALTER PROCEDURE spBuscarMontoCompra
	@compraID INT, @proveedorID INT
AS
BEGIN
	SELECT DBO.fSaldoPendienteProveedorPorCompra(@CompraID,@proveedorID) AS Monto
END
exec spBuscarMontoCompra 3,2

select * from CompraInsumos
