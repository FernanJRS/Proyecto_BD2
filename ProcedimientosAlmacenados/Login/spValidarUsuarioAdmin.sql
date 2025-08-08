CREATE OR ALTER PROCEDURE spValidarUsuarioAdmin
    @Usuario VARCHAR(50),
    @Contrasena VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        IF EXISTS (
            SELECT 1 FROM config.Usuarios
            WHERE Usuario = @Usuario
              AND Contrasena = @Contrasena
              AND Administrador = 'Si')
            SELECT 1 AS Resultado
        ELSE
            SELECT 0 AS Resultado
    END TRY
    BEGIN CATCH
        SELECT -1 AS Resultado
    END CATCH
END
GO
