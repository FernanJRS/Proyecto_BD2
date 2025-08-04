USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fSaldoPendienteProductor (@AgricultorID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @Saldo MONEY;
    SELECT @Saldo = ValorCosechas - Pagado
    FROM   dbo.vw_SaldoPendienteProductores
    WHERE  AgricultorID = @AgricultorID;
    RETURN @Saldo;
END;
GO