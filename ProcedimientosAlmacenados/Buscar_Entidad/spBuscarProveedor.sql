CREATE OR ALTER PROCEDURE spBuscarProveedor
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT Nombre FROM ProveedorInsumos WHERE ProveedorID = @Codigo
END
