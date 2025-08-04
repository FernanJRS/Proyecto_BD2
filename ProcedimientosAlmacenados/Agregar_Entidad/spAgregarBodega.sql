USE GrupoNo4
GO

CREATE OR ALTER PROCEDURE spAgregarBodega
@nombre VARCHAR(MAX), @desc VARCHAR(MAX), @espacio INT
AS
	DECLARE @bodegaID INT;

	SELECT @bodegaID =  ISNULL(MAX(BodegaID), 0) + 1 FROM Bodega;

	INSERT INTO Bodega (BodegaID, Nombre, Descripcion, Espacio)
	VALUES (@bodegaID, @nombre, @desc, @espacio);
GO