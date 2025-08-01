USE GrupoNo4
GO

CREATE OR ALTER FUNCTION dbo.fMunicipioMax(@departamento INT) RETURNS INT
AS
	BEGIN
		DECLARE @cantidadMunicipios INT;

		SELECT @cantidadMunicipios = CASE @departamento
														WHEN 1  THEN 8
														WHEN 2  THEN 10
														WHEN 3  THEN 21
														WHEN 4  THEN 23
														WHEN 5  THEN 12
														WHEN 6  THEN 16
														WHEN 7  THEN 19
														WHEN 8  THEN 28
														WHEN 9  THEN 6
														WHEN 10 THEN 17
														WHEN 11 THEN 4
														WHEN 12 THEN 19
														WHEN 13 THEN 28
														WHEN 14 THEN 16
														WHEN 15 THEN 23
														WHEN 16 THEN 28
														WHEN 17 THEN 9
														WHEN 18 THEN 11
														ELSE 0  -- Departamento inválido
		END;

		RETURN @cantidadMunicipios;
	END
GO