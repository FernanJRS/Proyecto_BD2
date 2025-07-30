USE GrupoNo4
GO

CREATE TYPE DetalleInsumo AS TABLE
(
	Codigo		VARCHAR(10),
	Insumo		VARCHAR(50),
	Cantidad	INT,
	Unidad		VARCHAR(30),
	Precio		NUMERIC(11,2),
	Descuento	NUMERIC(11,2)
)