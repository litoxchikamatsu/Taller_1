--------------------------------------------------------
--  File created - Sunday-November-19-2017   
--------------------------------------------------------
DROP VIEW "SYSTEM"."VIEWFACTURAS";
DROP VIEW "SYSTEM"."VIEWACCESORIOSPORDEBAJOTOPE";
DROP TABLE "SYSTEM"."CLIENTES";
DROP TABLE "SYSTEM"."DETALLES_FACTURAS";
DROP TABLE "SYSTEM"."FACTURAS";
DROP TABLE "SYSTEM"."IMPUESTOS";
DROP TABLE "SYSTEM"."FABRICANTES";
DROP TABLE "SYSTEM"."IMPUESTOS_FACTURA";
DROP TABLE "SYSTEM"."OPCIONES";
DROP TABLE "SYSTEM"."VEHICULOS";
DROP TABLE "SYSTEM"."VENDEDORES";
DROP SEQUENCE "SYSTEM"."SEC_CLIENTES";
DROP SEQUENCE "SYSTEM"."SEC_DETALLES_FACTURAS";
DROP SEQUENCE "SYSTEM"."SEC_FABRICANTES";
DROP SEQUENCE "SYSTEM"."SEC_FACTURAS";
DROP SEQUENCE "SYSTEM"."SEC_IMPUESTOS";
DROP SEQUENCE "SYSTEM"."SEC_IMPUESTOS_FACTURA";
DROP SEQUENCE "SYSTEM"."SEC_OPCIONES";
DROP SEQUENCE "SYSTEM"."SEC_VEHICULOS";
DROP SEQUENCE "SYSTEM"."SEC_VENDEDORES";
DROP PROCEDURE "SYSTEM"."PAREORDER_UNITS";
DROP TRIGGER "SYSTEM"."TRUPDATEUNIDADESDISPONIBLES";
--------------------------------------------------------
--  DDL for View VIEWFACTURAS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SYSTEM"."VIEWFACTURAS" ("IDFACTURA", "ID_VENDEDOR", "NOMBREVENDEDOR", "ID_CLIENTE", "NOMBRECLIENTE", "ID_VEHICULO", "MARCAVEHICULO", "FABRICAVEHICULO", "ID_ACCESORIO", "NOMBREACCESORIO") AS 
  Select Facturas.IdFactura,Facturas.Id_Vendedor,Vendedores.NOMBRE NombreVendedor,
Facturas.Id_Cliente,Clientes.Nombre NombreCliente,Facturas.Id_Vehiculo, Fabricantes.Marca MarcaVehiculo,
Fabricantes.Nombre FabricaVehiculo, Opciones.IdOpcion Id_Accesorio, 
NVL(Opciones.Nombre,'') NombreAccesorio
from Facturas
inner join Vendedores on Vendedores.IdVendedor=Facturas.Id_Vendedor
inner join Clientes on Clientes.IdCliente=Facturas.Id_Cliente
inner join Vehiculos on Vehiculos.IdVehiculo=Facturas.Id_Vehiculo
inner join Fabricantes on Fabricantes.IdFabricante=Vehiculos.Id_Fabricante 
left join Detalles_Facturas on Detalles_Facturas.Id_Factura=Facturas.IdFactura
left join Opciones on Opciones.IdOpcion=Detalles_Facturas.Id_Opcion
;
--------------------------------------------------------
--  DDL for View VIEWACCESORIOSPORDEBAJOTOPE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SYSTEM"."VIEWACCESORIOSPORDEBAJOTOPE" ("IDOPCION", "NOMBREPRODUCTO", "CODIGO", "FABRICA", "UNIDADES_DISPONIBLES") AS 
  Select Opciones.IdOpcion,Opciones.NOMBRE NombreProducto, Opciones.CODIGO, Fabricantes.NOMBRE Fabrica, Opciones.UNIDADES_DISPONIBLES
