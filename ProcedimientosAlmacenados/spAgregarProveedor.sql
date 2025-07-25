USE GrupoNo4
GO

--sp_help 'dbo.ProveedorInsumos'

CREATE OR ALTER PROCEDURE spAgregarProveedor 
@proveedor VARCHAR(100), @tipoProveedor VARCHAR(100), @contacto VARCHAR(100), @direccion VARCHAR(200), @telefono VARCHAR(20), @correo VARCHAR(50), @condCredito VARCHAR(MAX),
@nombreBanco VARCHAR (100), @numCuenta VARCHAR(100), @tipoCuenta VARCHAR(50)
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
		VALUES (@cuentaID, @bancoID, 'PR', @numCuenta, @tipoCuentaBancaria)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1
			
		DECLARE @proveedorID INT, @condiciones VARCHAR(MAX);

		SELECT @proveedorID = ISNULL(MAX(ProveedorID), 0) + 1 FROM ProveedorInsumos

		SELECT @condiciones = ISNULL(@condCredito, 'N/A')

		INSERT INTO ProveedorInsumos (ProveedorID, CuentaID, Nombre, Contacto, Direccion, Telefono, Correo, CondicionesCredito) VALUES
		(@proveedorID, @cuentaID, @proveedor, @contacto, @direccion, @telefono, @correo, @condiciones)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1

		DECLARE @tipoID INT

		SELECT @tipoID = TipoID FROM TipoProveedor WHERE Nombre = @tipoProveedor

		INSERT INTO TipoProveedorInsumos (TipoID, ProveedorID) VALUES (@tipoID, @proveedorID)
		
		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1

		IF @err = 0
			COMMIT TRANSACTION;
		ELSE
			ROLLBACK TRANSACTION;
GO

CREATE TYPE TipoProveedor AS TABLE
(
	TipoProveedor	VARCHAR(100)
)
GO

CREATE OR ALTER PROCEDURE spAgregarProveedor 
@proveedor VARCHAR(100), @tipoProveedor TipoProveedor READONLY, @contacto VARCHAR(100), @direccion VARCHAR(200), @telefono VARCHAR(20), @correo VARCHAR(50), @condCredito VARCHAR(MAX),
@nombreBanco VARCHAR (100), @numCuenta VARCHAR(100), @tipoCuenta VARCHAR(50)
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
		VALUES (@cuentaID, @bancoID, 'PR', @numCuenta, @tipoCuentaBancaria)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1
			
		DECLARE @proveedorID INT, @condiciones VARCHAR(MAX);

		SELECT @proveedorID = ISNULL(MAX(ProveedorID), 0) + 1 FROM ProveedorInsumos

		SELECT @condiciones = ISNULL(@condCredito, 'N/A')

		INSERT INTO ProveedorInsumos (ProveedorID, CuentaID, Nombre, Contacto, Direccion, Telefono, Correo, CondicionesCredito) VALUES
		(@proveedorID, @cuentaID, @proveedor, @contacto, @direccion, @telefono, @correo, @condiciones)

		IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1

		DECLARE crsTipoProveedor CURSOR FOR
		SELECT TipoProveedor FROM @tipoProveedor;

		DECLARE @tipo VARCHAR(100)

		OPEN crsTipoProveedor;
		FETCH NEXT FROM crsTipoProveedor INTO @tipo;

		WHILE @@FETCH_STATUS = 0
			BEGIN
				INSERT INTO TipoProveedorInsumos (TipoID, ProveedorID) VALUES ((SELECT TipoID FROM TipoProveedor WHERE Nombre = @tipo), @proveedorID);

				IF @@ERROR <> 0 AND @err = 0 SELECT @err = 1
				
				FETCH NEXT FROM crsTipoProveedor INTO @tipo;
			END

		DEALLOCATE crsTipoProveedor;

		IF @err = 0
			COMMIT TRANSACTION;
		ELSE
			ROLLBACK TRANSACTION;
GO
