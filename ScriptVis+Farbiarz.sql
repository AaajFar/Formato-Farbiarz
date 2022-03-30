USE fabrica_guitarras;

# Vista para saber el costo de fabricación de todas las guitarras
CREATE OR REPLACE VIEW costo_guitarras
AS SELECT SUM(mat.costo) costo, guit.id id_guitarra
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id
GROUP BY guit.id;

# Vista para saber el valor total de mis ventas, en que cantidad de pedidos y que cantidad de guitarras
CREATE OR REPLACE VIEW total_ventas
AS SELECT SUM(cantidad) cantidad_guitarras, COUNT(id) cantidad_pedidos, SUM(precio) total
FROM pedidos;

# Vista para obtener los datos solamente de los proveedores del tipo de material "maderas"
CREATE OR REPLACE VIEW proveedores_maderas
AS SELECT prov.nombre, prov.telefono, prov.mail
FROM proveedores prov
INNER JOIN proveedores_materiales pm ON pm.prov_id = prov.id
INNER JOIN materiales mat ON mat.id = pm.mat_id
WHERE mat.tipo = "maderas"
GROUP BY prov.nombre;

# Vista para ver todos los pedidos junto a su valor y direccion de envio
CREATE OR REPLACE VIEW pedidos_clientes
AS SELECT ped.id id_pedido, ped.precio valor, CONCAT (cl.nombre, ' ', cl.apellido) nombre_apellido, dir.direccion direccion_envio, dir.localidad, dir.provincia
FROM pedidos ped
INNER JOIN clientes cl ON ped.cliente = cl.id
INNER JOIN direcciones_envio dir ON ped.dir_envio = dir.id
ORDER BY ped.fecha;

# Vista para saber que materiales necesito para fabricar cada guitarra
CREATE OR REPLACE VIEW material_p_guitarra
AS SELECT guit.id id_guitarra, guit.tipo tipo_guitarra, guit.modelo modelo_guitarra, mat.tipo tipo_material, mat.marca marca_material, mat.modelo modelo_material
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id;

# Vista para saber de que materiales tengo stock bajo junto con los datos del proveedor que lo vende.
CREATE OR REPLACE VIEW stock_bajo_materiales
AS SELECT mat.id id_material, mat.tipo, mat.modelo, mat.stock, prov.nombre, prov.telefono, prov.mail
FROM materiales mat
INNER JOIN proveedores_materiales pm ON mat.id = pm.mat_id
INNER JOIN proveedores prov ON prov.id = pm.prov_id
WHERE mat.stock <= 100;

# Vista para saber de que guitarras tengo stock bajo para fabricar mas
CREATE OR REPLACE VIEW stock_bajo_guitarras
AS SELECT id, tipo, modelo, stock
FROM guitarras
WHERE stock <= 100;

# Vista para saber cual es el promedio de ventas y en que cantidad de pedidos
CREATE OR REPLACE VIEW promedio_ventas
AS SELECT AVG(precio) promedio_venta, COUNT(id) tota_pedidos
FROM pedidos;