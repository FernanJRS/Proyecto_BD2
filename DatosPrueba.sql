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
EXEC spAgregarProducto 'Frijoles', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Arroz', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Café', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Plátano', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Caña de Azúcar', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Tomate', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Cebolla', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Papa', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Yuca', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Sandía', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Melón', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Piña', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Naranja', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Limón', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Mango', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Aguacate', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Lechuga', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Zanahoria', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Pepino', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Repollo', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Ajo', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Cilantro', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Perejil', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Espinaca', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Apio', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Rábano', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Berenjena', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Pimiento', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Calabaza', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Chayote', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Guayaba', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Papaya', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Maracuyá', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Fresa', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Uva', 'Cultivo Alimenticio';
EXEC spAgregarProducto 'Tabaco', 'Cultivo Industrial';
EXEC spAgregarProducto 'Henequén', 'Cultivo Industrial';
EXEC spAgregarProducto 'Palma Africana', 'Cultivo Industrial';
EXEC spAgregarProducto 'Caucho', 'Cultivo Industrial';
EXEC spAgregarProducto 'Pasto Estrella', 'Cultivo Forrajero';
EXEC spAgregarProducto 'Pasto Guinea', 'Cultivo Forrajero';
EXEC spAgregarProducto 'Pasto Elefante', 'Cultivo Forrajero';
EXEC spAgregarProducto 'Manzanilla', 'Plantas Medicinales';
EXEC spAgregarProducto 'Ruda', 'Plantas Medicinales';
GO

-- Agregar Fincas
EXEC spAgregarFinca 
    @agricultorID = 3, 
    @nombre = 'Finca El Encanto', 
    @ubicacion = 'Tatumbla, Fco. Morazán', 
    @extension = 12.5; -- ha

EXEC spAgregarFinca 
    @agricultorID = 4, 
    @nombre = 'Finca La Esperanza', 
    @ubicacion = 'Santa Ana, Fco. Morazán', 
    @extension = 8.3; -- ha

EXEC spAgregarFinca 
    @agricultorID = 4, 
    @nombre = 'Finca Los Pinos', 
    @ubicacion = 'Valle de Ángeles', 
    @extension = 15.0; -- ha
 
EXEC spAgregarFinca 
    @agricultorID = 5, 
    @nombre = 'Finca Tierra Fértil', 
    @ubicacion = 'El Zamorano', 
    @extension = 10.7; -- ha

EXEC spAgregarFinca 
    @agricultorID = 5, 
    @nombre = 'Finca La Cumbre', 
    @ubicacion = 'San Juancito', 
    @extension = 6.9; -- ha

-- Lotes de Prueba
EXEC spAgregarLoteFinca 
    @fincaID = 3, 
    @codigoProducto = 'AGR-001', -- Maíz
    @nombre = 'Lote Maicero',
    @extension = 5.0, -- ha
    @tipoSuelo = 'Suelo Franco',
    @tipoRiego = 'Riego por Gravedad';
	
EXEC spAgregarLoteFinca 
    @fincaID = 3, 
    @codigoProducto = 'AGR-008', -- Café
    @nombre = 'Lote Cafetal',
    @extension = 4.0, -- ha
    @tipoSuelo = 'Suelo Arcilloso',
    @tipoRiego = 'Riego por Goteo';
 
 EXEC spAgregarLoteFinca 
    @fincaID = 4, 
    @codigoProducto = 'AGR-017', -- Piña
    @nombre = 'Lote Tropical',
    @extension = 3.5, -- ha
    @tipoSuelo = 'Suelo Arenoso',
    @tipoRiego = 'Riego por Aspersión';

EXEC spAgregarLoteFinca 
    @fincaID = 4, 
    @codigoProducto = 'AGR-004', -- Rosas
    @nombre = 'Lote Floral',
    @extension = 6.0, -- ha
    @tipoSuelo = 'Suelo Humífero',
    @tipoRiego = 'Riego por Nebulización';

EXEC spAgregarLoteFinca 
    @fincaID = 4, 
    @codigoProducto = 'AGR-039', -- Fresa
    @nombre = 'Lote Frutal',
    @extension = 3.5, -- ha
    @tipoSuelo = 'Suelo Limoso',
    @tipoRiego = 'Riego por Microaspersión';

EXEC spAgregarLoteFinca 
    @fincaID = 5, 
    @codigoProducto = 'AGR-045', -- Pasto Estrella
    @nombre = 'Lote Forrajero',
    @extension = 4.5, -- ha
    @tipoSuelo = 'Suelo Marga',
    @tipoRiego = 'Riego por Superficie';

EXEC spAgregarLoteFinca 
    @fincaID = 5, 
    @codigoProducto = 'AGR-002', -- Algodón
    @nombre = 'Lote Algodonero',
    @extension = 3.0, -- ha
    @tipoSuelo = 'Suelo Calizo',
    @tipoRiego = 'Riego por Cañón Viajero';

 -- Proveedores
 EXEC spAgregarProveedor 
    @proveedor = 'AgroSoluciones HN',
    @tipoProveedor = 'Proveedor de Agroquímicos',
    @contacto = 'Carlos Mejía',
    @direccion = 'Col. Miraflores, Tegucigalpa',
    @telefono = '99887766',
    @correo = 'contacto@agrosolhn.com',
    @rtn = '08011999123456',
    @condCredito = '30 días neto, sin intereses',
    @nombreBanco = 'BAC Honduras',
    @numCuenta = '301020304050',
    @tipoCuenta = 'cheques';

