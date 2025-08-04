USE GrupoNo4
GO

CREATE OR ALTER VIEW dbo.vw_UtilidadPorCosecha
AS
	SELECT A.Nombre, CA.CosechaID, SUM(Monto) AS Costo, SUM(Monto) * 0.35 AS Utilidad FROM CosechaAgricultor CA
	INNER JOIN Agricultor A ON CA.AgricultorID = A.AgricultorID
	GROUP BY A.Nombre, CA.CosechaID
GO