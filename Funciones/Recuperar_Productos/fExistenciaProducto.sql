USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fExistenciaProducto (@ProductoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Stock INT;
    SELECT @Stock = ExistenciaCalculada
    FROM   dbo.vw_InventarioProductos
    WHERE  ProductoID = @ProductoID;
    RETURN @Stock;
END;
GO