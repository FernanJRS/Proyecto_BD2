USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarProducto
@nombre VARCHAR(100), @tipo VARCHAR(120), @unidadMedida VARCHAR(100)
AS
	DECLARE @tipoProductoID INT, @unidadID INT, @productoID INT, @codigo VARCHAR(10)

	SELECT @tipoProductoID = TipoID FROM TipoProducto WHERE Nombre = @tipo

	SELECT @unidadID = UnidadID FROM UnidadMedida WHERE Nombre = @unidadMedida

	SELECT @productoID = ISNULL(MAX(ProductoID), 0) + 1 FROM ProductosAgricolas

	SELECT @codigo = CONCAT('AGR-', LEFT(CAST(NEWID() AS VARCHAR(36)), 6))

	WHILE (SELECT Codigo FROM ProductosAgricolas WHERE Codigo = @codigo) IS NOT NULL
		SELECT @codigo = CONCAT('AGR-', LEFT(CAST(NEWID() AS VARCHAR(36)), 6))

	INSERT INTO ProductosAgricolas (ProductoID, Nombre, Existencias, Precio, Codigo, TipoID, UnidadID)
	VALUES (@productoID, @nombre, 0, 1.00, @codigo, @tipoProductoID, @unidadID)
GO