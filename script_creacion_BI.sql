use GD2C2022
go

-- CREACIÓN TABLAS

create table FOR_AND_IF.Dimension_tiempo (
   dime_tiempo_id decimal(18, 0) not null identity(1, 1),
   anio decimal(4, 0) not null,
   mes decimal(2, 0) not null
)

create table FOR_AND_IF.Dimension_canal (
    dime_canal_id decimal(18, 0) not null,
    nombre_canal nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_provincia (
    dime_provincia_id decimal(18, 0) not null,
    nombre_provincia nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_producto (
    dime_producto_id nvarchar(50) not null,
    prod_nombre nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_categoria_producto (
    dime_categoria_id decimal(18, 0) identity(1, 1),
    categoria_nombre nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_proveedor (
    dime_proveedor_id nvarchar(50) not null,
    prov_razon_social nvarchar(50) not null
)

create table FOR_AND_IF.Dimension_cliente_rango_etario (
    dime_cliente_rango_id decimal(18,0) not null identity(1,1),
    rango_etario char(8) not null
)

create table FOR_AND_IF.Dimension_medio_de_pago (
    dime_medio_de_pago_id decimal(18,0) not null,
    nombre nvarchar(255) not null,
    costo decimal(18,2) not null,
    porcentaje_descuento decimal(18,2) not null
)

create table FOR_AND_IF.Dimension_tipo_envio (
    dime_tipo_envio_id decimal(18, 0) not null,
    tipo_envio_nombre nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_descuento (
    dime_desc_id decimal(18, 0) not null identity(1, 1),
    tipo_desc nvarchar(255) not null,
)

create table FOR_AND_IF.Hechos_Ventas (
    dime_tiempo decimal(18, 0) not null,
    dime_canal decimal(18, 0) not null,
    dime_producto nvarchar(50) not null,
	dime_rango_etario decimal(18, 0) not null,
    dime_medio_pago decimal(18, 0) not null,
    dime_provincia decimal(18, 0) not null,
    dime_categoria decimal(18, 0) not null,
    cantidad_vendida decimal(18, 0) not null,
    precio_unitario decimal(18, 2) not null,
    costo_canal_prop decimal(18, 6) not null,
    costo_medio_pago_prop decimal(18, 6) not null
)

create table FOR_AND_IF.Hechos_Compras (
    dime_tiempo decimal(18, 0) not null,
    dime_producto nvarchar(50) not null,
    dime_proveedor nvarchar(50) not null,
    dime_categoria decimal(18, 0) not null,
    cantidad_comprada decimal(18, 0) not null,
    precio_unitario decimal(18, 2) not null
)

create table FOR_AND_IF.Hechos_Descuentos (
    dime_tiempo decimal(18, 0) not null,
    dime_canal decimal(18, 0) not null,
	dime_rango_etario decimal(18, 0) not null,
    dime_medio_pago decimal(18, 0) not null,
    dime_provincia decimal(18, 0) not null,
    dime_desc decimal(18, 0) not null,
    suma_descontada decimal(18, 2) not null
)

create table FOR_AND_IF.Hechos_Envios (
    dime_tiempo decimal(18, 0) not null,
    dime_provincia decimal(18, 0) not null,
    dime_tipo_envio decimal(18, 0) not null,
    cant_envios decimal(18, 0) not null,
    total_importes_envios decimal(18, 2) not null
)

-- PRIMARY KEYS

alter table FOR_AND_IF.Dimension_tiempo add constraint pk_dimension_tiempo primary key (dime_tiempo_id)
alter table FOR_AND_IF.Dimension_canal add constraint pk_dimension_canal primary key (dime_canal_id)
alter table FOR_AND_IF.Dimension_provincia add constraint pk_dimension_provincia primary key (dime_provincia_id)
alter table FOR_AND_IF.Dimension_producto add constraint pk_dimension_producto primary key (dime_producto_id)
alter table FOR_AND_IF.Dimension_cliente_rango_etario add constraint pk_dimension_cliente_rango_etario primary key (dime_cliente_rango_id)
alter table FOR_AND_IF.Dimension_medio_de_pago add constraint pk_dimension_medio_de_pago primary key (dime_medio_de_pago_id)
alter table FOR_AND_IF.Dimension_proveedor add constraint pk_dimension_proveedor primary key (dime_proveedor_id)
alter table FOR_AND_IF.Dimension_descuento add constraint pk_dimension_descuento primary key (dime_desc_id)
alter table FOR_AND_IF.Dimension_tipo_envio add constraint pk_dimension_tipo_envio primary key (dime_tipo_envio_id)
alter table FOR_AND_IF.Dimension_categoria_producto add constraint pk_dimension_categoria_producto primary key (dime_categoria_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint pk_hechos_ventas primary key (dime_tiempo, dime_canal, dime_producto, dime_rango_etario, dime_medio_pago, dime_provincia, dime_categoria)
alter table FOR_AND_IF.Hechos_Compras add constraint pk_hechos_compras primary key (dime_tiempo, dime_producto, dime_proveedor, dime_categoria)
alter table FOR_AND_IF.Hechos_Descuentos add constraint pk_hechos_descuentos primary key (dime_tiempo, dime_canal, dime_rango_etario, dime_medio_pago, dime_provincia, dime_desc)
alter table FOR_AND_IF.Hechos_Envios add constraint pk_hechos_envios primary key (dime_tiempo, dime_provincia, dime_tipo_envio)
go

-- FOREIGN KEYS

alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo (dime_tiempo_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_canal foreign key (dime_canal)
    references FOR_AND_IF.Dimension_canal (dime_canal_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_producto foreign key (dime_producto)
    references FOR_AND_IF.Dimension_producto (dime_producto_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_rango_etario foreign key (dime_rango_etario)
    references FOR_AND_IF.Dimension_cliente_rango_etario (dime_cliente_rango_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_medio_pago foreign key (dime_medio_pago)
    references FOR_AND_IF.Dimension_medio_de_pago (dime_medio_de_pago_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_provincia foreign key (dime_provincia)
    references FOR_AND_IF.Dimension_provincia (dime_provincia_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_categoria_producto foreign key (dime_categoria)
    references FOR_AND_IF.Dimension_categoria_producto (dime_categoria_id)

alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo (dime_tiempo_id)
alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_producto foreign key (dime_producto)
    references FOR_AND_IF.Dimension_producto (dime_producto_id)
alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_proveedor foreign key (dime_proveedor)
    references FOR_AND_IF.Dimension_proveedor (dime_proveedor_id)
alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_categoria_producto foreign key (dime_categoria)
    references FOR_AND_IF.Dimension_categoria_producto (dime_categoria_id)

alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_descuento foreign key (dime_desc)
    references FOR_AND_IF.Dimension_descuento (dime_desc_id)
alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo(dime_tiempo_id)
alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_provincia foreign key (dime_provincia)
    references FOR_AND_IF.Dimension_provincia(dime_provincia_id)
alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_rango_etario foreign key (dime_rango_etario)
    references FOR_AND_IF.Dimension_cliente_rango_etario(dime_cliente_rango_id)
alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_canal foreign key (dime_canal)
    references FOR_AND_IF.Dimension_canal(dime_canal_id)
alter table FOR_AND_IF.Hechos_Descuentos add constraint fk_hechos_descuentos_dimension_tipo_envio foreign key (dime_tipo_envio)
    references FOR_AND_IF.Dimension_tipo_envio(dime_tipo_envio_id)

alter table FOR_AND_IF.Hechos_Envios add constraint fk_hechos_envios_dimension_tipo_envio foreign key (dime_tipo_envio)
    references FOR_AND_IF.Dimension_tipo_envio (dime_tipo_envio_id)
alter table FOR_AND_IF.Hechos_Envios add constraint fk_hechos_envios_dimension_provincia foreign key (dime_provincia)
    references FOR_AND_IF.Dimension_provincia (dime_provincia_id)
alter table FOR_AND_IF.Hechos_Envios add constraint fk_hechos_envios_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo (dime_tiempo_id)
go

-- DEFINICIÓN FUNCIONES
create function FOR_AND_IF.obtener_id_categoria(@categoria nvarchar(255)) returns decimal(18, 0)
as
begin
    return(select dime_categoria_id from FOR_AND_IF.Dimension_categoria_producto
    where categoria_nombre=@categoria)
end
go

create function FOR_AND_IF.obtener_id_tiempo(@fecha date) returns decimal(18, 0) as
begin
    return (
        select dime_tiempo_id from FOR_AND_IF.Dimension_tiempo
        where anio = year(@fecha) and mes = month(@fecha)
    )
end
go

create function FOR_AND_IF.obtener_rango_etario(@fecha date) returns char(8) as
begin
    return (
		case
			when year(GETDATE())-year(@fecha) <= 25 then '<=25' 
			when year(GETDATE())-year(@fecha) > 25 and year(GETDATE())-year(@fecha) <= 35 then '25-35' 
			when year(GETDATE())-year(@fecha) > 35 and year(GETDATE())-year(@fecha) <= 55 then '35-55' 
			when year(GETDATE())-year(@fecha) > 55 then '>55'
		end
    )
end
go

create function FOR_AND_IF.obtener_rango_etario_id(@fecha date) returns char(8) as
begin
    return (
		select dime_cliente_rango_id
		from FOR_AND_IF.Dimension_cliente_rango_etario
		where rango_etario=FOR_AND_IF.obtener_rango_etario(@fecha)
	)
end
go

create function FOR_AND_IF.costo_canal_por_unidad(@venta decimal(19, 0))
returns decimal(18, 6)
as
begin
    return (
        select vent_canal_costo / sum(prod_cantidad) from FOR_AND_IF.Venta
        join FOR_AND_IF.Venta_por_producto on Venta.vent_codigo = Venta_por_producto.vent_codigo
        where Venta.vent_codigo = @venta
        group by vent_canal_costo
    )
end
go

create function FOR_AND_IF.costo_medio_pago_por_unidad(@venta decimal(19, 0))
returns decimal(18, 6)
as
begin
    return (
        select vent_medio_pago_costo / sum(prod_cantidad) from FOR_AND_IF.Venta
        join FOR_AND_IF.Venta_por_producto on Venta.vent_codigo = Venta_por_producto.vent_codigo
        where Venta.vent_codigo = @venta
        group by vent_medio_pago_costo
    )
end
go

-- DEFINICIÓN PROCEDURES

create proc FOR_AND_IF.migrar_dimension_tiempo as
begin
    if (select count(*) from FOR_AND_IF.Dimension_tiempo) = 0
    begin
        insert FOR_AND_IF.Dimension_tiempo (anio, mes) (
            select distinct YEAR(vent_fecha), MONTH(vent_fecha) from FOR_AND_IF.Venta
            union
            select distinct YEAR(comp_fecha), MONTH(comp_fecha) from FOR_AND_IF.Compra
        )
    end
end
go

create proc FOR_AND_IF.migrar_dimension_canal as
begin
    insert FOR_AND_IF.Dimension_canal (dime_canal_id, nombre_canal) (
        select cana_id, cana_nombre from FOR_AND_IF.Canal
    )
end
go

create proc FOR_AND_IF.migrar_dimension_provincia AS
begin
    insert FOR_AND_IF.Dimension_provincia (dime_provincia_id, nombre_provincia) (
        select prov_id, prov_nombre from FOR_AND_IF.Provincia
    )
end
go

create proc FOR_AND_IF.migrar_dimension_tipo_envio as
begin
    insert FOR_AND_IF.Dimension_tipo_envio (dime_tipo_envio_id, tipo_envio_nombre) (
        select envi_medio, envi_nombre from FOR_AND_IF.Envio
    )
end
go

create proc FOR_AND_IF.migrar_dimension_producto as
begin
    insert FOR_AND_IF.Dimension_producto (dime_producto_id, prod_nombre) (
        select prod_codigo, prod_nombre from FOR_AND_IF.Producto   
    )
end
go

create proc FOR_AND_IF.migrar_dimension_cliente_rango_etario as
begin
    insert FOR_AND_IF.Dimension_cliente_rango_etario (rango_etario) (
        select FOR_AND_IF.obtener_rango_etario(clie_fecha_nac)
        from FOR_AND_IF.Cliente
		group by FOR_AND_IF.obtener_rango_etario(clie_fecha_nac)
	)
end
go

create proc FOR_AND_IF.migrar_dimension_medio_pago as 
begin
    insert FOR_AND_IF.Dimension_medio_de_pago (dime_medio_de_pago_id, nombre, costo, porcentaje_descuento) (
        select medi_id, medi_pago, medi_costo, medi_porcentaje_descuento
        from FOR_AND_IF.Medio_Pago
    )
end
go

create proc FOR_AND_IF.migrar_dimension_descuento as
begin
    insert FOR_AND_IF.Dimension_descuento (tipo_desc) values ('Cupón')
    insert FOR_AND_IF.Dimension_descuento (tipo_desc) values ('Especial')
    insert FOR_AND_IF.Dimension_descuento (tipo_desc) (
        select medi_pago from FOR_AND_IF.Medio_Pago
        where medi_porcentaje_descuento > 0
    )
end
go

create proc FOR_AND_IF.migrar_dimension_proveedor as
begin
    insert FOR_AND_IF.Dimension_proveedor (dime_proveedor_id, prov_razon_social) (
        select prov_cuit, prov_razon_social from FOR_AND_IF.Proveedor
    )
end
go

create proc FOR_AND_IF.migrar_dimension_categoria_producto as
begin
    insert FOR_AND_IF.Dimension_categoria_producto (categoria_nombre) (
        select distinct prod_categoria from FOR_AND_IF.Producto
    )
end
go

create proc FOR_AND_IF.migrar_hechos_ventas as
begin
    insert FOR_AND_IF.Hechos_Ventas (dime_tiempo, dime_canal, dime_producto, dime_rango_etario, dime_medio_pago, dime_provincia, dime_categoria, cantidad_vendida, precio_unitario, costo_canal_prop, costo_medio_pago_prop) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_canal, Producto.prod_codigo,
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac), 
        vent_medio_pago, clie_provincia,
        FOR_AND_IF.obtener_id_categoria(prod_categoria),
        sum(prod_cantidad),
        sum(prod_cantidad * prod_precio_unitario)/sum(prod_cantidad),
        sum(prod_cantidad * FOR_AND_IF.costo_canal_por_unidad(Venta.vent_codigo)),
        sum(prod_cantidad * FOR_AND_IF.costo_medio_pago_por_unidad(Venta.vent_codigo))
        from FOR_AND_IF.Venta
        join FOR_AND_IF.Venta_por_producto on Venta.vent_codigo = Venta_por_producto.vent_codigo
		join FOR_AND_IF.Cliente on vent_cliente = clie_id
        join FOR_AND_IF.Producto on Venta_por_producto.prod_codigo = Producto.prod_codigo
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_canal,
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_medio_pago, clie_provincia, Producto.prod_codigo, vent_canal_costo, prod_categoria
    )
end
go

create proc FOR_AND_IF.migrar_hechos_compras as
begin
    insert FOR_AND_IF.Hechos_Compras (dime_tiempo, dime_producto, dime_proveedor, dime_categoria, cantidad_comprada, precio_unitario) (
        select FOR_AND_IF.obtener_id_tiempo(comp_fecha), Producto.prod_codigo, comp_proveedor,
        FOR_AND_IF.obtener_id_categoria(prod_categoria),
        sum(prod_cantidad),
        sum(prod_cantidad * prod_precio_unitario)/sum(prod_cantidad)
        from FOR_AND_IF.Compra join FOR_AND_IF.Compra_por_producto 
        on FOR_AND_IF.Compra.comp_numero=FOR_AND_IF.Compra_por_producto.comp_numero
        join FOR_AND_IF.Producto on Compra_por_producto.prod_codigo = Producto.prod_codigo
        group by FOR_AND_IF.obtener_id_tiempo(comp_fecha), Producto.prod_codigo,
        comp_proveedor, prod_categoria
    )
end
go

create proc FOR_AND_IF.migrar_hechos_descuentos as
begin
    insert FOR_AND_IF.Hechos_Descuentos (dime_tiempo, dime_rango_etario, dime_canal, dime_medio_pago, dime_provincia, dime_desc, suma_descontada) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), 
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_canal,
        vent_medio_pago,
        clie_provincia,
        (select dime_desc_id from FOR_AND_IF.Dimension_descuento where tipo_desc = 'Cupón'),
        sum(cupo_importe)
        from FOR_AND_IF.Venta
		join FOR_AND_IF.Cliente on vent_cliente = clie_id
        join FOR_AND_IF.Cupon_por_venta on Venta.vent_codigo = Cupon_por_venta.vent_codigo
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), 
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_canal,
        vent_medio_pago,
        clie_provincia
    )
    insert FOR_AND_IF.Hechos_Descuentos (dime_tiempo, dime_rango_etario, dime_canal, dime_medio_pago, dime_provincia, dime_desc, suma_descontada) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), 
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_canal,
        vent_medio_pago,
        clie_provincia,
        (select dime_desc_id from FOR_AND_IF.Dimension_descuento where tipo_desc = 'Especial'),
        sum(desc_importe)
        from FOR_AND_IF.Venta
		join FOR_AND_IF.Cliente on vent_cliente = clie_id
        join FOR_AND_IF.Descuento_especial on Venta.vent_codigo = Descuento_especial.vent_codigo
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_canal,
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_medio_pago,
        clie_provincia
    )
    insert FOR_AND_IF.Hechos_Descuentos (dime_tiempo, dime_rango_etario, dime_canal, dime_medio_pago, dime_provincia, dime_desc, suma_descontada) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), 
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_canal,
        vent_medio_pago,
        clie_provincia,
        (select dime_desc_id from FOR_AND_IF.Dimension_descuento where tipo_desc = medi_pago),
        sum(prod_precio_unitario*prod_cantidad)*medi_porcentaje_descuento
        from FOR_AND_IF.Venta
		join FOR_AND_IF.Cliente on vent_cliente = clie_id
        join FOR_AND_IF.Medio_Pago on vent_medio_pago = medi_id
        join FOR_AND_IF.Venta_por_producto on Venta.vent_codigo = Venta_por_producto.vent_codigo
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_canal,
        FOR_AND_IF.obtener_rango_etario_id(clie_fecha_nac),
        vent_medio_pago, medi_pago, medi_porcentaje_descuento, clie_provincia
        having medi_porcentaje_descuento > 0
    )
end
go

create proc FOR_AND_IF.migrar_hechos_envios as
begin
    insert FOR_AND_IF.Hechos_Envios (dime_tiempo, dime_tipo_envio, dime_provincia, cant_envios, total_importes_envios) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_envio, clie_provincia,
        count(*),
        sum(envi_cp_costo)
        from FOR_AND_IF.Venta
        join FOR_AND_IF.Cliente on vent_cliente = clie_id
        join FOR_AND_IF.Envio_disponible_por_localidad_y_CP
        on vent_envio = envi_cp_medio and clie_codigo_postal = envi_cp_postal and clie_localidad = envi_cp_localidad
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), vent_envio, clie_provincia
    )
end
go

-- EJECUCIÓN PROCEDURES

exec FOR_AND_IF.migrar_dimension_tiempo
exec FOR_AND_IF.migrar_dimension_canal
exec FOR_AND_IF.migrar_dimension_medio_pago
exec FOR_AND_IF.migrar_dimension_provincia
exec FOR_AND_IF.migrar_dimension_producto
exec FOR_AND_IF.migrar_dimension_cliente_rango_etario
exec FOR_AND_IF.migrar_dimension_descuento
exec FOR_AND_IF.migrar_dimension_proveedor
exec FOR_AND_IF.migrar_dimension_tipo_envio
exec FOR_AND_IF.migrar_dimension_categoria_producto
exec FOR_AND_IF.migrar_hechos_ventas
exec FOR_AND_IF.migrar_hechos_compras
exec FOR_AND_IF.migrar_hechos_descuentos
exec FOR_AND_IF.migrar_hechos_envios
go

-- DEFINICIÓN VIEWS

-- Las ganancias mensuales de cada canal de venta. 
-- Se entiende por ganancias al total de las ventas, menos el total de las 
-- compras, menos los costos de transacción totales aplicados asociados los 
-- medios de pagos utilizados en las mismas. 

create view FOR_AND_IF.ganancia_mensual_de_canal_de_venta (anio, mes, canal, ganancia) as
select anio, mes, dime_canal,
(sum(cantidad_vendida * precio_unitario) /
(
	select sum(cantidad_vendida * precio_unitario) from FOR_AND_IF.Hechos_Ventas
	where dime_tiempo = dime_tiempo_id
)) * ((
	select sum(cantidad_vendida * precio_unitario) from FOR_AND_IF.Hechos_Ventas
	where dime_tiempo = dime_tiempo_id
) - (
	select sum(cantidad_comprada * precio_unitario) from FOR_AND_IF.Hechos_Compras
	where dime_tiempo = dime_tiempo_id
)) / 100 - sum(costo_canal_prop)
from FOR_AND_IF.Hechos_Ventas
join FOR_AND_IF.Dimension_tiempo t1 on dime_tiempo = dime_tiempo_id
group by dime_tiempo_id, anio, mes, dime_canal
go

-- Los 5 productos con mayor rentabilidad anual, con sus respectivos % 
-- Se entiende por rentabilidad a los ingresos generados por el producto 
-- (ventas) durante el periodo menos la inversión realizada en el producto 
-- (compras) durante el periodo, todo esto sobre dichos ingresos. 
-- Valor expresado en porcentaje. 
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados. 

create view FOR_AND_IF.Top_5_productos_ultimo_anio (producto, rentabilidad) as
select top 5 dime_producto, (sum(cantidad_vendida * precio_unitario) - 
(
    select sum(cantidad_comprada * precio_unitario) from FOR_AND_IF.Hechos_Compras
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    where anio = (select max(anio) from FOR_AND_IF.Dimension_tiempo)
    and Hechos_Compras.dime_producto = Hechos_Ventas.dime_producto
)) / sum(cantidad_vendida * precio_unitario) from FOR_AND_IF.Hechos_Ventas
join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
where anio = (select max(anio) from FOR_AND_IF.Dimension_tiempo)
group by dime_producto
order by (sum(cantidad_vendida * precio_unitario) - 
(
    select sum(cantidad_comprada * precio_unitario) from FOR_AND_IF.Hechos_Compras
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    where anio = (select max(anio) from FOR_AND_IF.Dimension_tiempo)
    and Hechos_Compras.dime_producto = Hechos_Ventas.dime_producto
)) / sum(cantidad_vendida * precio_unitario) desc
go

-- Las 5 categorías de productos más vendidos por rango etario de clientes 
-- por mes.

create view FOR_AND_IF.Top_5_categorias_mas_vendidas_por_rango_etario_por_mes (categoria, rango_etario, mes, anio) as
    select dime_categoria, rango_etario, mes, anio from FOR_AND_IF.Hechos_Ventas v1
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo=dime_tiempo_id
    join FOR_AND_IF.Dimension_cliente_rango_etario on dime_rango_etario = dime_cliente_rango_id
    where dime_categoria in (
        select top 5 dime_categoria from FOR_AND_IF.Hechos_Ventas v2
        where v1.dime_tiempo = v2.dime_tiempo and v1.dime_rango_etario = v2.dime_rango_etario
        group by dime_categoria
        order by sum(cantidad_vendida)
    )
    group by dime_tiempo, dime_rango_etario, rango_etario, anio, mes, dime_categoria
go

-- Total de Ingresos por cada medio de pago por mes, descontando los costos 
-- por medio de pago (en caso que aplique) y descuentos por medio de pago 
-- (en caso que aplique)

create view FOR_AND_IF.ingresos_por_medio_de_pago_por_mes (medio_pago, anio, mes, ingreso) as
select v.dime_medio_pago, anio, mes,
sum(cantidad_vendida*precio_unitario) - (
    select isnull(sum(suma_descontada), 0) from FOR_AND_IF.Hechos_Descuentos d
    where v.dime_medio_pago = d.dime_medio_pago
    and v.dime_tiempo = d.dime_tiempo
) 
- (sum(costo_medio_pago_prop))
from FOR_AND_IF.Hechos_Ventas v
join FOR_AND_IF.Dimension_tiempo t on v.dime_tiempo = dime_tiempo_id
group by v.dime_medio_pago, dime_tiempo, anio, mes
go

-- Importe total en descuentos aplicados según su tipo de descuento, por 
-- canal de venta, por mes. Se entiende por tipo de descuento como los 
-- correspondientes a envío, medio de pago, cupones, etc) 

