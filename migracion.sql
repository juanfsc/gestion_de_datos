use GD2C2022
go
---DEFINICION FUNCTIONS

create function ForAndIf.obtener_id_provincia (@prov_nombre nvarchar(255)) RETURNS decimal(18, 0) AS
begin
    DECLARE @id_provincia INTEGER;
    SET @id_provincia =  ( select prov_id from ForAndIf.Provincia
        where @prov_nombre = prov_nombre)
    RETURN @id_provincia
end
go

create function ForAndIf.obtener_id_localidad (@prov_nombre nvarchar(255), @loca_nombre nvarchar(255)) RETURNS decimal(18, 0) AS
begin
    DECLARE @id_localidad INTEGER;
    SET @id_localidad = ( select loca_id from ForAndIf.Localidad join ForAndIf.Provincia
        on loca_provincia = prov_id
        where prov_nombre=@prov_nombre and loca_nombre=@loca_nombre)
    RETURN @id_localidad
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

create proc ForAndIf.migrar_envio_disponible_por_CP as
begin
    insert ForAndIf.Envio_disponible_por_CP (envi_cp_medio, envi_cp_postal, envi_cp_costo, envi_tiempo) (
        select (
            select envi_medio from ForAndIf.Envio
            where envi_nombre = VENTA_MEDIO_ENVIO
        
        ), CLIENTE_CODIGO_POSTAL,
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
        where VENTA_MEDIO_ENVIO is not null and CLIENTE_CODIGO_POSTAL is not null and VENTA_ENVIO_PRECIO is not null 
        group by VENTA_MEDIO_ENVIO, CLIENTE_CODIGO_POSTAL, VENTA_ENVIO_PRECIO
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
exec ForAndIf.migrar_envio_disponible_por_CP
exec ForAndIf.migrar_medio_pago
exec ForAndIf.migrar_proveedor
exec ForAndIf.migrar_cliente
-- select VENTA_MEDIO_ENVIO, VENTA_ENVIO_PRECIO from gd_esquema.Maestra
-- where VENTA_MEDIO_ENVIO is not null and VENTA_ENVIO_PRECIO is not NULL
-- group by VENTA_MEDIO_ENVIO, VENTA_ENVIO_PRECIO