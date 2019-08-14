--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

-- Started on 2019-08-09 23:53:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 610 (class 1247 OID 25111)
-- Name: _condicion_propiedad; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._condicion_propiedad AS ENUM (
    'propietario unico',
    'sucecion indivisa',
    'poseedor',
    'tenedor',
    'sociedad conyugar',
    'condominio',
    'otros'
);


ALTER TYPE public._condicion_propiedad OWNER TO postgres;

--
-- TOC entry 613 (class 1247 OID 25126)
-- Name: _motivodeclaracion; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._motivodeclaracion AS ENUM (
    'inscripcion',
    'aumento valor',
    'disminucion valor',
    'compra',
    'venta',
    'masiva',
    'otros'
);


ALTER TYPE public._motivodeclaracion OWNER TO postgres;

--
-- TOC entry 695 (class 1247 OID 25142)
-- Name: _segun; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._segun AS ENUM (
    'contrato de compra venta',
    ''
);


ALTER TYPE public._segun OWNER TO postgres;

--
-- TOC entry 698 (class 1247 OID 25148)
-- Name: _tipo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._tipo AS ENUM (
    'cierta',
    'presunta'
);


ALTER TYPE public._tipo OWNER TO postgres;

--
-- TOC entry 701 (class 1247 OID 25154)
-- Name: _tipo_persona; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._tipo_persona AS ENUM (
    'JURIDICA',
    'NATURAL'
);


ALTER TYPE public._tipo_persona OWNER TO postgres;

--
-- TOC entry 704 (class 1247 OID 25160)
-- Name: _tipo_predio; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._tipo_predio AS ENUM (
    'rustico',
    'urbano'
);


ALTER TYPE public._tipo_predio OWNER TO postgres;

--
-- TOC entry 707 (class 1247 OID 25166)
-- Name: _tipodocu; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public._tipodocu AS ENUM (
    'DNI',
    'PASAPORTE',
    'CARNET'
);


ALTER TYPE public._tipodocu OWNER TO postgres;

--
-- TOC entry 710 (class 1247 OID 25174)
-- Name: tipo_terreno; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_terreno AS ENUM (
    'hacienda',
    'fundo'
);


ALTER TYPE public.tipo_terreno OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 25179)
-- Name: acta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acta (
    idacta integer NOT NULL,
    observacion character varying(100),
    idusuario integer,
    idcontribuyente integer
);


ALTER TABLE public.acta OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 25182)
-- Name: acta_idacta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acta_idacta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acta_idacta_seq OWNER TO postgres;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 197
-- Name: acta_idacta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acta_idacta_seq OWNED BY public.acta.idacta;


--
-- TOC entry 198 (class 1259 OID 25184)
-- Name: alcabala; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alcabala (
    idalcabala integer NOT NULL,
    fecha_transferencia timestamp without time zone,
    segun public._segun,
    ingresar_ipm character(10),
    fecha_emision timestamp without time zone,
    area character(15),
    emision_valor numeric(10,2),
    idpredio integer,
    estado integer,
    idcontribuyente integer,
    valor_compra numeric(10,2),
    valor_autovaluo numeric(10,2),
    total_apagar numeric(10,2)
);


ALTER TABLE public.alcabala OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 25187)
-- Name: alcabala_idalcabala_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alcabala_idalcabala_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alcabala_idalcabala_seq OWNER TO postgres;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 199
-- Name: alcabala_idalcabala_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alcabala_idalcabala_seq OWNED BY public.alcabala.idalcabala;


--
-- TOC entry 200 (class 1259 OID 25189)
-- Name: alcabaladetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alcabaladetalle (
    iddetalle integer NOT NULL,
    base_imponible_compra_autovaluo numeric(10,2),
    ipm character(10),
    uit numeric(10,2),
    base_imponible numeric(10,2),
    tasa numeric(10,2),
    interes_acumulado numeric(10,2),
    incremento numeric(10,2),
    interes_diario numeric(10,2),
    sub_total numeric(10,2),
    idalcabala integer
);


ALTER TABLE public.alcabaladetalle OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 25192)
-- Name: alcabaladetalle_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alcabaladetalle_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alcabaladetalle_iddetalle_seq OWNER TO postgres;

--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 201
-- Name: alcabaladetalle_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alcabaladetalle_iddetalle_seq OWNED BY public.alcabaladetalle.iddetalle;


--
-- TOC entry 202 (class 1259 OID 25194)
-- Name: antiguedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antiguedad (
    idantiguedad integer NOT NULL,
    descripcion character varying(100),
    idinstitucion integer
);


ALTER TABLE public.antiguedad OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25197)
-- Name: antiguedad_idantiguedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antiguedad_idantiguedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antiguedad_idantiguedad_seq OWNER TO postgres;

--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 203
-- Name: antiguedad_idantiguedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antiguedad_idantiguedad_seq OWNED BY public.antiguedad.idantiguedad;


--
-- TOC entry 204 (class 1259 OID 25199)
-- Name: arancelurbano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arancelurbano (
    idarancel integer NOT NULL,
    zona character varying(100),
    iddistrito integer,
    idperiodo integer,
    arancel integer
);


ALTER TABLE public.arancelurbano OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 25202)
-- Name: arancelurbano_idarancel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arancelurbano_idarancel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arancelurbano_idarancel_seq OWNER TO postgres;

--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 205
-- Name: arancelurbano_idarancel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arancelurbano_idarancel_seq OWNED BY public.arancelurbano.idarancel;


--
-- TOC entry 206 (class 1259 OID 25204)
-- Name: auxiliarcoactivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auxiliarcoactivo (
    idauxiciliarcoactivo integer NOT NULL,
    auxiliar character varying(100),
    siglas character(5)
);


ALTER TABLE public.auxiliarcoactivo OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 25207)
-- Name: auxiliarcoactivo_idauxiciliarcoactivo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auxiliarcoactivo_idauxiciliarcoactivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auxiliarcoactivo_idauxiciliarcoactivo_seq OWNER TO postgres;

--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 207
-- Name: auxiliarcoactivo_idauxiciliarcoactivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auxiliarcoactivo_idauxiciliarcoactivo_seq OWNED BY public.auxiliarcoactivo.idauxiciliarcoactivo;


--
-- TOC entry 208 (class 1259 OID 25209)
-- Name: caja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caja (
    idcaja integer NOT NULL,
    hora_apertura character(10),
    hora_cierre character(10),
    fecha timestamp without time zone,
    monto_apertura numeric(10,2),
    monto_cierre numeric(10,2),
    idusuario integer
);


ALTER TABLE public.caja OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25212)
-- Name: caja_idcaja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.caja_idcaja_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.caja_idcaja_seq OWNER TO postgres;

--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 209
-- Name: caja_idcaja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.caja_idcaja_seq OWNED BY public.caja.idcaja;


--
-- TOC entry 210 (class 1259 OID 25214)
-- Name: calidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calidad (
    idcalidad integer NOT NULL,
    descripcion character(10)
);


ALTER TABLE public.calidad OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 25217)
-- Name: calidad_idcalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calidad_idcalidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calidad_idcalidad_seq OWNER TO postgres;

--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 211
-- Name: calidad_idcalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calidad_idcalidad_seq OWNED BY public.calidad.idcalidad;


--
-- TOC entry 212 (class 1259 OID 25219)
-- Name: caracteristicaspredio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caracteristicaspredio (
    idcatracteristica integer NOT NULL,
    estado character varying(50),
    tipo character varying(100),
    uso character varying(100),
    idpredio integer
);


ALTER TABLE public.caracteristicaspredio OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 25222)
-- Name: caracteristicaspredio_idcatracteristica_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.caracteristicaspredio_idcatracteristica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.caracteristicaspredio_idcatracteristica_seq OWNER TO postgres;

--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 213
-- Name: caracteristicaspredio_idcatracteristica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.caracteristicaspredio_idcatracteristica_seq OWNED BY public.caracteristicaspredio.idcatracteristica;


--
-- TOC entry 214 (class 1259 OID 25224)
-- Name: catterrenoarancel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catterrenoarancel (
    idcatterrenoarancel integer NOT NULL,
    nom_categoria character varying(100),
    des_categoria text,
    arancel integer
);


ALTER TABLE public.catterrenoarancel OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25230)
-- Name: carterrenoarancel_idcatterrenoarancel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carterrenoarancel_idcatterrenoarancel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carterrenoarancel_idcatterrenoarancel_seq OWNER TO postgres;

--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 215
-- Name: carterrenoarancel_idcatterrenoarancel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carterrenoarancel_idcatterrenoarancel_seq OWNED BY public.catterrenoarancel.idcatterrenoarancel;


--
-- TOC entry 216 (class 1259 OID 25232)
-- Name: catastro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catastro (
    idcatrasto integer NOT NULL,
    unid_catastral integer,
    idcontribuyente integer,
    iddepartamento integer,
    codigo_predio integer
);


ALTER TABLE public.catastro OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25235)
-- Name: catastro_idcatrasto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catastro_idcatrasto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catastro_idcatrasto_seq OWNER TO postgres;

--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 217
-- Name: catastro_idcatrasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catastro_idcatrasto_seq OWNED BY public.catastro.idcatrasto;


--
-- TOC entry 218 (class 1259 OID 25237)
-- Name: categoriacalidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriacalidad (
    idcatcalidad integer NOT NULL,
    idcalidad integer,
    idcatterrenoarancel integer,
    monto numeric(10,2),
    idperiodo integer
);


ALTER TABLE public.categoriacalidad OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25240)
-- Name: categoriacalidad_idcatcalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoriacalidad_idcatcalidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoriacalidad_idcatcalidad_seq OWNER TO postgres;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 219
-- Name: categoriacalidad_idcatcalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoriacalidad_idcatcalidad_seq OWNED BY public.categoriacalidad.idcatcalidad;


--
-- TOC entry 220 (class 1259 OID 25242)
-- Name: clasesvalores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clasesvalores (
    idclasvalores integer NOT NULL,
    descripcion character varying(100),
    monto numeric(10,2),
    idclasificacion integer,
    idvalunitario integer,
    idperiodo integer,
    idnivel integer,
    idregvalores integer
);


