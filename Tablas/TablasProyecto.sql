USE GrupoNo4

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


--DROP TABLE Agricultor
create table Agricultor (
    AgricultorID	INT NOT NULL,
    Nombre			VARCHAR(100) not null,
    Identidad		VARCHAR(50) not null,
    Telefono		VARCHAR(30) not null,
    Direccion		VARCHAR(200) not null,
    Correo			VARCHAR(100) not null,
	CONSTRAINT pkAgricultorID PRIMARY KEY (AgricultorID)
)
GO

--DROP TABLE Fincas
create table Fincas (
    FincaID			INT NOT NULL,
    AgricultorID	INT NOT NULL,
    Nombre			VARCHAR(100) NOT NULL,
	Ubicacion		VARCHAR(50) NOT NULL,
    Extension		FlOAT NOT NULL,
	CONSTRAINT pkFincaID PRIMARY KEY (FincaID),
	CONSTRAINT fkFincaAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor
)
GO

--DROP TABLE TipoSuelo
create table TipoSuelo (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(50) NOT NULL,
	CONSTRAINT pkTipoSueloID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE TipoRiego
create table TipoRiego (
    TipoID		INT NOT NULL,
    Nombre		VARCHAR(50) NOT NULL,
	CONSTRAINT pkTipoRiegoID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE Lotes
create table Lotes (
    FincaID				INT NOT NULL,
    LoteID				INT NOT NULL,
	ProductoID			INT NOT NULL,
    Nombre				VARCHAR(100) NOT NULL,
    Extension			FLOAT NOT NULL,
    TipoRiegoID			INT NOT NULL,
    TipoSueloID			INT NOT NULL,
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
	FincaID			INT NOT NULL,
    LoteID			INT NOT NULL,
    Cantidad		INT NOT NULL,
	UnidadMedida	VARCHAR(50) NOT NULL,
	Precio			NUMERIC(11,2) NOT NULL,
	Impuesto		NUMERIC(11,2) NOT NULL,
	Descuento		NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkCosechaDetalleAgricultorID PRIMARY KEY (CosechaID, LoteID),
	CONSTRAINT fkCosechaDetalleCosecha FOREIGN KEY (CosechaID) REFERENCES CosechaAgricultor,
	CONSTRAINT fkCosechaDetalleFincaLote FOREIGN KEY (FincaID, LoteID) REFERENCES Lotes(FincaID, LoteID)
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

--DROP TABLE TipoProveedor
CREATE TABLE TipoProveedor
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoProveedorID PRIMARY KEY (TipoID)
)
GO

--DROP TABLE ProveedorInsumos
create table ProveedorInsumos (
    ProveedorID			INT NOT NULL,
    Nombre				VARCHAR(100) NOT NULL,
    Contacto			VARCHAR(100) NOT NULL,
    Direccion			VARCHAR(200) NOT NULL,
    Telefono			VARCHAR(20) NOT NULL,
	Correo				VARCHAR(50) NOT NULL,
	TipoProveedorID		INT NOT NULL,
	CondicionesCredito	VARCHAR(MAX),
	CONSTRAINT pkProveedorInsumosID PRIMARY KEY (ProveedorID),
	CONSTRAINT fkTipoProveedor FOREIGN KEY (TipoProveedorID) REFERENCES TipoProveedor
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

--DROP TABLE AgricultorInsumos
CREATE TABLE AgricultorInsumos
(
	AgricultorInsumoID	INT NOT NULL,
	AgricultorID		INT NOT NULL,
	CompraInsumoID		INT NOT NULL,
	SubTotal			NUMERIC(11,2) NOT NULL,
	Tasa				NUMERIC(11,2) NOT NULL,
	Descuento			NUMERIC(11,2) NOT NULL,
	CONSTRAINT pkAgricultorInsumosID PRIMARY KEY (AgricultorInsumoID),
	CONSTRAINT fkAgricultorInsumoAgricultor FOREIGN KEY (AgricultorID) REFERENCES Agricultor,
	CONSTRAINT fkAgricultorInsumosCompra FOREIGN KEY (CompraInsumoID) REFERENCES CompraInsumos
)
GO
--DROP TABLE Banco
CREATE TABLE Banco
(
	BancoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkBancoID PRIMARY KEY (BancoID)
)

-- DROP TABLE MetodoPago
CREATE TABLE MetodoPago
(
	TipoID		INT NOT NULL,
	Nombre		VARCHAR(100) NOT NULL,
	CONSTRAINT pkMetodoPagoID PRIMARY KEY (TipoID)
)

--DROP TABLE CuentaBancaria
CREATE TABLE CuentaBancaria
(
	CuentaID		INT NOT NULL,
	UsuarioID		INT NOT NULL,
	BancoID			INT NOT NULL,
	Tipo			CHAR(1) NOT NULL, -- A = Ahorros C = Cheques
	NumeroCuenta	VARCHAR(100) NOT NULL,

)

--DROP TABLE Liquidaciones
create table Liquidaciones (
    LiquidacionID int primary key not null,
    ProductorID int not null,
    FechaLiquidacion date not null,
    ValorTotal float not null,
    DescuentoInsumos float not null,
    SaldoNeto float not null,
    Observaciones varchar(max)
)
alter table Liquidaciones add constraint FK_Liquidaciones_Productores foreign key (ProductorID) references Productores(ProductorID)
GO

DROP TABLE Abonos
create table Abonos (
    AbonoID int primary key not null,
    ProductorID int not null,
	Monto float not null,
    FormaPagoID int not null,
    Referencia varchar(100) not null,
    Fecha date not null,   
)
alter table Abonos add constraint FK_Abonos_Productores foreign key (ProductorID) references Productores(ProductorID)
alter table Abonos add constraint FK_Abonos_FormaPago foreign key (FormaPagoID) references FormaPago(FormaPagoID)
GO

DROP TABLE FormaPago
create table FormaPago (
    FormaPagoID int primary key not null,
    Descripcion varchar(200) not null
)
GO

DROP TABLE Usuarios
create table Usuarios (
	UsuarioID	int not null,
	Nombre	varchar(100),
	Contrasena varchar(100),
	Area	varchar(100),
	Estado	varchar(50)
)
GO