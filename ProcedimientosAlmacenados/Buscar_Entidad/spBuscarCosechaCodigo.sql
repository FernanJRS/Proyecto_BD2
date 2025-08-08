CREATE OR ALTER PROCEDURE spBuscarCosechaCodigo
	@Codigo VARCHAR(50)
AS
BEGIN
	SELECT CONVERT(VARCHAR(MAX), CosechaID) as CosechaID FROM CosechaAgricultor WHERE AgricultorID = @Codigo
END

