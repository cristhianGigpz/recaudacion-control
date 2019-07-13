/*
*
@ CONTRIBULLENTES
*
*/
select * from departamento;
ALTER TABLE departamento ADD COLUMN flat INT DEFAULT '1'
INSERT INTO departamento(nombre_departamento) VALUES('ica')
drop table departamento;
create table departamento(
idDepartamento SERIAL  primary key,
nombre_departamento varchar(50)
)

select * from provincia;
drop table provincia;
create table provincia(
 idprovincia SERIAL  primary key,
 nombre_provincia varchar(50),
 iddepartamento int,
 flat int default '1'
);

drop table distrito;
ALTER TABLE distrito ADD COLUMN flat INT DEFAULT '1'
create table distrito(
idDistrito SERIAL  primary key,
codigo char(15),
nomDistrito varchar(100),
abreviatura char(10)
);

drop table urbanisacion;
ALTER TABLE urbanisacion ADD COLUMN flat INT DEFAULT '1'
create table urbanisacion(
idUrb SERIAL  primary key,
codigo int,
nomUrbanisacion varchar(100),
abreviatura varchar(100),
idDistrito int
);


ALTER TABLE contribuyente ADD COLUMN flat INT DEFAULT '1'
CREATE TYPE _tipoDocu AS ENUM('DNI','PASAPORTE','CARNET');
CREATE TYPE _tipo_persona AS ENUM('JURIDICA','NATURAL');
select * from contribuyente;
create table contribuyente(
idcontribuyente SERIAL  primary key,
nombre_razon_social varchar(100),
tipo_doc _tipoDocu,
numero_doc int,
idUrb int,
direccion varchar(100),
numero int,
dpto char(10),
manzana char(5),
lote char(5),
telefono char(10),
tipo_persona _tipo_persona,
motivo varchar(100),
diflmpuesto char(10),
observacion varchar(100),
total_anexo int,
estado int,
impuesto_anula decimal(10,8),
valor_total_exonerado decimal(10,8),
valor_total_predio decimal(10,8),
base_imponible_a decimal(10,8)
);

drop table declaracionJurada;
create table declaracionJurada(
idDeclaracion SERIAL  primary key,
fecha timestamp,
idContribuyente int
);

CREATE TYPE _motivoDeclaracion AS ENUM('inscripcion','aumento valor','disminucion valor','compra','venta','masiva','otros');
drop table declaracionJuradaDetalle;
create table declaracionJuradaDetalle(
idDetDeclaracion SERIAL  primary key,
idDeclaracion int,
motivoDeclaracion _motivoDeclaracion
);

/*
*
@ FISCALIZACION
*
*/
drop table acta;
create table acta(
idActa SERIAL  primary key,
observacion varchar(100),
idUsuario int,
idContribuyente int
);

drop table detalleActa;
create table detalleActa(
idDetalleActa SERIAL  primary key,
idClasificacion int,
idActa int,
anexo int,
nivel int,
idPeriodo int,
clase char(10),
material char(10),
estado int,
areaConstruida char(10),
areaComun char(10),
areaTerreno char(10),
descripcion varchar(100)
);

CREATE TYPE _tipo AS ENUM('cierta','presunta');
drop table determinacion;
create table determinacion(
codigoDeterminacion SERIAL  primary key,
idContribuyente int,
idActa int,
subtotales decimal(10,8),
tipo _tipo,
derechoEmision timestamp,
motivo varchar(100)
);

drop table determinacionDetalle;
create table determinacionDetalle(
idDetdetalle SERIAL  primary key,
codigoDeterminacion int,
idPredio int,
idPeriodo int,
declarado varchar(100),
fiscalizado varchar(100),
trimestre varchar(100),
diferencia_imp_fiscal int,
interesDiario decimal(18,8),
subtotal_por_anio decimal(18,8)
);

drop table multaTributaria;
create table multaTributaria(
codigoMultaTributaria SERIAL  primary key,
idContribuyente int,
idPeriodo int,
subTotal decimal(10,8),
referencia char(10)
);

drop table multaTributariaDetalle;
create table multaTributariaDetalle(
idDetMultaTributaria SERIAL  primary key,
idPredio int,
codigo_multa_tributaria int,
multaInsoluta decimal(10,8),
interesDiario decimal(10,8),
sub_total_por_anio decimal(10,8)
);
/*
*
@ PREDIO
*
*/
drop table calidad;
create table calidad(
idCalidad SERIAL  primary key,
descripcion char(10)
);

drop table carTerrenoArancel;
create table carTerrenoArancel(
idCatTerrenoArancel  SERIAL  primary key,
nom_categoria varchar(100),
des_categoria text
);

drop table categoriaCalidad;
create table categoriaCalidad(
idCatcalidad SERIAL  primary key,
idCalidad int,
idCatTerrenoArancel int,
monto decimal (10,8),
idPeriodo int
);

