use GD2C2022
go
--INICIAL
drop table FOR_AND_IF.Descuento_especial
drop table FOR_AND_IF.Cupon_por_venta
drop table FOR_AND_IF.Cupon
drop table FOR_AND_IF.Compra_por_producto
drop table FOR_AND_IF.Descuento_Compra
drop table FOR_AND_IF.Compra
drop table FOR_AND_IF.Proveedor
drop table FOR_AND_IF.Localidad_por_CP
drop table FOR_AND_IF.Envio_disponible_por_localidad_y_CP
drop table FOR_AND_IF.Localidad
drop table FOR_AND_IF.Provincia
drop table FOR_AND_IF.Producto_por_variante
drop table FOR_AND_IF.Producto
drop table FOR_AND_IF.Tipo_variante
drop table FOR_AND_IF.Variante
drop table FOR_AND_IF.Venta_por_producto
drop table FOR_AND_IF.Venta
drop table FOR_AND_IF.Cliente
drop table FOR_AND_IF.CP
drop table FOR_AND_IF.Canal
drop table FOR_AND_IF.Envio
drop table FOR_AND_IF.Medio_Pago
drop proc FOR_AND_IF.migrar_tipo_variante
drop proc FOR_AND_IF.migrar_variante
drop proc FOR_AND_IF.migrar_producto
drop proc FOR_AND_IF.migrar_provincia
drop proc FOR_AND_IF.migrar_localidad
drop proc FOR_AND_IF.migrar_cupon
drop proc FOR_AND_IF.migrar_CP
drop proc FOR_AND_IF.migrar_localidad_por_CP
drop proc FOR_AND_IF.migrar_descuento
drop proc FOR_AND_IF.migrar_canal
drop proc FOR_AND_IF.migrar_envio
drop proc FOR_AND_IF.migrar_envio_disponible_por_localidad_y_CP
drop proc FOR_AND_IF.migrar_medio_pago
drop proc FOR_AND_IF.migrar_proveedor
drop proc FOR_AND_IF.migrar_cliente
drop proc FOR_AND_IF.migrar_compra
drop proc FOR_AND_IF.migrar_producto_por_variante
drop proc FOR_AND_IF.migrar_compra_por_producto
drop proc FOR_AND_IF.migrar_venta
drop proc FOR_AND_IF.migrar_venta_por_producto
drop proc FOR_AND_IF.migrar_cupon_por_venta
drop proc FOR_AND_IF.migrar_Descuento_especial
drop proc FOR_AND_IF.migrar_descuento_compra
drop proc FOR_AND_IF.actualizar_medio_pago
drop function FOR_AND_IF.obtener_id_provincia
drop function FOR_AND_IF.obtener_id_localidad
drop function FOR_AND_IF.obtener_id_variante
drop function FOR_AND_IF.suma_descuento_importe_medio_pago
drop function FOR_AND_IF.suma_consumo_medio_pago 
drop function FOR_AND_IF.suma_importe_descuento
drop function FOR_AND_IF.porcentaje_medio_pago
drop function FOR_AND_IF.porcentaje_descuento
go

--BI
drop table FOR_AND_IF.Hechos_Compras
drop table FOR_AND_IF.Hechos_Ventas
drop table FOR_AND_IF.Dimension_tiempo
drop table FOR_AND_IF.Dimension_provincia
drop table FOR_AND_IF.Dimension_producto
drop proc FOR_AND_IF.migrar_dimension_tiempo
drop proc FOR_AND_IF.migrar_dimension_provincia
drop proc FOR_AND_IF.migrar_dimension_producto
drop proc FOR_AND_IF.migrar_hechos_ventas
drop proc FOR_AND_IF.migrar_hechos_compras
drop function FOR_AND_IF.obtener_id_tiempo
go

drop schema FOR_AND_IF

go