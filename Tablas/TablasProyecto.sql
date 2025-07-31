USE GrupoNo4
GO

--DROP TABLE dbo.TipoRiego
CREATE TABLE dbo.TipoRiego (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoRiegoID PRIMARY KEY (TipoID)
)

INSERT INTO dbo.TipoRiego VALUES (1, 'Riego por Gravedad'), (2, 'Riego por Aspersión'),
(3, 'Riego por Goteo'), (4, 'Riego por Nebulización'), (5, 'Riego por Microaspersión'),
(6, 'Riego por Inundación'), (7, 'Riego Subsuperficial'), (8, 'Riego por Exudación'),
(9, 'Riego Hidropónico'), (10, 'Riego Aeropónico'), (11, 'Riego por Cañon Viajero')
GO

--DROP TABLE dbo.TipoSuelo
CREATE TABLE dbo.TipoSuelo (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoSueloID PRIMARY KEY (TipoID)
)

INSERT INTO dbo.TipoSuelo VALUES (1, 'Suelo Franco'), (2, 'Suelo Arenoso'),
(3, 'Suelo Limoso'), (4, 'Suelo Calizo'), (5, 'Suelo Arcilloso'),
(6, 'Suelo Humífero'), (7, 'Suelo Andisol'), (8, 'Suelo Hidromorfo'),
(9, 'Suelo Turboso'), (10, 'Suelo Marga')
GO

--DROP TABLE dbo.Cliente
CREATE TABLE dbo.Cliente
(
	ClienteID		INT NOT NULL,
	Nombre			VARCHAR(100) NOT NULL,
	TipoIdentidad	CHAR(1) NOT NULL, -- C = Cedula, R = RTN
	Identidad		VARCHAR(20) NOT NULL,
	Direccion		VARCHAR(150) NOT NULL,
	Telefono		VARCHAR(100) NOT NULL,
	CONSTRAINT pkClienteID PRIMARY KEY (ClienteID),
)
GO
ALTER TABLE dbo.Cliente ADD CONSTRAINT ukIdentidad UNIQUE (Identidad)
ALTER TABLE dbo.Cliente ADD CONSTRAINT ukTelefono UNIQUE (Telefono)
ALTER TABLE dbo.Cliente ADD CONSTRAINT ckIdentidad CHECK ((TipoIdentidad = 'C' AND LEN(REPLACE(Identidad, '-', '')) = 13)
OR (TipoIdentidad = 'R' AND LEN(Identidad) = 14))
GO

CREATE RULE rCantidadMayor0 AS @col >= 0
GO
--DROP TABLE dbo.Factura
CREATE TABLE dbo.Factura
(
	FacturaID	INT NOT NULL,
	ClienteID	INT NOT NULL,
	Fecha		DATETIME NOT NULL,
	Tipo		CHAR(1) NOT NULL,
	SubTotal	NUMERIC(11,2) NOT NULL,
	Descuento	NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkFacturaID PRIMARY KEY (FacturaID),
	CONSTRAINT fkClienteID FOREIGN KEY (ClienteID) REFERENCES Cliente
)
ALTER TABLE dbo.Factura ADD CONSTRAINT ckTipoFactura CHECK (Tipo IN ('R', 'C')) -- R = Credito, C = Contado
GO

-- DROP TABLE dbo.TipoProducto
CREATE TABLE dbo.TipoProducto
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(120) NOT NULL,
	CONSTRAINT pkTipoProductoAgricolas PRIMARY KEY (TipoID)
)
INSERT INTO dbo.TipoProducto VALUES (1, 'Cultivo Alimenticio'), (2, 'Cultivo Industrial'),
(3, 'Cultivo Forrajero'), (4, 'Plantas Ornamentales'), (5, 'Plantas Medicinales')
GO

-- DROP TABLE UnidadMedida
CREATE TABLE UnidadMedida
(
	UnidadID	INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkUnidadMedidaID PRIMARY KEY (UnidadID)
)
INSERT INTO dbo.UnidadMedida VALUES (1, 'Kilogramo'), (2, 'Quintal'), (3, 'Fardo'), 
(4, 'Caja'), (5,'Saco'), (6, 'Litro'), (7, 'Unidad Individual')
GO

