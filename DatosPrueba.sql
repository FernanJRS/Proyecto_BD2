USE GrupoNo4
GO

-- Agricultores
EXEC spAgregarAgricultor
    @Nombre = 'Juan Pérez',
    @DNI = '0801-1990-12243',
    @Telefono = '9876-1234',
    @Direccion = 'Col. Kennedy, Teguc.',
    @Email = 'juanp@example.com',
    @nombreBanco = 'Banpaís',
    @TipoCuenta = 'ahorro',
    @NumCuenta = '000123456789';

EXEC spAgregarAgricultor
    @Nombre = 'María López',
    @DNI = '0801-1990-12345',
    @Telefono = '9988-5678',
    @Direccion = 'Col. Palmira, Teguc.',
    @Email = 'maria.l@example.com',
    @nombreBanco = 'Banco Ficohsa',
    @TipoCuenta = 'cheques',
    @NumCuenta = '000987654321';

EXEC spAgregarAgricultor
    @Nombre = 'Ana García',
    @DNI = '0801-1990-12346',
    @Telefono = '9345-6677',
    @Direccion = 'Col. Miraflores',
    @Email = 'ana.g@example.com',
    @nombreBanco = 'BAC Honduras',
    @TipoCuenta = 'ahorro',
    @NumCuenta = 'A00011223344';
GO
-- Productos Agrícolas
EXEC spAgregarProducto @nombre = 'Maíz',       @tipo = 'Cultivo Alimenticio';
EXEC spAgregarProducto @nombre = 'Algodón',    @tipo = 'Cultivo Industrial';
EXEC spAgregarProducto @nombre = 'Alfalfa',    @tipo = 'Cultivo Forrajero';
EXEC spAgregarProducto @nombre = 'Rosas',      @tipo = 'Plantas Ornamentales';
EXEC spAgregarProducto @nombre = 'Aloe Vera',  @tipo = 'Plantas Medicinales';
GO

-- Agregar Fincas
EXEC spAgregarFinca 
  @AgricultorID = 1, 
  @Nombre       = 'Finca El Paraíso', 
  @Ubicacion    = 'Col. Palmira, Tegucigalpa', 
  @Extension    = 25.50;  -- 25.50 ha (≈255 000 m²)

EXEC spAgregarFinca 
  @AgricultorID = 2, 
  @Nombre       = 'Finca Miravalles', 
  @Ubicacion    = 'Col. Miraflores, Tegucigalpa', 
  @Extension    = 18.00;  -- 18.00 ha (≈180 000 m²)

EXEC spAgregarFinca 
  @AgricultorID = 3, 
  @Nombre       = 'Finca La Esperanza', 
  @Ubicacion    = 'Col. Kennedy, Tegucigalpa', 
  @Extension    = 30.75;  -- 30.75 ha (≈307 500 m²)
  GO
  
-- Lotes de Prueba
 -- Finca 1: un lote de Maíz (AGR-001), 5 ha
 

EXEC spAgregarLoteFinca
  @fincaID        = 1,
  @codigoProducto = 'AGR-001',
  @nombre         = 'Lote Maíz Principal',
  @extension      = 5.00,
  @tipoSuelo      = 'Suelo Franco',
  @tipoRiego      = 'Riego por Aspersión';

-- Finca 2: un lote de Algodón (AGR-002), 6 ha
EXEC spAgregarLoteFinca
  @fincaID        = 1,
  @codigoProducto = 'AGR-002',
  @nombre         = 'Lote Algodón Norte',
  @extension      = 6.00,
  @tipoSuelo      = 'Suelo Arcilloso',
  @tipoRiego      = 'Riego por Goteo';

-- Finca 3: primer lote de Alfalfa (AGR-003), 10 ha
EXEC spAgregarLoteFinca
  @fincaID        = 2,
  @codigoProducto = 'AGR-003',
  @nombre         = 'Lote Alfalfa A',
  @extension      = 20.00,
  @tipoSuelo      = 'Suelo Limoso',
  @tipoRiego      = 'Riego por Inundación';

