USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarInsumo
@nombre VARCHAR(100), @tipoInsumo VARCHAR(100), @descripcion VARCHAR(150), @unidadMedida VARCHAR(100)
AS
	DECLARE @insumoID INT, @tipoID INT, @unidadID INT, @codigo VARCHAR(10)

	SELECT @insumoID = ISNULL(MAX(InsumoID), 0) + 1 FROM InsumosAgricolas;

	SELECT @tipoID = TipoID FROM TipoInsumo WHERE Nombre = @tipoInsumo;

	SELECT @unidadID = UnidadID FROM UnidadMedida WHERE Nombre = @unidadMedida;

	SELECT @codigo = CONCAT('INS-' ,LEFT(CAST(NEWID() AS VARCHAR(36)), 6));

	WHILE (SELECT Codigo FROM InsumosAgricolas WHERE Codigo = @codigo) IS NOT NULL
		SELECT @codigo = CONCAT('INS-' ,LEFT(CAST(NEWID() AS VARCHAR(36)), 6));

	INSERT INTO InsumosAgricolas (InsumoID, Nombre, TipoInsumoID, Descripcion, Precio, Existencias, Codigo, UnidadID)
	VALUES (@insumoID, @nombre, @tipoID, @descripcion, 1.00, 0, @codigo, @unidadID)
GO