--DROP TABLE dbo.ProductosAgricolas
CREATE TABLE dbo.ProductosAgricolas (
    ProductoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Codigo			VARCHAR(20) NOT NULL, -- AS CONCAT('AGR-', LEFT(CAST(NEWID() AS VARCHAR(36)), 6)),
	TipoID			INT NOT NULL,
	Existencias		NUMERIC(11,2) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkProductoAgrícolaID PRIMARY KEY (ProductoID)
)
ALTER TABLE dbo.ProductosAgricolas ADD CONSTRAINT ukNombreProducto UNIQUE (Nombre)
ALTER TABLE dbo.ProductosAgricolas ADD CONSTRAINT fkTipoProductoAgricola FOREIGN KEY (TipoID) REFERENCES dbo.TipoProducto
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.ProductosAgricolas.Existencias'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.ProductosAgricolas.Precio'
GO

--DROP TABLE dbo.FacturaDetalle
CREATE TABLE dbo.FacturaDetalle
(
	FacturaID	INT NOT NULL,
	ProductoID	INT NOT NULL,
	Cantidad	INT NOT NULL,
	Unidad		VARCHAR(20) NOT NULL,
	Precio		NUMERIC(11,2) NOT NULL,
	Descuento	NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkFacturaDetalleID PRIMARY KEY (FacturaID, ProductoID),
	CONSTRAINT fkFacturaDetalleProducto FOREIGN KEY (ProductoID) REFERENCES ProductosAgricolas,
	CONSTRAINT fkFacturaDetalleFactura FOREIGN KEY (FacturaID) REFERENCES Factura
)
GO
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Cantidad'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Precio' 
ALTER TABLE dbo.FacturaDetalle ADD CONSTRAINT ckDescuentoProductoFactura CHECK (Descuento BETWEEN 0 AND 1)
GO

--DROP TABLE dbo.TipoProveedor
CREATE TABLE dbo.TipoProveedor
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoProveedorID PRIMARY KEY (TipoID)
)
INSERT INTO dbo.TipoProveedor VALUES (1, 'Proveedor de Agroquímicos'),
(2, 'Proveedor de Herramientas'), (3, 'Proveedor de Materiales Complementarios'),
(4, 'Proveedor de Maquinaria'), (5, 'Proveedor de Insumos Biológicos')
GO

--DROP TABLE dbo.Banco
CREATE TABLE dbo.Banco
(
	BancoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkBancoID PRIMARY KEY (BancoID)
)
INSERT INTO dbo.Banco VALUES (1, 'Banco Ficohsa'), (2, 'Banco Atlantida'),
(3, 'BAC Honduras'), (4, 'Banco de Occidente'), (5, 'Banpaís'),
(6, 'Banco Azteca'), (7, 'Banco Cuscatlan')
GO

--DROP TABLE dbo.CuentaBancaria
CREATE TABLE dbo.CuentaBancaria
(
	CuentaID		INT NOT NULL,
	BancoID			INT NOT NULL,
	Tipo			CHAR(2) NOT NULL, -- AG = Agricultor PR = Proveedor
	NumeroCuenta	VARCHAR(100) NOT NULL,
	TipoCuenta		CHAR(1) NOT NULL, -- A = Ahorro C = Cheques
	CONSTRAINT pkCuentaID PRIMARY KEY (CuentaID),
	CONSTRAINT fkBancoCuenta FOREIGN KEY (BancoID) REFERENCES Banco
)
ALTER TABLE dbo.CuentaBancaria ADD CONSTRAINT ukNumeroCuenta UNIQUE (NumeroCuenta)
ALTER TABLE dbo.CuentaBancaria ADD CONSTRAINT ckTipoUsuarioCuenta CHECK (Tipo IN ('AG', 'PR'))
ALTER TABLE dbo.CuentaBancaria ADD CONSTRAINT ckTipoCuentaBancaria CHECK (TipoCuenta IN ('A', 'C'))
GO


