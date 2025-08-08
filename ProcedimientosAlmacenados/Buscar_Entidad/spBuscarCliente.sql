USE GrupoNo4
CREATE OR ALTER PROCEDURE spBuscarCliente
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT Nombre FROM Cliente WHERE ClienteID = @Codigo
END

