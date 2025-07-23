CREATE OR ALTER PROCEDURE spObtenerMedida
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UnidadID, Nombre
    FROM UnidadMedida
    ORDER BY UnidadID
END