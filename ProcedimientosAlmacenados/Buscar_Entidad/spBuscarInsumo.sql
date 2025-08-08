USE GrupoNo4

CREATE OR ALTER PROCEDURE spBuscarInsumo
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT Nombre, Precio, Unidad FROM InsumosAgricolas
	WHERE Codigo = @Codigo
END