--DROP TABLE dbo.ProveedorInsumos
CREATE TABLE dbo.ProveedorInsumos (
    ProveedorID				INT NOT NULL,
	CuentaID				INT NOT NULL,
    Nombre					VARCHAR(100) NOT NULL,
    Contacto				VARCHAR(100) NOT NULL,
	TipoID					INT NOT NULL,
    Direccion				VARCHAR(200) NOT NULL,
	RTN						VARCHAR(20) NOT NULL,
    Telefono				VARCHAR(20) NOT NULL,
	Correo					VARCHAR(50) NOT NULL,
	CondicionesCredito		VARCHAR(MAX),
	CONSTRAINT pkProveedorInsumosID PRIMARY KEY (ProveedorID),
	CONSTRAINT fkCuentaProveedor FOREIGN KEY (CuentaID) REFERENCES CuentaBancaria,
	CONSTRAINT fkProveedorTipo FOREIGN KEY (TipoID) REFERENCES TipoProveedor
) 
ALTER TABLE dbo.ProveedorInsumos ADD CONSTRAINT ckCorreoProveedor CHECK (Correo LIKE '%@%.%')
ALTER TABLE dbo.ProveedorInsumos ADD CONSTRAINT ckRTNProveedor CHECK (LEN(RTN) = 14)
ALTER TABLE dbo.ProveedorInsumos ADD CONSTRAINT ckTelefonoProveedor CHECK ((LEN(REPLACE(Telefono, '-', '')) = 8) AND (CAST(LEFT(Telefono, 1) AS INT) IN (3, 8, 9)))
GO

GO

--DROP TABLE dbo.CompraInsumos
CREATE TABLE dbo.CompraInsumos (
    CompraInsumosID		INT NOT NULL,
	ProveedorID			INT NOT NULL,
    FechaCompra			DATETIME NOT NULL,
	FechaVencimiento	DATETIME NOT NULL,
	SubTotal			NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	EstadoPago			VARCHAR(50),
	EstadoEntrega		VARCHAR(50),
	CONSTRAINT pkCompraInsumoID PRIMARY KEY (CompraInsumosID),
	CONSTRAINT fkProveedorCompra FOREIGN KEY (ProveedorID) REFERENCES ProveedorInsumos
)
EXEC sp_bindefault 'dftEstado', 'dbo.CompraInsumos.EstadoPago'
EXEC sp_bindefault 'dftEstado', 'dbo.CompraInsumos.EstadoEntrega'
ALTER TABLE dbo.CompraInsumos ADD CONSTRAINT ckFechaCompra CHECK (FechaCompra < FechaVencimiento)
ALTER TABLE dbo.CompraInsumos ADD CONSTRAINT ckEstadoCompraInsumos CHECK (EstadoPago IN ('Pendiente','Pagado'));
ALTER TABLE dbo.CompraInsumos ADD CONSTRAINT ckEstadoEntregaInsumos CHECK (EstadoEntrega IN ('Pendiente','Entregado'));
GO

--DROP TABLE dbo.TipoInsumo
CREATE TABLE dbo.TipoInsumo
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoInsumoID PRIMARY KEY (TipoID)
)
INSERT INTO dbo.TipoInsumo VALUES (1, 'Insumos Químicos'), (2, 'Insumos Biológicos'),
(3, 'Herramientas Manuales'), (4, 'Tecnología Agrícola'), (5, 'Maquinaria Agrícola')
GO