ALTER TABLE public.clasesvalores OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25245)
-- Name: clasesvalores_idclasvalores_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clasesvalores_idclasvalores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clasesvalores_idclasvalores_seq OWNER TO postgres;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 221
-- Name: clasesvalores_idclasvalores_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clasesvalores_idclasvalores_seq OWNED BY public.clasesvalores.idclasvalores;


--
-- TOC entry 222 (class 1259 OID 25247)
-- Name: clasificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clasificacion (
    idclasificacion integer NOT NULL,
    valor character(5)
);


ALTER TABLE public.clasificacion OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25250)
-- Name: clasificacion_idclasificacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clasificacion_idclasificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clasificacion_idclasificacion_seq OWNER TO postgres;

--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 223
-- Name: clasificacion_idclasificacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clasificacion_idclasificacion_seq OWNED BY public.clasificacion.idclasificacion;


--
-- TOC entry 224 (class 1259 OID 25252)
-- Name: contribuyente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contribuyente (
    idcontribuyente integer NOT NULL,
    nombre_razon_social character varying(100),
    tipodoc public._tipodocu,
    numerodoc integer,
    idurb integer,
    direccion character varying(100),
    numero integer,
    dpto character(10),
    manzana character(5),
    lote character(5),
    telefono character(10),
    tipo_persona public._tipo_persona,
    motivo character varying(100),
    difimpuesto character(10),
    observacion character varying(100),
    totalanexo integer,
    estado integer,
    impuestoanual integer,
    valortotalexonerado integer,
    valortotalpredio integer,
    baseimponiblea integer
);


ALTER TABLE public.contribuyente OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25256)
-- Name: contribuyente_idcontribuyente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contribuyente_idcontribuyente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contribuyente_idcontribuyente_seq OWNER TO postgres;

--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 225
-- Name: contribuyente_idcontribuyente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contribuyente_idcontribuyente_seq OWNED BY public.contribuyente.idcontribuyente;


--
-- TOC entry 226 (class 1259 OID 25258)
-- Name: contribuyentepredio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contribuyentepredio (
    idcontribuyentepredio integer NOT NULL,
    idpredio integer,
    idcontribuyente integer,
    porcentaje_predio character(10)
);


ALTER TABLE public.contribuyentepredio OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25261)
-- Name: contribuyentepredio_idcontribuyentepredio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contribuyentepredio_idcontribuyentepredio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contribuyentepredio_idcontribuyentepredio_seq OWNER TO postgres;

--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 227
-- Name: contribuyentepredio_idcontribuyentepredio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contribuyentepredio_idcontribuyentepredio_seq OWNED BY public.contribuyentepredio.idcontribuyentepredio;


--
-- TOC entry 228 (class 1259 OID 25263)
-- Name: costasgastoprocesalesdetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costasgastoprocesalesdetalle (
    iddetalle integer NOT NULL,
    idcostas integer,
    idmotivo integer,
    cantidad numeric(10,2)
);


ALTER TABLE public.costasgastoprocesalesdetalle OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25266)
-- Name: costasgastoprocesalesdetalle_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.costasgastoprocesalesdetalle_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costasgastoprocesalesdetalle_iddetalle_seq OWNER TO postgres;

--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 229
-- Name: costasgastoprocesalesdetalle_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.costasgastoprocesalesdetalle_iddetalle_seq OWNED BY public.costasgastoprocesalesdetalle.iddetalle;


--
-- TOC entry 230 (class 1259 OID 25268)
-- Name: costasgastosprocesales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costasgastosprocesales (
    idcostas integer NOT NULL,
    num_inicial integer,
    idcontribuyente integer,
    expediente_coactivo character(20),
    fecha timestamp without time zone
);


ALTER TABLE public.costasgastosprocesales OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25271)
-- Name: costasgastosprocesales_idcostas_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.costasgastosprocesales_idcostas_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costasgastosprocesales_idcostas_seq OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 231
-- Name: costasgastosprocesales_idcostas_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.costasgastosprocesales_idcostas_seq OWNED BY public.costasgastosprocesales.idcostas;


--
-- TOC entry 232 (class 1259 OID 25273)
-- Name: cuentacorriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentacorriente (
    idcuentacorriente integer NOT NULL,
    importe_total numeric(10,2),
    anexo integer,
    estado_cuenta character(10),
    idcontribuyente integer,
    idperiodo integer
);


ALTER TABLE public.cuentacorriente OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25276)
-- Name: cuentacorriente_idcuentacorriente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuentacorriente_idcuentacorriente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuentacorriente_idcuentacorriente_seq OWNER TO postgres;

--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 233
-- Name: cuentacorriente_idcuentacorriente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuentacorriente_idcuentacorriente_seq OWNED BY public.cuentacorriente.idcuentacorriente;


--
-- TOC entry 242 (class 1259 OID 25299)
-- Name: cuentadetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentadetalle (
    iddetalle integer NOT NULL,
    idcuenta integer,
    concepto character varying(100),
    generado integer,
    monto numeric(10,2),
    saldo numeric(10,2),
    ncuota integer
);


ALTER TABLE public.cuentadetalle OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25278)
-- Name: datosconstruccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datosconstruccion (
    idconstruccion integer NOT NULL,
    descripcion character varying(100),
    tipo character varying(100),
    estado character(10),
    idnivel integer
);


ALTER TABLE public.datosconstruccion OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25281)
-- Name: datosconstruccion_idconstruccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datosconstruccion_idconstruccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datosconstruccion_idconstruccion_seq OWNER TO postgres;

--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 235
-- Name: datosconstruccion_idconstruccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datosconstruccion_idconstruccion_seq OWNED BY public.datosconstruccion.idconstruccion;


--
-- TOC entry 236 (class 1259 OID 25283)
-- Name: declaracionjurada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.declaracionjurada (
    iddeclaracion integer NOT NULL,
    fecha timestamp without time zone,
    idcontribuyente integer
);


ALTER TABLE public.declaracionjurada OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 25286)
-- Name: declaracionjurada_iddeclaracion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.declaracionjurada_iddeclaracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.declaracionjurada_iddeclaracion_seq OWNER TO postgres;

--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 237
-- Name: declaracionjurada_iddeclaracion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.declaracionjurada_iddeclaracion_seq OWNED BY public.declaracionjurada.iddeclaracion;


--
-- TOC entry 238 (class 1259 OID 25288)
-- Name: declaracionjuradadetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.declaracionjuradadetalle (
    iddetdeclaracion integer NOT NULL,
    iddeclaracion integer,
    motivodeclaracion public._motivodeclaracion
);


ALTER TABLE public.declaracionjuradadetalle OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 25291)
-- Name: declaracionjuradadetalle_iddetdeclaracion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.declaracionjuradadetalle_iddetdeclaracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.declaracionjuradadetalle_iddetdeclaracion_seq OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 239
-- Name: declaracionjuradadetalle_iddetdeclaracion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.declaracionjuradadetalle_iddetdeclaracion_seq OWNED BY public.declaracionjuradadetalle.iddetdeclaracion;


--
-- TOC entry 240 (class 1259 OID 25293)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    iddepartamento integer NOT NULL,
    nombre_departamento character varying(50),
    estado integer DEFAULT 1
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 25297)
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departamento_iddepartamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamento_iddepartamento_seq OWNER TO postgres;

--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 241
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamento_iddepartamento_seq OWNED BY public.departamento.iddepartamento;


--
-- TOC entry 243 (class 1259 OID 25302)
-- Name: detalle_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_iddetalle_seq OWNER TO postgres;

--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 243
-- Name: detalle_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_iddetalle_seq OWNED BY public.cuentadetalle.iddetalle;


--
-- TOC entry 244 (class 1259 OID 25304)
-- Name: detalleacta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalleacta (
    iddetalleacta integer NOT NULL,
    idclasificacion integer,
    idacta integer,
    anexo integer,
    nivel integer,
    idperiodo integer,
    clase character(10),
    material character(10),
    estado integer,
    areaconstruida character(10),
    areacomun character(10),
    areaterreno character(10),
    descripcion character varying(100)
);


ALTER TABLE public.detalleacta OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 25307)
-- Name: detalleacta_iddetalleacta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalleacta_iddetalleacta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalleacta_iddetalleacta_seq OWNER TO postgres;

--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 245
-- Name: detalleacta_iddetalleacta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalleacta_iddetalleacta_seq OWNED BY public.detalleacta.iddetalleacta;


--
-- TOC entry 246 (class 1259 OID 25309)
-- Name: detallerecibo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detallerecibo (
    iddetaller integer NOT NULL,
    operacion character(20),
    detalleoperacion character varying(100),
    emisonr numeric(10,2),
    moras numeric(10,2),
    sub_total numeric(10,2),
    idrecibo integer
);


ALTER TABLE public.detallerecibo OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 25312)
-- Name: detallerecibo_iddetaller_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detallerecibo_iddetaller_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detallerecibo_iddetaller_seq OWNER TO postgres;

--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 247
-- Name: detallerecibo_iddetaller_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detallerecibo_iddetaller_seq OWNED BY public.detallerecibo.iddetaller;


--
-- TOC entry 248 (class 1259 OID 25314)
-- Name: determinacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.determinacion (
    codigodeterminacion integer NOT NULL,
    idcontribuyente integer,
    idacta integer,
    subtotales numeric(10,8),
    tipo public._tipo,
    derechoemision timestamp without time zone,
    motivo character varying(100)
);


ALTER TABLE public.determinacion OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 25317)
-- Name: determinacion_codigodeterminacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.determinacion_codigodeterminacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.determinacion_codigodeterminacion_seq OWNER TO postgres;

--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 249
-- Name: determinacion_codigodeterminacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.determinacion_codigodeterminacion_seq OWNED BY public.determinacion.codigodeterminacion;


--
-- TOC entry 250 (class 1259 OID 25319)
-- Name: determinaciondetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.determinaciondetalle (
    iddetdetalle integer NOT NULL,
    codigodeterminacion integer,
    idpredio integer,
    idperiodo integer,
    declarado character varying(100),
    fiscalizado character varying(100),
    trimestre character varying(100),
    diferencia_imp_fiscal integer,
    interesdiario numeric(10,2),
    subtotal_por_anio numeric(10,2)
);


ALTER TABLE public.determinaciondetalle OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 25322)
-- Name: determinaciondetalle_iddetdetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.determinaciondetalle_iddetdetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.determinaciondetalle_iddetdetalle_seq OWNER TO postgres;

