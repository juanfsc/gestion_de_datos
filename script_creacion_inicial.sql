drop table ForAndIf.Canal
drop table ForAndIf.Cliente
drop table ForAndIf.Descuento_Compra
drop table ForAndIf.Compra_por_producto
drop table ForAndIf.Compra
drop table ForAndIf.Localidad_por_CP
drop table ForAndIf.Envio_disponible_por_CP
drop table ForAndIf.CP
drop table ForAndIf.Descuento
drop table ForAndIf.Descuento_por_venta
drop table ForAndIf.Envio
drop table ForAndIf.Localidad
drop table ForAndIf.Provincia
drop table ForAndIf.Venta
drop table ForAndIf.Cupon
drop table ForAndIf.Cupon_por_venta
drop table ForAndIf.Medio_Pago
drop table ForAndIf.Producto
drop table ForAndIf.Producto_por_variante
drop table ForAndIf.Proveedor
drop table ForAndIf.Tipo_variante
drop table ForAndIf.Variante
drop table ForAndIf.Venta_por_producto

create table ForAndIf.Cliente (
   clie_id decimal(18, 0) not null,
   clie_nombre nvarchar(255) not null,
   clie_apellido nvarchar(255) not null,
   clie_dni decimal(18, 0) not null,
   clie_direccion nvarchar(255) not null,
   clie_telefono decimal(18, 0) not null,
   clie_mail nvarchar(255) not null,
   clie_fecha_nac date not null,
   clie_provincia decimal(18, 0) not null,
   clie_codigo_postal decimal(18, 0) not null,
   clie_localidad decimal(18, 0) not null
)

create table ForAndIf.Provincia (
   prov_id decimal(18, 0) not null,
   prov_nombre nvarchar(255) not null
)

create table ForAndIf.Localidad (
   loca_id decimal(18, 0) not null,
   loca_provincia decimal(18, 0) not null,
   loca_nombre nvarchar(255) not null
)

create table ForAndIf.Localidad_por_CP (
   loca_id decimal(18, 0) not null,
   codi_postal decimal(18, 0) not null,
   loca_nombre nvarchar(255) not null
)

create table ForAndIf.CP (
   codi_postal decimal(18, 0) not null
)

create table ForAndIf.Envio_disponible_por_CP (
   envi_cp_medio decimal(18, 0) not null,
   envi_cp_postal decimal(18, 0) not null,
   envi_cp_costo decimal(18, 2) not null,
   envi_tiempo decimal(18, 2) not null  
)

create table ForAndIf.Canal (
   cana_id decimal(18,0) not null,
   cana_nombre nvarchar(2255) not null,
   cana_costo decimal(18,2) not null
)

create table ForAndIf.Envio (
   envi_medio decimal(18,0) not null,
   envi_costo decimal(18,2) not null,
   envi_nombre nvarchar(255) not null
)

create table ForAndIf.Venta (
   vent_codigo decimal(19, 0) not null,
   vent_fecha date not null,
   vent_cliente decimal(18, 0) not null,
   vent_envio decimal(18, 0) not null,
   vent_medio_pago decimal(18, 0) not null,
   vent_medio_pago_costo decimal(18, 2) not null,
   vent_canal decimal(18, 0) not null,
)

create table ForAndIf.Descuento (
   desc_id decimal(18, 0) not null,
   desc_concepto nvarchar(50) not null
)

create table ForAndIf.Compra (
   comp_numero decimal(19,0) not null,
   comp_fecha date not null,
   comp_proveedor nvarchar(50) not null,
   comp_medio_pago decimal(18,0) not null,
   comp_total decimal(18,2) not null,
)

create table ForAndIf.Descuento_por_venta (
   vent_codigo decimal(19, 0) not null,
   desc_id decimal(18, 0) not null,
   desc_importe decimal(18, 2) not null
)

create table ForAndIf.Descuento_Compra (
   desc_codigo decimal(19,0) not null,
   desc_valor decimal(18,2) not null,
   comp_numero decimal(19,0) not null
)

create table ForAndIf.Medio_Pago (
   medi_id decimal(18, 0) not null,
   medi_pago nvarchar(255) not null,
   medi_costo decimal(18, 2) not null,
   medi_porcentaje_descuento decimal(18, 2) not null
)

create table ForAndIf.Compra_por_producto (
   comp_numero decimal(19, 0) not null,
   prod_codigo nvarchar(50) not null,
   vari_id decimal(18, 0) not null,
   prod_precio_unitario decimal(18, 2) not null,
   prod_cantidad decimal(18, 0) not null
)