CREATE TYPE _tipo_predio AS ENUM('rustico','urbano');
CREATE TYPE tipo_terreno AS ENUM('hacienda','fundo');
CREATE TYPE _condicion_propiedad AS ENUM('propietario unico','sucecion indivisa','poseedor','tenedor','sociedad conyugar','condominio','otros');
drop table predios;
create table predios(
idPredio SERIAL  primary key,
idUrb int,
tipo_predio _tipo_predio,
anexo int,
fecha_reg timestamp,
condicion_propiedad _condicion_propiedad,
porcentaje_ondominio char(5),
detalle text,
observacion text,
tipo_terreno _tipo_terreno,
uso_terreno varchar(100),
nombre_predio varchar(100),
numero int,
departamento int,
manzana char(5),
lote char(5),
pexonerado char(10),
num_resolucion int,
fecha_resolucion timestamp,
estacho int,
idLimites int,
idCategoiat int,
area_terreno char(10),
fecha_adquisicion timestamp,
total_area_construida char(10),
valor_total_construccion char(10),
valor_terreno decimal(10,8),
valor_auto_exonerado char(5),
valor_efecto char(5),
valor_porcentaje_condominio char(5),
otras_instalaciones varchar(100)
);


drop table contribuyentePredio;
create table contribuyentePredio(
idContribuyentePredio SERIAL  primary key,
idPredio int,
idContribuyente int,
porcentaje_predio char(10)
);

drop table caracteristicasPredio;
create table caracteristicasPredio(
idCatracteristica SERIAL  primary key,
estado varchar(50),
tipo varchar(100),
uso varchar(100),
idPredio int
);

drop table niveles;
create table niveles(
idNivel SERIAL  primary key,
orden int,
nivel char(5),
anio_inspecion timestamp,
valor_unitario decimal(10,8),
porcentaje_depreciacion char(10),
depreciacion decimal(10,8),
valor_unitario_depreciacion decimal(10,8),
area_construida char(10),
valor_area_construida decimal(10,8),
valor_area_comun decimal(10,8),
incremento int,
valor_construccion decimal(10,8),
observacion text,
idPredio int
);

drop table datosConstruccion;
create table datosConstruccion(
idConstruccion SERIAL  primary key,
descripcion varchar(100),
tipo varchar(100),
estado char(10),
idNivel int
);

drop table regionValores;
create table regionValores(
idRegValores SERIAL  primary key,
valor varchar(100)
);

drop table valoresUnitarios;
create table valoresUnitarios(
idValUnitario SERIAL  primary key,
nomValor varchar(100)
);

drop table clasificacion;
create table clasificacion(
idClasificacion SERIAL  primary key,
valor char(5)
);
drop table clasesValores;
create table clasesValores(
idClasValores SERIAL  primary key,
descripcion varchar(100),
monto decimal(18,8),
idClasificacion int,
idValUnitario int,
idPeriodo int,
idNivel int,
idRegValores int
);

drop table arancelUrbano;
create table arancelUrbano(
idArancel SERIAL  primary key,
zona varchar(100),
idDistrito int,
idPeriodo int
);

/*
*
@ DEPRECIACON
*
*/
/* (depreciacion)*/
drop table institucion;
create table institucion(
idInstitucion SERIAL  primary key,
descripcion varchar(100)
);

drop table antiguedad;
create table antiguedad(
idAntiguedad SERIAL  primary key,
descripcion varchar(100),
idInstitucion int
);

drop table valoresAntiguedad;
create table valoresAntiguedad(
idValoresAntiguedad SERIAL  primary key,
muy_bueno char(10),
bueno char(10),
malo char(10),
idAntiguedad int
);

/*
*
@ PERFIL USUARIO
*
*/
drop table perfilUsuario;
create table perfilUsuario(
IdTipoUsuario SERIAL  primary key,
descripcion varchar(100)
);
drop table modulo;
create table modulo(
idModulo SERIAL  primary key,
descripcion varchar(100),
estado int,
IdTipoUsuario int
);

drop table usuario;
create table usuario(
idUsuario SERIAL  primary key,
login varchar(100),
password varchar(100),
fecha_registro timestamp,
IdMunicipalidad int,
IdTipoUsuario int,
estado int,
nombre_completo varchar(100)
);

/*
*
@ CAJA
*
*/

drop table caja;
create table caja(
idCaja SERIAL  primary key,
hora_apertura char(10),
hora_cierre char(10),
fecha timestamp,
monto_apertura decimal(10,8),
monto_cierre decimal(10,8),
idUsuario int
);

drop table recibo;
create table recibo(
idRecibo SERIAL  primary key,
numero int,
serie char(20),
idPeriodo int,
fecha_recibo timestamp,
total decimal(10,8)
);

drop table movimiento;
create table movimiento(
idMovimiento SERIAL  primary key,
fecha timestamp,
tipo_pago char(20),
importe decimal(10,8),
idCaja int,
idRecibo int
);

