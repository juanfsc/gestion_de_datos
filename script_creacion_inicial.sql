use GD2C2022
go

create schema ForAndIf
GO

create table ForAndIf.Cliente (
   clie_id decimal(18, 0) not null identity(1, 1),
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
   prov_id decimal(18, 0) not null identity(1, 1),
   prov_nombre nvarchar(255) not null
)

create table ForAndIf.Localidad (
   loca_id decimal(18, 0) not null identity(1, 1),
   loca_provincia decimal(18, 0) not null,
   loca_nombre nvarchar(255) not null
)

create table ForAndIf.Localidad_por_CP (
   loca_id decimal(18, 0) not null,
   codi_postal decimal(18, 0) not null
)

create table ForAndIf.CP (
   codi_postal decimal(18, 0) not null
)

create table ForAndIf.Envio_disponible_por_localidad_y_CP (
   envi_cp_medio decimal(18, 0) not null,
   envi_cp_localidad decimal(18, 0) not null,
   envi_cp_postal decimal(18, 0) not null,
   envi_cp_costo decimal(18, 2) not null,
   envi_tiempo decimal(18, 2)
)

create table ForAndIf.Canal (
   cana_id decimal(18,0) not null identity(1,1),
   cana_nombre nvarchar(2255) not null,
   cana_costo decimal(18,2) not null
)

create table ForAndIf.Envio (
   envi_medio decimal(18,0) not null identity(1, 1),
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
   vent_canal_costo decimal(18, 0) not null,
   vent_total decimal(18, 2) not null
)

create table ForAndIf.Descuento (
   desc_id decimal(18, 0) not null identity(1, 1),
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
   medi_id decimal(18, 0) not null identity(1, 1),
   medi_pago nvarchar(255) not null,
   medi_costo decimal(18, 2) not null,
   medi_porcentaje_descuento decimal(18, 2)
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
   prov_localidad decimal(18, 0) not null,
   prov_mail nvarchar(50) not null,
   prov_codigo_postal decimal(18,0) not null,
   prov_provincia decimal(18, 0) not null
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
   vari_id decimal(18, 0) not null identity(1, 1),
   vari_tipo decimal(18, 0) not null,
   vari_valor nvarchar(50) not null
)

