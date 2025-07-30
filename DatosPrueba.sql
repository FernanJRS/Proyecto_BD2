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
  @fincaID        = 2,
  @codigoProducto = 'AGR-002',
  @nombre         = 'Lote Algodón Norte',
  @extension      = 6.00,
  @tipoSuelo      = 'Suelo Arcilloso',
  @tipoRiego      = 'Riego por Goteo';

-- Finca 3: primer lote de Alfalfa (AGR-003), 10 ha
EXEC spAgregarLoteFinca
  @fincaID        = 3,
  @codigoProducto = 'AGR-003',
  @nombre         = 'Lote Alfalfa A',
  @extension      = 10.00,
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
  ('AGR-003', 'Alfalfa', 10000.00, 'quintales', 80.00),
  ('AGR-004', 'Rosas', 5000.00, 'quintales', 1200.00);

EXEC spRegistrarCosecha
  @agricultorID = 3,
  @bodega       = 'Bodega 1',
  @fecha        = '2025-07-30',
  @tdetalle     = @detalle;

SELECT * FROM CosechaAgricultor
SELECT * FROM CosechaDetalleAgricultor