--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 251
-- Name: determinaciondetalle_iddetdetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.determinaciondetalle_iddetdetalle_seq OWNED BY public.determinaciondetalle.iddetdetalle;


--
-- TOC entry 252 (class 1259 OID 25324)
-- Name: distrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distrito (
    iddistrito integer NOT NULL,
    codigo character(15),
    nomdistrito character varying(100),
    abreviatura character(10),
    estado integer DEFAULT 1,
    idprovincia integer DEFAULT 1
);


ALTER TABLE public.distrito OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25329)
-- Name: distrito_iddistrito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.distrito_iddistrito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.distrito_iddistrito_seq OWNER TO postgres;

--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 253
-- Name: distrito_iddistrito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.distrito_iddistrito_seq OWNED BY public.distrito.iddistrito;


--
-- TOC entry 254 (class 1259 OID 25331)
-- Name: documentocoactivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documentocoactivo (
    iddocumentocoactivo integer NOT NULL,
    expediente character varying(50),
    cuaderno character(20),
    fecha timestamp without time zone,
    idauxiciliarcoactivo integer,
    idejecutarcoactivo integer,
    nomdocumento character varying(100),
    concepto character varying(100),
    tipodoc character varying(100),
    detalledocumento character varying(100)
);


ALTER TABLE public.documentocoactivo OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 25334)
-- Name: documentocoactivo_iddocumentocoactivo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documentocoactivo_iddocumentocoactivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documentocoactivo_iddocumentocoactivo_seq OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 255
-- Name: documentocoactivo_iddocumentocoactivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documentocoactivo_iddocumentocoactivo_seq OWNED BY public.documentocoactivo.iddocumentocoactivo;


--
-- TOC entry 256 (class 1259 OID 25336)
-- Name: ejecutorcoactivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ejecutorcoactivo (
    idejecutarcoactivo integer NOT NULL,
    ejecutor character varying(100),
    siglas character(10)
);


ALTER TABLE public.ejecutorcoactivo OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 25339)
-- Name: ejecutorcoactivo_idejecutarcoactivo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ejecutorcoactivo_idejecutarcoactivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ejecutorcoactivo_idejecutarcoactivo_seq OWNER TO postgres;

--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 257
-- Name: ejecutorcoactivo_idejecutarcoactivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ejecutorcoactivo_idejecutarcoactivo_seq OWNED BY public.ejecutorcoactivo.idejecutarcoactivo;


--
-- TOC entry 258 (class 1259 OID 25341)
-- Name: institucion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.institucion (
    idinstitucion integer NOT NULL,
    descripcion character varying(100),
    idnivel integer
);


ALTER TABLE public.institucion OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 25344)
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.institucion_idinstitucion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.institucion_idinstitucion_seq OWNER TO postgres;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 259
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.institucion_idinstitucion_seq OWNED BY public.institucion.idinstitucion;


--
-- TOC entry 260 (class 1259 OID 25346)
-- Name: modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo (
    idmodulo integer NOT NULL,
    descripcion character varying(100),
    estado integer,
    idtipousuario integer
);


ALTER TABLE public.modulo OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25349)
-- Name: modulo_idmodulo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modulo_idmodulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulo_idmodulo_seq OWNER TO postgres;

--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 261
-- Name: modulo_idmodulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modulo_idmodulo_seq OWNED BY public.modulo.idmodulo;


--
-- TOC entry 262 (class 1259 OID 25351)
-- Name: motivogastos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motivogastos (
    idmotivo integer NOT NULL,
    descripcion text,
    valor_unitario numeric(10,2)
);


ALTER TABLE public.motivogastos OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 25357)
-- Name: motivogastos_idmotivo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motivogastos_idmotivo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motivogastos_idmotivo_seq OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 263
-- Name: motivogastos_idmotivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motivogastos_idmotivo_seq OWNED BY public.motivogastos.idmotivo;


--
-- TOC entry 264 (class 1259 OID 25359)
-- Name: movimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimiento (
    idmovimiento integer NOT NULL,
    fecha timestamp without time zone,
    tipo_pago character(20),
    importe numeric(10,2),
    idcaja integer,
    idrecibo integer
);


ALTER TABLE public.movimiento OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 25362)
-- Name: movimiento_idmovimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimiento_idmovimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movimiento_idmovimiento_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 265
-- Name: movimiento_idmovimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimiento_idmovimiento_seq OWNED BY public.movimiento.idmovimiento;


--
-- TOC entry 266 (class 1259 OID 25364)
-- Name: multatributaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.multatributaria (
    codigomultatributaria integer NOT NULL,
    idcontribuyente integer,
    idperiodo integer,
    subtotal numeric(10,8),
    referencia character(10)
);


ALTER TABLE public.multatributaria OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 25367)
-- Name: multatributaria_codigomultatributaria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.multatributaria_codigomultatributaria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.multatributaria_codigomultatributaria_seq OWNER TO postgres;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 267
-- Name: multatributaria_codigomultatributaria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.multatributaria_codigomultatributaria_seq OWNED BY public.multatributaria.codigomultatributaria;


--
-- TOC entry 268 (class 1259 OID 25369)
-- Name: multatributariadetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.multatributariadetalle (
    iddetmultatributaria integer NOT NULL,
    idpredio integer,
    codigo_multa_tributaria integer,
    multainsoluta numeric(10,2),
    interesdiario numeric(10,2),
    sub_total_por_anio numeric(10,2)
);


ALTER TABLE public.multatributariadetalle OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 25372)
-- Name: multatributariadetalle_iddetmultatributaria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.multatributariadetalle_iddetmultatributaria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.multatributariadetalle_iddetmultatributaria_seq OWNER TO postgres;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 269
-- Name: multatributariadetalle_iddetmultatributaria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.multatributariadetalle_iddetmultatributaria_seq OWNED BY public.multatributariadetalle.iddetmultatributaria;


--
-- TOC entry 270 (class 1259 OID 25374)
-- Name: municipalidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipalidad (
    idmunicipalidad integer NOT NULL,
    nom_municipalidad character varying(100),
    idperiodo integer,
    ruc integer,
    representante character varying(100),
    siglas character(10),
    tipo_municipio character varying(50),
    telefono character(10)
);


ALTER TABLE public.municipalidad OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 25377)
-- Name: municipalidad_idmunicipalidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.municipalidad_idmunicipalidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.municipalidad_idmunicipalidad_seq OWNER TO postgres;

--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 271
-- Name: municipalidad_idmunicipalidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.municipalidad_idmunicipalidad_seq OWNED BY public.municipalidad.idmunicipalidad;


--
-- TOC entry 272 (class 1259 OID 25379)
-- Name: niveles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveles (
    idnivel integer NOT NULL,
    orden integer,
    nivel character(5),
    anio_inspecion timestamp without time zone,
    valor_unitario numeric(10,2),
    porcentaje_depreciacion character(10),
    depreciacion numeric(10,2),
    valor_unitario_depreciacion numeric(10,2),
    area_construida character(10),
    valor_area_construida numeric(10,2),
    valor_area_comun numeric(10,2),
    incremento integer,
    valor_construccion numeric(10,2),
    observacion text,
    idpredio integer
);


ALTER TABLE public.niveles OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 25385)
-- Name: niveles_idnivel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveles_idnivel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.niveles_idnivel_seq OWNER TO postgres;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 273
-- Name: niveles_idnivel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveles_idnivel_seq OWNED BY public.niveles.idnivel;


--
-- TOC entry 274 (class 1259 OID 25387)
-- Name: ordedetalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordedetalle (
    idpagodetalle integer NOT NULL,
    periodo_adeudado character(20),
    base_imponible numeric(10,2),
    deuda_insoluta numeric(10,2),
    interes_diario numeric(10,2),
    sub_total_por_periodo numeric(10,2),
    idperiodo integer,
    idpago integer
);


ALTER TABLE public.ordedetalle OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 25390)
-- Name: ordedetalle_idpagodetalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordedetalle_idpagodetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordedetalle_idpagodetalle_seq OWNER TO postgres;

--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 275
-- Name: ordedetalle_idpagodetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordedetalle_idpagodetalle_seq OWNED BY public.ordedetalle.idpagodetalle;


--
-- TOC entry 276 (class 1259 OID 25392)
-- Name: ordenpago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordenpago (
    idpago integer NOT NULL,
    idcontribuyente integer,
    fecha_emitida timestamp without time zone,
    total_pagar numeric(10,2),
    emision_derecho numeric(10,2),
    estado integer
);


ALTER TABLE public.ordenpago OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 25395)
-- Name: ordenpago_idpago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordenpago_idpago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordenpago_idpago_seq OWNER TO postgres;

--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 277
-- Name: ordenpago_idpago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordenpago_idpago_seq OWNED BY public.ordenpago.idpago;


--
-- TOC entry 278 (class 1259 OID 25397)
-- Name: partidapresupuestal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partidapresupuestal (
    idpartida integer NOT NULL,
    codigo_presupuestal character(10),
    concepto character varying(100),
    importe_tupa numeric(10,2),
    idperiodo integer
);


ALTER TABLE public.partidapresupuestal OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 25400)
-- Name: partidapresupuestal_idpartida_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partidapresupuestal_idpartida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partidapresupuestal_idpartida_seq OWNER TO postgres;

--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 279
-- Name: partidapresupuestal_idpartida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partidapresupuestal_idpartida_seq OWNED BY public.partidapresupuestal.idpartida;


--
-- TOC entry 280 (class 1259 OID 25402)
-- Name: perfilusuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfilusuario (
    idtipousuario integer NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE public.perfilusuario OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 25405)
-- Name: perfilusuario_idtipousuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfilusuario_idtipousuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfilusuario_idtipousuario_seq OWNER TO postgres;

--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 281
-- Name: perfilusuario_idtipousuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfilusuario_idtipousuario_seq OWNED BY public.perfilusuario.idtipousuario;


