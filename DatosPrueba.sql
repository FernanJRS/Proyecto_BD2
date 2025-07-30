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