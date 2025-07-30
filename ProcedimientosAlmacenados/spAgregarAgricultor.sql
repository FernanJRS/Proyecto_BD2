USE GrupoNo4
GO
-- Agregar/Crear Agricultor
CREATE OR ALTER PROCEDURE spAgregarAgricultor 
@nombre VARCHAR(100), @dni VARCHAR(50), @telefono VARCHAR(30), @direccion VARCHAR(MAX), @email VARCHAR(100),
@nombreBanco VARCHAR(100), @tipoCuenta VARCHAR(50), @numCuenta VARCHAR(100)
AS
	BEGIN TRANSACTION
		DECLARE @err INT = 0;

		DECLARE @bancoID INT, @cuentaID INT, @tipoCuentaBancaria CHAR(1);

		SELECT @bancoID = BancoID FROM Banco WHERE Nombre = @nombreBanco;

		IF @tipoCuenta LIKE '%ahorro%' 
			SELECT @tipoCuentaBancaria = 'A';
		IF @tipoCuenta LIKE '%cheques%'
			SELECT @tipoCuentaBancaria = 'C';

		SELECT @cuentaID = ISNULL(MAX(CuentaID), 0) + 1 FROM CuentaBancaria

		INSERT INTO CuentaBancaria (CuentaID, BancoID, Tipo, NumeroCuenta, TipoCuenta)
		VALUES (@cuentaID, @bancoID, 'AG', @numCuenta, @tipoCuentaBancaria)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1
			
		DECLARE @usuarioID INT;

		SELECT @usuarioID = ISNULL(MAX(AgricultorID), 0) + 1 FROM Agricultor

		INSERT INTO Agricultor (AgricultorID, CuentaID, Nombre, Identidad, Telefono, Direccion, Correo) VALUES
		(@usuarioID, @cuentaID, @nombre, @dni, @telefono, @direccion, @email)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1
		
	IF @err = 0
		COMMIT TRANSACTION;
	ELSE
		ROLLBACK TRANSACTION;
GO