USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spBuscarProductoVenta
@codigo VARCHAR(10), @unidad VARCHAR(10)
AS
	SELECT Codigo, Nombre, CASE @unidad
								WHEN 'Fardos' THEN Precio * 1.39 * 0.20
								WHEN 'Arrobas' THEN Precio * 1.37 * 0.25
								WHEN 'Quintales' THEN Precio * 1.35
								END AS Precio, 
								@unidad FROM ProductosAgricolas
	WHERE Codigo = @codigo
GO