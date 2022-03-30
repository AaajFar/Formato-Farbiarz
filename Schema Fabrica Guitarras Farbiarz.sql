DROP SCHEMA IF EXISTS fabrica_guitarras;
CREATE SCHEMA IF NOT EXISTS fabrica_guitarras;
USE fabrica_guitarras;

CREATE TABLE IF NOT EXISTS proveedores
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
);

CREATE TABLE IF NOT EXISTS materiales
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('clavijas', 'microfonos', 'maderas', 'cuerdas') NOT NULL,
marca VARCHAR(60) DEFAULT NULL,
modelo VARCHAR(60) NOT NULL,
descripcion VARCHAR(100),
stock INT NOT NULL,
costo INT NOT NULL
);

CREATE TABLE IF NOT EXISTS proveedores_materiales
(
mat_id INT NOT NULL,
prov_id INT NOT NULL,
PRIMARY KEY(mat_id, prov_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id),
FOREIGN KEY (prov_id) REFERENCES fabrica_guitarras.proveedores(id)
);

CREATE TABLE IF NOT EXISTS guitarras
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('electrica', 'clasica', 'electroacustica', 'clasica nino', 'clasica concierto') NOT NULL,
modelo VARCHAR(60) NOT NULL,
ano YEAR NOT NULL,
stock INT NOT NULL,
precio INT NOT NULL
);

CREATE TABLE IF NOT EXISTS materiales_guitarras
(
mat_id INT NOT NULL,
guit_id INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (mat_id, guit_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id),
FOREIGN KEY (guit_id) REFERENCES fabrica_guitarras.guitarras(id)
);

CREATE TABLE IF NOT EXISTS clientes
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
direccion VARCHAR(200) DEFAULT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
);

CREATE TABLE IF NOT EXISTS direcciones_envio
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
localidad VARCHAR(60) NOT NULL,
provincia VARCHAR(30) NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id)
);

CREATE TABLE IF NOT EXISTS fabrica_guitarras.pedidos
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente INT NOT NULL,
guit INT NOT NULL,
cantidad INT NOT NULL,
precio INT NOT NULL,
fecha DATE NOT NULL,
dir_envio INT NOT NULL,
FOREIGN KEY (cliente) REFERENCES fabrica_guitarras.clientes(id),
FOREIGN KEY (guit) REFERENCES fabrica_guitarras.guitarras(id),
FOREIGN KEY (dir_envio) REFERENCES fabrica_guitarras.direcciones_envio(id)
);
