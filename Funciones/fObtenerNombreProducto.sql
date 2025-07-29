USE GrupoNo4 
GO

CREATE OR ALTER FUNCTION dbo.fObtenerNombreProducto(@codigo VARCHAR(10)) RETURNS VARCHAR(60)
AS
	BEGIN
		DECLARE @nombre VARCHAR(60);

		SELECT @nombre = Nombre FROM ProductosAgricolas
		WHERE Codigo = @codigo;

		RETURN @nombre;
	END
GO