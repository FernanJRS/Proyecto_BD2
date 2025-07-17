USE GrupoNo4

--DROP TABLE TipoRiego
create table TipoRiego (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(50) NOT NULL,
	CONSTRAINT pkTipoRiegoID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE TipoSuelo
create table TipoSuelo (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(50) NOT NULL,
	CONSTRAINT pkTipoSueloID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE Cliente
CREATE TABLE Cliente
(
	ClienteID	INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	RTN			VARCHAR(100) NOT NULL,
	Direccion	VARCHAR(150) NOT NULL,
	Telefono	VARCHAR(100) NOT NULL,
	CONSTRAINT pkClienteID PRIMARY KEY (ClienteID),
	CONSTRAINT ukRTN UNIQUE (RTN)
)
GO

--DROP TABLE Factura
CREATE TABLE Factura
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
GO

--DROP TABLE FacturaDetalle
CREATE TABLE FacturaDetalle
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


--DROP TABLE ProductosAgricolas
create table ProductosAgricolas (
    ProductoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Codigo			AS CONCAT('AGR-', LEFT(CAST(NEWID() AS VARCHAR(36)), 6)),
	Existencias		INT NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
    UnidadMedida	VARCHAR(50) NOT NULL,
	CONSTRAINT pkProductoAgrícolaID PRIMARY KEY (ProductoID)
)
GO

--DROP TABLE TipoProveedor
CREATE TABLE TipoProveedor
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoProveedorID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE Banco
CREATE TABLE Banco
(
	BancoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkBancoID PRIMARY KEY (BancoID)
)

--DROP TABLE CuentaBancaria
CREATE TABLE CuentaBancaria
(
	CuentaID		INT NOT NULL,
	BancoID			INT NOT NULL,
	Tipo			CHAR(2) NOT NULL, -- AG = Agricultor PR = Proveedor
	NumeroCuenta	VARCHAR(100) NOT NULL,
	TipoCuenta		CHAR(1) NOT NULL, -- A = Ahorro C = Cheques
	CONSTRAINT pkCuentaID PRIMARY KEY (CuentaID),
	CONSTRAINT fkBancoCuenta FOREIGN KEY (BancoID) REFERENCES Banco
)

--DROP TABLE ProveedorInsumos
create table ProveedorInsumos (
    ProveedorID			INT NOT NULL,
	CuentaID			INT NOT NULL,
    Nombre				VARCHAR(100) NOT NULL,
    Contacto			VARCHAR(100) NOT NULL,
    Direccion			VARCHAR(200) NOT NULL,
    Telefono			VARCHAR(20) NOT NULL,
	Correo				VARCHAR(50) NOT NULL,
	TipoProveedorID		INT NOT NULL,
	CondicionesCredito	VARCHAR(MAX),
	CONSTRAINT pkProveedorInsumosID PRIMARY KEY (ProveedorID),
	CONSTRAINT fkTipoProveedor FOREIGN KEY (TipoProveedorID) REFERENCES TipoProveedor,
	CONSTRAINT fkCuentaProveedor FOREIGN KEY (CuentaID) REFERENCES CuentaBancaria
)
GO

--DROP TABLE CompraInsumos
create table CompraInsumos (
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
GO

--DROP TABLE Insumos
CREATE TABLE TipoInsumo
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoInsumoID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE InsumosAgricolas
create table InsumosAgricolas (
    InsumoID		INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
    TipoInsumoID	INT NOT NULL,
	Codigo			AS CONCAT( 'INS-' ,LEFT(CAST(NEWID() AS VARCHAR(36)), 6)),
	Descripcion		VARCHAR(150) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	Existencias		INT NOT NULL,
	UnidadMedida	VARCHAR(50) NOT NULL,
	CONSTRAINT pkInsumoID PRIMARY KEY (InsumoID),
	CONSTRAINT fkTipoInsumo FOREIGN KEY (TipoInsumoID) REFERENCES TipoInsumo
)

--DROP TABLE CompraDetalleInsumos
CREATE TABLE CompraDetalleInsumos
(
	CompraInsumoID		INT NOT NULL,
	InsumoID			INT NOT NULL,
	Cantidad			INT NOT NULL,
	UnidadMedida		VARCHAR(50) NOT NULL,
	Precio				NUMERIC(11,2) NOT NULL,
	Tasa				NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCompraDetalleID PRIMARY KEY (CompraInsumoID, InsumoID),
	CONSTRAINT fkCompraDetalleInsumo FOREIGN KEY (InsumoID) REFERENCES InsumosAgricolas
)
GO

--DROP TABLE Agricultor
CREATE TABLE Agricultor (
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
GO

--DROP TABLE Fincas
CREATE TABLE Fincas (
    FincaID			INT NOT NULL,
    AgricultorID	INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Ubicacion		VARCHAR(50) NOT NULL,
    Extension		FlOAT NOT NULL,
	CONSTRAINT pkFincaID PRIMARY KEY (FincaID),
	CONSTRAINT fkFincaAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
GO

--DROP TABLE Lotes
CREATE TABLE Lotes (
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
GO

--DROP TABLE Bodega
CREATE TABLE Bodega
(
	BodegaID	INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	Espacio		VARCHAR(150) NOT NULL,
	CONSTRAINT pkBodegaID PRIMARY KEY (BodegaID)
)
GO

--DROP TABLE CosechaAgricultor
create table CosechaAgricultor (
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

--DROP TABLE CosechaDetalleAgricultor
create table CosechaDetalleAgricultor (
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


--DROP TABLE AgricultorInsumos
CREATE TABLE AgricultorInsumos
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

--DROP TABLE AgricultorInsumosDetalle
create table AgricultorInsumosDetalle (
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

-- DROP TABLE Transaccion
CREATE TABLE Transaccion
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

-- DROP TABLE PagosProveedores
CREATE TABLE PagosProveedores
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

--DROP TABLE Liquidaciones
CREATE TABLE LiquidacionAgricultores (
    LiquidacionID		INT not null,
    AgricultorID		INT not null,
    Periodo				DATETIME not null,
    TotalIngresos		FLOAT not null,
    DeduccionInsumos	FLOAT not null,
	CONSTRAINT pkLiquidacionAgricultoresID PRIMARY KEY (LiquidacionID),
	CONSTRAINT fkLiquidacionAgricultores FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
GO


--DROP TABLE Abonos
CREATE TABLE AbonoAgricultores (
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

DROP TABLE Usuarios
CREATE TABLE Usuarios (
	UsuarioID		int not null,
	Nombre			varchar(100),
	Contrasena		BINARY(16), -- La contraseña se guardará en BINARY y después sera convertida a un VARCHAR
	Area			varchar(150),
	Estado			varchar(50),
	CONSTRAINT pkUsuarioID PRIMARY KEY (UsuarioID)
)
GO