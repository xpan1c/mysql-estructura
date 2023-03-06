-- MySQL Script generated by MySQL Workbench
-- Fri Feb 24 18:56:31 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;
-- -----------------------------------------------------
-- Table `pizzeria`.`direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`direccion` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`direccion` (
  `id` INT NOT NULL,
  `direccion` VARCHAR(255) NULL,
  `codigo_postal` INT NULL,
  `localidad` VARCHAR(45) NULL,
  `provincia` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`cliente` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(255) NULL,
  `telefono` VARCHAR(42) NULL,
  `direccion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_direccion_idx` (`direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_direccion`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `pizzeria`.`direccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`tienda` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT NOT NULL,
  `direccion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tienda_direccion1_idx` (`direccion_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_direccion1`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `pizzeria`.`direccion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`empleado` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(255) NULL,
  `nif` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `es_repartidor` TINYINT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleado_tienda1_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`pedido` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id` INT NOT NULL,
  `data_hora` DATE NULL,
  `reparto_domicilio` TINYINT NULL,
  `precio_total` DECIMAL(10,2) NULL,
  `cliente_id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_pedido_empleado1_idx` (`empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`categoria` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`productos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` TEXT NULL,
  `imagen` VARCHAR(255) NULL,
  `precio` DECIMAL(10,2) NULL,
  `tipo_producto` ENUM('PIZZA', 'HAMBURGUESA', 'BEBIDA') NULL,
  `categoria_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `pizzeria`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos_has_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`productos_has_pedido` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos_has_pedido` (
  `productos_id` INT NOT NULL,
  `pedido_id` INT NOT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`productos_id`, `pedido_id`),
  INDEX `fk_productos_has_pedido_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_productos_has_pedido_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_has_pedido_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_has_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insertando datos en la tabla pizzeria.direccion
INSERT INTO pizzeria.direccion (id, direccion, codigo_postal, localidad, provincia) VALUES
(1, 'Calle Principal, 1', 12345, 'Madrid', 'Madrid'),
(2, 'Calle Secundaria, 2', 54321, 'Barcelona', 'Barcelona'),
(3, 'Avenida de la Playa, 3', 45678, 'Valencia', 'Valencia'),
(4, 'Calle de la Luna, 4', 98765, 'Sevilla', 'Sevilla');

-- Insertando datos en la tabla pizzeria.cliente
INSERT INTO pizzeria.cliente (id, nombre, apellidos, telefono, direccion_id) VALUES
(1, 'Juan', 'Gonzalez', '123456789', 1),
(2, 'Ana', 'Perez', '987654321', 2),
(3, 'Pedro', 'Lopez', '456789123', 3),
(4, 'Maria', 'Garcia', '789123456', 4);

-- Insertando datos en la tabla pizzeria.tienda
INSERT INTO pizzeria.tienda (id, direccion_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Insertando datos en la tabla pizzeria.empleado
INSERT INTO pizzeria.empleado (id, nombre, apellidos, nif, telefono, es_repartidor, tienda_id) VALUES
(1, 'Miguel', 'Martinez', '12345678A', '111111111', 1, 1),
(2, 'Sofia', 'Sanchez', '87654321B', '222222222', 1, 2),
(3, 'Jose', 'Garcia', '11111111C', '333333333', 0, 3),
(4, 'Ana', 'Martinez', '22222222D', '444444444', 1, 4);

-- Insertando datos en la tabla pizzeria.pedido
INSERT INTO pizzeria.pedido (id, data_hora, reparto_domicilio, precio_total, cliente_id, empleado_id) VALUES
(1, '2023-02-23', 1, 15.50, 1, 1),
(2, '2023-02-23', 0, 12.50, 2, 2),
(3, '2023-02-24', 1, 18.50, 3, 3),
(4, '2023-02-24', 0, 20.00, 4, 4);
-- Insertar categorías de pizza
INSERT INTO pizzeria.categoria (id, nom) VALUES
(1, 'Clásica'),
(2, 'Vegetariana'),
(3, 'Hawaiana'),
(4, 'Pepperoni'),
(5, 'Margarita');

-- Insertar productos
INSERT INTO pizzeria.productos (id, nombre, descripcion, imagen, precio, tipo_producto, categoria_id) VALUES
(1, 'Pizza Margarita', 'Tomate, mozzarella, albahaca', 'margarita.jpg', 9.99, 'PIZZA', 5),
(2, 'Pizza Pepperoni', 'Tomate, mozzarella, pepperoni', 'pepperoni.jpg', 11.99, 'PIZZA', 4),
(3, 'Pizza Vegetariana', 'Tomate, mozzarella, champiñones, pimiento, cebolla', 'vegetariana.jpg', 10.99, 'PIZZA', 2),
(4, 'Hamburguesa Clásica', 'Carne de res, lechuga, tomate, cebolla, salsa especial', 'hamburguesa.jpg', 8.99, 'HAMBURGUESA', NULL),
(5, 'Coca Cola', 'Refresco de cola', 'cocacola.jpg', 1.99, 'BEBIDA', NULL);

-- Insertar productos del pedido 1
INSERT INTO pizzeria.productos_has_pedido (productos_id, pedido_id, cantidad) VALUES
(1, 1, 1),
(4, 1, 2),
(5, 1, 3);

-- Insertar productos del pedido 2
INSERT INTO pizzeria.productos_has_pedido (productos_id, pedido_id, cantidad) VALUES
(2, 2, 1),
(3, 2, 2),
(5, 2, 1);

-- Insertar productos del pedido 3
INSERT INTO pizzeria.productos_has_pedido (productos_id, pedido_id, cantidad) VALUES
(1, 3, 2),
(2, 3, 1),
(3, 3, 1),
(5, 3, 3);

-- Insertar productos del pedido 4
INSERT INTO pizzeria.productos_has_pedido (productos_id, pedido_id, cantidad) VALUES
(1, 4, 1),
(2, 4, 1),
(4, 4, 2),
(5, 4, 2);
-- Consultas
-- Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.
SELECT COUNT(*)  FROM pizzeria.productos pr JOIN pizzeria.productos_has_pedido pp ON pr.id = pp.productos_id JOIN pizzeria.pedido p ON pp.pedido_id = p.id JOIN pizzeria.empleado e ON  p.empleado_id = e.id JOIN pizzeria.tienda t ON e.tienda_id = t.id JOIN pizzeria.direccion d ON t.direccion_id = d.id WHERE pr.tipo_producto = 'BEBIDA' AND d.localidad = 'Valencia';
-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT empleado_id ,COUNT(*) numero_pedidos FROM pizzeria.pedido p GROUP BY empleado_id;
