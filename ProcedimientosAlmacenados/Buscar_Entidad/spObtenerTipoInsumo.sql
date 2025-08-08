USE GrupoNo4

CREATE OR ALTER PROCEDURE spObtenerTipoInsumo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TipoID, Nombre
    FROM TipoInsumo
    ORDER BY TipoID
END



