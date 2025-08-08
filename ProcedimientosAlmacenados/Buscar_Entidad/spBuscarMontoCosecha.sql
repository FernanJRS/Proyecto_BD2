CREATE OR ALTER PROCEDURE spBuscarMontoCosecha
	@Cosecha VARCHAR(50)
AS
BEGIN
	SELECT	Monto  FROM CosechaAgricultor WHERE CosechaID = @Cosecha
END

exec spBuscarMontoCosecha 1

