CREATE OR ALTER PROCEDURE spObtenerTipoProveedor
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TipoID, Nombre
    FROM TipoProveedor
    ORDER BY TipoID
END
select * from UnidadMedida