EXEC spAgregarProveedor 
    @proveedor = 'Herramientas del Campo',
    @tipoProveedor = 'Proveedor de Herramientas',
    @contacto = 'Ana Rodríguez',
    @direccion = 'Barrio El Centro, Danlí',
    @telefono = '98765432',
    @correo = 'ventas@herramientascampo.hn',
    @rtn = '08011998223344',
    @condCredito = 'Pago contra entrega',
    @nombreBanco = 'Banco Ficohsa',
    @numCuenta = '110022334455',
    @tipoCuenta = 'ahorro';

EXEC spAgregarProveedor 
    @proveedor = 'Materiales Agroindustriales',
    @tipoProveedor = 'Proveedor de Materiales Complementarios',
    @contacto = 'José Martínez',
    @direccion = 'Bo. Abajo, San Pedro Sula',
    @telefono = '91234567',
    @correo = 'info@agroindustriales.hn',
    @rtn = '08011997334455',
    @condCredito = '15 días con descuento del 5%',
    @nombreBanco = 'Banco de Occidente',
    @numCuenta = '556677889900',
    @tipoCuenta = 'cheques';

EXEC spAgregarProveedor 
    @proveedor = 'Distribuidora Agroverde',
    @tipoProveedor = 'Proveedor de Agroquímicos',
    @contacto = 'Lucía Gómez',
    @direccion = 'Col. San Ignacio, Tegucigalpa',
    @telefono = '93456789',
    @correo = 'agroverde@distribuciones.hn',
    @rtn = '08011996445566',
    @condCredito = 'Crédito a 45 días con garantía',
    @nombreBanco = 'Banco Atlántida',
    @numCuenta = '778899001122',
    @tipoCuenta = 'ahorro';

EXEC spAgregarProveedor 
    @proveedor = 'TecnoHerramientas HN',
    @tipoProveedor = 'Proveedor de Herramientas',
    @contacto = 'Mario López',
    @direccion = 'Bo. El Carmen, La Ceiba',
    @telefono = '94567890',
    @correo = 'soporte@tecnoherramientas.hn',
    @rtn = '08011995556677',
    @condCredito = 'Pago anticipado con bonificación del 3%',
    @nombreBanco = 'Banpaís',
    @numCuenta = '889900112233',
    @tipoCuenta = 'cheques';

SELECT * FROM ProveedorInsumos
SELECT * FROM Agricultor

-- Registrar cosecha
DECLARE @detalle1 DetalleCosecha;

INSERT INTO @detalle1 (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES 
('AGR-001', 'Maíz', 850.0, 'Quintales', 250.00),
('AGR-002', 'Algodón', 600.0, 'Quintales', 270.00),
('AGR-003', 'Alfalfa', 500.0, 'Quintales', 180.00);

EXEC spRegistrarCosecha 
    @agricultorID = 2, 
    @finca = 'Finca Bellavista', 
    @bodega = 'Bodega 1', 
    @fecha = '2025-08-04', 
    @tdetalle = @detalle1;

DECLARE @detalle2 DetalleCosecha;

INSERT INTO @detalle2 (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES 
('AGR-003', 'Alfalfa', 1200.0, 'Quintales', 180.00),
('AGR-001', 'Maíz', 400.0, 'Quintales', 250.00);

EXEC spRegistrarCosecha 
    @agricultorID = 2, 
    @finca = 'Finca Monteverde', 
    @bodega = 'Bodega INFOP', 
    @fecha = '2025-08-04', 
    @tdetalle = @detalle2;

DECLARE @detalle3 DetalleCosecha;

INSERT INTO @detalle3 (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES 
('AGR-004', 'Rosas', 700.0, 'Quintales', 520.00),
('AGR-001', 'Maíz', 300.0, 'Quintales', 250.00),
('AGR-008', 'Café', 500.0, 'Quintales', 400.00);

EXEC spRegistrarCosecha 
    @agricultorID = 1, 
    @finca = 'Finca El Paraíso', 
    @bodega = 'Bodega INFOP', 
    @fecha = '2025-08-04', 
    @tdetalle = @detalle3;

DECLARE @detalle4 DetalleCosecha;

INSERT INTO @detalle4 (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES 
('AGR-017', 'Piña', 900.0, 'Quintales', 180.00),
('AGR-004', 'Rosas', 650.0, 'Quintales', 520.00),
('AGR-039', 'Fresa', 800.0, 'Quintales', 300.00);

EXEC spRegistrarCosecha 
    @agricultorID = 2, 
    @finca = 'Finca Miravalles', 
    @bodega = 'Bodega 1', 
    @fecha = '2025-08-04', 
    @tdetalle = @detalle4;

DECLARE @detalle5 DetalleCosecha;

INSERT INTO @detalle5 (Codigo, Producto, Cantidad, Unidad, Precio)
VALUES 
('AGR-045', 'Pasto Estrella', 1500.0, 'Quintales', 90.00);

EXEC spRegistrarCosecha 
    @agricultorID = 3, 
    @finca = 'Finca La Esperanza', 
    @bodega = 'Bodega INFOP', 
    @fecha = '2025-08-04', 
    @tdetalle = @detalle5;

SELECT DISTINCT PA.Codigo FROM ProductosAgricolas PA INNER JOIN Lotes L ON PA.ProductoID = L.ProductoID 
INNER JOIN Fincas F ON L.FincaID = F.FincaID WHERE F.AgricultorID = 2;

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