--
-- TOC entry 282 (class 1259 OID 25407)
-- Name: predios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.predios (
    idpredio integer NOT NULL,
    idurb integer,
    tipo_predio public._tipo_predio,
    anexo integer,
    fecha_reg timestamp without time zone,
    condicion_propiedad public._condicion_propiedad,
    porcentaje_condominio character(5),
    detalle text,
    observacion text,
    tipo_terreno public.tipo_terreno[],
    uso_terreno character varying(100),
    nombre_predio character varying(100),
    numero integer,
    departamento integer,
    manzana character(5),
    lote character(5),
    pexonerado character(10),
    num_resolucion integer,
    fecha_resolucion timestamp without time zone,
    estado integer,
    idlimites integer,
    idcategoriat integer,
    area_terreno character(10),
    fecha_adquisicion timestamp without time zone,
    total_area_construida character(10),
    valor_total_construccion character(10),
    valor_terreno numeric(10,8),
    valor_auto_exonerado character(5),
    valor_efecto character(5),
    valor_porcentaje_condominio character(5),
    otras_instalaciones character varying(100),
    valor_predio double precision
);


ALTER TABLE public.predios OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 25413)
-- Name: predios_idpredio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.predios_idpredio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.predios_idpredio_seq OWNER TO postgres;

--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 283
-- Name: predios_idpredio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.predios_idpredio_seq OWNED BY public.predios.idpredio;


--
-- TOC entry 284 (class 1259 OID 25415)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincia (
    idprovincia integer NOT NULL,
    nombre_provincia character varying(50),
    iddepartamento integer,
    estado integer DEFAULT 1
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 25419)
-- Name: provincia_idprovincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provincia_idprovincia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provincia_idprovincia_seq OWNER TO postgres;

--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 285
-- Name: provincia_idprovincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provincia_idprovincia_seq OWNED BY public.provincia.idprovincia;


--
-- TOC entry 286 (class 1259 OID 25421)
-- Name: recibo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recibo (
    idrecibo integer NOT NULL,
    numero integer,
    serie character(20),
    idperiodo integer,
    fecha_recibo timestamp without time zone,
    total numeric(10,2)
);


ALTER TABLE public.recibo OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 25424)
-- Name: recibo_idrecibo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recibo_idrecibo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recibo_idrecibo_seq OWNER TO postgres;

--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 287
-- Name: recibo_idrecibo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recibo_idrecibo_seq OWNED BY public.recibo.idrecibo;


--
-- TOC entry 288 (class 1259 OID 25426)
-- Name: regionvalores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regionvalores (
    idregvalores integer NOT NULL,
    valor character varying(100)
);


ALTER TABLE public.regionvalores OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 25429)
-- Name: regionvalores_idregvalores_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regionvalores_idregvalores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regionvalores_idregvalores_seq OWNER TO postgres;

--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 289
-- Name: regionvalores_idregvalores_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regionvalores_idregvalores_seq OWNED BY public.regionvalores.idregvalores;


--
-- TOC entry 290 (class 1259 OID 25431)
-- Name: tributo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tributo (
    idtributo integer NOT NULL,
    concepto character varying(100),
    monto numeric(10,2),
    idperiodo integer
);


ALTER TABLE public.tributo OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 25434)
-- Name: tributo_idtributo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tributo_idtributo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tributo_idtributo_seq OWNER TO postgres;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 291
-- Name: tributo_idtributo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tributo_idtributo_seq OWNED BY public.tributo.idtributo;


--
-- TOC entry 292 (class 1259 OID 25436)
-- Name: urbanisacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urbanisacion (
    idurb integer NOT NULL,
    codigo integer,
    nomurbanisacion character varying(100),
    abreviatura character varying(100),
    iddistrito integer,
    estado integer DEFAULT 1
);


ALTER TABLE public.urbanisacion OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 25440)
-- Name: urbanisacion_idurb_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urbanisacion_idurb_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urbanisacion_idurb_seq OWNER TO postgres;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 293
-- Name: urbanisacion_idurb_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urbanisacion_idurb_seq OWNED BY public.urbanisacion.idurb;


--
-- TOC entry 294 (class 1259 OID 25442)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    idusuario integer NOT NULL,
    login character varying(100),
    password character varying(100),
    fecha_registro timestamp without time zone,
    idmunicipalidad integer,
    idtipousuario integer,
    estado integer,
    nombre_completo character varying(100)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 25445)
-- Name: usuario_idusuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_idusuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_idusuario_seq OWNER TO postgres;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 295
-- Name: usuario_idusuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_idusuario_seq OWNED BY public.usuario.idusuario;


--
-- TOC entry 296 (class 1259 OID 25447)
-- Name: valores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.valores (
    idvalor integer NOT NULL,
    ipm integer,
    uit numeric(10,2),
    tasa numeric(10,2),
    interes_diario numeric(10,2),
    gasto_admin numeric(10,2),
    emison_op integer,
    emision_derecho character(5),
    cantidad_uit integer,
    idperiodo integer,
    emisonr numeric(10,2),
    moras numeric(10,2),
    incremento numeric(10,2)
);


ALTER TABLE public.valores OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 25450)
-- Name: valores_idvalor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.valores_idvalor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.valores_idvalor_seq OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 297
-- Name: valores_idvalor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.valores_idvalor_seq OWNED BY public.valores.idvalor;


--
-- TOC entry 298 (class 1259 OID 25452)
-- Name: valoresantiguedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.valoresantiguedad (
    idvaloresantiguedad integer NOT NULL,
    muy_bueno character(10),
    bueno character(10),
    malo character(10),
    idantiguedad integer,
    regular character(10)
);


ALTER TABLE public.valoresantiguedad OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 25455)
-- Name: valoresantiguedad_idvaloresantiguedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.valoresantiguedad_idvaloresantiguedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.valoresantiguedad_idvaloresantiguedad_seq OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 299
-- Name: valoresantiguedad_idvaloresantiguedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.valoresantiguedad_idvaloresantiguedad_seq OWNED BY public.valoresantiguedad.idvaloresantiguedad;


--
-- TOC entry 300 (class 1259 OID 25457)
-- Name: valoresunitarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.valoresunitarios (
    idvalunitario integer NOT NULL,
    nomvalor character varying(100)
);


ALTER TABLE public.valoresunitarios OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 25460)
-- Name: valoresunitarios_idvalunitario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.valoresunitarios_idvalunitario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.valoresunitarios_idvalunitario_seq OWNER TO postgres;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 301
-- Name: valoresunitarios_idvalunitario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.valoresunitarios_idvalunitario_seq OWNED BY public.valoresunitarios.idvalunitario;


--
-- TOC entry 3010 (class 2604 OID 25462)
-- Name: acta idacta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acta ALTER COLUMN idacta SET DEFAULT nextval('public.acta_idacta_seq'::regclass);


--
-- TOC entry 3011 (class 2604 OID 25463)
-- Name: alcabala idalcabala; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alcabala ALTER COLUMN idalcabala SET DEFAULT nextval('public.alcabala_idalcabala_seq'::regclass);


--
-- TOC entry 3012 (class 2604 OID 25464)
-- Name: alcabaladetalle iddetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alcabaladetalle ALTER COLUMN iddetalle SET DEFAULT nextval('public.alcabaladetalle_iddetalle_seq'::regclass);


--
-- TOC entry 3013 (class 2604 OID 25465)
-- Name: antiguedad idantiguedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antiguedad ALTER COLUMN idantiguedad SET DEFAULT nextval('public.antiguedad_idantiguedad_seq'::regclass);


--
-- TOC entry 3014 (class 2604 OID 25466)
-- Name: arancelurbano idarancel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arancelurbano ALTER COLUMN idarancel SET DEFAULT nextval('public.arancelurbano_idarancel_seq'::regclass);


--
-- TOC entry 3015 (class 2604 OID 25467)
-- Name: auxiliarcoactivo idauxiciliarcoactivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auxiliarcoactivo ALTER COLUMN idauxiciliarcoactivo SET DEFAULT nextval('public.auxiliarcoactivo_idauxiciliarcoactivo_seq'::regclass);


--
-- TOC entry 3016 (class 2604 OID 25468)
-- Name: caja idcaja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja ALTER COLUMN idcaja SET DEFAULT nextval('public.caja_idcaja_seq'::regclass);


--
-- TOC entry 3017 (class 2604 OID 25469)
-- Name: calidad idcalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calidad ALTER COLUMN idcalidad SET DEFAULT nextval('public.calidad_idcalidad_seq'::regclass);


--
-- TOC entry 3018 (class 2604 OID 25470)
-- Name: caracteristicaspredio idcatracteristica; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caracteristicaspredio ALTER COLUMN idcatracteristica SET DEFAULT nextval('public.caracteristicaspredio_idcatracteristica_seq'::regclass);


--
-- TOC entry 3020 (class 2604 OID 25472)
-- Name: catastro idcatrasto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catastro ALTER COLUMN idcatrasto SET DEFAULT nextval('public.catastro_idcatrasto_seq'::regclass);


--
-- TOC entry 3021 (class 2604 OID 25473)
-- Name: categoriacalidad idcatcalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriacalidad ALTER COLUMN idcatcalidad SET DEFAULT nextval('public.categoriacalidad_idcatcalidad_seq'::regclass);


--
-- TOC entry 3019 (class 2604 OID 25471)
-- Name: catterrenoarancel idcatterrenoarancel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catterrenoarancel ALTER COLUMN idcatterrenoarancel SET DEFAULT nextval('public.carterrenoarancel_idcatterrenoarancel_seq'::regclass);


--
-- TOC entry 3022 (class 2604 OID 25474)
-- Name: clasesvalores idclasvalores; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasesvalores ALTER COLUMN idclasvalores SET DEFAULT nextval('public.clasesvalores_idclasvalores_seq'::regclass);


--
-- TOC entry 3023 (class 2604 OID 25475)
-- Name: clasificacion idclasificacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion ALTER COLUMN idclasificacion SET DEFAULT nextval('public.clasificacion_idclasificacion_seq'::regclass);


--
-- TOC entry 3024 (class 2604 OID 25476)
-- Name: contribuyente idcontribuyente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribuyente ALTER COLUMN idcontribuyente SET DEFAULT nextval('public.contribuyente_idcontribuyente_seq'::regclass);


--
-- TOC entry 3025 (class 2604 OID 25477)
-- Name: contribuyentepredio idcontribuyentepredio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribuyentepredio ALTER COLUMN idcontribuyentepredio SET DEFAULT nextval('public.contribuyentepredio_idcontribuyentepredio_seq'::regclass);


