USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarInsumo
@nombre VARCHAR(100), @tipoInsumo VARCHAR(100), @descripcion VARCHAR(150), @unidadMedida VARCHAR(100)
AS
	DECLARE @insumoID INT, @tipoID INT, @codigo VARCHAR(10)

	SELECT @insumoID = ISNULL(MAX(InsumoID), 0) + 1 FROM InsumosAgricolas;

	SELECT @tipoID = TipoID FROM TipoInsumo WHERE Nombre = @tipoInsumo;

	SELECT @codigo = 'INS-' + RIGHT('000' + CAST(@insumoID AS VARCHAR(3)), 3);

	INSERT INTO InsumosAgricolas (InsumoID, Nombre, TipoInsumoID, Descripcion, Precio, Existencias, Codigo, Unidad)
	VALUES (@insumoID, @nombre, @tipoID, @descripcion, 1.00, 0, @codigo, @unidadMedida)
GO