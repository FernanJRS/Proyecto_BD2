USE GrupoNo4

CREATE OR ALTER PROCEDURE spBuscarFincaCosecha
	@Codigo VARCHAR(50)
AS
BEGIN
	SELECT Nombre FROM Fincas WHERE AgricultorID = @Codigo
END

select * from Fincas

exec spBuscarFincaCosecha 2