--
-- TOC entry 3026 (class 2604 OID 25478)
-- Name: costasgastoprocesalesdetalle iddetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costasgastoprocesalesdetalle ALTER COLUMN iddetalle SET DEFAULT nextval('public.costasgastoprocesalesdetalle_iddetalle_seq'::regclass);


--
-- TOC entry 3027 (class 2604 OID 25479)
-- Name: costasgastosprocesales idcostas; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costasgastosprocesales ALTER COLUMN idcostas SET DEFAULT nextval('public.costasgastosprocesales_idcostas_seq'::regclass);


--
-- TOC entry 3028 (class 2604 OID 25480)
-- Name: cuentacorriente idcuentacorriente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentacorriente ALTER COLUMN idcuentacorriente SET DEFAULT nextval('public.cuentacorriente_idcuentacorriente_seq'::regclass);


--
-- TOC entry 3034 (class 2604 OID 25485)
-- Name: cuentadetalle iddetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentadetalle ALTER COLUMN iddetalle SET DEFAULT nextval('public.detalle_iddetalle_seq'::regclass);


--
-- TOC entry 3029 (class 2604 OID 25481)
-- Name: datosconstruccion idconstruccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datosconstruccion ALTER COLUMN idconstruccion SET DEFAULT nextval('public.datosconstruccion_idconstruccion_seq'::regclass);


--
-- TOC entry 3030 (class 2604 OID 25482)
-- Name: declaracionjurada iddeclaracion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaracionjurada ALTER COLUMN iddeclaracion SET DEFAULT nextval('public.declaracionjurada_iddeclaracion_seq'::regclass);


--
-- TOC entry 3031 (class 2604 OID 25483)
-- Name: declaracionjuradadetalle iddetdeclaracion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaracionjuradadetalle ALTER COLUMN iddetdeclaracion SET DEFAULT nextval('public.declaracionjuradadetalle_iddetdeclaracion_seq'::regclass);


--
-- TOC entry 3033 (class 2604 OID 25484)
-- Name: departamento iddepartamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento ALTER COLUMN iddepartamento SET DEFAULT nextval('public.departamento_iddepartamento_seq'::regclass);


--
-- TOC entry 3035 (class 2604 OID 25486)
-- Name: detalleacta iddetalleacta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleacta ALTER COLUMN iddetalleacta SET DEFAULT nextval('public.detalleacta_iddetalleacta_seq'::regclass);


--
-- TOC entry 3036 (class 2604 OID 25487)
-- Name: detallerecibo iddetaller; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallerecibo ALTER COLUMN iddetaller SET DEFAULT nextval('public.detallerecibo_iddetaller_seq'::regclass);


--
-- TOC entry 3037 (class 2604 OID 25488)
-- Name: determinacion codigodeterminacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.determinacion ALTER COLUMN codigodeterminacion SET DEFAULT nextval('public.determinacion_codigodeterminacion_seq'::regclass);


--
-- TOC entry 3038 (class 2604 OID 25489)
-- Name: determinaciondetalle iddetdetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.determinaciondetalle ALTER COLUMN iddetdetalle SET DEFAULT nextval('public.determinaciondetalle_iddetdetalle_seq'::regclass);


--
-- TOC entry 3041 (class 2604 OID 25490)
-- Name: distrito iddistrito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito ALTER COLUMN iddistrito SET DEFAULT nextval('public.distrito_iddistrito_seq'::regclass);


--
-- TOC entry 3042 (class 2604 OID 25491)
-- Name: documentocoactivo iddocumentocoactivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentocoactivo ALTER COLUMN iddocumentocoactivo SET DEFAULT nextval('public.documentocoactivo_iddocumentocoactivo_seq'::regclass);


--
-- TOC entry 3043 (class 2604 OID 25492)
-- Name: ejecutorcoactivo idejecutarcoactivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ejecutorcoactivo ALTER COLUMN idejecutarcoactivo SET DEFAULT nextval('public.ejecutorcoactivo_idejecutarcoactivo_seq'::regclass);


--
-- TOC entry 3044 (class 2604 OID 25493)
-- Name: institucion idinstitucion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institucion ALTER COLUMN idinstitucion SET DEFAULT nextval('public.institucion_idinstitucion_seq'::regclass);


--
-- TOC entry 3045 (class 2604 OID 25494)
-- Name: modulo idmodulo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo ALTER COLUMN idmodulo SET DEFAULT nextval('public.modulo_idmodulo_seq'::regclass);


--
-- TOC entry 3046 (class 2604 OID 25495)
-- Name: motivogastos idmotivo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivogastos ALTER COLUMN idmotivo SET DEFAULT nextval('public.motivogastos_idmotivo_seq'::regclass);


--
-- TOC entry 3047 (class 2604 OID 25496)
-- Name: movimiento idmovimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento ALTER COLUMN idmovimiento SET DEFAULT nextval('public.movimiento_idmovimiento_seq'::regclass);


--
-- TOC entry 3048 (class 2604 OID 25497)
-- Name: multatributaria codigomultatributaria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multatributaria ALTER COLUMN codigomultatributaria SET DEFAULT nextval('public.multatributaria_codigomultatributaria_seq'::regclass);


--
-- TOC entry 3049 (class 2604 OID 25498)
-- Name: multatributariadetalle iddetmultatributaria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multatributariadetalle ALTER COLUMN iddetmultatributaria SET DEFAULT nextval('public.multatributariadetalle_iddetmultatributaria_seq'::regclass);


--
-- TOC entry 3050 (class 2604 OID 25499)
-- Name: municipalidad idmunicipalidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipalidad ALTER COLUMN idmunicipalidad SET DEFAULT nextval('public.municipalidad_idmunicipalidad_seq'::regclass);


--
-- TOC entry 3051 (class 2604 OID 25500)
-- Name: niveles idnivel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles ALTER COLUMN idnivel SET DEFAULT nextval('public.niveles_idnivel_seq'::regclass);


--
-- TOC entry 3052 (class 2604 OID 25501)
-- Name: ordedetalle idpagodetalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordedetalle ALTER COLUMN idpagodetalle SET DEFAULT nextval('public.ordedetalle_idpagodetalle_seq'::regclass);


--
-- TOC entry 3053 (class 2604 OID 25502)
-- Name: ordenpago idpago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenpago ALTER COLUMN idpago SET DEFAULT nextval('public.ordenpago_idpago_seq'::regclass);


--
-- TOC entry 3054 (class 2604 OID 25503)
-- Name: partidapresupuestal idpartida; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidapresupuestal ALTER COLUMN idpartida SET DEFAULT nextval('public.partidapresupuestal_idpartida_seq'::regclass);


--
-- TOC entry 3055 (class 2604 OID 25504)
-- Name: perfilusuario idtipousuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilusuario ALTER COLUMN idtipousuario SET DEFAULT nextval('public.perfilusuario_idtipousuario_seq'::regclass);


--
-- TOC entry 3056 (class 2604 OID 25505)
-- Name: predios idpredio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predios ALTER COLUMN idpredio SET DEFAULT nextval('public.predios_idpredio_seq'::regclass);


--
-- TOC entry 3058 (class 2604 OID 25506)
-- Name: provincia idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia ALTER COLUMN idprovincia SET DEFAULT nextval('public.provincia_idprovincia_seq'::regclass);


--
-- TOC entry 3059 (class 2604 OID 25507)
-- Name: recibo idrecibo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recibo ALTER COLUMN idrecibo SET DEFAULT nextval('public.recibo_idrecibo_seq'::regclass);


--
-- TOC entry 3060 (class 2604 OID 25508)
-- Name: regionvalores idregvalores; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regionvalores ALTER COLUMN idregvalores SET DEFAULT nextval('public.regionvalores_idregvalores_seq'::regclass);


--
-- TOC entry 3061 (class 2604 OID 25509)
-- Name: tributo idtributo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tributo ALTER COLUMN idtributo SET DEFAULT nextval('public.tributo_idtributo_seq'::regclass);


--
-- TOC entry 3063 (class 2604 OID 25510)
-- Name: urbanisacion idurb; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urbanisacion ALTER COLUMN idurb SET DEFAULT nextval('public.urbanisacion_idurb_seq'::regclass);


--
-- TOC entry 3064 (class 2604 OID 25511)
-- Name: usuario idusuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN idusuario SET DEFAULT nextval('public.usuario_idusuario_seq'::regclass);


--
-- TOC entry 3065 (class 2604 OID 25512)
-- Name: valores idvalor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valores ALTER COLUMN idvalor SET DEFAULT nextval('public.valores_idvalor_seq'::regclass);


--
-- TOC entry 3066 (class 2604 OID 25513)
-- Name: valoresantiguedad idvaloresantiguedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valoresantiguedad ALTER COLUMN idvaloresantiguedad SET DEFAULT nextval('public.valoresantiguedad_idvaloresantiguedad_seq'::regclass);


--
-- TOC entry 3067 (class 2604 OID 25514)
-- Name: valoresunitarios idvalunitario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valoresunitarios ALTER COLUMN idvalunitario SET DEFAULT nextval('public.valoresunitarios_idvalunitario_seq'::regclass);


--
-- TOC entry 3295 (class 0 OID 25179)
-- Dependencies: 196
-- Data for Name: acta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acta (idacta, observacion, idusuario, idcontribuyente) FROM stdin;
\.


--
-- TOC entry 3297 (class 0 OID 25184)
-- Dependencies: 198
-- Data for Name: alcabala; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alcabala (idalcabala, fecha_transferencia, segun, ingresar_ipm, fecha_emision, area, emision_valor, idpredio, estado, idcontribuyente, valor_compra, valor_autovaluo, total_apagar) FROM stdin;
\.


--
-- TOC entry 3299 (class 0 OID 25189)
-- Dependencies: 200
-- Data for Name: alcabaladetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alcabaladetalle (iddetalle, base_imponible_compra_autovaluo, ipm, uit, base_imponible, tasa, interes_acumulado, incremento, interes_diario, sub_total, idalcabala) FROM stdin;
\.


--
-- TOC entry 3301 (class 0 OID 25194)
-- Dependencies: 202
-- Data for Name: antiguedad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antiguedad (idantiguedad, descripcion, idinstitucion) FROM stdin;
\.


