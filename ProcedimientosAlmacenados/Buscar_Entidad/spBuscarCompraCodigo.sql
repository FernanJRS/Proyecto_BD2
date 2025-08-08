CREATE OR ALTER PROCEDURE spBuscarCompraCodigo
	@Codigo VARCHAR(50)
AS
BEGIN
	SELECT CONVERT(VARCHAR(MAX), CompraInsumosID) as CompraID FROM CompraInsumos WHERE ProveedorID = @Codigo AND EstadoPago = 'P'
END

exec spBuscarCompraCodigo 1

select * from CompraInsumos