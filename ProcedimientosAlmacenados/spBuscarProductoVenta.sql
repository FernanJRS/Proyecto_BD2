USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spBuscarProductoVenta
@codigo VARCHAR(10), @unidad VARCHAR(10)
AS
	SELECT Codigo, Nombre, CASE @unidad
								WHEN 'Fardo' THEN Precio * 1.39 * 0.20
								WHEN 'Arroba' THEN Precio * 1.37 * 0.25
								WHEN 'Quintal' THEN Precio * 1.35
								END AS Precio, 
								@unidad FROM ProductosAgricolas
	WHERE Codigo = @codigo
GO