--
-- TOC entry 3303 (class 0 OID 25199)
-- Dependencies: 204
-- Data for Name: arancelurbano; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arancelurbano (idarancel, zona, iddistrito, idperiodo, arancel) FROM stdin;
\.


--
-- TOC entry 3305 (class 0 OID 25204)
-- Dependencies: 206
-- Data for Name: auxiliarcoactivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auxiliarcoactivo (idauxiciliarcoactivo, auxiliar, siglas) FROM stdin;
\.


--
-- TOC entry 3307 (class 0 OID 25209)
-- Dependencies: 208
-- Data for Name: caja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caja (idcaja, hora_apertura, hora_cierre, fecha, monto_apertura, monto_cierre, idusuario) FROM stdin;
\.


--
-- TOC entry 3309 (class 0 OID 25214)
-- Dependencies: 210
-- Data for Name: calidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calidad (idcalidad, descripcion) FROM stdin;
\.


--
-- TOC entry 3311 (class 0 OID 25219)
-- Dependencies: 212
-- Data for Name: caracteristicaspredio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caracteristicaspredio (idcatracteristica, estado, tipo, uso, idpredio) FROM stdin;
\.


--
-- TOC entry 3315 (class 0 OID 25232)
-- Dependencies: 216
-- Data for Name: catastro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catastro (idcatrasto, unid_catastral, idcontribuyente, iddepartamento, codigo_predio) FROM stdin;
\.


--
-- TOC entry 3317 (class 0 OID 25237)
-- Dependencies: 218
-- Data for Name: categoriacalidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoriacalidad (idcatcalidad, idcalidad, idcatterrenoarancel, monto, idperiodo) FROM stdin;
\.


--
-- TOC entry 3313 (class 0 OID 25224)
-- Dependencies: 214
-- Data for Name: catterrenoarancel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catterrenoarancel (idcatterrenoarancel, nom_categoria, des_categoria, arancel) FROM stdin;
\.


--
-- TOC entry 3319 (class 0 OID 25242)
-- Dependencies: 220
-- Data for Name: clasesvalores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clasesvalores (idclasvalores, descripcion, monto, idclasificacion, idvalunitario, idperiodo, idnivel, idregvalores) FROM stdin;
\.


--
-- TOC entry 3321 (class 0 OID 25247)
-- Dependencies: 222
-- Data for Name: clasificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clasificacion (idclasificacion, valor) FROM stdin;
\.


--
-- TOC entry 3323 (class 0 OID 25252)
-- Dependencies: 224
-- Data for Name: contribuyente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contribuyente (idcontribuyente, nombre_razon_social, tipodoc, numerodoc, idurb, direccion, numero, dpto, manzana, lote, telefono, tipo_persona, motivo, difimpuesto, observacion, totalanexo, estado, impuestoanual, valortotalexonerado, valortotalpredio, baseimponiblea) FROM stdin;
1	GIGPZ SAC	DNI	44995954	1	JR. COMERCIO 121	127	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
2	MUNICIPALIDAD	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
3	HACIENDA SAN JOSE	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
4	FUNDO DOÑA PANCHA	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
5	FUNDO EL RANCHO	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
6	HOJA REDONDA	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
7	FUNDO SAN REGIS	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
8	FUNDO EL GUAYABO	DNI	44995955	1	JR. SAN JOSE	126	ICA       	A    	01   	956314857 	NATURAL	A	40        	NINGUNA	2	1	200	200	500	500
9	FUNDO HUARANJAPO	DNI	44995954	1	JR. COMERCIO 121	121	ICA       	A    	7    	956314857 	JURIDICA	B	20        	NINGUNA	2	1	100	200	300	300
\.


--
-- TOC entry 3325 (class 0 OID 25258)
-- Dependencies: 226
-- Data for Name: contribuyentepredio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contribuyentepredio (idcontribuyentepredio, idpredio, idcontribuyente, porcentaje_predio) FROM stdin;
\.


--
-- TOC entry 3327 (class 0 OID 25263)
-- Dependencies: 228
-- Data for Name: costasgastoprocesalesdetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.costasgastoprocesalesdetalle (iddetalle, idcostas, idmotivo, cantidad) FROM stdin;
\.


--
-- TOC entry 3329 (class 0 OID 25268)
-- Dependencies: 230
-- Data for Name: costasgastosprocesales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.costasgastosprocesales (idcostas, num_inicial, idcontribuyente, expediente_coactivo, fecha) FROM stdin;
\.


--
-- TOC entry 3331 (class 0 OID 25273)
-- Dependencies: 232
-- Data for Name: cuentacorriente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuentacorriente (idcuentacorriente, importe_total, anexo, estado_cuenta, idcontribuyente, idperiodo) FROM stdin;
\.


--
-- TOC entry 3341 (class 0 OID 25299)
-- Dependencies: 242
-- Data for Name: cuentadetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuentadetalle (iddetalle, idcuenta, concepto, generado, monto, saldo, ncuota) FROM stdin;
\.


--
-- TOC entry 3333 (class 0 OID 25278)
-- Dependencies: 234
-- Data for Name: datosconstruccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datosconstruccion (idconstruccion, descripcion, tipo, estado, idnivel) FROM stdin;
\.


--
-- TOC entry 3335 (class 0 OID 25283)
-- Dependencies: 236
-- Data for Name: declaracionjurada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.declaracionjurada (iddeclaracion, fecha, idcontribuyente) FROM stdin;
\.


--
-- TOC entry 3337 (class 0 OID 25288)
-- Dependencies: 238
-- Data for Name: declaracionjuradadetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.declaracionjuradadetalle (iddetdeclaracion, iddeclaracion, motivodeclaracion) FROM stdin;
\.


--
-- TOC entry 3339 (class 0 OID 25293)
-- Dependencies: 240
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamento (iddepartamento, nombre_departamento, estado) FROM stdin;
1	ICA	1
2	LIMA	1
3	TUMBES	1
4	PIURA	1
5	LAMBAYEQUE	1
6	LA LIBERTAD	1
\.


--
-- TOC entry 3343 (class 0 OID 25304)
-- Dependencies: 244
-- Data for Name: detalleacta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalleacta (iddetalleacta, idclasificacion, idacta, anexo, nivel, idperiodo, clase, material, estado, areaconstruida, areacomun, areaterreno, descripcion) FROM stdin;
\.


--
-- TOC entry 3345 (class 0 OID 25309)
-- Dependencies: 246
-- Data for Name: detallerecibo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detallerecibo (iddetaller, operacion, detalleoperacion, emisonr, moras, sub_total, idrecibo) FROM stdin;
\.


--
-- TOC entry 3347 (class 0 OID 25314)
-- Dependencies: 248
-- Data for Name: determinacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.determinacion (codigodeterminacion, idcontribuyente, idacta, subtotales, tipo, derechoemision, motivo) FROM stdin;
\.


--
-- TOC entry 3349 (class 0 OID 25319)
-- Dependencies: 250
-- Data for Name: determinaciondetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.determinaciondetalle (iddetdetalle, codigodeterminacion, idpredio, idperiodo, declarado, fiscalizado, trimestre, diferencia_imp_fiscal, interesdiario, subtotal_por_anio) FROM stdin;
\.


--
-- TOC entry 3351 (class 0 OID 25324)
-- Dependencies: 252
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distrito (iddistrito, codigo, nomdistrito, abreviatura, estado, idprovincia) FROM stdin;
1	D01            	EL CARMEN	MDDEC     	1	1
2	S1             	SUNAMPE	MDDSU     	1	1
\.


--
-- TOC entry 3353 (class 0 OID 25331)
-- Dependencies: 254
-- Data for Name: documentocoactivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documentocoactivo (iddocumentocoactivo, expediente, cuaderno, fecha, idauxiciliarcoactivo, idejecutarcoactivo, nomdocumento, concepto, tipodoc, detalledocumento) FROM stdin;
\.


--
-- TOC entry 3355 (class 0 OID 25336)
-- Dependencies: 256
-- Data for Name: ejecutorcoactivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ejecutorcoactivo (idejecutarcoactivo, ejecutor, siglas) FROM stdin;
\.


--
-- TOC entry 3357 (class 0 OID 25341)
-- Dependencies: 258
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institucion (idinstitucion, descripcion, idnivel) FROM stdin;
\.


--
-- TOC entry 3359 (class 0 OID 25346)
-- Dependencies: 260
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modulo (idmodulo, descripcion, estado, idtipousuario) FROM stdin;
\.


--
-- TOC entry 3361 (class 0 OID 25351)
-- Dependencies: 262
-- Data for Name: motivogastos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motivogastos (idmotivo, descripcion, valor_unitario) FROM stdin;
\.


--
-- TOC entry 3363 (class 0 OID 25359)
-- Dependencies: 264
-- Data for Name: movimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimiento (idmovimiento, fecha, tipo_pago, importe, idcaja, idrecibo) FROM stdin;
\.


--
-- TOC entry 3365 (class 0 OID 25364)
-- Dependencies: 266
-- Data for Name: multatributaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.multatributaria (codigomultatributaria, idcontribuyente, idperiodo, subtotal, referencia) FROM stdin;
\.


--
-- TOC entry 3367 (class 0 OID 25369)
-- Dependencies: 268
-- Data for Name: multatributariadetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.multatributariadetalle (iddetmultatributaria, idpredio, codigo_multa_tributaria, multainsoluta, interesdiario, sub_total_por_anio) FROM stdin;
\.


--
-- TOC entry 3369 (class 0 OID 25374)
-- Dependencies: 270
-- Data for Name: municipalidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.municipalidad (idmunicipalidad, nom_municipalidad, idperiodo, ruc, representante, siglas, tipo_municipio, telefono) FROM stdin;
\.


--
-- TOC entry 3371 (class 0 OID 25379)
-- Dependencies: 272
-- Data for Name: niveles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.niveles (idnivel, orden, nivel, anio_inspecion, valor_unitario, porcentaje_depreciacion, depreciacion, valor_unitario_depreciacion, area_construida, valor_area_construida, valor_area_comun, incremento, valor_construccion, observacion, idpredio) FROM stdin;
\.


--
-- TOC entry 3373 (class 0 OID 25387)
-- Dependencies: 274
-- Data for Name: ordedetalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordedetalle (idpagodetalle, periodo_adeudado, base_imponible, deuda_insoluta, interes_diario, sub_total_por_periodo, idperiodo, idpago) FROM stdin;
\.


