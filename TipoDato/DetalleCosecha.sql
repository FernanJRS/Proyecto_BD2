USE GrupoNo4
GO

CREATE TYPE DetalleCosecha AS TABLE
(
	Codigo			VARCHAR(10),
	Producto		VARCHAR(50),
	Cantidad		NUMERIC(11,2),
	Unidad			VARCHAR(50),
	Precio			NUMERIC(11,2)
)
GO