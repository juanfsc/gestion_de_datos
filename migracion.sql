insert ForAndIf.Tipo_variante (tiva_nombre) (
    select distinct PRODUCTO_TIPO_VARIANTE from gd_esquema.Maestra
    where PRODUCTO_TIPO_VARIANTE is not null
)

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

insert ForAndIf.Producto (prod_codigo, prod_nombre, prod_descripcion, prod_marca, prod_material, prod_categoria) (
    select PRODUCTO_CODIGO, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_MATERIAL, PRODUCTO_CATEGORIA from gd_esquema.Maestra
    WHERE PRODUCTO_CODIGO is not null and PRODUCTO_NOMBRE is not null and PRODUCTO_DESCRIPCION is not null and PRODUCTO_MARCA is not null and PRODUCTO_MATERIAL is not null and PRODUCTO_CATEGORIA is not null
    GROUP BY PRODUCTO_CODIGO, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_MATERIAL, PRODUCTO_CATEGORIA
)

insert ForAndIf.Provincia (prov_nombre) (
    select distinct PROVEEDOR_PROVINCIA from gd_esquema.Maestra
    where PROVEEDOR_PROVINCIA is not null
    union
    select distinct CLIENTE_PROVINCIA  from gd_esquema.Maestra
    where CLIENTE_PROVINCIA is not null
)

insert ForAndIf.Localidad (loca_provincia, loca_nombre) (
    select (
        select prov_id from ForAndIf.Provincia
        where CLIENTE_PROVINCIA = prov_nombre
        ), 
    CLIENTE_LOCALIDAD from gd_esquema.Maestra
    where CLIENTE_LOCALIDAD is not null and CLIENTE_PROVINCIA is not null
    group by CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA
    union
    select (
        select prov_id from ForAndIf.Provincia
        where PROVEEDOR_PROVINCIA = prov_nombre
    ), 
    PROVEEDOR_LOCALIDAD from gd_esquema.Maestra
    where PROVEEDOR_LOCALIDAD is not null and PROVEEDOR_PROVINCIA is not null
    group by PROVEEDOR_LOCALIDAD, PROVEEDOR_PROVINCIA 
)

insert ForAndIf.Cupon (cupo_codigo, cupo_valor, cupo_tipo, cupo_fecha_desde, cupo_fecha_hasta) (
    select VENTA_CUPON_CODIGO, VENTA_CUPON_VALOR, VENTA_CUPON_TIPO, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA from gd_esquema.Maestra
    where VENTA_CUPON_CODIGO is not null and VENTA_CUPON_FECHA_DESDE is not null and VENTA_CUPON_FECHA_HASTA is not null and VENTA_CUPON_TIPO is not null and VENTA_CUPON_VALOR is not null
    group by VENTA_CUPON_CODIGO, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA, VENTA_CUPON_TIPO, VENTA_CUPON_VALOR 
)

insert ForAndIf.CP (codi_postal) (
    select distinct PROVEEDOR_CODIGO_POSTAL from gd_esquema.Maestra
    where PROVEEDOR_CODIGO_POSTAL is not null
    union
    select distinct cliente_codigo_postal from gd_esquema.Maestra
    where CLIENTE_CODIGO_POSTAL is not null 
)

insert ForAndIf.Localidad_por_CP (loca_id, codi_postal) (
    select (
        select loca_id from ForAndIf.Localidad
        where CLIENTE_LOCALIDAD = loca_nombre
    ), CLIENTE_CODIGO_POSTAL from gd_esquema.Maestra
    where CLIENTE_LOCALIDAD is not null and CLIENTE_CODIGO_POSTAL is not null
    group by CLIENTE_LOCALIDAD, CLIENTE_CODIGO_POSTAL
    union
    select (
        select loca_id from ForAndIf.Localidad
        where PROVEEDOR_LOCALIDAD = loca_nombre
    ), PROVEEDOR_CODIGO_POSTAL from gd_esquema.Maestra
    where PROVEEDOR_LOCALIDAD is not null and PROVEEDOR_CODIGO_POSTAL is not null
    group by PROVEEDOR_LOCALIDAD, PROVEEDOR_CODIGO_POSTAL
)

insert ForAndIf.Descuento (desc_concepto) (
    select distinct VENTA_DESCUENTO_CONCEPTO from gd_esquema.Maestra
    where VENTA_DESCUENTO_CONCEPTO IS NOT NULL
)

insert ForAndIf.Canal (cana_nombre, cana_costo) (
    select VENTA_CANAL, VENTA_CANAL_COSTO from gd_esquema.Maestra
    where VENTA_CANAL is not null and VENTA_CANAL_COSTO is not null
    group by VENTA_CANAL, VENTA_CANAL_COSTO 
) 
-- select DESCUENTO_COMPRA_CODIGO, VENTA_DESCUENTO_CONCEPTO, DESCUENTO_COMPRA_VALOR, VENTA_DESCUENTO_IMPORTE from gd_esquema.Maestra
-- GROUP BY DESCUENTO_COMPRA_CODIGO, VENTA_DESCUENTO_CONCEPTO, DESCUENTO_COMPRA_VALOR, VENTA_DESCUENTO_IMPORTE