--
-- TOC entry 3375 (class 0 OID 25392)
-- Dependencies: 276
-- Data for Name: ordenpago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordenpago (idpago, idcontribuyente, fecha_emitida, total_pagar, emision_derecho, estado) FROM stdin;
\.


--
-- TOC entry 3377 (class 0 OID 25397)
-- Dependencies: 278
-- Data for Name: partidapresupuestal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partidapresupuestal (idpartida, codigo_presupuestal, concepto, importe_tupa, idperiodo) FROM stdin;
\.


--
-- TOC entry 3379 (class 0 OID 25402)
-- Dependencies: 280
-- Data for Name: perfilusuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfilusuario (idtipousuario, descripcion) FROM stdin;
\.


--
-- TOC entry 3381 (class 0 OID 25407)
-- Dependencies: 282
-- Data for Name: predios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.predios (idpredio, idurb, tipo_predio, anexo, fecha_reg, condicion_propiedad, porcentaje_condominio, detalle, observacion, tipo_terreno, uso_terreno, nombre_predio, numero, departamento, manzana, lote, pexonerado, num_resolucion, fecha_resolucion, estado, idlimites, idcategoriat, area_terreno, fecha_adquisicion, total_area_construida, valor_total_construccion, valor_terreno, valor_auto_exonerado, valor_efecto, valor_porcentaje_condominio, otras_instalaciones, valor_predio) FROM stdin;
\.


--
-- TOC entry 3383 (class 0 OID 25415)
-- Dependencies: 284
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provincia (idprovincia, nombre_provincia, iddepartamento, estado) FROM stdin;
1	CHINCHA	1	1
2	PISCO	1	1
\.


--
-- TOC entry 3385 (class 0 OID 25421)
-- Dependencies: 286
-- Data for Name: recibo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recibo (idrecibo, numero, serie, idperiodo, fecha_recibo, total) FROM stdin;
\.


--
-- TOC entry 3387 (class 0 OID 25426)
-- Dependencies: 288
-- Data for Name: regionvalores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regionvalores (idregvalores, valor) FROM stdin;
\.


--
-- TOC entry 3389 (class 0 OID 25431)
-- Dependencies: 290
-- Data for Name: tributo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tributo (idtributo, concepto, monto, idperiodo) FROM stdin;
\.


--
-- TOC entry 3391 (class 0 OID 25436)
-- Dependencies: 292
-- Data for Name: urbanisacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urbanisacion (idurb, codigo, nomurbanisacion, abreviatura, iddistrito, estado) FROM stdin;
\.


--
-- TOC entry 3393 (class 0 OID 25442)
-- Dependencies: 294
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (idusuario, login, password, fecha_registro, idmunicipalidad, idtipousuario, estado, nombre_completo) FROM stdin;
1	cjacevedot@gmail.com	123456789	2019-07-07 00:00:00	1	1	1	CRISTHIAN JOEL ACEVEDO TIPIAN
\.


--
-- TOC entry 3395 (class 0 OID 25447)
-- Dependencies: 296
-- Data for Name: valores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.valores (idvalor, ipm, uit, tasa, interes_diario, gasto_admin, emison_op, emision_derecho, cantidad_uit, idperiodo, emisonr, moras, incremento) FROM stdin;
\.


--
-- TOC entry 3397 (class 0 OID 25452)
-- Dependencies: 298
-- Data for Name: valoresantiguedad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.valoresantiguedad (idvaloresantiguedad, muy_bueno, bueno, malo, idantiguedad, regular) FROM stdin;
\.


--
-- TOC entry 3399 (class 0 OID 25457)
-- Dependencies: 300
-- Data for Name: valoresunitarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.valoresunitarios (idvalunitario, nomvalor) FROM stdin;
\.


--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 197
-- Name: acta_idacta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acta_idacta_seq', 1, false);


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 199
-- Name: alcabala_idalcabala_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alcabala_idalcabala_seq', 1, false);


--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 201
-- Name: alcabaladetalle_iddetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alcabaladetalle_iddetalle_seq', 1, false);


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 203
-- Name: antiguedad_idantiguedad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antiguedad_idantiguedad_seq', 1, false);


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 205
-- Name: arancelurbano_idarancel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arancelurbano_idarancel_seq', 1, false);


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 207
-- Name: auxiliarcoactivo_idauxiciliarcoactivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auxiliarcoactivo_idauxiciliarcoactivo_seq', 1, false);


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 209
-- Name: caja_idcaja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caja_idcaja_seq', 1, false);


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 211
-- Name: calidad_idcalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calidad_idcalidad_seq', 1, false);


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 213
-- Name: caracteristicaspredio_idcatracteristica_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caracteristicaspredio_idcatracteristica_seq', 1, false);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 215
-- Name: carterrenoarancel_idcatterrenoarancel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carterrenoarancel_idcatterrenoarancel_seq', 1, false);


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 217
-- Name: catastro_idcatrasto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catastro_idcatrasto_seq', 1, false);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 219
-- Name: categoriacalidad_idcatcalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoriacalidad_idcatcalidad_seq', 1, false);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 221
-- Name: clasesvalores_idclasvalores_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clasesvalores_idclasvalores_seq', 1, false);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 223
-- Name: clasificacion_idclasificacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clasificacion_idclasificacion_seq', 1, false);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 225
-- Name: contribuyente_idcontribuyente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contribuyente_idcontribuyente_seq', 9, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 227
-- Name: contribuyentepredio_idcontribuyentepredio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contribuyentepredio_idcontribuyentepredio_seq', 1, false);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 229
-- Name: costasgastoprocesalesdetalle_iddetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.costasgastoprocesalesdetalle_iddetalle_seq', 1, false);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 231
-- Name: costasgastosprocesales_idcostas_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.costasgastosprocesales_idcostas_seq', 1, false);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 233
-- Name: cuentacorriente_idcuentacorriente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuentacorriente_idcuentacorriente_seq', 1, false);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 235
-- Name: datosconstruccion_idconstruccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datosconstruccion_idconstruccion_seq', 1, false);


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 237
-- Name: declaracionjurada_iddeclaracion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.declaracionjurada_iddeclaracion_seq', 1, false);


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 239
-- Name: declaracionjuradadetalle_iddetdeclaracion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.declaracionjuradadetalle_iddetdeclaracion_seq', 1, false);


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 241
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamento_iddepartamento_seq', 6, true);


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 243
-- Name: detalle_iddetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_iddetalle_seq', 1, false);


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 245
-- Name: detalleacta_iddetalleacta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalleacta_iddetalleacta_seq', 1, false);


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 247
-- Name: detallerecibo_iddetaller_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detallerecibo_iddetaller_seq', 1, false);


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 249
-- Name: determinacion_codigodeterminacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.determinacion_codigodeterminacion_seq', 1, false);


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 251
-- Name: determinaciondetalle_iddetdetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.determinaciondetalle_iddetdetalle_seq', 1, false);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 253
-- Name: distrito_iddistrito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.distrito_iddistrito_seq', 2, true);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 255
-- Name: documentocoactivo_iddocumentocoactivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documentocoactivo_iddocumentocoactivo_seq', 1, false);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 257
-- Name: ejecutorcoactivo_idejecutarcoactivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ejecutorcoactivo_idejecutarcoactivo_seq', 1, false);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 259
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.institucion_idinstitucion_seq', 1, false);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 261
-- Name: modulo_idmodulo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modulo_idmodulo_seq', 1, false);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 263
-- Name: motivogastos_idmotivo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motivogastos_idmotivo_seq', 1, false);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 265
-- Name: movimiento_idmovimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimiento_idmovimiento_seq', 1, false);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 267
-- Name: multatributaria_codigomultatributaria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.multatributaria_codigomultatributaria_seq', 1, false);


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 269
-- Name: multatributariadetalle_iddetmultatributaria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.multatributariadetalle_iddetmultatributaria_seq', 1, false);


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 271
-- Name: municipalidad_idmunicipalidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.municipalidad_idmunicipalidad_seq', 1, false);


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 273
-- Name: niveles_idnivel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.niveles_idnivel_seq', 1, false);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 275
-- Name: ordedetalle_idpagodetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordedetalle_idpagodetalle_seq', 1, false);


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 277
-- Name: ordenpago_idpago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordenpago_idpago_seq', 1, false);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 279
-- Name: partidapresupuestal_idpartida_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partidapresupuestal_idpartida_seq', 1, false);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 281
-- Name: perfilusuario_idtipousuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfilusuario_idtipousuario_seq', 1, false);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 283
-- Name: predios_idpredio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.predios_idpredio_seq', 1, false);


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 285
-- Name: provincia_idprovincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provincia_idprovincia_seq', 2, true);


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 287
-- Name: recibo_idrecibo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recibo_idrecibo_seq', 1, false);


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 289
-- Name: regionvalores_idregvalores_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regionvalores_idregvalores_seq', 1, false);


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 291
-- Name: tributo_idtributo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tributo_idtributo_seq', 1, false);


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 293
-- Name: urbanisacion_idurb_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urbanisacion_idurb_seq', 1, false);


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 295
-- Name: usuario_idusuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_idusuario_seq', 1, true);


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 297
-- Name: valores_idvalor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.valores_idvalor_seq', 1, false);


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 299
-- Name: valoresantiguedad_idvaloresantiguedad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.valoresantiguedad_idvaloresantiguedad_seq', 1, false);


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 301
-- Name: valoresunitarios_idvalunitario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.valoresunitarios_idvalunitario_seq', 1, false);


--
-- TOC entry 3069 (class 2606 OID 25516)
-- Name: acta acta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acta
    ADD CONSTRAINT acta_pkey PRIMARY KEY (idacta);


--
-- TOC entry 3071 (class 2606 OID 25518)
-- Name: alcabala alcabala_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alcabala
    ADD CONSTRAINT alcabala_pkey PRIMARY KEY (idalcabala);


--
-- TOC entry 3073 (class 2606 OID 25520)
-- Name: alcabaladetalle alcabaladetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alcabaladetalle
    ADD CONSTRAINT alcabaladetalle_pkey PRIMARY KEY (iddetalle);


--
-- TOC entry 3075 (class 2606 OID 25522)
-- Name: antiguedad antiguedad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antiguedad
    ADD CONSTRAINT antiguedad_pkey PRIMARY KEY (idantiguedad);


