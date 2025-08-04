USE GrupoNo4
GO

CREATE OR ALTER VIEW dbo.vw_SaldoPendienteProveedores
AS
SELECT ci.ProveedorID,
       pr.Nombre                            AS Proveedor,
       SUM(ci.SubTotal - ci.Descuento)      AS TotalCompras,
       SUM(ISNULL(pp.Monto,0))              AS TotalPagado,
       SUM(ci.SubTotal - ci.Descuento)
       - SUM(ISNULL(pp.Monto,0))            AS SaldoPendiente
FROM   CompraInsumos  ci
LEFT  JOIN PagoProveedores pp ON pp.CompraInsumoID = ci.CompraInsumosID
JOIN   ProveedorInsumos pr ON pr.ProveedorID = ci.ProveedorID
WHERE ci.EstadoEntrega = 'E'
GROUP BY ci.ProveedorID, pr.Nombre;
GO