create table ForAndIf.Proveedor (
   prov_cuit nvarchar(50) not null,
   prov_razon_social nvarchar(50) not null,
   prov_domicilio nvarchar(50) not null,
   prov_localidad nvarchar(255) not null,
   prov_mail nvarchar(50) not null,
   prov_codigo_postal decimal(18,0) not null,
   prov_provincia nvarchar(255) not null
)

create table ForAndIf.Producto (
   prod_codigo nvarchar(50) not null,
   prod_nombre nvarchar(50) not null,
   prod_descripcion nvarchar(50) not null,
   prod_marca nvarchar(255) not null,
   prod_material nvarchar(50) not null,
   prod_categoria nvarchar(255) not null
)

create table ForAndIf.Producto_por_variante (
   vari_id decimal(18, 0) not null,
   prod_codigo nvarchar(50) not null,
   producto_variante_precio_compra decimal(18, 0) not null,
   producto_variante_precio_venta decimal(18, 0) not null
)

create table ForAndIf.Venta_por_producto (
   vent_codigo decimal(19, 0) not null,
   prod_codigo nvarchar(50) not null,
   vari_id decimal(18, 0) not null,
   prod_precio_unitario decimal(18, 2) not null,
   prod_cantidad decimal(18, 0) not null
)

create table ForAndIf.Variante (
   vari_id decimal(18, 0) not null,
   vari_tipo decimal(18, 0) not null,
   vari_valor decimal(18, 0) not null
)

create table ForAndIf.Tipo_variante (
   tiva_id decimal(18, 0) not null,
   tiva_nombre nvarchar(50) not null
)

create table ForAndIf.Cupon_por_venta (
   cupo_codigo nvarchar(255) not null,
   vent_codigo decimal(19, 0) not null,
   cupo_importe decimal(18, 2) not null
)

create table ForAndIf.Cupon (
   cupo_codigo nvarchar(255) not null,
   cupo_valor decimal(18, 2) not null,
   cupo_tipo nvarchar(50) not null,
   cupo_fecha_desde date not null,
   cupo_fecha_hasta date not null
)

--Primary Keys
alter table ForAndIf.Cliente add constraint pk_cliente primary key (clie_id)
alter table ForAndIf.Provincia add constraint pk_provincia primary key (prov_id)
alter table ForAndIf.Compra add constraint pk_compra primary key (comp_numero)
alter table ForAndIf.Localidad add constraint pk_localidad primary key (loca_id)
alter table ForAndIf.Localidad_por_CP add constraint pk_loca_id_codi_postal primary key (loca_id, codi_postal)
alter table ForAndIf.CP add constraint pk_codi_postal primary key (codi_postal)
alter table ForAndIf.Descuento_por_venta add constraint pk_descuento_por_venta primary key (vent_codigo, desc_id)
alter table ForAndIf.Envio add constraint pk_envio primary key (envi_medio)
alter table ForAndIf.Descuento add constraint pk_descuento primary key (desc_id)
alter table ForAndIf.Canal add constraint pk_canal primary key (cana_id)
alter table ForAndIf.Venta add constraint pk_venta primary key (vent_codigo)
alter table ForAndIf.Medio_Pago add constraint pk_medio_pago primary key (medi_id)
alter table ForAndIf.Descuento_Compra add constraint pk_descuento_compra primary key (desc_codigo)
alter table ForAndIf.Producto add constraint pk_producto primary key (prod_codigo)
alter table ForAndIf.Proveedor add constraint pk_proveedor primary key (prov_cuit)
alter table ForAndIf.Compra_por_producto add constraint pk_compra_por_producto primary key (comp_numero, prod_codigo, vari_id)
alter table ForAndIf.Variante add constraint pk_variante primary key (vari_id)
alter table ForAndIf.Tipo_variante add constraint pk_tipo_variante primary key (tiva_id)
alter table ForAndIf.Producto_por_variante add constraint pk_producto_por_variante primary key (vari_id, prod_codigo)
alter table ForAndIf.Venta_por_producto add constraint pk_venta_por_producto primary key (vent_codigo, prod_codigo, vari_id)
alter table ForAndIf.Cupon_por_venta add constraint pk_cupon_por_venta primary key (cupo_codigo, vent_codigo)
alter table ForAndIf.Cupon add constraint pk_cupon primary key (cupo_codigo)
alter table ForAndIf.Envio_disponible_por_CP add constraint pk_envio_disponible_por_cp primary key (envi_cp_medio, envi_cp_postal)