--DROP TABLE dbo.InsumosAgricolas
CREATE TABLE dbo.InsumosAgricolas (
    InsumoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Codigo			VARCHAR(20) NOT NULL,
    TipoInsumoID	INT NOT NULL,
	Descripcion		VARCHAR(150) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	Existencias		INT NOT NULL,
	Unidad			VARCHAR(20) NOT NULL,
	CONSTRAINT pkInsumoID PRIMARY KEY (InsumoID),
	CONSTRAINT fkTipoInsumo FOREIGN KEY (TipoInsumoID) REFERENCES TipoInsumo
)
ALTER TABLE dbo.InsumosAgricolas ADD CONSTRAINT ukNombreInsumo UNIQUE (Nombre)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.InsumosAgricolas.Precio'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.InsumosAgricolas.Existencias'
GO

--DROP TABLE dbo.CompraDetalleInsumos
CREATE TABLE dbo.CompraDetalleInsumos
(
	CompraInsumoID		INT NOT NULL,
	InsumoID			INT NOT NULL,
	Cantidad			INT NOT NULL,
	Unidad				VARCHAR(20) NOT NULL,
	Precio				NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCompraDetalleID PRIMARY KEY (CompraInsumoID, InsumoID),
	CONSTRAINT fkCompraDetalleInsumo FOREIGN KEY (InsumoID) REFERENCES InsumosAgricolas
)
ALTER TABLE dbo.CompraDetalleInsumos ADD CONSTRAINT ckDecuentoInsumos CHECK (Descuento BETWEEN 0 AND 1)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraDetalleInsumos.Precio'
GO

--DROP TABLE dbo.Agricultor
CREATE TABLE dbo.Agricultor (
    AgricultorID	INT NOT NULL,
	CuentaID		INT NOT NULL,
    Nombre			VARCHAR(100) not null,
    Identidad		VARCHAR(50) not null,
    Telefono		VARCHAR(30) not null,
    Direccion		VARCHAR(200) not null,
    Correo			VARCHAR(100) not null,
	CONSTRAINT pkAgricultorID PRIMARY KEY (AgricultorID),
	CONSTRAINT fkCuentaAgricultor FOREIGN KEY (CuentaID) REFERENCES CuentaBancaria
)
ALTER TABLE dbo.Agricultor ADD CONSTRAINT ckCorreoAgricultor CHECK (Correo LIKE '%@%.%')
ALTER TABLE dbo.Agricultor ADD CONSTRAINT ukIdentidadAgricultor UNIQUE (Identidad) 
ALTER TABLE dbo.Agricultor ADD CONSTRAINT ckIdentidadAgricultor CHECK ((LEN(REPLACE(Identidad, '-', '')) = 13) AND (CAST(LEFT(Identidad, 2) AS INT) BETWEEN 1 AND 18) AND 
CAST(SUBSTRING(identidad, 6, 4) AS INT) < YEAR(GETDATE()))
ALTER TABLE dbo.Agricultor ADD CONSTRAINT ckTelefonoAgricultor CHECK ((LEN(REPLACE(Telefono, '-', '')) = 8) AND (CAST(LEFT(Telefono, 1) AS INT) IN (3, 8, 9)))
GO