create view FOR_AND_IF.descuentos_por_canal_por_mes (tipo, canal, anio, mes, importe) as
    select dime_desc, dime_canal, anio, mes, sum(suma_descontada) from FOR_AND_IF.Hechos_Descuentos
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    group by dime_desc, dime_canal, anio, mes
go

-- Aumento promedio de precios de cada proveedor anual. Para calcular este 
-- indicador se debe tomar como referencia el máximo precio por año menos 
-- el mínimo todo esto divido el mínimo precio del año. Teniendo en cuenta 
-- que los precios siempre van en aumento. 

-- AUXILIAR
create view FOR_AND_IF.aumento_por_proveedor_por_anio_por_producto (anio, proveedor, producto, aumento) as
    select anio, dime_proveedor, dime_producto,
    (max(precio_unitario)-min(precio_unitario)) / min(precio_unitario) as aumento
    from FOR_AND_IF.Hechos_Compras
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    group by anio, dime_proveedor, dime_producto
go

create view FOR_AND_IF.aumento_promedio_por_proveedor_por_anio (anio, proveedor, aumento)
as
    select anio, proveedor, avg(aumento)
    from FOR_AND_IF.aumento_por_proveedor_por_anio_por_producto
    group by anio, proveedor
go

-- Los 3 productos con mayor cantidad de reposición por mes. 

