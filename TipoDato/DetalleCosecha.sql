USE GrupoNo4
GO

CREATE TYPE DetalleCosecha AS TABLE
(
	ProductoID		INT,
	Cantidad		NUMERIC(11,2),
	Precio			NUMERIC(11,2),
	Descuento		NUMERIC(11,2)
)
GO