-- Crear la base de datos
CREATE DATABASE ferreteria;

-- Usar la base de datos
USE ferreteria;

-- Crear la tabla producto
CREATE TABLE producto (
    cod_producto INT AUTO_INCREMENT PRIMARY KEY,
    nom_producto VARCHAR(100),
    precio VARCHAR(50)
);

-- Crear la tabla venta
	CREATE TABLE venta (
		cod_venta INT PRIMARY KEY AUTO_INCREMENT,
		nom_cliente VARCHAR(100),
		dni VARCHAR(8),
		telefono VARCHAR(9),
		fecha VARCHAR(11),
		ruc VARCHAR(11),
		subtotal DECIMAL(10, 2),
		total DECIMAL(10, 2)
	);

-- Crear la tabla usuario para manejar el inicio de sesión
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);