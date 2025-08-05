USE GrupoNo4
GO

CREATE OR ALTER VIEW vw_InsumosEntregados
AS
	SELECT A.Nombre AS Agricultor,IA.Codigo AS CodigoInsumo, IA.Nombre AS Insumo, SUM(AID.Cantidad) AS Recibidos, IA.Unidad AS UnidadMedida  FROM Agricultor A
	INNER JOIN AgricultorInsumos AI ON A.AgricultorID = AI.AgricultorID
	INNER JOIN AgricultorInsumosDetalle AID ON AI.AgricultorInsumoID = AID.AgricultorInsumoID
	INNER JOIN InsumosAgricolas IA ON AID.InsumoID = IA.InsumoID
	GROUP BY A.Nombre, IA.Nombre, IA.Unidad, IA.Codigo
GO