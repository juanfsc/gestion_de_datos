use GD2C2022
go

create table FOR_AND_IF.Dimension_tiempo (
   dime_tiempo_id decimal(18, 0) not null identity(1, 1),
   anio decimal(4, 0) not null,
   mes decimal(2, 0) not null
)

create table FOR_AND_IF.Dimension_provincia (
    dime_provincia_id decimal(18, 0) not null,
    nombre_provincia nvarchar(255) not null
)

create table FOR_AND_IF.Dimension_producto (
    dime_producto_id nvarchar(50) not null,
    prod_nombre nvarchar(255) not null,
    prod_categoria nvarchar(255) not null
)

create table FOR_AND_IF.Hechos_Ventas (
    dime_tiempo decimal(18, 0) not null,
    dime_producto nvarchar(50) not null,
    cantidad_vendida decimal(18, 0) not null,
    precio_unitario decimal(18, 2) not null
)

create table FOR_AND_IF.Hechos_Compras (
    dime_tiempo decimal(18, 0) not null,
    dime_producto nvarchar(50) not null,
    cantidad_comprada decimal(18, 0) not null,
    precio_unitario decimal(18, 2) not null
)

--PRIMARY KEYS

alter table FOR_AND_IF.Dimension_tiempo add constraint pk_dimension_tiempo primary key (dime_tiempo_id)
alter table FOR_AND_IF.Dimension_provincia add constraint pk_dimension_provincia primary key (dime_provincia_id)
alter table FOR_AND_IF.Dimension_producto add constraint pk_dimension_producto primary key (dime_producto_id)
alter table FOR_AND_IF.Hechos_Ventas add constraint pk_hechos_ventas primary key (dime_tiempo, dime_producto)
alter table FOR_AND_IF.Hechos_Compras add constraint pk_hechos_compras primary key (dime_tiempo, dime_producto)

go

--FOREIGN KEYS

alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo (dime_tiempo_id)
alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_tiempo foreign key (dime_tiempo)
    references FOR_AND_IF.Dimension_tiempo (dime_tiempo_id)
    
alter table FOR_AND_IF.Hechos_Ventas add constraint fk_hechos_ventas_dimension_producto foreign key (dime_producto)
    references FOR_AND_IF.Dimension_producto (dime_producto_id)
alter table FOR_AND_IF.Hechos_Compras add constraint fk_hechos_compras_dimension_producto foreign key (dime_producto)
    references FOR_AND_IF.Dimension_producto (dime_producto_id)
go

--DEFINICIÓN FUNCIONES

create function FOR_AND_IF.obtener_id_tiempo(@fecha date) returns decimal(18, 0) as
begin
    return (
        select dime_tiempo_id from FOR_AND_IF.Dimension_tiempo
        where anio = year(@fecha) and mes = month(@fecha)
    )
end
go

--DEFINICIÓN PROCEDURES

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

create proc FOR_AND_IF.migrar_dimension_provincia AS
begin
    insert FOR_AND_IF.Dimension_provincia (dime_provincia_id, nombre_provincia) (
        select prov_id, prov_nombre from FOR_AND_IF.Provincia
    )
end
go

create proc FOR_AND_IF.migrar_dimension_producto as
begin
    insert FOR_AND_IF.Dimension_producto (dime_producto_id, prod_nombre, prod_categoria) (
        select prod_codigo, prod_nombre, prod_categoria from FOR_AND_IF.Producto   
    )
end
go

create proc FOR_AND_IF.migrar_hechos_ventas as
begin
    insert FOR_AND_IF.Hechos_Ventas (dime_tiempo, dime_producto, cantidad_vendida, precio_unitario) (
        select FOR_AND_IF.obtener_id_tiempo(vent_fecha), prod_codigo, sum(prod_cantidad),
        sum(prod_cantidad * prod_precio_unitario)/sum(prod_cantidad)
        from FOR_AND_IF.Venta join FOR_AND_IF.Venta_por_producto 
        on FOR_AND_IF.Venta.vent_codigo=FOR_AND_IF.Venta_por_producto.vent_codigo
        group by FOR_AND_IF.obtener_id_tiempo(vent_fecha), prod_codigo
    )
end
go

create proc FOR_AND_IF.migrar_hechos_compras as
begin
    insert FOR_AND_IF.Hechos_Compras (dime_tiempo, dime_producto, cantidad_comprada, precio_unitario) (
        select FOR_AND_IF.obtener_id_tiempo(comp_fecha), prod_codigo, sum(prod_cantidad),
        sum(prod_cantidad * prod_precio_unitario)/sum(prod_cantidad)
        from FOR_AND_IF.Compra join FOR_AND_IF.Compra_por_producto 
        on FOR_AND_IF.Compra.comp_numero=FOR_AND_IF.Compra_por_producto.comp_numero
        group by FOR_AND_IF.obtener_id_tiempo(comp_fecha), prod_codigo
    )
end
go

--INVOCACIÓN PROCEDURES
exec FOR_AND_IF.migrar_dimension_tiempo
exec FOR_AND_IF.migrar_dimension_provincia
exec FOR_AND_IF.migrar_dimension_producto
exec FOR_AND_IF.migrar_hechos_ventas
exec FOR_AND_IF.migrar_hechos_compras


-- Las ganancias mensuales de cada canal de venta. 
-- Se entiende por ganancias al total de las ventas, menos el total de las 
-- compras, menos los costos de transacción totales aplicados asociados los 
-- medios de pagos utilizados en las mismas. 

-- select * from Hechos_Venta venta, Hechos_Compras compra
-- group by venta.dime_tiempo
-- Los 5 productos con mayor rentabilidad anual, con sus respectivos %
-- Se entiende por rentabilidad a los ingresos generados por el producto
-- (ventas) durante el periodo menos la inversión realizada en el producto
-- (compras) durante el periodo, todo esto sobre dichos ingresos.
-- Valor expresado en porcentaje.
-- Para simplificar, no es necesario tener en cuenta los descuentos aplicados. 

select top 5 dime_producto, (sum(cantidad_vendida * precio_unitario) - 
(
    select sum(cantidad_comprada * precio_unitario) from FOR_AND_IF.Hechos_Compras
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    where anio = 2022
    and Hechos_compras.dime_producto = Hechos_ventas.dime_producto
)) / sum(cantidad_vendida * precio_unitario) from FOR_AND_IF.Hechos_Ventas
join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
where anio = 2022
group by dime_producto
order by (sum(cantidad_vendida * precio_unitario) - 
(
    select sum(cantidad_comprada * precio_unitario) from FOR_AND_IF.Hechos_Compras
    join FOR_AND_IF.Dimension_tiempo on dime_tiempo = dime_tiempo_id
    where anio = 2022
    and Hechos_compras.dime_producto = Hechos_ventas.dime_producto
)) / sum(cantidad_vendida * precio_unitario) desc