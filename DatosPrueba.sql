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

--SELECT DISTINCT PA.Codigo FROM ProductosAgricolas PA INNER JOIN Lotes L ON PA.ProductoID = L.ProductoID 
--INNER JOIN Fincas F ON L.FincaID = F.FincaID WHERE F.AgricultorID = 2;

--SELECT * FROM ProductosAgricolas
--SELECT * FROM CosechaAgricultor
--SELECT * FROM CosechaDetalleAgricultor 

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

-----------------------------------------------------------------

SELECT * FROM ProveedorInsumos

DECLARE @detalle1 DetalleInsumo;

INSERT INTO @detalle1 (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES 
('INS-001', 'Pesticida Orgánico', 50, 'galones', 18.75, 0.05),  -- Precio negociado por volumen
('INS-002', 'Herbicida Selectivo', 40, 'galones', 22.50, 0.03),
('INS-003', 'Fertilizante Nitrogenado', 60, 'galones', 19.90, 0.04);

EXEC spRegistrarOrdenInsumos 
  @proveedorID = 2,
  @fechaCompra = '2025-08-04',
  @fechaVencimiento = '2025-09-04',
  @tDetalle = @detalle1;

DECLARE @detalle2 DetalleInsumo;

INSERT INTO @detalle2 (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES 
('INS-007', 'Azada de Mano', 20, 'unidad', 145.00, 0.00),
('INS-008', 'Machete Agrícola', 15, 'unidad', 110.00, 0.00),
('INS-016', 'Pala de madera', 25, 'Unidad', 95.00, 0.00);

EXEC spRegistrarOrdenInsumos 
  @proveedorID = 3,
  @fechaCompra = '2025-08-04',
  @fechaVencimiento = '2025-09-04',
  @tDetalle = @detalle2;

DECLARE @detalle3 DetalleInsumo;

INSERT INTO @detalle3 (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES 
('INS-004', 'Bioinsecticida Líquido', 30, 'quintales', 520.00, 0.02),
('INS-005', 'Abono Orgánico Granulado', 40, 'quintales', 480.00, 0.03),
('INS-006', 'Compost Activado', 35, 'quintales', 450.00, 0.01);

EXEC spRegistrarOrdenInsumos 
  @proveedorID = 4,
  @fechaCompra = '2025-08-04',
  @fechaVencimiento = '2025-09-04',
  @tDetalle = @detalle3;

DECLARE @detalle4 DetalleInsumo;

INSERT INTO @detalle4 (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES 
('INS-009', 'Carretilla de Acero', 10, 'unidad', 875.00, 0.00),
('INS-010', 'Sensor de Humedad', 5, 'unidad', 1250.00, 0.00),
('INS-012', 'Controlador de Riego', 3, 'unidad', 3400.00, 0.00);

EXEC spRegistrarOrdenInsumos 
  @proveedorID = 5,
  @fechaCompra = '2025-08-04',
  @fechaVencimiento = '2025-09-04',
  @tDetalle = @detalle4;

--SELECT * FROM CompraInsumos

EXEC dbo.spRegistrarIngresoInsumos 1;
EXEC dbo.spRegistrarIngresoInsumos 2;
GO
--SELECT * FROM CompraInsumos
--SELECT * FROM CompraDetalleInsumos
--SELECT * FROM InsumosAgricolas

------------------------------------------------------------------------------------------

DECLARE @detalleEntrega DetalleInsumo;

INSERT INTO @detalleEntrega (Codigo, Insumo, Cantidad, Unidad, Precio, Descuento)
VALUES 
('INS-003', 'Fertilizante Nitrogenado', 25, 'galones', 19.90, 0.00),  
('INS-001', 'Pesticida Orgánico', 15, 'galones', 18.75, 0.00),       
('INS-007', 'Azada de Mano', 5, 'unidad', 145.00, 0.00)              

EXEC spRegistrarInsumosAgricultor
  @agricultorID = 2,  -- Jose Antonio Reyes
  @fecha = '2025-08-04',
  @tDetalle = @detalleEntrega;

--SELECT * FROM AgricultorInsumos

--SELECT * FROM Agricultor
--------------------------------------------------------------------------------

--SELECT * FROM CompraDetalleInsumos

EXEC spRegistrarPagoProveedor 
    @proveedorID = 2,
    @compraInsumoID = 1,
    @fecha = '2025-08-04',
    @metodoPago = 'Deposito',
    @monto = 2909.86;

	
--SELECT * FROM PagoProveedores
DECLARE @agricultorID INT = 2;
DECLARE @cosechaID INT = 1;
DECLARE @fecha DATETIME = GETDATE();
DECLARE @metodoPago VARCHAR(20) = 'Deposito';

-- Obtener saldo sin insumos
DECLARE @saldoTotal FLOAT = dbo.fLiquidacionPendienteAgricultorPorCosecha(@cosechaID, @agricultorID);
DECLARE @tInsumos InsumosDeducidos;

SELECT @saldoTotal

INSERT INTO @tInsumos (AgricultorInsumoID)
SELECT AgricultorInsumoID FROM dbo.ftInsumosPendientesAgricultor(@agricultorID, @saldoTotal);

DECLARE @deduccionInsumos FLOAT = dbo.fDeduccionInsumosAgricultor(@tInsumos);

--DECLARE @saldoSinInsumos FLOAT = @saldoTotal + @deduccionInsumos;

-- Calcular abono del 50%
DECLARE @montoAbono FLOAT = ROUND(@saldoTotal * 0.50, 2);

--SELECT @saldoTotal
--SELECT @montoAbono

---- Ejecutar abono
EXEC spRegistrarAbonoAgricultor
     @agricultorID = @agricultorID,
     @cosechaID = @cosechaID,
     @fecha = @fecha,
     @metodoPago = @metodoPago,
     @monto = @montoAbono;

--SELECT * FROM CosechaAgricultor WHERE CosechaID = 1
--SELECT * FROM PagoAgricultores

-- Recalcular saldo total y deducción de insumos
SELECT @saldoTotal = dbo.fLiquidacionPendienteAgricultorPorCosecha(@cosechaID, @agricultorID);
SELECT @deduccionInsumos = dbo.fDeduccionInsumosAgricultor(@tInsumos);

-- Monto final para liquidar
DECLARE @montoLiquidacion FLOAT = ROUND(@saldoTotal - @deduccionInsumos, 2);

-- Ejecutar procedimiento
EXEC spRegistrarLiquidacionAgricultor
     @agricultorID = @agricultorID,
     @cosechaID = @cosechaID,
     @fecha = @fecha,
     @metodoPago = @metodoPago,
     @monto = @montoLiquidacion;

SELECT * FROM AgricultorInsumos

--------------------------------------------------------------------------------------------------------------------------------------------------

--EXEC spAgregarAgricultor 
--  @nombre = 'Calixto Zúniga', 
--  @dni = '0101-1999-12345', 
--  @telefono = '9987-9823', 
--  @direccion = 'Col. Bella Vista, SPS', 
--  @email = 'calixto.zuniga@gmail.com', 
--  @nombreBanco = 'Banco Atlantida', 
--  @tipoCuenta = 'ahorro', 
--  @numCuenta = 'ATL-001-998877';

--EXEC spAgregarAgricultor 
--  @nombre = 'Yadira Montoya', 
--  @dni = '0502-1998-23456', 
--  @telefono = '9876-5432', 
--  @direccion = 'Bo. El Centro, La Ceiba', 
--  @email = 'yadira.montoya@yahoo.com', 
--  @nombreBanco = 'Banco Ficohsa', 
--  @tipoCuenta = 'cheques', 
--  @numCuenta = 'FIC-002-112233';

--EXEC spAgregarAgricultor 
--  @nombre = 'Efraín “Chino” Duarte', 
--  @dni = '0303-1997-34567', 
--  @telefono = '9123-4567', 
--  @direccion = 'Col. Miraflores, Tegucigalpa', 
--  @email = 'efrain.duarte@outlook.com', 
--  @nombreBanco = 'BAC Honduras', 
--  @tipoCuenta = 'ahorro', 
--  @numCuenta = 'BAC-003-445566';

--EXEC spAgregarAgricultor 
--  @nombre = 'Nayeli del Carmen', 
--  @dni = '0704-1996-45678', 
--  @telefono = '9456-7890', 
--  @direccion = 'Bo. Abajo, Danlí', 
--  @email = 'nayeli.carmen@gmail.com', 
--  @nombreBanco = 'Banco de Occidente', 
--  @tipoCuenta = 'cheques', 
--  @numCuenta = 'OCC-004-778899';

--EXEC spAgregarAgricultor 
--  @nombre = 'Rigoberto “Rigo” Zelaya', 
--  @dni = '0205-1995-56789', 
--  @telefono = '9345-6789', 
--  @direccion = 'Bo. El Carmen, Choluteca', 
--  @email = 'rigo.zelaya@hnmail.com', 
--  @nombreBanco = 'Banpaís', 
--  @tipoCuenta = 'ahorro', 
--  @numCuenta = 'BAN-005-991122';

--EXEC spAgregarAgricultor 
--  @nombre = 'Dulce María Pineda', 
--  @dni = '0106-1994-47890', 
--  @telefono = '9234-5678', 
--  @direccion = 'Col. Satélite, SPS', 
--  @email = 'dulce.pineda@gmail.com', 
--  @nombreBanco = 'Banco Azteca', 
--  @tipoCuenta = 'cheques', 
--  @numCuenta = 'AZT-006-334455';

--EXEC spAgregarAgricultor 
--  @nombre = 'Leandro Castellón', 
--  @dni = '0807-1993-38901', 
--  @telefono = '9789-0123', 
--  @direccion = 'Bo. El Calvario, Yoro', 
--  @email = 'leandro.castellon@correo.hn', 
--  @nombreBanco = 'Banco Cuscatlan', 
--  @tipoCuenta = 'ahorro', 
--  @numCuenta = 'CUS-007-556677';

--EXEC spAgregarAgricultor 
--  @nombre = 'Zulema Reyes', 
--  @dni = '0608-1992-29012', 
--  @telefono = '9654-3210', 
--  @direccion = 'Col. Kennedy, Tegucigalpa', 
--  @email = 'zulema.reyes@hnmail.com', 
--  @nombreBanco = 'Banco Ficohsa', 
--  @tipoCuenta = 'ahorro', 
--  @numCuenta = 'FIC-008-778899';

SELECT * FROM Agricultor

SELECT * FROM Cliente

EXEC spAgregarCliente 
  @nombre = 'Calixto Zúniga', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0101-1999-12345', 
  @direccion = 'Col. Bella Vista, SPS', 
  @telefono = '9987-9823';

EXEC spAgregarCliente 
  @nombre = 'Yadira Montoya', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0502-1998-23456', 
  @direccion = 'Bo. El Centro, La Ceiba', 
  @telefono = '9876-5432';

EXEC spAgregarCliente 
  @nombre = 'Agroservicios El Trigal S.A.', 
  @tipoIdentidad = 'RTN', 
  @identidad = '08011999456789', 
  @direccion = 'Zona Industrial, TGU', 
  @telefono = '9123-4567';

EXEC spAgregarCliente 
  @nombre = 'Nayeli del Carmen', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0704-1996-45678', 
  @direccion = 'Bo. Abajo, Danlí', 
  @telefono = '9456-7890';

EXEC spAgregarCliente 
  @nombre = 'Distribuidora Zelaya y Cía.', 
  @tipoIdentidad = 'RTN', 
  @identidad = '02051995567890', 
  @direccion = 'Bo. El Carmen, Choluteca', 
  @telefono = '9345-6789';

EXEC spAgregarCliente 
  @nombre = 'Dulce María Pineda', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0106-1994-47890', 
  @direccion = 'Col. Satélite, SPS', 
  @telefono = '9234-5678';

EXEC spAgregarCliente 
  @nombre = 'Leandro Castellón', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0807-1993-38901', 
  @direccion = 'Bo. El Calvario, Yoro', 
  @telefono = '9789-0123';

EXEC spAgregarCliente 
  @nombre = 'Zulema Reyes', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0608-1992-29012', 
  @direccion = 'Col. Kennedy, Tegucigalpa', 
  @telefono = '9654-3210';

EXEC spAgregarCliente 
  @nombre = 'Servicios Agrícolas La Ceibita', 
  @tipoIdentidad = 'RTN', 
  @identidad = '05021998234567', 
  @direccion = 'Carretera a Jutiapa, Atlántida', 
  @telefono = '9111-2233';

EXEC spAgregarCliente 
  @nombre = 'Melany Fuentes', 
  @tipoIdentidad = 'DNI', 
  @identidad = '0608-1991-33445', 
  @direccion = 'Col. El Pedregal, TGU', 
  @telefono = '9654-7788';

--EXEC spAgregarCliente 'Patricio', 'DNI', '0401-2004-00584', 'En algún lugar', '9982-9141'

SELECT * FROM Cliente

SELECT * FROM ProductosAgricolas

DECLARE @detalle1 DetalleVenta, @fechaa DATETIME = GETDATE();

INSERT INTO @detalle1 (Codigo, Producto, Unidad, Cantidad, Precio, Descuento)
VALUES 
  ('AGR-001', 'Maíz', 'Quintales', 5, 337.50, 0.00),
  ('AGR-045', 'Pasto Estrella', 'Fardos', 12, 25.02, 0.00);

 
EXEC spFacturarProductos 
  @clienteID = 2, 
  @tipo = 'Contado', 
  @fecha = @fechaa, 
  @tDetalle = @detalle1;

DECLARE @detalle2 DetalleVenta;

INSERT INTO @detalle2 (Codigo, Producto, Unidad, Cantidad, Precio, Descuento)
VALUES 
  ('AGR-017', 'Piña', 'Arrobas', 20, 61.65, 0.05),
  ('AGR-039', 'Fresa', 'Quintales', 3, 405.00, 0.00);

--EXEC spBuscarProductoVenta 'AGR-039', 'Quintales'

EXEC spFacturarProductos 
  @clienteID = 5, 
  @tipo = 'Contado', 
  @fecha = @fechaa, 
  @tDetalle = @detalle2;

SELECT * FROM Factura
SELECT * FROM FacturaDetalle
--SELECT * FROM PagoAgricultores

--SELECT * FROM AgricultorInsumos