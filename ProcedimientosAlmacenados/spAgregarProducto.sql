USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarProducto
@nombre VARCHAR(100), @tipo VARCHAR(120)
AS
	DECLARE @tipoProductoID INT, @unidadID INT, @productoID INT, @codigo VARCHAR(10)

	SELECT @tipoProductoID = TipoID FROM TipoProducto WHERE Nombre = @tipo;

	SELECT @productoID = ISNULL(MAX(ProductoID), 0) + 1 FROM ProductosAgricolas;

	SELECT @codigo = 'AGR-' + RIGHT('000' + CAST(@productoID AS VARCHAR(3)), 3);
	
	INSERT INTO ProductosAgricolas (ProductoID, Nombre, Existencias, Precio, Codigo, TipoID )
	VALUES (@productoID, @nombre, 0, 1.00, @codigo, @tipoProductoID)
GO