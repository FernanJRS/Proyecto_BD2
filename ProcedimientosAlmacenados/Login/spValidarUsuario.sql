CREATE OR ALTER PROCEDURE config.spValidarUsuario
    @Usuario VARCHAR(50),
    @Contrasena VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (
            SELECT 1 FROM config.Usuarios
            WHERE Usuario = @Usuario AND Contrasena = @Contrasena
        )
            SELECT 'OK' AS Resultado;
        ELSE
            SELECT 'Credenciales inválidas' AS Resultado;
    END TRY
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS CodigoError,
            ERROR_MESSAGE() AS MensajeError;
    END CATCH
END
GO
