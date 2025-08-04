USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spBuscarProductoVenta
@codigo VARCHAR(10), @unidad VARCHAR(10)
AS
	SELECT Codigo, Nombre, CASE @unidad
								WHEN 'Fardos' THEN CAST(Precio * 1.39 * 0.20 AS NUMERIC(11,2))
								WHEN 'Arrobas' THEN CAST(Precio * 1.37 * 0.25 AS NUMERIC(11,2))
								WHEN 'Quintales' THEN CAST(Precio * 1.35 AS NUMERIC(11,2))
								END AS Precio, 
								@unidad AS Unidad FROM ProductosAgricolas
	WHERE Codigo = @codigo
GO