create table ForAndIf.Tipo_variante (
   tiva_id decimal(18, 0) not null identity(1, 1),
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
go

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
alter table ForAndIf.Envio_disponible_por_localidad_y_CP add constraint pk_envio_disponible_por_localidad_y_cp primary key (envi_cp_medio, envi_cp_localidad, envi_cp_postal)
go
--Foreign Keys
alter table ForAndIf.Localidad add constraint fk_loca_provincia foreign key (loca_provincia)
	references ForAndIf.Provincia (prov_id)
alter table ForAndIf.Localidad_por_CP add constraint fk_localidad_por_cp_loca_id foreign key (loca_id)
	references ForAndIf.Localidad (loca_id)
alter table ForAndIf.Localidad_por_CP add constraint fk_localidad_por_cp_codi_postal foreign key (codi_postal)
	references ForAndIf.CP (codi_postal)
alter table ForAndIf.Envio_disponible_por_localidad_y_CP add constraint fk_envio_disponible_por_localidad_y_cp_postal foreign key (envi_cp_localidad, envi_cp_postal)
	references ForAndIf.Localidad_por_CP (loca_id, codi_postal)
alter table ForAndIf.Envio_disponible_por_localidad_y_CP add constraint fk_envio_disponible_por_localidad_y_cp_medio foreign key (envi_cp_medio)
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
alter table ForAndIf.Compra_por_producto add constraint fk_producto_hacia_compra foreign key (comp_numero)
   references ForAndIf.Compra (comp_numero)
alter table ForAndIf.Compra_por_producto add constraint fk_compra_hacia_producto foreign key (vari_id, prod_codigo)
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
alter table ForAndIf.Proveedor add constraint fk_prov_provincia foreign key (prov_provincia)
   references ForAndIf.Provincia (prov_id)
alter table ForAndIf.Proveedor add constraint fk_prov_localidad foreign key (prov_localidad)
   references ForAndIf.Localidad (loca_id)
alter table ForAndIf.Proveedor add constraint fk_prov_cp foreign key (prov_codigo_postal)
   references ForAndIf.CP (codi_postal)
---DEFINICION FUNCTIONS
GO

create function ForAndIf.obtener_id_provincia (@prov_nombre nvarchar(255)) RETURNS decimal(18, 0) AS
begin
    DECLARE @id INTEGER;
    SET @id =  ( select prov_id from ForAndIf.Provincia
        where @prov_nombre = prov_nombre)
    RETURN @id
end
go

create function ForAndIf.obtener_id_localidad (@prov_nombre nvarchar(255), @loca_nombre nvarchar(255)) RETURNS decimal(18, 0) AS
begin
    DECLARE @id INTEGER;
    SET @id = ( select loca_id from ForAndIf.Localidad join ForAndIf.Provincia
        on loca_provincia = prov_id
        where prov_nombre=@prov_nombre and loca_nombre=@loca_nombre)
    RETURN @id
end
go

create function ForAndIf.obtener_id_variante (@vari_valor nvarchar(50), @tiva_nombre nvarchar(50)) returns decimal(18, 0) as
begin
    DECLARE @id INTEGER;
    SET @id = (select vari_id from ForAndIf.Variante
        join ForAndIf.Tipo_variante on vari_tipo = tiva_id
        where tiva_nombre = @tiva_nombre and vari_valor = @vari_valor)
    RETURN @id
end
go


create function ForAndIf.suma_descuento_importe_medio_pago (@medi_pago nvarchar(255)) returns decimal(18, 2) as
begin
    declare @suma decimal(18, 2)
    set @suma = (select sum(VENTA_DESCUENTO_IMPORTE) from gd_esquema.Maestra
                where VENTA_DESCUENTO_CONCEPTO = @medi_pago)
                return @suma
end
go

create function ForAndIf.suma_consumo_medio_pago (@medi_pago nvarchar(255)) returns decimal(18, 2) as
begin
    declare @suma decimal(18, 2)
    set @suma = (select sum(prod_cantidad * prod_precio_unitario) from ForAndIf.Venta v1
                join ForAndIf.Venta_por_producto v2 on v1.vent_codigo = v2.vent_codigo
                where v1.vent_codigo in (
                    select VENTA_CODIGO from gd_esquema.Maestra
                    where VENTA_DESCUENTO_CONCEPTO = @medi_pago))
    return @suma
end
go

create function ForAndIf.porcentaje_medio_pago (@medi_pago nvarchar(255)) returns decimal(18, 2) as
begin

    return  isnull(ForAndIf.suma_descuento_importe_medio_pago (@medi_pago) / ForAndIf.suma_consumo_medio_pago (@medi_pago),0)
end
go

create function ForAndIf.id_descuento (@desc_concepto nvarchar(50)) returns decimal(18, 0) as
begin
    declare @id decimal(18, 0)
    set @id = (select desc_id from ForAndIf.Descuento
    where desc_concepto = @desc_concepto)
    return @id
end
go

create function ForAndIf.porcentaje_descuento (@id decimal(19, 0), @desc_importe decimal(18, 2)) returns decimal(18, 2) as
begin
    declare @porcentaje decimal(18, 2)
    set @porcentaje = @desc_importe / (select vent_total from ForAndIf.Venta where vent_codigo = @id) 
    return @porcentaje
end
go

---DEFINICION PROCEDURES
create proc ForAndIf.migrar_tipo_variante as
begin
    insert ForAndIf.Tipo_variante (tiva_nombre) (
        select distinct PRODUCTO_TIPO_VARIANTE from gd_esquema.Maestra
        where PRODUCTO_TIPO_VARIANTE is not null
    )
end
go

create proc ForAndIf.migrar_variante as
begin
    declare @id_tipo_variante decimal(18, 0)
    declare @tipo_variante nvarchar(50)
    declare @variante nvarchar(50)

    declare cursor_variante cursor for (
        select PRODUCTO_TIPO_VARIANTE, PRODUCTO_VARIANTE from gd_esquema.Maestra
        where PRODUCTO_TIPO_VARIANTE is not null and PRODUCTO_VARIANTE is not null
        GROUP BY PRODUCTO_TIPO_VARIANTE, PRODUCTO_VARIANTE
    )
    open cursor_variante

    fetch next from cursor_variante into @tipo_variante, @variante

    while @@FETCH_STATUS = 0
    BEGIN
        set @id_tipo_variante = (
            select tiva_id from ForAndIf.Tipo_variante
            where tiva_nombre = @tipo_variante
        )
        insert ForAndIf.Variante (vari_tipo, vari_valor) values (@id_tipo_variante, @variante)
        fetch next from cursor_variante into @tipo_variante, @variante
    END

    close cursor_variante
    deallocate cursor_variante
end
go

create proc ForAndIf.migrar_producto as
begin
    insert ForAndIf.Producto (prod_codigo, prod_nombre, prod_descripcion, prod_marca, prod_material, prod_categoria) (
        select PRODUCTO_CODIGO, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_MATERIAL, PRODUCTO_CATEGORIA from gd_esquema.Maestra
        WHERE PRODUCTO_CODIGO is not null and PRODUCTO_NOMBRE is not null and PRODUCTO_DESCRIPCION is not null and PRODUCTO_MARCA is not null and PRODUCTO_MATERIAL is not null and PRODUCTO_CATEGORIA is not null
        GROUP BY PRODUCTO_CODIGO, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_MATERIAL, PRODUCTO_CATEGORIA
    )
end
go

create proc ForAndIf.migrar_provincia as
begin
    insert ForAndIf.Provincia (prov_nombre) (
        select distinct PROVEEDOR_PROVINCIA from gd_esquema.Maestra
        where PROVEEDOR_PROVINCIA is not null
        union
        select distinct CLIENTE_PROVINCIA  from gd_esquema.Maestra
        where CLIENTE_PROVINCIA is not null
    )
end
go

create proc ForAndIf.migrar_localidad as
begin
    insert ForAndIf.Localidad (loca_provincia, loca_nombre) (
    select
    ForAndIf.obtener_id_provincia(CLIENTE_PROVINCIA), 
    CLIENTE_LOCALIDAD from gd_esquema.Maestra
    where CLIENTE_LOCALIDAD is not null and CLIENTE_PROVINCIA is not null
    group by CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA
    union
    select
    ForAndIf.obtener_id_provincia(PROVEEDOR_PROVINCIA), 
    PROVEEDOR_LOCALIDAD from gd_esquema.Maestra
    where PROVEEDOR_LOCALIDAD is not null and PROVEEDOR_PROVINCIA is not null
    group by PROVEEDOR_LOCALIDAD, PROVEEDOR_PROVINCIA 
    )
end
go

create proc ForAndIf.migrar_cupon as
begin
    insert ForAndIf.Cupon (cupo_codigo, cupo_valor, cupo_tipo, cupo_fecha_desde, cupo_fecha_hasta) (
        select VENTA_CUPON_CODIGO, VENTA_CUPON_VALOR, VENTA_CUPON_TIPO, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA from gd_esquema.Maestra
        where VENTA_CUPON_CODIGO is not null and VENTA_CUPON_FECHA_DESDE is not null and VENTA_CUPON_FECHA_HASTA is not null and VENTA_CUPON_TIPO is not null and VENTA_CUPON_VALOR is not null
        group by VENTA_CUPON_CODIGO, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA, VENTA_CUPON_TIPO, VENTA_CUPON_VALOR 
    )
end
go

create proc ForAndIf.migrar_CP as
begin
    insert ForAndIf.CP (codi_postal) (
        select distinct PROVEEDOR_CODIGO_POSTAL from gd_esquema.Maestra
        where PROVEEDOR_CODIGO_POSTAL is not null
        union
        select distinct cliente_codigo_postal from gd_esquema.Maestra
        where CLIENTE_CODIGO_POSTAL is not null 
    )
end
go

create proc ForAndIf.migrar_localidad_por_CP as
begin
    insert ForAndIf.Localidad_por_CP (loca_id, codi_postal) (
    select (
        select loca_id from ForAndIf.Localidad
        where CLIENTE_LOCALIDAD = loca_nombre
        and CLIENTE_PROVINCIA = (
            select prov_nombre from ForAndIf.Provincia
            where prov_id = loca_provincia
        )
    ), CLIENTE_CODIGO_POSTAL from gd_esquema.Maestra
    where CLIENTE_LOCALIDAD is not null and CLIENTE_CODIGO_POSTAL is not null
    group by CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, CLIENTE_PROVINCIA
    union
    select (
        select loca_id from ForAndIf.Localidad
        where PROVEEDOR_LOCALIDAD = loca_nombre
        and PROVEEDOR_PROVINCIA = (
            select prov_nombre from ForAndIf.Provincia
            where prov_id = loca_provincia
        )
    ), PROVEEDOR_CODIGO_POSTAL from gd_esquema.Maestra
    where PROVEEDOR_LOCALIDAD is not null and PROVEEDOR_CODIGO_POSTAL is not null
    group by PROVEEDOR_LOCALIDAD, PROVEEDOR_CODIGO_POSTAL, PROVEEDOR_PROVINCIA
    )
end
go

create proc ForAndIf.migrar_descuento as
begin
    insert ForAndIf.Descuento (desc_concepto) (
        select distinct VENTA_DESCUENTO_CONCEPTO from gd_esquema.Maestra
        where VENTA_DESCUENTO_CONCEPTO IS NOT NULL
    )
end
go

create proc ForAndIf.migrar_canal as
begin
    insert ForAndIf.Canal (cana_nombre, cana_costo) (
    select VENTA_CANAL, VENTA_CANAL_COSTO from gd_esquema.Maestra
    where VENTA_CANAL is not null and VENTA_CANAL_COSTO is not null
    group by VENTA_CANAL, VENTA_CANAL_COSTO 
    ) 
end
go

create proc ForAndIf.migrar_envio as
begin
    insert ForAndIf.Envio (envi_nombre) (
        select distinct VENTA_MEDIO_ENVIO from gd_esquema.Maestra
        where VENTA_MEDIO_ENVIO IS NOT NULL
        group by VENTA_MEDIO_ENVIO
    )
end
go

create proc ForAndIf.migrar_envio_disponible_por_localidad_y_CP as
begin
    insert ForAndIf.Envio_disponible_por_localidad_y_CP (envi_cp_medio, envi_cp_localidad, envi_cp_postal, envi_cp_costo, envi_tiempo) (
        select (
            select envi_medio from ForAndIf.Envio
            where envi_nombre = VENTA_MEDIO_ENVIO
        
        ), 
        ForAndIf.obtener_id_localidad(CLIENTE_PROVINCIA, CLIENTE_LOCALIDAD),
        CLIENTE_CODIGO_POSTAL,
        VENTA_ENVIO_PRECIO,
        /*(
            select top 1 VENTA_ENVIO_PRECIO from gd_esquema.Maestra m2
            where m1.CLIENTE_CODIGO_POSTAL = m2.CLIENTE_CODIGO_POSTAL
            and m1.VENTA_MEDIO_ENVIO = m2.VENTA_MEDIO_ENVIO
            order by VENTA_FECHA desc
        )
        CHEQUEAR CADENA DE MAILS:https://groups.google.com/u/0/g/gestiondedatos/c/qTmHCd7HjTE?hl=es
        NO HACE FALTA ESTA SUBQUERY PORQUE NO EXISTEN MULTIPLES PRECIOS PARA UN CODIGO POSTAL Y MEDIO ENVIO, VALIDADO CON LA QUERY:
        select CLIENTE_PROVINCIA, CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, VENTA_MEDIO_ENVIO  from gd_esquema.Maestra
        group by CLIENTE_PROVINCIA, CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL, VENTA_MEDIO_ENVIO 
        HAVING COUNT(DISTINCT VENTA_ENVIO_PRECIO)>1
        ORDER BY CLIENTE_CODIGO_POSTAL
        */
        NULL from gd_esquema.Maestra m1
        where VENTA_MEDIO_ENVIO is not null and CLIENTE_LOCALIDAD is not null and CLIENTE_CODIGO_POSTAL is not null and VENTA_ENVIO_PRECIO is not null 
        group by VENTA_MEDIO_ENVIO, CLIENTE_CODIGO_POSTAL, CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA, VENTA_ENVIO_PRECIO
    )
end
go

create proc ForAndIf.migrar_medio_pago as
begin
    insert ForAndIf.Medio_Pago (medi_pago, medi_costo, medi_porcentaje_descuento) (
        select VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO, NULL from gd_esquema.Maestra
        group by VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO 
        having VENTA_MEDIO_PAGO is not null and VENTA_MEDIO_PAGO_COSTO is not null
        union
        select COMPRA_MEDIO_PAGO, NULL,  NULL from gd_esquema.Maestra
        group by COMPRA_MEDIO_PAGO
        having COMPRA_MEDIO_PAGO is not null and COMPRA_MEDIO_PAGO not in (select VENTA_MEDIO_PAGO from gd_esquema.Maestra
        group by VENTA_MEDIO_PAGO
        having VENTA_MEDIO_PAGO is not null)
    )
end
go

create proc ForAndIf.migrar_proveedor as
begin
    insert ForAndIf.Proveedor (prov_cuit, prov_razon_social, prov_domicilio, prov_localidad, prov_mail, prov_codigo_postal, prov_provincia) (
    select PROVEEDOR_CUIT, PROVEEDOR_RAZON_SOCIAL, PROVEEDOR_DOMICILIO, 
    (select loca_id from ForAndIf.Localidad where loca_nombre = PROVEEDOR_LOCALIDAD and loca_provincia = (select p.prov_id from ForAndIf.Provincia as p where p.prov_nombre = PROVEEDOR_PROVINCIA)), 
    PROVEEDOR_MAIL, 
    PROVEEDOR_CODIGO_POSTAL,
    ForAndIf.obtener_id_provincia(PROVEEDOR_PROVINCIA)
    from gd_esquema.Maestra
    where PROVEEDOR_CUIT is not null
    group by PROVEEDOR_CUIT, PROVEEDOR_RAZON_SOCIAL, PROVEEDOR_DOMICILIO, PROVEEDOR_LOCALIDAD, PROVEEDOR_MAIL, PROVEEDOR_CODIGO_POSTAL, PROVEEDOR_PROVINCIA
    )
end
go

create proc ForAndIf.migrar_cliente as
begin
    insert ForAndIf.Cliente (clie_nombre, clie_apellido, clie_dni, clie_direccion, clie_telefono, clie_mail, clie_fecha_nac, clie_provincia, clie_codigo_postal, clie_localidad) (
        select CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_DIRECCION, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NAC, ForAndIf.obtener_id_provincia(CLIENTE_PROVINCIA), CLIENTE_CODIGO_POSTAL, ForAndIf.obtener_id_localidad(CLIENTE_PROVINCIA, CLIENTE_LOCALIDAD)
        from gd_esquema.Maestra
        where CLIENTE_DNI IS NOT NULL AND CLIENTE_APELLIDO IS NOT NULL AND CLIENTE_DNI IS NOT NULL AND CLIENTE_DIRECCION IS NOT NULL AND CLIENTE_TELEFONO IS NOT NULL AND CLIENTE_MAIL IS NOT NULL AND CLIENTE_FECHA_NAC IS NOT NULL AND CLIENTE_PROVINCIA IS NOT NULL AND (CLIENTE_CODIGO_POSTAL) IS NOT NULL AND (CLIENTE_LOCALIDAD) IS NOT NULL
        group by CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_DIRECCION, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NAC, CLIENTE_PROVINCIA, CLIENTE_CODIGO_POSTAL, CLIENTE_LOCALIDAD
    )
end
go

create proc ForAndIf.migrar_compra as
begin
    insert ForAndIf.Compra (comp_numero, comp_fecha, comp_proveedor, comp_medio_pago, comp_total) (
        select COMPRA_NUMERO, COMPRA_FECHA, PROVEEDOR_CUIT,
        (
            select medi_id from ForAndIf.Medio_pago
            where medi_pago = COMPRA_MEDIO_PAGO
        ),
        COMPRA_TOTAL 
        from gd_esquema.Maestra
        where COMPRA_NUMERO is not null and COMPRA_FECHA is not null and PROVEEDOR_CUIT is not null and COMPRA_MEDIO_PAGO is not null and COMPRA_TOTAL is not null
        group by COMPRA_NUMERO, COMPRA_FECHA, PROVEEDOR_CUIT, COMPRA_MEDIO_PAGO, COMPRA_TOTAL
    )
end
go

create proc ForAndIf.migrar_producto_por_variante as
begin
    insert ForAndIf.Producto_por_variante (vari_id, prod_codigo, producto_variante_precio_compra, producto_variante_precio_venta) (
        select 
        ForAndIf.obtener_id_variante(PRODUCTO_VARIANTE, PRODUCTO_TIPO_VARIANTE), PRODUCTO_CODIGO,
        (
            select top 1 COMPRA_PRODUCTO_PRECIO from gd_esquema.Maestra M2
            where COMPRA_PRODUCTO_PRECIO is not null
            and M1.PRODUCTO_CODIGO = M2.PRODUCTO_CODIGO
            and M1.PRODUCTO_VARIANTE = M2.PRODUCTO_VARIANTE
            order by COMPRA_FECHA desc
        ),
        (
            select top 1 VENTA_PRODUCTO_PRECIO from gd_esquema.Maestra M2
            where VENTA_PRODUCTO_PRECIO is not null
            and M1.PRODUCTO_CODIGO = M2.PRODUCTO_CODIGO
            and M1.PRODUCTO_VARIANTE = M2.PRODUCTO_VARIANTE
            order by VENTA_FECHA desc
        )
        from gd_esquema.Maestra M1
        where PRODUCTO_CODIGO is not null and PRODUCTO_VARIANTE is not null
        group by PRODUCTO_CODIGO, PRODUCTO_TIPO_VARIANTE, PRODUCTO_VARIANTE
    )
end
go

create proc ForAndIf.migrar_compra_por_producto as
begin
    insert ForAndIf.Compra_por_producto (comp_numero, prod_codigo, vari_id, prod_precio_unitario, prod_cantidad) (
        select COMPRA_NUMERO, PRODUCTO_CODIGO, 
        ForAndIf.obtener_id_variante(PRODUCTO_VARIANTE, PRODUCTO_TIPO_VARIANTE),
        COMPRA_PRODUCTO_PRECIO, sum(COMPRA_PRODUCTO_CANTIDAD)
        from gd_esquema.Maestra
        where COMPRA_NUMERO is not null and PRODUCTO_CODIGO is not null and PRODUCTO_TIPO_VARIANTE is not null and PRODUCTO_VARIANTE is not null and COMPRA_PRODUCTO_PRECIO is not null and COMPRA_PRODUCTO_CANTIDAD is not null
        group by COMPRA_NUMERO, PRODUCTO_CODIGO, PRODUCTO_TIPO_VARIANTE, PRODUCTO_VARIANTE, COMPRA_PRODUCTO_PRECIO
    )
end
go

create proc ForAndIf.migrar_venta as
begin
    insert ForAndIf.Venta (vent_codigo, vent_fecha, vent_cliente, vent_envio, vent_medio_pago, vent_medio_pago_costo, vent_canal, vent_canal_costo, vent_total) (
        select VENTA_CODIGO, VENTA_FECHA,
        (
            select clie_id from ForAndIf.Cliente
            where clie_dni = CLIENTE_DNI
            and clie_nombre = CLIENTE_NOMBRE
            and clie_apellido = CLIENTE_APELLIDO
        ),
        (
            select envi_medio from ForAndIf.Envio
            where envi_nombre = VENTA_MEDIO_ENVIO
        ),
        (
            select medi_id from ForAndIf.Medio_Pago
            where medi_pago = VENTA_MEDIO_PAGO
        ), 
        VENTA_MEDIO_PAGO_COSTO, 
        (
            select cana_id from ForAndIf.Canal
            where cana_nombre = VENTA_CANAL
        ),
        VENTA_CANAL_COSTO, VENTA_TOTAL
        from gd_esquema.Maestra
        where VENTA_CODIGO is not null and VENTA_FECHA is not null and CLIENTE_DNI is not null and CLIENTE_NOMBRE is not null and CLIENTE_APELLIDO is not null and VENTA_MEDIO_ENVIO is not null and VENTA_MEDIO_PAGO is not null and VENTA_MEDIO_PAGO_COSTO is not null and VENTA_CANAL is not null and VENTA_CANAL_COSTO is not null and VENTA_TOTAL is not null
        group by VENTA_CODIGO, VENTA_FECHA, CLIENTE_DNI, CLIENTE_NOMBRE, CLIENTE_APELLIDO, VENTA_MEDIO_ENVIO, VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO, VENTA_CANAL, VENTA_CANAL_COSTO, VENTA_TOTAL
    )
end
go

create proc ForAndIf.migrar_venta_por_producto as
begin
    insert ForAndIf.Venta_por_producto (vent_codigo, prod_codigo, vari_id, prod_precio_unitario, prod_cantidad) (
        select VENTA_CODIGO, PRODUCTO_CODIGO, ForAndIf.obtener_id_variante(PRODUCTO_VARIANTE, PRODUCTO_TIPO_VARIANTE),

        VENTA_PRODUCTO_PRECIO, 
        sum(VENTA_PRODUCTO_CANTIDAD)
        from gd_esquema.Maestra
        where VENTA_CODIGO is not null and PRODUCTO_CODIGO is not null and PRODUCTO_VARIANTE is not null AND PRODUCTO_TIPO_VARIANTE is not null and VENTA_PRODUCTO_PRECIO is not null and VENTA_PRODUCTO_CANTIDAD is not null
        group by VENTA_CODIGO, PRODUCTO_CODIGO, PRODUCTO_VARIANTE, PRODUCTO_TIPO_VARIANTE, VENTA_PRODUCTO_PRECIO
    )
end
go

create proc ForAndIf.migrar_cupon_por_venta as
begin
    insert ForAndIf.Cupon_por_venta (cupo_codigo, vent_codigo, cupo_importe) (
        select VENTA_CUPON_CODIGO, VENTA_CODIGO, VENTA_CUPON_IMPORTE
        from gd_esquema.Maestra
        where VENTA_CUPON_CODIGO is not null AND VENTA_CODIGO is not null AND VENTA_CUPON_IMPORTE  is not null
        group by VENTA_CUPON_CODIGO, VENTA_CODIGO, VENTA_CUPON_IMPORTE
    )
end
go

create proc ForAndIf.migrar_descuento_por_venta as
begin    
    insert ForAndIf.Descuento_por_venta (vent_codigo, desc_id, desc_importe) (   
        select VENTA_CODIGO,
        ForAndIf.id_descuento(VENTA_DESCUENTO_CONCEPTO),
        VENTA_DESCUENTO_IMPORTE
        from gd_esquema.Maestra
        where VENTA_CODIGO is not null and VENTA_DESCUENTO_CONCEPTO is not null
        group by VENTA_CODIGO, VENTA_DESCUENTO_CONCEPTO, VENTA_DESCUENTO_IMPORTE)
end
go

create proc ForAndIf.migrar_descuento_compra as
begin    
    insert ForAndIf.Descuento_Compra(desc_codigo, desc_valor, comp_numero) (   
        select DESCUENTO_COMPRA_CODIGO,
        round(COMPRA_TOTAL*DESCUENTO_COMPRA_VALOR,2),
        COMPRA_NUMERO
        from gd_esquema.Maestra
        where DESCUENTO_COMPRA_CODIGO is not null and COMPRA_TOTAL is not null and COMPRA_NUMERO is not null
        group by DESCUENTO_COMPRA_CODIGO, DESCUENTO_COMPRA_VALOR, COMPRA_TOTAL, COMPRA_NUMERO
    )
end
go

create proc ForAndIf.actualizar_medio_pago as
begin
    update ForAndIf.Medio_Pago set medi_porcentaje_descuento = ForAndIf.porcentaje_medio_pago (medi_pago)
end
go

--INVOCACION PROCEDURES
exec ForAndIf.migrar_tipo_variante
exec ForAndIf.migrar_variante
exec ForAndIf.migrar_producto
exec ForAndIf.migrar_provincia
exec ForAndIf.migrar_localidad
exec ForAndIf.migrar_cupon
exec ForAndIf.migrar_CP
exec ForAndIf.migrar_localidad_por_CP
exec ForAndIf.migrar_descuento
exec ForAndIf.migrar_canal
exec ForAndIf.migrar_envio
exec ForAndIf.migrar_envio_disponible_por_localidad_y_CP
exec ForAndIf.migrar_medio_pago
exec ForAndIf.migrar_proveedor
exec ForAndIf.migrar_cliente
exec ForAndIf.migrar_compra
exec ForAndIf.migrar_producto_por_variante
exec ForAndIf.migrar_compra_por_producto
exec ForAndIf.migrar_venta
exec ForAndIf.migrar_venta_por_producto
exec ForAndIf.migrar_cupon_por_venta
exec ForAndIf.migrar_descuento_por_venta
exec ForAndIf.migrar_descuento_compra
exec ForAndIf.actualizar_medio_pago