-- Finca 3: segundo lote de Rosas (AGR-004), 12 ha
EXEC spAgregarLoteFinca
  @fincaID        = 3,
  @codigoProducto = 'AGR-004',
  @nombre         = 'Lote Rosas B',
  @extension      = 12.00,
  @tipoSuelo      = 'Suelo Humífero',
  @tipoRiego      = 'Riego por Aspersión';
 
-- Registrar cosecha
-- Nota: Precio en lempiras, Cantidad en quintales
DECLARE @detalle DetalleCosecha;

INSERT INTO @detalle (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES
  ('AGR-001', 'Maiz', 5000.00, 'Quintales', 550.00)
  --('AGR-004', 'Algodon', 2000.00, 'quintales', 2500.00);

EXEC spRegistrarCosecha
  @agricultorID = 2,
  @finca = 1,
  @bodega       = 'Bodega 1',
  @fecha        = '2025-07-30',
  @tdetalle     = @detalle;
  
SELECT * FROM ProductosAgricolas 
SELECT * FROM CosechaAgricultor
SELECT * FROM CosechaDetalleAgricultor 

-- Agregar Insumos
EXEC spAgregarInsumo 
  @nombre = 'Pesticida Orgánico', 
  @tipoInsumo = 'Insumos Químicos', 
  @descripcion = 'Pesticida de bajo impacto ambiental', 
  @unidadMedida = 'galones';

EXEC spAgregarInsumo 
  @nombre = 'Herbicida Selectivo', 
  @tipoInsumo = 'Insumos Químicos', 
  @descripcion = 'Inhibe el crecimiento de malezas específicas', 
  @unidadMedida = 'galones';

EXEC spAgregarInsumo 
  @nombre = 'Fertilizante Nitrogenado', 
  @tipoInsumo = 'Insumos Químicos', 
  @descripcion = 'Fertilizante con 30% de nitrógeno', 
  @unidadMedida = 'galones';

EXEC spAgregarInsumo 
  @nombre = 'Bioinsecticida Líquido', 
  @tipoInsumo = 'Insumos Biológicos', 
  @descripcion = 'Control biológico de plagas', 
  @unidadMedida = 'quintales';

EXEC spAgregarInsumo 
  @nombre = 'Abono Orgánico Granulado', 
  @tipoInsumo = 'Insumos Biológicos', 
  @descripcion = 'Abono natural para suelos', 
  @unidadMedida = 'quintales';

EXEC spAgregarInsumo 
  @nombre = 'Compost Activado', 
  @tipoInsumo = 'Insumos Biológicos', 
  @descripcion = 'Mejora la estructura del suelo', 
  @unidadMedida = 'quintales';

EXEC spAgregarInsumo 
  @nombre = 'Azada de Mano', 
  @tipoInsumo = 'Herramientas Manuales', 
  @descripcion = 'Azada de acero con mango de madera', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Machete Agrícola', 
  @tipoInsumo = 'Herramientas Manuales', 
  @descripcion = 'Machete de hoja ancha para corte de maleza', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Carretilla de Acero', 
  @tipoInsumo = 'Herramientas Manuales', 
  @descripcion = 'Capacidad de 100 kg, ruedas neumáticas', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Sensor de Humedad', 
  @tipoInsumo = 'Tecnología Agrícola', 
  @descripcion = 'Sensor digital de humedad de suelo', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'GPS Agrícola', 
  @tipoInsumo = 'Tecnología Agrícola', 
  @descripcion = 'Sistema GPS para mapeo de parcelas', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Controlador de Riego', 
  @tipoInsumo = 'Tecnología Agrícola', 
  @descripcion = 'Programador automático de riego', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Tractor de 75 HP', 
  @tipoInsumo = 'Maquinaria Agrícola', 
  @descripcion = 'Tractor con cabina y tracción 4x4', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Arado de Discos', 
  @tipoInsumo = 'Maquinaria Agrícola', 
  @descripcion = 'Arado para labranza profunda', 
  @unidadMedida = 'unidad';

EXEC spAgregarInsumo 
  @nombre = 'Cosechadora de Granos', 
  @tipoInsumo = 'Maquinaria Agrícola', 
  @descripcion = 'Cosechadora autopropulsada', 
  @unidadMedida = 'unidad';
GO

SELECT * FROM ProveedorInsumos

DECLARE @proveedorID INT = 1;
DECLARE @fechaCompra DATE = GETDATE();
DECLARE @fechaVencimiento DATE = DATEADD(DAY, 30, @fechaCompra);

DECLARE @tDetalle DetalleInsumo;

INSERT INTO @tDetalle (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES ('INS-001', 'Pesticida Orgánico', 10, 'galones', 250.00, 0.00),
('INS-002', 'Herbicida Selectivo', 5, 'galones', 300.00, 0.10);

EXEC dbo.spRegistrarOrdenInsumos
    @proveedorID = @proveedorID,
    @fechaCompra = @fechaCompra,
    @fechaVencimiento = @fechaVencimiento,
    @tDetalle = @tDetalle;

EXEC dbo.spRegistrarIngresoInsumos 2;

SELECT * FROM CompraInsumos
SELECT * FROM CompraDetalleInsumos
SELECT * FROM InsumosAgricolas

DECLARE @tDetalle DetalleInsumo, @fecha DATETIME = GETDATE();

INSERT INTO @tDetalle (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES ('INS-001', 'Pesticida Orgánico', 5, 'galones', 250.00, 0.00)

EXEC dbo.spRegistrarInsumosAgricultor 2, @fecha, @tDetalle

SELECT * FROM AgricultorInsumos

DECLARE @fecha1 DATETIME = GETDATE(), @pago FLOAT;

SELECT @pago = (SELECT dbo.fSaldoPendienteProveedorPorCompra(3, 1))

EXEC spRegistrarPagoProveedor 1, 1, @fecha1, 'Deposito', @pago

SELECT * FROM PagoProveedores

DECLARE @fecha3 DATETIME = GETDATE(), @saldo1 FLOAT, @saldo2 FLOAT, @monto FLOAT, @tDeduccion InsumosDeducidos;

SELECT @saldo1 = (SELECT dbo.fLiquidacionPendienteAgricultorPorCosecha(4, 2))

SELECT @saldo2 = (SELECT dbo.fSaldoPendienteAgricultorPorCosecha(3, 2))

INSERT INTO @tDeduccion (AgricultorInsumoID)
SELECT AgricultorInsumoID FROM dbo.ftInsumosPendientesAgricultor(2, @saldo1);

SELECT @monto = @saldo1 - (SELECT dbo.fDeduccionInsumosAgricultor(@tDeduccion))

SELECT @monto

--DECLARE @deposito FLOAT = @saldo2 * 0.01;

--EXEC spRegistrarAbonoAgricultor 2, 1, @fecha3, 'Deposito', 1100000.00
EXEC spRegistrarLiquidacionAgricultor 2, 4, @fecha3, 'Deposito', @monto

SELECT * FROM PagoAgricultores
SELECT * FROM AgricultorInsumos

SELECT * FROM PagoProveedores

------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM Cliente
EXEC spAgregarCliente 'Patricio', 'DNI', '0401-2004-00584', 'En algún lugar', '9982-9141'

DECLARE @ff DATETIME = GETDATE();

DECLARE @tVentas DetalleVenta;

INSERT INTO @tVentas
VALUES ('AGR-001', 'Maíz', 300, 'Fardos', 650.00, 0)

EXEC spFacturarProductos 1, 'Contado', @ff, @tVentas


SELECT * FROM PagoAgricultores

SELECT * FROM AgricultorInsumos