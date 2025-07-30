CREATE OR ALTER PROCEDURE spBuscarProductor
    @Codigo VARCHAR(50)
AS
BEGIN
    SELECT Nombre FROM Agricultor WHERE AgricultorID = @Codigo
END