--
-- TOC entry 3077 (class 2606 OID 25524)
-- Name: arancelurbano arancelurbano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arancelurbano
    ADD CONSTRAINT arancelurbano_pkey PRIMARY KEY (idarancel);


--
-- TOC entry 3079 (class 2606 OID 25526)
-- Name: auxiliarcoactivo auxiliarcoactivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auxiliarcoactivo
    ADD CONSTRAINT auxiliarcoactivo_pkey PRIMARY KEY (idauxiciliarcoactivo);


--
-- TOC entry 3081 (class 2606 OID 25528)
-- Name: caja caja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_pkey PRIMARY KEY (idcaja);


--
-- TOC entry 3083 (class 2606 OID 25530)
-- Name: calidad calidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calidad
    ADD CONSTRAINT calidad_pkey PRIMARY KEY (idcalidad);


--
-- TOC entry 3085 (class 2606 OID 25532)
-- Name: caracteristicaspredio caracteristicaspredio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caracteristicaspredio
    ADD CONSTRAINT caracteristicaspredio_pkey PRIMARY KEY (idcatracteristica);


--
-- TOC entry 3087 (class 2606 OID 25534)
-- Name: catterrenoarancel carterrenoarancel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catterrenoarancel
    ADD CONSTRAINT carterrenoarancel_pkey PRIMARY KEY (idcatterrenoarancel);


--
-- TOC entry 3089 (class 2606 OID 25536)
-- Name: catastro catastro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catastro
    ADD CONSTRAINT catastro_pkey PRIMARY KEY (idcatrasto);


--
-- TOC entry 3091 (class 2606 OID 25538)
-- Name: categoriacalidad categoriacalidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriacalidad
    ADD CONSTRAINT categoriacalidad_pkey PRIMARY KEY (idcatcalidad);


--
-- TOC entry 3093 (class 2606 OID 25540)
-- Name: clasesvalores clasesvalores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasesvalores
    ADD CONSTRAINT clasesvalores_pkey PRIMARY KEY (idclasvalores);


--
-- TOC entry 3095 (class 2606 OID 25542)
-- Name: clasificacion clasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion
    ADD CONSTRAINT clasificacion_pkey PRIMARY KEY (idclasificacion);


--
-- TOC entry 3097 (class 2606 OID 25544)
-- Name: contribuyente contribuyente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribuyente
    ADD CONSTRAINT contribuyente_pkey PRIMARY KEY (idcontribuyente);


--
-- TOC entry 3099 (class 2606 OID 25546)
-- Name: contribuyentepredio contribuyentepredio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribuyentepredio
    ADD CONSTRAINT contribuyentepredio_pkey PRIMARY KEY (idcontribuyentepredio);


--
-- TOC entry 3101 (class 2606 OID 25548)
-- Name: costasgastoprocesalesdetalle costasgastoprocesalesdetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costasgastoprocesalesdetalle
    ADD CONSTRAINT costasgastoprocesalesdetalle_pkey PRIMARY KEY (iddetalle);


--
-- TOC entry 3103 (class 2606 OID 25550)
-- Name: costasgastosprocesales costasgastosprocesales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costasgastosprocesales
    ADD CONSTRAINT costasgastosprocesales_pkey PRIMARY KEY (idcostas);


--
-- TOC entry 3105 (class 2606 OID 25552)
-- Name: cuentacorriente cuentacorriente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentacorriente
    ADD CONSTRAINT cuentacorriente_pkey PRIMARY KEY (idcuentacorriente);


--
-- TOC entry 3107 (class 2606 OID 25554)
-- Name: datosconstruccion datosconstruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datosconstruccion
    ADD CONSTRAINT datosconstruccion_pkey PRIMARY KEY (idconstruccion);


--
-- TOC entry 3109 (class 2606 OID 25556)
-- Name: declaracionjurada declaracionjurada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaracionjurada
    ADD CONSTRAINT declaracionjurada_pkey PRIMARY KEY (iddeclaracion);


--
-- TOC entry 3111 (class 2606 OID 25558)
-- Name: declaracionjuradadetalle declaracionjuradadetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaracionjuradadetalle
    ADD CONSTRAINT declaracionjuradadetalle_pkey PRIMARY KEY (iddetdeclaracion);


--
-- TOC entry 3113 (class 2606 OID 25560)
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (iddepartamento);


--
-- TOC entry 3115 (class 2606 OID 25562)
-- Name: cuentadetalle detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentadetalle
    ADD CONSTRAINT detalle_pkey PRIMARY KEY (iddetalle);


--
-- TOC entry 3117 (class 2606 OID 25564)
-- Name: detalleacta detalleacta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalleacta
    ADD CONSTRAINT detalleacta_pkey PRIMARY KEY (iddetalleacta);


--
-- TOC entry 3119 (class 2606 OID 25566)
-- Name: detallerecibo detallerecibo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallerecibo
    ADD CONSTRAINT detallerecibo_pkey PRIMARY KEY (iddetaller);


--
-- TOC entry 3121 (class 2606 OID 25568)
-- Name: determinacion determinacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.determinacion
    ADD CONSTRAINT determinacion_pkey PRIMARY KEY (codigodeterminacion);


--
-- TOC entry 3123 (class 2606 OID 25570)
-- Name: determinaciondetalle determinaciondetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.determinaciondetalle
    ADD CONSTRAINT determinaciondetalle_pkey PRIMARY KEY (iddetdetalle);


--
-- TOC entry 3125 (class 2606 OID 25572)
-- Name: distrito distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (iddistrito);


--
-- TOC entry 3127 (class 2606 OID 25574)
-- Name: documentocoactivo documentocoactivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentocoactivo
    ADD CONSTRAINT documentocoactivo_pkey PRIMARY KEY (iddocumentocoactivo);


--
-- TOC entry 3129 (class 2606 OID 25576)
-- Name: ejecutorcoactivo ejecutorcoactivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ejecutorcoactivo
    ADD CONSTRAINT ejecutorcoactivo_pkey PRIMARY KEY (idejecutarcoactivo);


--
-- TOC entry 3131 (class 2606 OID 25578)
-- Name: institucion institucion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (idinstitucion);


--
-- TOC entry 3133 (class 2606 OID 25580)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (idmodulo);


--
-- TOC entry 3135 (class 2606 OID 25582)
-- Name: motivogastos motivogastos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motivogastos
    ADD CONSTRAINT motivogastos_pkey PRIMARY KEY (idmotivo);


--
-- TOC entry 3137 (class 2606 OID 25584)
-- Name: movimiento movimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_pkey PRIMARY KEY (idmovimiento);


--
-- TOC entry 3139 (class 2606 OID 25586)
-- Name: multatributaria multatributaria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multatributaria
    ADD CONSTRAINT multatributaria_pkey PRIMARY KEY (codigomultatributaria);


--
-- TOC entry 3141 (class 2606 OID 25588)
-- Name: multatributariadetalle multatributariadetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multatributariadetalle
    ADD CONSTRAINT multatributariadetalle_pkey PRIMARY KEY (iddetmultatributaria);


--
-- TOC entry 3143 (class 2606 OID 25590)
-- Name: municipalidad municipalidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipalidad
    ADD CONSTRAINT municipalidad_pkey PRIMARY KEY (idmunicipalidad);


--
-- TOC entry 3145 (class 2606 OID 25592)
-- Name: niveles niveles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles
    ADD CONSTRAINT niveles_pkey PRIMARY KEY (idnivel);


--
-- TOC entry 3147 (class 2606 OID 25594)
-- Name: ordedetalle ordedetalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordedetalle
    ADD CONSTRAINT ordedetalle_pkey PRIMARY KEY (idpagodetalle);


--
-- TOC entry 3149 (class 2606 OID 25596)
-- Name: ordenpago ordenpago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordenpago
    ADD CONSTRAINT ordenpago_pkey PRIMARY KEY (idpago);


--
-- TOC entry 3151 (class 2606 OID 25598)
-- Name: partidapresupuestal partidapresupuestal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidapresupuestal
    ADD CONSTRAINT partidapresupuestal_pkey PRIMARY KEY (idpartida);


--
-- TOC entry 3153 (class 2606 OID 25600)
-- Name: perfilusuario perfilusuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilusuario
    ADD CONSTRAINT perfilusuario_pkey PRIMARY KEY (idtipousuario);


--
-- TOC entry 3155 (class 2606 OID 25602)
-- Name: predios predios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.predios
    ADD CONSTRAINT predios_pkey PRIMARY KEY (idpredio);


--
-- TOC entry 3157 (class 2606 OID 25604)
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (idprovincia);


--
-- TOC entry 3159 (class 2606 OID 25606)
-- Name: recibo recibo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recibo
    ADD CONSTRAINT recibo_pkey PRIMARY KEY (idrecibo);


--
-- TOC entry 3161 (class 2606 OID 25608)
-- Name: regionvalores regionvalores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regionvalores
    ADD CONSTRAINT regionvalores_pkey PRIMARY KEY (idregvalores);


--
-- TOC entry 3163 (class 2606 OID 25610)
-- Name: tributo tributo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tributo
    ADD CONSTRAINT tributo_pkey PRIMARY KEY (idtributo);


--
-- TOC entry 3165 (class 2606 OID 25612)
-- Name: urbanisacion urbanisacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urbanisacion
    ADD CONSTRAINT urbanisacion_pkey PRIMARY KEY (idurb);


--
-- TOC entry 3167 (class 2606 OID 25614)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 3169 (class 2606 OID 25616)
-- Name: valores valores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valores
    ADD CONSTRAINT valores_pkey PRIMARY KEY (idvalor);


--
-- TOC entry 3171 (class 2606 OID 25618)
-- Name: valoresantiguedad valoresantiguedad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valoresantiguedad
    ADD CONSTRAINT valoresantiguedad_pkey PRIMARY KEY (idvaloresantiguedad);


--
-- TOC entry 3173 (class 2606 OID 25620)
-- Name: valoresunitarios valoresunitarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.valoresunitarios
    ADD CONSTRAINT valoresunitarios_pkey PRIMARY KEY (idvalunitario);


-- Completed on 2019-08-09 23:53:12

--
-- PostgreSQL database dump complete
--

