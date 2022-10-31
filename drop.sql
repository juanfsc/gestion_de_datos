use GD2C2022
go

drop table ForAndIf.Descuento_por_venta
drop table ForAndIf.Descuento
drop table ForAndIf.Cupon_por_venta
drop table ForAndIf.Cupon
drop table ForAndIf.Compra_por_producto
drop table ForAndIf.Descuento_Compra
drop table ForAndIf.Compra
drop table ForAndIf.Proveedor
drop table ForAndIf.Localidad_por_CP
drop table ForAndIf.Envio_disponible_por_localidad_y_CP
drop table ForAndIf.Localidad
drop table ForAndIf.Provincia
drop table ForAndIf.Producto_por_variante
drop table ForAndIf.Producto
drop table ForAndIf.Tipo_variante
drop table ForAndIf.Variante
drop table ForAndIf.Venta_por_producto
drop table ForAndIf.Venta
drop table ForAndIf.Cliente
drop table ForAndIf.CP
drop table ForAndIf.Canal
drop table ForAndIf.Envio
drop table ForAndIf.Medio_Pago
drop proc ForAndIf.migrar_tipo_variante
drop proc ForAndIf.migrar_variante
drop proc ForAndIf.migrar_producto
drop proc ForAndIf.migrar_provincia
drop proc ForAndIf.migrar_localidad
drop proc ForAndIf.migrar_cupon
drop proc ForAndIf.migrar_CP
drop proc ForAndIf.migrar_localidad_por_CP
drop proc ForAndIf.migrar_descuento
drop proc ForAndIf.migrar_canal
drop proc ForAndIf.migrar_envio
drop proc ForAndIf.migrar_envio_disponible_por_CP
drop proc ForAndIf.migrar_medio_pago
drop proc ForAndIf.migrar_proveedor
drop proc ForAndIf.migrar_cliente
drop proc ForAndIf.migrar_compra
drop proc ForAndIf.migrar_producto_por_variante
drop proc ForAndIf.migrar_compra_por_producto
drop proc ForAndIf.migrar_venta
drop proc ForAndIf.migrar_venta_por_producto
drop proc ForAndIf.migrar_cupon_por_venta
drop proc ForAndIf.migrar_descuento_por_venta
drop proc ForAndIf.migrar_descuento_compra
drop proc ForAndIf.actualizar_medio_pago
drop function ForAndIf.obtener_id_provincia
drop function ForAndIf.obtener_id_localidad
drop function ForAndIf.obtener_id_variante
drop function ForAndIf.suma_descuento_importe_medio_pago
drop function ForAndIf.suma_consumo_medio_pago 
drop function ForAndIf.suma_importe_descuento
drop function ForAndIf.porcentaje_medio_pago
drop function ForAndIf.id_descuento
drop function ForAndIf.porcentaje_descuento
drop schema ForAndIf
go