drop table detalleRecibo;
create table detalleRecibo(
idDetalleR SERIAL  primary key,
operacion char(20),
detalleOperacion varchar(100),
emisonR decimal(10,8),
moras decimal(10,8),
sub_total decimal(10,8),
idRecibo int
);

drop table tributo;
create table tributo(
idTributo SERIAL  primary key,
concepto varchar(100),
monto decimal(10,8),
idPeriodo int
);

drop table partidaPresupuestal;
create table partidaPresupuestal(
idPartida SERIAL  primary key,
codigo_presupuestal char(10),
concepto varchar(100),
importe_tupa decimal(10,8),
idPeriodo int
);

/*
*
@ ALCABALA
*
*/
CREATE TYPE _segun AS ENUM('contrato de compra venta','');
drop table alcabala;
create table alcabala(
idAlcabala SERIAL  primary key,
fecha_transferencia timestamp,
segegun _segun,
ingresar_ipm char(10),
fecha_emision timestamp,
area char(15),
emision_valor decimal(10,8),
idPredio int,
estado int,
idContribuyente int,
valor_compra decimal(10,8),
valor_autovaluo decimal(10,8),
total_apagar decimal(10,8)
);

drop table alcabalaDetalle;
create table alcabalaDetalle(
idDetalle SERIAL  primary key,
base_imponible_compra_autovaluo decimal(10,8),
ipm char(10),
uit decimal(10,8),
base_imponible decimal(10,8),
tasa decimal(10,8),
interes_acumulado decimal(10,8),
incremento decimal(10,8),
interes_diario decimal(10,8),
sub_total decimal(10,8)
);

drop table ordenPago;
create table ordenPago(
idPago SERIAL  primary key,
idContribuyente int,
fecha_emitida timestamp,
total_pagar decimal(10,8),
emision_derecho decimal(10,8),
estado int
);

drop table ordeDetalle;
create table ordeDetalle(
idPagoDetalle SERIAL  primary key,
periodo_adeudado char(20),
base_imponible decimal(10,8),
deuda_insoluta decimal(10,8),
interes_diario decimal(10,8),
sub_total_por_periodo decimal(10,8),
idPeriodo int,
idPago int
);

drop table cuentaCorriente;
create table cuentaCorriente(
idCuentaCorriente SERIAL  primary key,
importe_total decimal(10,8),
anexo int,
estado_cuenta char(10),
idContribuyente int,
idPeriodo int
);

drop table detalle;
create table detalle(
idDetalle SERIAL  primary key,
idCuenta int,
concepto varchar(100),
generado  int,
monto decimal(10,8),
saldo decimal(10,8),
ncuota int
);

/*
*
@ COACTIVO
*
*/

drop table auxiliarCoactivo;
create table auxiliarCoactivo(
idAuxiciliarCoactivo SERIAL  primary key,
auxiliar varchar(100),
siglas char(5)
);

drop table ejecutorCoactivo;
create table ejecutorCoactivo(
idEjecutarCoactivo SERIAL  primary key,
ejecutor varchar(100),
siglas char(10)
);

drop table documentoCoactivo;
create table documentoCoactivo(
idDocumentoCoactivo  SERIAL  primary key,
expediente  varchar(50),
cuaderno char(20),
fecha timestamp,
idAuxiciliarCoactivo int,
idEjecutarCoactivo int,
nomDocumento varchar(100),
concepto varchar(100),
tipoDoc varchar(100),
detalleDocumento varchar(100)
);

drop table costasGastosProcesales;
create table costasGastosProcesales(
idCostas SERIAL  primary key,
num_inicial int,
idContribuyente int,
expediente_coactivo char(20),
fecha timestamp
);

drop table motivoGastos;
create table motivoGastos(
idMotivo SERIAL  primary key,
descripcion text,
valor_unitario decimal(10,8)
);

drop table costasGastoProcesalesDetalle;
create table costasGastoProcesalesDetalle(
idDetalle SERIAL  primary key,
idCostas int,
idMotivo int,
cantidad decimal(10,8)
);

/*
*
@ MUNICIPALIDAD
*
*/
drop table municipalidad;
create table municipalidad(
idMunicipalidad SERIAL  primary key,
nom_municipalidad varchar(100),
idPeriodo int,
ruc int,
representante varchar(100),
siglas char(10),
tipo_municipio varchar(50),
telefono char(10)
);

/*
*
@ CATASTRO
*
*/
drop table catastro;
create table catastro(
idCatrasto SERIAL  primary key,
unid_catastral int,
idContribuyente int,
idDepartamento int,
codigo_predio int
);

/*
*
@ VALORES
*
*/
drop table valores;
create table valores(
IdValor SERIAL  primary key,
ipm int,
uit decimal(10,8),
tasa decimal(10,8),
interes_diario decimal(10,8),
gasto_admin decimal(10,8),
emison_op int,
emision_derecho char(5),
cantidad_uit int,
idPeriodo int,
emisonR decimal(10,8),
moras decimal(10,8)
);