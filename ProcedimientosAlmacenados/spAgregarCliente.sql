USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarCliente
@nombre VARCHAR(100), @tipoIdentidad VARCHAR(3), 
@identidad VARCHAR(20), @direccion VARCHAR(100), @telefono VARCHAR(15)
AS
	BEGIN TRANSACTION
		
		DECLARE @err INT = 0;

		DECLARE @clienteID INT;

		SELECT @clienteID = ISNULL(MAX(ClienteID), 0) + 1 FROM Cliente;

		DECLARE @tipo CHAR(1);

		IF @tipoIdentidad = 'DNI'
			BEGIN
				SELECT @tipo = 'C'; 
				DECLARE @municipio INT, @departamento INT;

				SELECT @municipio = SUBSTRING(@identidad, 3, 2), @departamento = SUBSTRING(@identidad, 1, 2);

				IF @municipio NOT BETWEEN 1 AND dbo.fMunicipioMax(@departamento) SELECT @err = 1;
			END

		IF @tipoIdentidad = 'RTN' SELECT @tipo = 'R';

		INSERT INTO Cliente (ClienteID, Nombre, TipoIdentidad, Identidad, Direccion, Telefono)
		VALUES (@clienteID, @nombre, @tipo, @identidad, @direccion, @telefono)
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1;

	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO