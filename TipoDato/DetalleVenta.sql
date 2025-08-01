USE GrupoNo4
GO

CREATE TYPE DetalleVenta AS TABLE
(
	Codigo			VARCHAR(10),
	Producto		VARCHAR(50),
	Cantidad		NUMERIC(11,2),
	Unidad			VARCHAR(50),
	Precio			NUMERIC(11,2),
	Descuento		NUMERIC(11,2)
)