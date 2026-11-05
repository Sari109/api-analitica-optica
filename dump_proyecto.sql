-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-11-2026 a las 04:59:40
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

CREATE DATABASE IF NOT EXISTS optica;
USE optica;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `optica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre`) VALUES
(15, 'Accesorios de cuidado'),
(14, 'Cadenas para gafas'),
(13, 'Estuches'),
(10, 'Gafas de lectura'),
(9, 'Gafas deportivas'),
(8, 'Lentes con filtro de luz azul'),
(5, 'Lentes de contacto'),
(4, 'Lentes de sol'),
(7, 'Lentes fotocromáticos'),
(6, 'Lentes oftálmicos'),
(11, 'Líquidos de limpieza'),
(1, 'Monturas de acetato'),
(3, 'Monturas infantiles'),
(2, 'Monturas metálicas'),
(12, 'Paños de microfibra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'Programada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `id_cliente`, `id_usuario`, `fecha`, `hora`, `estado`) VALUES
(1, 1, 3, '2026-10-05', '09:00:00', 'Atendida'),
(2, 2, 3, '2026-10-05', '10:00:00', 'Atendida'),
(3, 3, 4, '2026-10-06', '08:30:00', 'Atendida'),
(4, 4, 3, '2026-10-07', '14:00:00', 'Atendida'),
(5, 5, 4, '2026-10-08', '15:30:00', 'Atendida'),
(6, 6, 3, '2026-10-09', '11:00:00', 'Cancelada'),
(7, 7, 5, '2026-10-12', '09:30:00', 'Atendida'),
(8, 8, 3, '2026-10-13', '16:00:00', 'Atendida'),
(9, 9, 4, '2026-10-14', '10:30:00', 'Atendida'),
(10, 10, 3, '2026-10-15', '08:00:00', 'Atendida'),
(11, 11, 4, '2026-10-16', '13:30:00', 'Atendida'),
(12, 1, 3, '2026-10-26', '09:00:00', 'Programada'),
(13, 13, 4, '2026-10-27', '10:00:00', 'Programada'),
(14, 5, 3, '2026-10-28', '15:00:00', 'Programada'),
(15, 15, 5, '2026-10-29', '11:30:00', 'Programada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cedula` varchar(15) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `apellido`, `cedula`, `telefono`, `correo`) VALUES
(1, 'María', 'Pérez', '1067890123', '3001234567', 'maria.perez@gmail.com'),
(2, 'Carlos', 'Ramírez', '1067890456', '3012345678', 'carlos.ramirez@gmail.com'),
(3, 'Ana', 'Martínez', '1067891789', '3023456789', 'ana.martinez@hotmail.com'),
(4, 'Luis', 'Hernández', '1067892012', '3034567890', 'luis.hernandez@gmail.com'),
(5, 'Camila', 'Torres', '1067893345', '3045678901', 'camila.torres@gmail.com'),
(6, 'Juan', 'Gómez', '1067894678', '3056789012', 'juan.gomez@outlook.com'),
(7, 'Valentina', 'Díaz', '1067895901', '3067890123', 'valentina.diaz@gmail.com'),
(8, 'Andrés', 'López', '1067896234', '3078901234', 'andres.lopez@gmail.com'),
(9, 'Sofía', 'Vargas', '1067897567', '3089012345', 'sofia.vargas@hotmail.com'),
(10, 'Daniel', 'Castro', '1067898890', '3090123456', 'daniel.castro@gmail.com'),
(11, 'Laura', 'Mendoza', '1067899123', '3101234567', 'laura.mendoza@gmail.com'),
(12, 'Jorge', 'Ortega', '1067800456', '3112345678', 'jorge.ortega@gmail.com'),
(13, 'Paola', 'Suárez', '1067801789', '3123456789', 'paola.suarez@outlook.com'),
(14, 'Miguel', 'Rojas', '1067802012', '3134567890', 'miguel.rojas@gmail.com'),
(15, 'Isabela', 'Jiménez', '1067803345', '3145678901', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id_compra`, `id_proveedor`, `fecha`, `total`) VALUES
(1, 1, '2026-09-01', 2100000.00),
(2, 2, '2026-09-03', 600000.00),
(3, 3, '2026-09-05', 1780000.00),
(4, 4, '2026-09-08', 1100000.00),
(5, 5, '2026-09-10', 1500000.00),
(6, 6, '2026-09-12', 2900000.00),
(7, 7, '2026-09-15', 840000.00),
(8, 8, '2026-09-17', 430000.00),
(9, 9, '2026-09-20', 300000.00),
(10, 10, '2026-09-22', 160000.00),
(11, 11, '2026-09-25', 165000.00),
(12, 12, '2026-09-28', 950000.00),
(13, 13, '2026-10-02', 840000.00),
(14, 14, '2026-10-06', 320000.00),
(15, 15, '2026-10-09', 920000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_detalle_compra` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id_detalle_compra`, `id_compra`, `id_producto`, `cantidad`, `precio_compra`) VALUES
(1, 1, 1, 10, 95000.00),
(2, 1, 2, 10, 115000.00),
(3, 2, 3, 10, 60000.00),
(4, 3, 4, 8, 140000.00),
(5, 3, 9, 6, 110000.00),
(6, 4, 5, 20, 55000.00),
(7, 5, 6, 20, 75000.00),
(8, 6, 7, 10, 170000.00),
(9, 6, 8, 10, 120000.00),
(10, 7, 10, 30, 28000.00),
(11, 8, 11, 40, 7000.00),
(12, 8, 12, 50, 3000.00),
(13, 9, 13, 30, 10000.00),
(14, 10, 14, 20, 8000.00),
(15, 11, 15, 30, 5500.00),
(16, 12, 1, 10, 95000.00),
(17, 13, 4, 6, 140000.00),
(18, 14, 13, 20, 10000.00),
(19, 14, 14, 15, 8000.00),
(20, 15, 2, 8, 115000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle_venta` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_vendido` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle_venta`, `id_venta`, `id_producto`, `cantidad`, `precio_vendido`) VALUES
(1, 1, 1, 1, 150000.00),
(2, 1, 13, 1, 18000.00),
(3, 2, 6, 2, 120000.00),
(4, 2, 11, 1, 12000.00),
(5, 3, 3, 1, 95000.00),
(6, 4, 4, 1, 220000.00),
(7, 4, 12, 2, 6000.00),
(8, 5, 5, 2, 85000.00),
(9, 6, 8, 1, 190000.00),
(10, 6, 14, 1, 15000.00),
(11, 7, 2, 1, 180000.00),
(12, 7, 6, 2, 120000.00),
(13, 8, 10, 1, 45000.00),
(14, 9, 7, 1, 260000.00),
(15, 10, 9, 1, 175000.00),
(16, 11, 11, 2, 12000.00),
(17, 11, 12, 3, 6000.00),
(18, 12, 1, 1, 150000.00),
(19, 12, 8, 2, 190000.00),
(20, 13, 15, 1, 10000.00),
(21, 13, 13, 1, 18000.00),
(22, 14, 2, 1, 180000.00),
(23, 14, 14, 2, 15000.00),
(24, 15, 4, 1, 220000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `id_categoria`, `nombre`, `precio_venta`, `stock`) VALUES
(1, 1, 'Montura de acetato clásica negra', 150000.00, 25),
(2, 2, 'Montura metálica dorada', 180000.00, 20),
(3, 3, 'Montura infantil flexible azul', 95000.00, 18),
(4, 4, 'Gafas de sol polarizadas aviador', 220000.00, 15),
(5, 5, 'Lentes de contacto mensuales (caja x6)', 85000.00, 30),
(6, 6, 'Lente oftálmico monofocal', 120000.00, 40),
(7, 7, 'Lente fotocromático', 260000.00, 22),
(8, 8, 'Lente con filtro de luz azul', 190000.00, 28),
(9, 9, 'Gafas deportivas para ciclismo', 175000.00, 12),
(10, 10, 'Gafas de lectura +1.50', 45000.00, 50),
(11, 11, 'Líquido limpiador de lentes 60 ml', 12000.00, 60),
(12, 12, 'Paño de microfibra', 6000.00, 100),
(13, 13, 'Estuche rígido para gafas', 18000.00, 45),
(14, 14, 'Cadena para gafas', 15000.00, 35),
(15, 15, 'Kit de reparación (tornillos y destornillador)', 10000.00, 40),
(16, 1, 'Montura de acetato carey', 150000.00, 10),
(17, 2, 'Montura metálica plateada', 180000.00, 8),
(18, 4, 'Gafas de sol clásicas', 220000.00, 6),
(19, 6, 'Lente oftálmico bifocal', 120000.00, 12),
(20, 12, 'Paño de microfibra grande', 10000.00, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `telefono`, `correo`) VALUES
(1, 'Ópticas del Caribe S.A.S.', '3109876543', 'ventas@opticascaribe.com'),
(2, 'Distribuidora Visión Total', '3118765432', 'contacto@visiontotal.com'),
(3, 'Lentes y Monturas Andinas', '3127654321', 'pedidos@lmandinas.com'),
(4, 'Importadora Ray Optic', '3136543210', 'ventas@rayoptic.com'),
(5, 'Cristales del Sinú', '3145432109', 'info@cristalesdelsinu.com'),
(6, 'Laboratorio Óptico Central', '3154321098', 'lab@opticocentral.com'),
(7, 'Gafas y Estilo Ltda.', '3163210987', 'ventas@gafasyestilo.com'),
(8, 'Suministros Ópticos del Norte', '3172109876', 'compras@opticosnorte.com'),
(9, 'ProVisión Colombia', '3181098765', 'ventas@provision.co'),
(10, 'Lentes de Contacto Express', '3190987654', 'pedidos@lcexpress.com'),
(11, 'Accesorios Ópticos Medellín', '3201876543', 'info@accopticos.com'),
(12, 'Montura Prime Distribuciones', '3212765432', 'ventas@monturaprime.com'),
(13, 'Sol y Vista Importaciones', '3223654321', 'contacto@solyvista.com'),
(14, 'Insumos Visuales del Caribe', '3234543210', 'insumos@visualescaribe.com'),
(15, 'Óptica Mayorista Bogotá', '3245432109', 'mayorista@opticabogota.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `usuario`, `contrasena`, `rol`) VALUES
(1, 'Administrador General', 'admin', 'admin123', 'Administrador'),
(2, 'Patricia Salcedo', 'psalcedo', 'psalcedo123', 'Administrador'),
(3, 'Laura Gómez', 'lgomez', 'lgomez123', 'Optometrista'),
(4, 'Ricardo Pineda', 'rpineda', 'rpineda123', 'Optometrista'),
(5, 'Natalia Báez', 'nbaez', 'nbaez123', 'Optometrista'),
(6, 'Felipe Arrieta', 'farrieta', 'farrieta123', 'Optometrista'),
(7, 'Diana Cogollo', 'dcogollo', 'dcogollo123', 'Optometrista'),
(8, 'Sebastián Montes', 'smontes', 'smontes123', 'Optometrista'),
(9, 'Karen Ballesteros', 'kballesteros', 'kballesteros123', 'Optometrista'),
(10, 'Alejandro Pastrana', 'apastrana', 'apastrana123', 'Optometrista'),
(11, 'Yuliana Doria', 'ydoria', 'ydoria123', 'Optometrista'),
(12, 'Camilo Berrío', 'cberrio', 'cberrio123', 'Optometrista'),
(13, 'Mariana Lozano', 'mlozano', 'mlozano123', 'Optometrista'),
(14, 'Esteban Hoyos', 'ehoyos', 'ehoyos123', 'Optometrista'),
(15, 'Viviana Tapia', 'vtapia', 'vtapia123', 'Optometrista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `id_cliente`, `id_usuario`, `fecha`, `total`) VALUES
(1, 1, 1, '2026-08-05', 168000.00),
(2, 2, 1, '2026-08-05', 252000.00),
(3, 3, 2, '2026-08-06', 95000.00),
(4, 4, 1, '2026-08-07', 232000.00),
(5, 5, 2, '2026-08-08', 170000.00),
(6, 7, 1, '2026-09-12', 205000.00),
(7, 8, 2, '2026-09-13', 420000.00),
(8, 9, 1, '2026-09-14', 45000.00),
(9, 10, 2, '2026-09-15', 260000.00),
(10, 11, 1, '2026-09-16', 175000.00),
(11, 6, 2, '2026-10-16', 42000.00),
(12, 12, 1, '2026-10-17', 530000.00),
(13, 1, 2, '2026-10-19', 28000.00),
(14, 14, 1, '2026-10-20', 210000.00),
(15, 15, 2, '2026-10-20', 220000.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `cedula` (`cedula`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_detalle_compra`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle_venta`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
