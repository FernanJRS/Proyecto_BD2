USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fBuscarNombreProducto(@codigo VARCHAR(10)) RETURNS VARCHAR(50)
AS
	BEGIN
		DECLARE @nombre VARCHAR(50);

		SELECT @nombre = Nombre FROM ProductosAgricolas
		WHERE Codigo = @codigo

		RETURN @nombre;
	END
GO