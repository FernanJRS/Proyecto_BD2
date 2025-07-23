use GrupoNo4

CREATE OR ALTER PROCEDURE spAgregarTipoRiego
    @Nombre VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
	
	DECLARE @TipoID int;
	SELECT @TipoID = ISNULL(MAX(TipoID)+1,0) from TipoRiego 

    INSERT INTO TipoRiego (TipoID, Nombre)
    VALUES (@TipoID, @Nombre);
END

EXEC spAgregarTipoRiego 'Riego por goteo'
EXEC spAgregarTipoRiego 'Riego por aspersión'
EXEC spAgregarTipoRiego 'Riego por superficie'
EXEC spAgregarTipoRiego 'Riego por exudación'