create view FOR_AND_IF.top_3_productos_mas_repuestos_por_mes (anio, mes, producto) as
select anio, mes, dime_producto from FOR_AND_IF.Hechos_Compras
join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
where dime_producto in (
    select top 3 dime_producto from FOR_AND_IF.Hechos_Compras
    where dime_tiempo = dime_tiempo_id
    group by dime_producto
    order by sum(cantidad_comprada) desc
)
group by anio, mes, dime_producto
go

-- Porcentaje de envíos realizados a cada Provincia por mes. El porcentaje
-- debe representar la cantidad de envíos realizados a cada provincia sobre
-- total de envío mensuales.

create view FOR_AND_IF.porcentaje_de_envios_a_cada_provincia_por_mes (anio, mes, provincia, porcentaje) as
select anio, mes, dime_provincia,
sum(cant_envios) / (select sum(cant_envios) from FOR_AND_IF.Hechos_Envios e2 where e1.dime_tiempo = e2.dime_tiempo)
from FOR_AND_IF.Hechos_Envios e1
join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
group by dime_tiempo, anio, mes, dime_provincia
go

-- Valor promedio de envío por Provincia por Medio De Envío anual.
create view FOR_AND_IF.valor_promedio_envio_por_provincia_por_medio_de_envio_por_año
(promedio, provincia, medio_envio, anio)
as
    select avg(total_importes_envios), nombre_provincia, tipo_envio_nombre, anio
    from FOR_AND_IF.Hechos_envios join FOR_AND_IF.Dimension_tiempo
    on dime_tiempo=dime_tiempo_id
    join FOR_AND_IF.Dimension_provincia
    on dime_provincia=dime_provincia_id
    join FOR_AND_IF.Dimension_tipo_envio
    on dime_tipo_envio=dime_tipo_envio_id
    group by nombre_provincia, tipo_envio_nombre, anio
go

-- CONSULTA VIEWS

select * from FOR_AND_IF.ganancia_mensual_de_canal_de_venta
select * from FOR_AND_IF.Top_5_productos_ultimo_anio 
select * from FOR_AND_IF.Top_5_categorias_mas_vendidas_por_rango_etario_por_mes
select * from FOR_AND_IF.ingresos_por_medio_de_pago_por_mes
select * from FOR_AND_IF.descuentos_por_canal_por_mes
select * from FOR_AND_IF.aumento_promedio_por_proveedor_por_anio
select * from FOR_AND_IF.top_3_productos_mas_repuestos_por_mes
select * from FOR_AND_IF.porcentaje_de_envios_a_cada_provincia_por_mes
select * from FOR_AND_IF.valor_promedio_envio_por_provincia_por_medio_de_envio_por_año