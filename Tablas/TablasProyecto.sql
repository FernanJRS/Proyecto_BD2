+

--DROP TABLE dbo.TipoRiego
create table dbo.TipoRiego (
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
create table dbo.TipoSuelo (
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
ALTER TABLE dbo.Cliente ADD CONSTRAINT ckIdentidad CHECK ((TipoIdentidad = 'C' AND LEN(Identidad) = 13)
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
	Impuesto	NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkFacturaID PRIMARY KEY (FacturaID),
	CONSTRAINT fkClienteID FOREIGN KEY (ClienteID) REFERENCES Cliente
)
ALTER TABLE dbo.Factura ADD CONSTRAINT ckTipoFactura CHECK (Tipo IN ('R', 'C')) -- R = Credito, C = Contado
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Factura.SubTotal'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Factura.Descuento'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Factura.Impuesto'
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
create table dbo.ProductosAgricolas (
    ProductoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Codigo			VARCHAR(36) NOT NULL, -- AS CONCAT('AGR-', LEFT(CAST(NEWID() AS VARCHAR(36)), 6)),
	TipoID			INT NOT NULL,
	Existencias		INT NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
    UnidadID		INT NOT NULL,
	CONSTRAINT pkProductoAgrícolaID PRIMARY KEY (ProductoID)
)
ALTER TABLE dbo.ProductosAgricolas ADD CONSTRAINT fkUnidadProducto FOREIGN KEY (UnidadID) REFERENCES UnidadMedida
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
	Precio		NUMERIC(11,2) NOT NULL,
	Impuesto	NUMERIC(11,2) NOT NULL,
	Descuento	NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkFacturaDetalleID PRIMARY KEY (FacturaID, ProductoID),
	CONSTRAINT fkFacturaDetalleProducto FOREIGN KEY (ProductoID) REFERENCES ProductosAgricolas,
	CONSTRAINT fkFacturaDetalleFactura FOREIGN KEY (FacturaID) REFERENCES Factura
)
GO
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Cantidad'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Precio'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Impuesto'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.FacturaDetalle.Descuento'
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
ALTER TABLE dbo.CuentaBancaria ADD CONSTRAINT ckTipoUsuarioCuenta CHECK (Tipo IN ('AG', 'PR'))
ALTER TABLE dbo.CuentaBancaria ADD CONSTRAINT ckTipoCuentaBancaria CHECK (TipoCuenta IN ('A', 'C'))
GO

--DROP TABLE dbo.TipoProveedorInsumos
CREATE TABLE dbo.TipoProveedorInsumos
(
	TipoID			INT NOT NULL,
	ProveedorID		INT NOT NULL,
	CONSTRAINT pkTipoProveedorInsumo PRIMARY KEY (TipoID, ProveedorID),
	CONSTRAINT fkTiposProveedores FOREIGN KEY (TipoID) REFERENCES TipoProveedor,
	CONSTRAINT fkProveedoresInsumos FOREIGN KEY (ProveedorID) REFERENCES ProveedorInsumos
)
GO

--DROP TABLE dbo.ProveedorInsumos
create table dbo.ProveedorInsumos (
    ProveedorID			INT NOT NULL,
	CuentaID			INT NOT NULL,
    Nombre				VARCHAR(100) NOT NULL,
    Contacto			VARCHAR(100) NOT NULL,
    Direccion			VARCHAR(200) NOT NULL,
    Telefono			VARCHAR(20) NOT NULL,
	Correo				VARCHAR(50) NOT NULL,
	CondicionesCredito	VARCHAR(MAX),
	CONSTRAINT pkProveedorInsumosID PRIMARY KEY (ProveedorID),
	CONSTRAINT fkCuentaProveedor FOREIGN KEY (CuentaID) REFERENCES CuentaBancaria
)
ALTER TABLE dbo.ProveedorInsumos ADD CONSTRAINT ckCorreoProveedor CHECK (Correo LIKE '%@%.%')
GO

--DROP TABLE dbo.CompraInsumos
create table dbo.CompraInsumos (
    CompraInsumosID		INT NOT NULL,
	ProveedorID			INT NOT NULL,
    FechaCompra			DATETIME NOT NULL,
	FechaVencimiento	DATETIME NOT NULL,
	SubTotal			NUMERIC(11,2) NOT NULL,
	Impuesto			NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL
	CONSTRAINT pkCompraInsumoID PRIMARY KEY (CompraInsumosID),
	CONSTRAINT fkProveedorCompra FOREIGN KEY (ProveedorID) REFERENCES ProveedorInsumos
)
ALTER TABLE dbo.CompraInsumos ADD CONSTRAINT ckFechaCompra CHECK (FechaCompra < FechaVencimiento)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraInsumos.SubTotal'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraInsumos.Impuesto'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraInsumos.Descuento'
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
create table dbo.InsumosAgricolas (
    InsumoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
    TipoInsumoID	INT NOT NULL,
	Codigo			VARCHAR(36) NOT NULL, -- AS CONCAT( 'INS-' ,LEFT(CAST(NEWID() AS VARCHAR(36)), 6)),
	Descripcion		VARCHAR(150) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	Existencias		INT NOT NULL,
	UnidadID		INT NOT NULL,
	CONSTRAINT pkInsumoID PRIMARY KEY (InsumoID),
	CONSTRAINT fkTipoInsumo FOREIGN KEY (TipoInsumoID) REFERENCES TipoInsumo
)
ALTER TABLE dbo.InsumosAgricolas ADD CONSTRAINT fkUnidadInsumo FOREIGN KEY (UnidadID) REFERENCES UnidadMedida
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.InsumosAgricolas.Precio'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.InsumosAgricolas.Existencias'
GO

--DROP TABLE dbo.CompraDetalleInsumos
CREATE TABLE dbo.CompraDetalleInsumos
(
	CompraInsumoID		INT NOT NULL,
	InsumoID			INT NOT NULL,
	Cantidad			INT NOT NULL,
	Precio				NUMERIC(11,2) NOT NULL,
	Tasa				NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCompraDetalleID PRIMARY KEY (CompraInsumoID, InsumoID),
	CONSTRAINT fkCompraDetalleInsumo FOREIGN KEY (InsumoID) REFERENCES InsumosAgricolas
)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraDetalleInsumos.Precio'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraDetalleInsumos.Tasa'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.CompraDetalleInsumos.Descuento'
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
ALTER TABLE dbo.Agricultor ADD CONSTRAINT ckIdentidadAgricultor CHECK (LEN(Identidad) = 13)
GO

--DROP TABLE dbo.Fincas
CREATE TABLE dbo.Fincas (
    FincaID			INT NOT NULL,
    AgricultorID	INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Ubicacion		VARCHAR(50) NOT NULL,
    Extension		FlOAT NOT NULL,
	CONSTRAINT pkFincaID PRIMARY KEY (FincaID),
	CONSTRAINT fkFincaAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
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
	CantidadCosechas	INT NOT NULL, 
    FechaSiembra		DATETIME NOT NULL,
	CONSTRAINT pkLoteFinca PRIMARY KEY (FincaID, LoteID),
	CONSTRAINT fkFincaLote FOREIGN KEY (FincaID) REFERENCES Fincas(FincaID),
	CONSTRAINT fkLoteTipoRiego FOREIGN KEY (TipoRiegoID) REFERENCES TipoRiego,
	CONSTRAINT fkLoteTipoSuelo FOREIGN KEY (TipoSueloID) REFERENCES TipoSuelo
)
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Lotes.Extension'
EXEC sp_bindrule 'rCantidadMayor0', 'dbo.Lotes.CantidadCosechas'
GO

--DROP TABLE dbo.Bodega
CREATE TABLE dbo.Bodega
(
	BodegaID	INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	Espacio		VARCHAR(150) NOT NULL,
	CONSTRAINT pkBodegaID PRIMARY KEY (BodegaID)
)
GO

--DROP TABLE dbo.CosechaAgricultor
create table dbo.CosechaAgricultor (
    CosechaID		INT NOT NULL,
    AgricultorID	INT NOT NULL,
    BodegaID		INT NOT NULL,
	Tipo			CHAR(1) NOT NULL,
	Estado			CHAR(1) NOT NULL,
    Fecha			DATETIME NOT NULL,
	Monto			FLOAT NOT NULL,
	CONSTRAINT pkCosechaID PRIMARY KEY (CosechaID),
	CONSTRAINT fkAgricultorCosecha FOREIGN KEY (AgricultorID) REFERENCES Agricultor,
	CONSTRAINT fkBodegaCosecha FOREIGN KEY (BodegaID) REFERENCES Bodega
)
GO

--DROP TABLE dbo.CosechaDetalleAgricultor
create table dbo.CosechaDetalleAgricultor (
    CosechaID		INT NOT NULL,
	ProductoID		INT NOT NULL,
    Cantidad		INT NOT NULL,
	UnidadMedida	VARCHAR(50) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	Impuesto		NUMERIC(11,2) NOT NULL,
	Descuento		NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCosechaDetalleAgricultorID PRIMARY KEY (CosechaID, ProductoID),
	CONSTRAINT fkCosechaDetalleCosecha FOREIGN KEY (CosechaID) REFERENCES CosechaAgricultor,
)
GO


--DROP TABLE dbo.AgricultorInsumos
CREATE TABLE dbo.AgricultorInsumos
(
	AgricultorInsumoID	INT NOT NULL,
	AgricultorID		INT NOT NULL,
	Fecha				DATETIME NOT NULL,
	SubTotal			NUMERIC(11,2) NOT NULL,
	Tasa				NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkAgricultorInsumosID PRIMARY KEY (AgricultorInsumoID),
	CONSTRAINT fkAgricultorInsumoAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor,
)
GO

--DROP TABLE dbo.AgricultorInsumosDetalle
create table dbo.AgricultorInsumosDetalle (
    AgricultorInsumoID		INT NOT NULL,
    InsumoID				INT NOT NULL,
	Cantidad				INT NOT NULL,
	UnidadMedida			VARCHAR(50) NOT NULL,
	Precio					NUMERIC(11,2) NOT NULL,
	Descuento				NUMERIC(11,2) NOT NULL,
	Tasa				NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkAgricultorInsumoDetalleID PRIMARY KEY (AgricultorInsumoID, InsumoID),
	CONSTRAINT fkAgrInsDetAgrIns FOREIGN KEY (AgricultorInsumoID) REFERENCES AgricultorInsumos,
	CONSTRAINT fkAgricultorInsumosDetalleInsumos FOREIGN KEY (InsumoID) REFERENCES InsumosAgricolas
)
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
GO

--DROP TABLE dbo.LiquidacionAgricultores
CREATE TABLE dbo.LiquidacionAgricultores (
    LiquidacionID		INT not null,
    AgricultorID		INT not null,
    Periodo				DATETIME not null,
    TotalIngresos		FLOAT not null,
    DeduccionInsumos	FLOAT not null,
	CONSTRAINT pkLiquidacionAgricultoresID PRIMARY KEY (LiquidacionID),
	CONSTRAINT fkLiquidacionAgricultores FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
GO


--DROP TABLE dbo.AbonoAgricultores
CREATE TABLE dbo.AbonoAgricultores (
    AbonoID				INT not null,
    LiquidacionID		INT not null,
	TransaccionID		INT not null,
    Fecha				DATETIME not null,
    MontoAbonado		NUMERIC(11,2) not null,
	CONSTRAINT pkAbonoID PRIMARY KEY (AbonoID),
	CONSTRAINT fkLiquidacionAbono FOREIGN KEY (LiquidacionID) REFERENCES LiquidacionAgricultores,
	CONSTRAINT fkTransaccionAbono FOREIGN KEY (TransaccionID) REFERENCES Transaccion
)
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