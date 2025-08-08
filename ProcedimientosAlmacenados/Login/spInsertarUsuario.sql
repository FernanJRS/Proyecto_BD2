USE GrupoNo4
CREATE OR ALTER PROCEDURE spInsertarUsuario
    @Nombre VARCHAR(50),
    @Usuario VARCHAR(50),
    @Contrasena VARCHAR(100),
    @Departamento VARCHAR(50),
    @Administrador VARCHAR(10)
AS
BEGIN	
		DECLARE @UsuarioID INT;
		SELECT @UsuarioID=  ISNULL(MAX(UsuarioID),0)+1 FROM config.Usuarios

        INSERT INTO config.Usuarios(UsuarioID,Nombre, Usuario, Contrasena, Departamento, Administrador)
        VALUES (@UsuarioID,@Nombre, @Usuario, @Contrasena, @Departamento, @Administrador);
    END
GO

select * from config.Usuarios

exec spInsertarUsuario 'Bryan Cruz','bcruz','cruz','Administración','Si'