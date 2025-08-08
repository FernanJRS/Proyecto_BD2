CREATE OR ALTER PROCEDURE spBuscarCodigoProducto
    @Producto VARCHAR(50)
AS
BEGIN
    SELECT * FROM ProductosAgricolas WHERE Nombre = @Producto
END

exec spBuscarCodigoProducto "Maíz"