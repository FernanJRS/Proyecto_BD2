USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fUtilidadCosecha (@CosechaID INT)
RETURNS TABLE
AS RETURN
SELECT *
FROM   dbo.vw_UtilidadPorCosecha
WHERE  CosechaID = @CosechaID;
GO