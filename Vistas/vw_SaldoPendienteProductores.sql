USE GrupoNo4
GO

CREATE VIEW dbo.vw_SaldoPendienteProductores
AS
SELECT ca.AgricultorID,
       a.Nombre                 AS Agricultor,
       SUM(ca.Monto)            AS ValorCosechas,
       SUM(ISNULL(pa.Monto,0))  AS Pagado,
       SUM(ca.Monto) - SUM(ISNULL(pa.Monto,0)) AS SaldoPendiente
FROM   CosechaAgricultor ca
LEFT  JOIN PagoAgricultores pa ON pa.CosechaID = ca.CosechaID
JOIN   Agricultor a  ON a.AgricultorID = ca.AgricultorID
GROUP BY ca.AgricultorID, a.Nombre;
GO