from Opciones
inner join Fabricantes on Fabricantes.IDFABRICANTE=Opciones.ID_FABRICANTE
where Opciones.UNIDADES_DISPONIBLES<5
;
--------------------------------------------------------
--  DDL for Table CLIENTES
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."CLIENTES" 
   (	"IDCLIENTE" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"DIRECCION" VARCHAR2(50 BYTE), 
	"CELULAR" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table DETALLES_FACTURAS
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."DETALLES_FACTURAS" 
   (	"IDDETALLEFACTURA" NUMBER(*,0), 
	"ID_FACTURA" NUMBER(*,0), 
	"ID_OPCION" NUMBER(*,0), 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"COSTOINSTALACION" NUMBER(21,2), 
	"VALOROPCION" NUMBER(21,2)
   ) ;
--------------------------------------------------------
--  DDL for Table FACTURAS
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."FACTURAS" 
   (	"IDFACTURA" NUMBER(*,0), 
	"ID_CLIENTE" NUMBER(*,0), 
	"ID_VEHICULO" NUMBER(*,0), 
	"ID_VENDEDOR" NUMBER(*,0), 
	"ID_VEHICULOINTERCAMBIO" NUMBER(*,0), 
	"VALORTOTAL" NUMBER(21,2)
   ) ;
--------------------------------------------------------
--  DDL for Table IMPUESTOS
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."IMPUESTOS" 
   (	"IDIMPUESTO" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table FABRICANTES
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."FABRICANTES" 
   (	"IDFABRICANTE" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"MARCA" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table IMPUESTOS_FACTURA
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."IMPUESTOS_FACTURA" 
   (	"IDIMPUESTOFACTURA" NUMBER(*,0), 
	"ID_FACTURA" NUMBER(*,0), 
	"ID_IMPUESTO" NUMBER(*,0), 
	"VALOR" NUMBER(21,2)
   ) ;
--------------------------------------------------------
--  DDL for Table OPCIONES
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."OPCIONES" 
   (	"IDOPCION" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"CODIGO" VARCHAR2(20 BYTE), 
	"ID_FABRICANTE" NUMBER(*,0), 
	"UNIDADES_DISPONIBLES" NUMBER(*,0) DEFAULT (30)
   ) ;
--------------------------------------------------------
--  DDL for Table VEHICULOS
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."VEHICULOS" 
   (	"IDVEHICULO" NUMBER(*,0), 
	"VIN" VARCHAR2(50 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"MODELO" VARCHAR2(50 BYTE), 
	"ANIO" VARCHAR2(5 BYTE), 
	"ID_FABRICANTE" NUMBER(*,0), 
	"MONTOPAGADO" CHAR(1 BYTE), 
	"ESTADO" VARCHAR2(20 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table VENDEDORES
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."VENDEDORES" 
   (	"IDVENDEDOR" NUMBER(*,0), 
	"CEDULA" VARCHAR2(20 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Sequence SEC_CLIENTES
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_CLIENTES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_DETALLES_FACTURAS
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_DETALLES_FACTURAS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_FABRICANTES
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_FABRICANTES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_FACTURAS
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_FACTURAS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_IMPUESTOS
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_IMPUESTOS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_IMPUESTOS_FACTURA
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_IMPUESTOS_FACTURA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_OPCIONES
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_OPCIONES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_VEHICULOS
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_VEHICULOS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEC_VENDEDORES
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."SEC_VENDEDORES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
REM INSERTING into SYSTEM.CLIENTES
SET DEFINE OFF;
Insert into SYSTEM.CLIENTES (IDCLIENTE,NOMBRE,DIRECCION,CELULAR) values (1,'Carlos Alberto Correa Ortiz','cll. 108A No. 77-48','3194475488');
Insert into SYSTEM.CLIENTES (IDCLIENTE,NOMBRE,DIRECCION,CELULAR) values (2,'Diana Patricia ','cra. 49A No. 11-07','311 554 8898');
Insert into SYSTEM.CLIENTES (IDCLIENTE,NOMBRE,DIRECCION,CELULAR) values (3,'Sebastián Danilo','cll. 117 no. 53-78','2739187');
REM INSERTING into SYSTEM.DETALLES_FACTURAS
SET DEFINE OFF;
Insert into SYSTEM.DETALLES_FACTURAS (IDDETALLEFACTURA,ID_FACTURA,ID_OPCION,DESCRIPCION,COSTOINSTALACION,VALOROPCION) values (1,2,1,null,0,25000);
REM INSERTING into SYSTEM.FACTURAS
SET DEFINE OFF;
Insert into SYSTEM.FACTURAS (IDFACTURA,ID_CLIENTE,ID_VEHICULO,ID_VENDEDOR,ID_VEHICULOINTERCAMBIO,VALORTOTAL) values (1,1,2,1,null,38000000);
Insert into SYSTEM.FACTURAS (IDFACTURA,ID_CLIENTE,ID_VEHICULO,ID_VENDEDOR,ID_VEHICULOINTERCAMBIO,VALORTOTAL) values (2,2,1,1,null,28000000);
Insert into SYSTEM.FACTURAS (IDFACTURA,ID_CLIENTE,ID_VEHICULO,ID_VENDEDOR,ID_VEHICULOINTERCAMBIO,VALORTOTAL) values (3,3,3,1,null,30000000);
REM INSERTING into SYSTEM.IMPUESTOS
SET DEFINE OFF;
REM INSERTING into SYSTEM.FABRICANTES
SET DEFINE OFF;
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (1,'EnRines',null);
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (2,'Atlas',null);
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (3,'Car Audio',null);
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (4,'DecorInAutos',null);
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (5,'Sofasa','Renault');
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (6,'Kia/Hyundai','Hyundai');
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (7,'Nissan ','Nissan ');
Insert into SYSTEM.FABRICANTES (IDFABRICANTE,NOMBRE,MARCA) values (8,'Toyota','Toyota');
REM INSERTING into SYSTEM.IMPUESTOS_FACTURA
SET DEFINE OFF;
REM INSERTING into SYSTEM.OPCIONES
SET DEFINE OFF;
Insert into SYSTEM.OPCIONES (IDOPCION,NOMBRE,CODIGO,ID_FABRICANTE,UNIDADES_DISPONIBLES) values (1,'Rines 17','001',1,30);
Insert into SYSTEM.OPCIONES (IDOPCION,NOMBRE,CODIGO,ID_FABRICANTE,UNIDADES_DISPONIBLES) values (2,'Rines 10','002',1,24);
Insert into SYSTEM.OPCIONES (IDOPCION,NOMBRE,CODIGO,ID_FABRICANTE,UNIDADES_DISPONIBLES) values (3,'Alarma GPS','003',2,22);
Insert into SYSTEM.OPCIONES (IDOPCION,NOMBRE,CODIGO,ID_FABRICANTE,UNIDADES_DISPONIBLES) values (4,'Radio Pantalla','004',3,20);
Insert into SYSTEM.OPCIONES (IDOPCION,NOMBRE,CODIGO,ID_FABRICANTE,UNIDADES_DISPONIBLES) values (5,'Portabicicletas','005',4,24);
REM INSERTING into SYSTEM.VEHICULOS
SET DEFINE OFF;
Insert into SYSTEM.VEHICULOS (IDVEHICULO,VIN,NOMBRE,MODELO,ANIO,ID_FABRICANTE,MONTOPAGADO,ESTADO) values (1,'8333909','EON','2018','2017',6,'0','Nuevo');
Insert into SYSTEM.VEHICULOS (IDVEHICULO,VIN,NOMBRE,MODELO,ANIO,ID_FABRICANTE,MONTOPAGADO,ESTADO) values (2,'1128427317','LOGAN','2011','2017',5,'1','Intercambio');
Insert into SYSTEM.VEHICULOS (IDVEHICULO,VIN,NOMBRE,MODELO,ANIO,ID_FABRICANTE,MONTOPAGADO,ESTADO) values (3,'1909128','SANDERO','2018','2017',5,'1','Nuevo');
Insert into SYSTEM.VEHICULOS (IDVEHICULO,VIN,NOMBRE,MODELO,ANIO,ID_FABRICANTE,MONTOPAGADO,ESTADO) values (4,'9091128','JUKE','2018','2017',7,'0','Nuevo');
Insert into SYSTEM.VEHICULOS (IDVEHICULO,VIN,NOMBRE,MODELO,ANIO,ID_FABRICANTE,MONTOPAGADO,ESTADO) values (5,'427317909','NOTE','2018','2017',7,'0','Nuevo');
REM INSERTING into SYSTEM.VENDEDORES
SET DEFINE OFF;
Insert into SYSTEM.VENDEDORES (IDVENDEDOR,CEDULA,NOMBRE) values (1,'788999','Mario Prieto');
REM INSERTING into SYSTEM.VIEWFACTURAS
SET DEFINE OFF;
Insert into SYSTEM.VIEWFACTURAS (IDFACTURA,ID_VENDEDOR,NOMBREVENDEDOR,ID_CLIENTE,NOMBRECLIENTE,ID_VEHICULO,MARCAVEHICULO,FABRICAVEHICULO,ID_ACCESORIO,NOMBREACCESORIO) values (3,1,'Mario Prieto',3,'Sebastián Danilo',3,'Renault','Sofasa',null,null);
Insert into SYSTEM.VIEWFACTURAS (IDFACTURA,ID_VENDEDOR,NOMBREVENDEDOR,ID_CLIENTE,NOMBRECLIENTE,ID_VEHICULO,MARCAVEHICULO,FABRICAVEHICULO,ID_ACCESORIO,NOMBREACCESORIO) values (1,1,'Mario Prieto',1,'Carlos Alberto Correa Ortiz',2,'Renault','Sofasa',null,null);
Insert into SYSTEM.VIEWFACTURAS (IDFACTURA,ID_VENDEDOR,NOMBREVENDEDOR,ID_CLIENTE,NOMBRECLIENTE,ID_VEHICULO,MARCAVEHICULO,FABRICAVEHICULO,ID_ACCESORIO,NOMBREACCESORIO) values (2,1,'Mario Prieto',2,'Diana Patricia ',1,'Hyundai','Kia/Hyundai',1,'Rines 17');
REM INSERTING into SYSTEM.VIEWACCESORIOSPORDEBAJOTOPE
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index PK_CLIENTES
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_CLIENTES" ON "SYSTEM"."CLIENTES" ("IDCLIENTE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_DETALLES_FACTURAS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_DETALLES_FACTURAS" ON "SYSTEM"."DETALLES_FACTURAS" ("IDDETALLEFACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_FABRICANTES
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_FABRICANTES" ON "SYSTEM"."FABRICANTES" ("IDFABRICANTE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_FACTURAS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_FACTURAS" ON "SYSTEM"."FACTURAS" ("IDFACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_IMPUESTOS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_IMPUESTOS" ON "SYSTEM"."IMPUESTOS" ("IDIMPUESTO") 
  ;
--------------------------------------------------------
--  DDL for Index PK_IMPUESTOS_FACTURA_FACTURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_IMPUESTOS_FACTURA_FACTURA" ON "SYSTEM"."IMPUESTOS_FACTURA" ("IDIMPUESTOFACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index PK_OPCIONES
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_OPCIONES" ON "SYSTEM"."OPCIONES" ("IDOPCION") 
  ;
--------------------------------------------------------
--  DDL for Index PK_VEHICULOS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_VEHICULOS" ON "SYSTEM"."VEHICULOS" ("IDVEHICULO") 
  ;
--------------------------------------------------------
--  DDL for Index PK_VENDEDORES
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYSTEM"."PK_VENDEDORES" ON "SYSTEM"."VENDEDORES" ("IDVENDEDOR") 
  ;
--------------------------------------------------------
--  DDL for Trigger TRUPDATEUNIDADESDISPONIBLES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "SYSTEM"."TRUPDATEUNIDADESDISPONIBLES" 
AFTER INSERT ON Detalles_Facturas FOR EACH ROW 
begin
    update Opciones set  Opciones.Unidades_Disponibles=Opciones.Unidades_Disponibles-1
    where Opciones.IDOPCION=:new.Id_Opcion;
end;
/
ALTER TRIGGER "SYSTEM"."TRUPDATEUNIDADESDISPONIBLES" ENABLE;
--------------------------------------------------------
--  DDL for Procedure PAREORDER_UNITS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."PAREORDER_UNITS" 
as
begin
    update (Select Opciones.* from Opciones 
    inner join (Select idOpcion from viewAccesoriosPorDebajoTope) Accesorios on Accesorios.idOpcion=Opciones.IDOPCION) Opciones
    set Opciones.UNIDADES_DISPONIBLES= Opciones.UNIDADES_DISPONIBLES+20;
end;

--------------------------------------------------------
--  Constraints for Table CLIENTES
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."CLIENTES" ADD CONSTRAINT "PK_CLIENTES" PRIMARY KEY ("IDCLIENTE") ENABLE;
  ALTER TABLE "SYSTEM"."CLIENTES" MODIFY ("CELULAR" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."CLIENTES" MODIFY ("DIRECCION" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."CLIENTES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."CLIENTES" MODIFY ("IDCLIENTE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DETALLES_FACTURAS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" ADD CONSTRAINT "PK_DETALLES_FACTURAS" PRIMARY KEY ("IDDETALLEFACTURA") ENABLE;
  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" ADD CHECK (ValorOpcion>=0) ENABLE;
  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" ADD CHECK (CostoInstalacion>=0) ENABLE;
  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" MODIFY ("IDDETALLEFACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FACTURAS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."FACTURAS" ADD CONSTRAINT "PK_FACTURAS" PRIMARY KEY ("IDFACTURA") ENABLE;
  ALTER TABLE "SYSTEM"."FACTURAS" ADD CHECK (ValorTotal>=0) ENABLE;
  ALTER TABLE "SYSTEM"."FACTURAS" MODIFY ("VALORTOTAL" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."FACTURAS" MODIFY ("ID_VENDEDOR" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."FACTURAS" MODIFY ("ID_VEHICULO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."FACTURAS" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."FACTURAS" MODIFY ("IDFACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table IMPUESTOS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."IMPUESTOS" ADD CONSTRAINT "PK_IMPUESTOS" PRIMARY KEY ("IDIMPUESTO") ENABLE;
  ALTER TABLE "SYSTEM"."IMPUESTOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."IMPUESTOS" MODIFY ("IDIMPUESTO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FABRICANTES
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."FABRICANTES" ADD CONSTRAINT "PK_FABRICANTES" PRIMARY KEY ("IDFABRICANTE") ENABLE;
  ALTER TABLE "SYSTEM"."FABRICANTES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."FABRICANTES" MODIFY ("IDFABRICANTE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table IMPUESTOS_FACTURA
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" ADD CONSTRAINT "PK_IMPUESTOS_FACTURA_FACTURA" PRIMARY KEY ("IDIMPUESTOFACTURA") ENABLE;
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" ADD CHECK (Valor>=0) ENABLE;
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" MODIFY ("VALOR" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" MODIFY ("ID_IMPUESTO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" MODIFY ("IDIMPUESTOFACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OPCIONES
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."OPCIONES" ADD CHECK (Unidades_disponibles>=0) ENABLE;
  ALTER TABLE "SYSTEM"."OPCIONES" MODIFY ("ID_FABRICANTE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."OPCIONES" MODIFY ("CODIGO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."OPCIONES" MODIFY ("UNIDADES_DISPONIBLES" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."OPCIONES" ADD CONSTRAINT "PK_OPCIONES" PRIMARY KEY ("IDOPCION") ENABLE;
  ALTER TABLE "SYSTEM"."OPCIONES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."OPCIONES" MODIFY ("IDOPCION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VEHICULOS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."VEHICULOS" ADD CONSTRAINT "PK_VEHICULOS" PRIMARY KEY ("IDVEHICULO") ENABLE;
  ALTER TABLE "SYSTEM"."VEHICULOS" ADD CHECK (MontoPagado=1 or MontoPagado=0) ENABLE;
  ALTER TABLE "SYSTEM"."VEHICULOS" ADD CHECK (Estado='Nuevo' or Estado='Intercambio' or Estado='Vendido' ) ENABLE;
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("MONTOPAGADO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("ID_FABRICANTE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("ANIO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("MODELO" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("VIN" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VEHICULOS" MODIFY ("IDVEHICULO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VENDEDORES
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."VENDEDORES" ADD CONSTRAINT "PK_VENDEDORES" PRIMARY KEY ("IDVENDEDOR") ENABLE;
  ALTER TABLE "SYSTEM"."VENDEDORES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VENDEDORES" MODIFY ("CEDULA" NOT NULL ENABLE);
  ALTER TABLE "SYSTEM"."VENDEDORES" MODIFY ("IDVENDEDOR" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table DETALLES_FACTURAS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" ADD CONSTRAINT "FK_DETALLE_FACTURA_ID_FACTURA" FOREIGN KEY ("ID_FACTURA")
	  REFERENCES "SYSTEM"."FACTURAS" ("IDFACTURA") ENABLE;
  ALTER TABLE "SYSTEM"."DETALLES_FACTURAS" ADD CONSTRAINT "FK_DETALLE_FACTURA_ID_OPCION" FOREIGN KEY ("ID_OPCION")
	  REFERENCES "SYSTEM"."OPCIONES" ("IDOPCION") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FACTURAS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."FACTURAS" ADD CONSTRAINT "FK_FACTURAS_ID_CLIENTE" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "SYSTEM"."CLIENTES" ("IDCLIENTE") ENABLE;
  ALTER TABLE "SYSTEM"."FACTURAS" ADD CONSTRAINT "FK_FACTURAS_ID_VEHICULO" FOREIGN KEY ("ID_VEHICULO")
	  REFERENCES "SYSTEM"."VEHICULOS" ("IDVEHICULO") ENABLE;
  ALTER TABLE "SYSTEM"."FACTURAS" ADD CONSTRAINT "FK_FACTURAS_ID_VENDEDOR" FOREIGN KEY ("ID_VENDEDOR")
	  REFERENCES "SYSTEM"."VENDEDORES" ("IDVENDEDOR") ENABLE;
  ALTER TABLE "SYSTEM"."FACTURAS" ADD CONSTRAINT "FK_FACTURA_VEHICULOINTERCAMBIO" FOREIGN KEY ("ID_VEHICULOINTERCAMBIO")
	  REFERENCES "SYSTEM"."VEHICULOS" ("IDVEHICULO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table IMPUESTOS_FACTURA
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" ADD CONSTRAINT "FK_IMPUESTOSFACTURA_IDFACTURA" FOREIGN KEY ("ID_FACTURA")
	  REFERENCES "SYSTEM"."FACTURAS" ("IDFACTURA") ENABLE;
  ALTER TABLE "SYSTEM"."IMPUESTOS_FACTURA" ADD CONSTRAINT "FK_IMPUESTOSFACTURA_IDIMPUESTO" FOREIGN KEY ("ID_IMPUESTO")
	  REFERENCES "SYSTEM"."IMPUESTOS" ("IDIMPUESTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OPCIONES
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."OPCIONES" ADD CONSTRAINT "FK_OPCIONES_ID_FABRICANTE" FOREIGN KEY ("ID_FABRICANTE")
	  REFERENCES "SYSTEM"."FABRICANTES" ("IDFABRICANTE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VEHICULOS
--------------------------------------------------------

  ALTER TABLE "SYSTEM"."VEHICULOS" ADD CONSTRAINT "FK_VEHICULOS_ID_FABRICANTE" FOREIGN KEY ("ID_FABRICANTE")
	  REFERENCES "SYSTEM"."FABRICANTES" ("IDFABRICANTE") ENABLE;
