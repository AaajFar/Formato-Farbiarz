USE fabrica_guitarras;

# Funcion para calcular el costo de un pedido mediante el id del mismo
DELIMITER $$
CREATE FUNCTION `costo_pedido` (id INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
    SET resultado = (SELECT SUM(mat.costo) * ped.cantidad
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	INNER JOIN pedidos ped ON ped.guit = guit.id
	WHERE ped.id = id);
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular el costo de fabricacion de una guitarra mediante el id de la misma
DELIMITER $$
CREATE FUNCTION `costo_guitarra`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
    SET resultado = (SELECT SUM(mat.costo)
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id);
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular cuantos pedidos realizo un cliente mediante el id del mismo
DELIMITER $$
CREATE FUNCTION `cantidad_pedidos_clientes`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE cliente = id);
RETURN resultado;
END
$$
DELIMITER ;


/* Funcion para calcular cuantos dias pasaron desde el ultimo pedido que hizo un cliente
mediante su id */
DELIMITER $$
CREATE FUNCTION `cantidad_dias_ult_pedido`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE fecha1 DATE;
    DECLARE fecha2 DATE;
    DECLARE resultado INT;
	SET fecha1 = (SELECT ped.fecha
	FROM pedidos ped
	WHERE cliente = id
	ORDER BY fecha DESC
	LIMIT 1);
    SET fecha2 = (SELECT CURDATE() FROM DUAL);
    SET resultado = (DATEDIFF(fecha2,fecha1));
RETURN resultado;
END
$$
DELIMITER ;


# Funcion para calcular cantidad de pedidos entre 2 fechas que ingrese el usuario
DELIMITER $$
CREATE FUNCTION `cant_pedidos_por_fecha`(fecha1 DATE, fecha2 DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2);
RETURN resultado;
END
$$
DELIMITER ;