--DROP TABLE dbo.Fincas
CREATE TABLE dbo.Fincas (
    FincaID			INT NOT NULL,
    AgricultorID	INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Ubicacion		VARCHAR(50) NOT NULL,
    Extension		FlOAT NOT NULL, -- En hectáreas
	CONSTRAINT pkFincaID PRIMARY KEY (FincaID),
	CONSTRAINT fkFincaAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
ALTER TABLE dbo.Fincas ADD CONSTRAINT ukFincaAgricultor UNIQUE (AgricultorID, Nombre)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Fincas.Extension'
GO

--DROP TABLE dbo.Lotes
CREATE TABLE dbo.Lotes (
    FincaID				INT NOT NULL,
    LoteID				INT NOT NULL,
	ProductoID			INT NOT NULL,
    Nombre				VARCHAR(100) NOT NULL,
    Extension			FLOAT NOT NULL,
    TipoSueloID			INT NOT NULL,
    TipoRiegoID			INT NOT NULL,
	CantidadCosechas	INT, 
    FechaSiembra		DATETIME,
	CONSTRAINT pkLoteFinca PRIMARY KEY (FincaID, LoteID),
	CONSTRAINT fkFincaLote FOREIGN KEY (FincaID) REFERENCES Fincas(FincaID),
	CONSTRAINT fkLoteTipoRiego FOREIGN KEY (TipoRiegoID) REFERENCES TipoRiego,
	CONSTRAINT fkLoteTipoSuelo FOREIGN KEY (TipoSueloID) REFERENCES TipoSuelo
)
ALTER TABLE dbo.Lotes ADD CONSTRAINT ukLoteAgricultor UNIQUE (FincaID, Nombre)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Lotes.Extension'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Lotes.CantidadCosechas'
GO

--DROP TABLE dbo.Bodega
CREATE TABLE dbo.Bodega
(
	BodegaID	INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(MAX),
	Espacio		BIGINT NOT NULL, -- En metros cúbicos (m3)
	CONSTRAINT pkBodegaID PRIMARY KEY (BodegaID)
)
ALTER TABLE dbo.Bodega ADD CONSTRAINT ukNombreBodega UNIQUE (Nombre); 
INSERT INTO dbo.Bodega VALUES (1, 'Bodega 1', 'Aqui se almacenan los cultivos alimenticios', 5000);
GO

--DROP TABLE dbo.CosechaAgricultor
CREATE TABLE dbo.CosechaAgricultor (
    CosechaID		INT NOT NULL,
    AgricultorID	INT NOT NULL,
    BodegaID		INT NOT NULL,
    Fecha			DATETIME NOT NULL,
	Monto			FLOAT NOT NULL,
	Estado			VARCHAR(50) NULL,
	CONSTRAINT pkCosechaID PRIMARY KEY (CosechaID),
	CONSTRAINT fkAgricultorCosecha FOREIGN KEY (AgricultorID) REFERENCES Agricultor,
	CONSTRAINT fkBodegaCosecha FOREIGN KEY (BodegaID) REFERENCES Bodega
)
CREATE DEFAULT dftEstado AS ('Pendiente')
ALTER TABLE dbo.CosechaAgricultor ADD CONSTRAINT ckEstadoCosechaAgricultor CHECK (Estado IN ('Pendiente','Liquidado'));
GO
EXEC sp_bindefault 'dftEstado', 'dbo.CosechaAgricultor.Estado' 
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CosechaAgricultor.Monto'
GO

--DROP TABLE dbo.CosechaDetalleAgricultor
CREATE TABLE dbo.CosechaDetalleAgricultor (
    CosechaID		INT NOT NULL,
	ProductoID		INT NOT NULL,
    Cantidad		INT NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCosechaDetalleAgricultorID PRIMARY KEY (CosechaID, ProductoID),
	CONSTRAINT fkCosechaDetalleCosecha FOREIGN KEY (CosechaID) REFERENCES CosechaAgricultor,
)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CosechaDetalleAgricultor.Cantidad'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CosechaDetalleAgricultor.Precio'
GO


--DROP TABLE dbo.AgricultorInsumos
CREATE TABLE dbo.AgricultorInsumos
(
	AgricultorInsumoID	INT NOT NULL,
	AgricultorID		INT NOT NULL,
	Fecha				DATETIME NOT NULL,
	SubTotal			NUMERIC(11,2) NOT NULL,
	Impuesto			NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	Estado				VARCHAR(50),
	CONSTRAINT pkAgricultorInsumosID PRIMARY KEY (AgricultorInsumoID),
	CONSTRAINT fkAgricultorInsumoAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor,
)
GO 
EXEC sp_bindefault 'dftEstado', 'dbo.AgricultorInsumos.Estado' 
ALTER TABLE dbo.AgricultorInsumos ADD CONSTRAINT ckEstadoAgricultorInsumos CHECK (Estado IN ('Pendiente','Cobrado'));
GO

--DROP TABLE dbo.AgricultorInsumosDetalle
CREATE TABLE dbo.AgricultorInsumosDetalle (
    AgricultorInsumoID		INT NOT NULL,
    InsumoID				INT NOT NULL,
	Cantidad				INT NOT NULL,
	Precio					NUMERIC(11,2) NOT NULL,
	Descuento				NUMERIC(11,2) NOT NULL,
	Tasa					NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkAgricultorInsumoDetalleID PRIMARY KEY (AgricultorInsumoID, InsumoID),
	CONSTRAINT fkAgrInsDetAgrIns FOREIGN KEY (AgricultorInsumoID) REFERENCES AgricultorInsumos,
	CONSTRAINT fkAgricultorInsumosDetalleInsumos FOREIGN KEY (InsumoID) REFERENCES InsumosAgricolas
)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.AgricultorInsumosDetalle.Cantidad'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.AgricultorInsumosDetalle.Precio'

GO

-- DROP TABLE dbo.Transaccion
CREATE TABLE dbo.Transaccion
(
	TransaccionID		INT NOT NULL,
	CuentaID			INT NOT NULL,
	Fecha				DATETIME NOT NULL,
	Tipo				CHAR(1) NOT NULL, -- C = Cheque D = Deposito
	Monto				NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkTransaccionID PRIMARY KEY (TransaccionID),
	CONSTRAINT fkCuentaTransaccion FOREIGN KEY (CuentaID) REFERENCES CuentaBancaria
)
ALTER TABLE dbo.Transaccion ADD CONSTRAINT ckTipoTransaccion CHECK (Tipo IN ('C', 'D'))
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Transaccion.Monto'
GO

-- DROP TABLE dbo.PagosProveedores
CREATE TABLE dbo.PagosProveedores
(
	PagoID			INT NOT NULL,
	TransaccionID	INT NOT NULL,
	CompraInsumoID	INT NOT NULL,
	Fecha			DATETIME NOT NULL,
	Monto			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkPagoID PRIMARY KEY (PagoID),
	CONSTRAINT fkTransaccionPago FOREIGN KEY (TransaccionID) REFERENCES Transaccion,
	CONSTRAINT fkCompraInsumoPago FOREIGN KEY (CompraInsumoID) REFERENCES CompraInsumos
)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.PagosProveedores.Monto'
GO

--DROP TABLE dbo.LiquidacionAgricultores
CREATE TABLE dbo.LiquidacionAgricultores (
    LiquidacionID		INT NOT NULL,
    TransaccionID		INT NOT NULL,
    TotalIngresos		FLOAT NOT NULL,
	AbonosAnteriores	FLOAT NOT NULL,
    DeduccionInsumos	FLOAT NOT NULL,
	CONSTRAINT pkLiquidacionAgricultoresID PRIMARY KEY (LiquidacionID),
	CONSTRAINT fkLiquidacionTransaccion FOREIGN KEY (TransaccionID) REFERENCES Transaccion
)
GO

--DROP TABLE dbo.AbonoAgricultores
CREATE TABLE dbo.AbonoAgricultores (
    AbonoID				INT not null,
	TransaccionID		INT not null,
    Monto				NUMERIC(11,2) not null,
	Estado				VARCHAR(50),
	CONSTRAINT pkAbonoID PRIMARY KEY (AbonoID),
	CONSTRAINT fkTransaccionAbono FOREIGN KEY (TransaccionID) REFERENCES Transaccion
)
EXEC sp_bindefault 'dftEstado', 'dbo.AbonoAgricultores.Estado' 
ALTER TABLE dbo.AbonoAgricultores ADD CONSTRAINT ckEstadoAbonos CHECK (Estado IN ('Pendiente','Aplicado'));
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.AbonoAgricultores.Monto'
GO

CREATE SCHEMA config
--DROP TABLE config.Usuarios
CREATE TABLE config.Usuarios (
	UsuarioID		int not null,
	Nombre			varchar(100),
	Contrasena		BINARY(16), -- La contraseña se guardará en BINARY y después sera convertida a un VARCHAR
	Area			varchar(150),
	Estado			varchar(50),
	CONSTRAINT pkUsuarioID PRIMARY KEY (UsuarioID)
)
GO
