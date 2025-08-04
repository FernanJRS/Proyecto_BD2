USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spBuscarProducto
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT Nombre, Precio, 'Quintal' AS Unidad FROM ProductosAgricolas 
	WHERE Codigo = @Codigo
END