--Foreign Keys
alter table ForAndIf.Localidad add constraint fk_loca_provincia foreign key (loca_provincia) 
	references ForAndIf.Provincia (prov_id)
alter table ForAndIf.Localidad_por_CP add constraint fk_localidad_por_cp_loca_id foreign key (loca_id) 
	references ForAndIf.Localidad (loca_id)
alter table ForAndIf.Localidad_por_CP add constraint fk_localidad_por_cp_codi_postal foreign key (codi_postal) 
	references ForAndIf.CP (codi_postal)
alter table ForAndIf.Envio_disponible_por_CP add constraint fk_envio_disponible_por_cp_postal foreign key (envi_cp_postal) 
	references ForAndIf.CP (codi_postal)
alter table ForAndIf.Envio_disponible_por_CP add constraint fk_envio_disponible_por_cp_medio foreign key (envi_cp_medio) 
	references ForAndIf.Envio (envi_medio)
alter table ForAndIf.Cliente add constraint fk_clie_codigo_postal foreign key (clie_codigo_postal)
   references ForAndIf.CP (codi_postal)
alter table ForAndIf.Cliente add constraint fk_clie_provincia foreign key (clie_provincia) 
	references ForAndIf.Provincia (prov_id)
alter table ForAndIf.Cliente add constraint fk_clie_localidad foreign key (clie_localidad) 
	references ForAndIf.Localidad (loca_id)
alter table ForAndIf.Descuento_por_venta add constraint fk_descuento_hacia_venta foreign key (vent_codigo) 
	references ForAndIf.Venta (vent_codigo)
alter table ForAndIf.Descuento_por_venta add constraint fk_venta_hacia_descuento foreign key (desc_id) 
	references ForAndIf.Descuento (desc_id)
alter table ForAndIf.Descuento_Compra add constraint fk_descuento_compra_compra foreign key (comp_numero) 
	references ForAndIf.Compra (comp_numero)   
alter table ForAndIf.Compra add constraint fk_compra_proveedor foreign key (comp_proveedor) 
	references ForAndIf.Proveedor (prov_cuit)
alter table ForAndIf.Compra add constraint fk_compra_medio_pago foreign key (comp_medio_pago) 
   references ForAndIf.Medio_Pago (medi_id)
alter table ForAndIf.Variante add constraint fk_variante_cupon foreign key (vari_tipo)
   references ForAndIf.Tipo_variante (tiva_id)
alter table ForAndIf.Producto_por_variante add constraint fk_producto_por_variante_variante foreign key (vari_id)
   references ForAndIf.Variante (vari_id)
alter table ForAndIf.Producto_por_variante add constraint fk_producto_por_variante_producto foreign key (prod_codigo)
   references ForAndIf.Producto (prod_codigo)
alter table ForAndIf.Compra_por_producto add constraint fk_compra_numero foreign key (comp_numero)
   references ForAndIf.Compra (comp_numero)
alter table ForAndIf.Compra_por_producto add constraint fk_variante_id_codigo_cupon foreign key (vari_id, prod_codigo)
   references ForAndIf.Producto_por_variante (vari_id, prod_codigo)
alter table ForAndIf.Venta_por_producto add constraint fk_venta_hacia_producto foreign key (vent_codigo)
   references ForAndIf.Venta (vent_codigo)
alter table ForAndIf.Venta_por_producto add constraint fk_producto_hacia_venta foreign key (vari_id, prod_codigo)
   references ForAndIf.Producto_por_variante (vari_id, prod_codigo)
alter table ForAndIf.Cupon_por_venta add constraint fk_cupon_hacia_venta foreign key (vent_codigo)
   references ForAndIf.Venta (vent_codigo)
alter table ForAndIf.Cupon_por_venta add constraint fk_venta_hacia_cupon foreign key (cupo_codigo)
   references ForAndIf.Cupon (cupo_codigo)
alter table ForAndIf.Venta add constraint fk_venta_cliente foreign key (vent_cliente)
   references ForAndIf.Cliente (clie_id)
alter table ForAndIf.Venta add constraint fk_venta_envio foreign key (vent_envio)
   references ForAndIf.Envio (envi_medio)
alter table ForAndIf.Venta add constraint fk_venta_medio_pago foreign key (vent_medio_pago)
   references ForAndIf.Medio_Pago (medi_id)
alter table ForAndIf.Venta add constraint fk_venta_canal foreign key (vent_canal)
   references ForAndIf.Canal (cana_id)