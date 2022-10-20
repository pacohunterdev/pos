-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-09-2022 a las 16:49:43
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombreCategoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombreCategoria`) VALUES
(1, 'LIBRETAS'),
(2, 'LAPICES'),
(3, 'COLORES DE MADERA'),
(4, 'PLUMONES'),
(5, 'CRAYOLAS'),
(8, 'ARTICULOS DE OFICINA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `telefono`) VALUES
(1, 'paco rivera bernabe', '2311459874'),
(2, 'canela perez', '2311469874'),
(3, 'ejemplo de cliente', ''),
(4, 'ejemplo de otro cliente', '231213456987'),
(5, 'otrooooo clienteee', ''),
(7, 'Lars Montriel', '231212315121');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `nombre` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`nombre`, `telefono`, `logo`) VALUES
('Tienda de conveniencia Spiderman', '777666123', './logos/logo.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cotizaciones`
--

INSERT INTO `cotizaciones` (`id`, `fecha`, `total`, `idCliente`, `idUsuario`) VALUES
(1, '2022-07-03 16:33:23', '1162.00', 2, 1),
(2, '2022-07-03 16:36:43', '1000.00', 1, 1),
(4, '2022-07-06 14:33:04', '4518.00', 2, 1),
(5, '2022-07-06 18:10:45', '1342.00', 2, 1),
(6, '2022-08-01 09:54:23', '6594.00', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_apartados`
--

CREATE TABLE `cuentas_apartados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `pagado` decimal(9,2) NOT NULL,
  `porPagar` decimal(9,2) NOT NULL,
  `tipo` enum('apartado','cuenta') NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuentas_apartados`
--

INSERT INTO `cuentas_apartados` (`id`, `fecha`, `total`, `pagado`, `porPagar`, `tipo`, `idCliente`, `idUsuario`) VALUES
(1, '2022-06-25 17:30:03', '1000.00', '1000.00', '0.00', 'cuenta', 2, 1),
(2, '2022-06-25 17:36:09', '1000.00', '1000.00', '0.00', 'apartado', 1, 1),
(3, '2022-06-25 17:53:10', '1000.00', '900.00', '100.00', 'cuenta', 1, 1),
(4, '2022-06-25 17:53:25', '1000.00', '1000.00', '0.00', 'apartado', 2, 1),
(5, '2022-07-03 17:53:15', '22.00', '22.00', '0.00', 'cuenta', 1, 1),
(6, '2022-07-03 18:13:16', '1000.00', '300.00', '700.00', 'apartado', 4, 1),
(7, '2022-07-06 18:09:30', '300.00', '50.00', '250.00', 'cuenta', 2, 1),
(8, '2022-07-06 18:10:14', '1022.00', '0.00', '1022.00', 'apartado', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombreMarca` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id`, `nombreMarca`) VALUES
(1, 'NORMA'),
(2, 'SCRIBE'),
(3, 'MAPED'),
(4, 'PELIKAN'),
(5, 'BIC'),
(6, 'PAPER MATE'),
(7, 'KIUT'),
(10, 'SHARPIE'),
(11, 'ESTRELLA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `precioCompra` decimal(8,2) NOT NULL,
  `precioVenta` decimal(8,2) NOT NULL,
  `existencia` int(11) NOT NULL,
  `vendidoMayoreo` tinyint(1) DEFAULT NULL,
  `precioMayoreo` decimal(8,2) DEFAULT NULL,
  `cantidadMayoreo` decimal(8,2) DEFAULT NULL,
  `marca` bigint(20) UNSIGNED DEFAULT NULL,
  `categoria` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `nombre`, `precioCompra`, `precioVenta`, `existencia`, `vendidoMayoreo`, `precioMayoreo`, `cantidadMayoreo`, `marca`, `categoria`) VALUES
(1, '1321355155', 'Bocina', '500.00', '1000.00', 25, 0, '0.00', '0.00', 0, 0),
(2, '12123146556415', 'Libreta de Call of duty', '15.00', '22.00', 99, 0, '0.00', '0.00', 1, 1),
(3, '113241564546', 'Cuaderno cosido ', '15.00', '22.00', 66, 1, '13.00', '10.00', 2, 1),
(4, '1321354564', 'Lapiz bonito', '5.00', '10.00', 453, 1, '8.00', '20.00', 3, 2),
(6, '12131212545454', 'Mouse inalámbrico ', '50.00', '100.00', 96, 0, '0.00', '0.00', 0, 0),
(7, '11321345495', 'Teclado inálambrico', '105.00', '200.00', 496, 0, '0.00', '0.00', 0, 0),
(8, '1213221', 'Calculadora', '25.00', '28.00', 11, 0, '0.00', '0.00', 0, 0),
(9, '123135135487487', 'Goma pelikan strike', '1.54', '4.00', 3, 1, '3.00', '20.00', 4, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_vendidos`
--

CREATE TABLE `productos_vendidos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` decimal(5,2) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `idProducto` bigint(20) NOT NULL,
  `idReferencia` bigint(20) NOT NULL,
  `tipo` enum('apartado','cuenta','venta','cotiza') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos_vendidos`
--

INSERT INTO `productos_vendidos` (`id`, `cantidad`, `precio`, `idProducto`, `idReferencia`, `tipo`) VALUES
(1, '1.00', '1000.00', 1, 1, 'cuenta'),
(2, '1.00', '20.00', 3, 1, 'venta'),
(3, '1.00', '22.00', 2, 1, 'venta'),
(4, '1.00', '1000.00', 1, 2, 'apartado'),
(5, '1.00', '22.00', 2, 2, 'venta'),
(6, '1.00', '10.00', 4, 2, 'venta'),
(7, '1.00', '1000.00', 1, 3, 'cuenta'),
(8, '1.00', '1000.00', 1, 4, 'apartado'),
(9, '1.00', '22.00', 2, 3, 'venta'),
(10, '1.00', '10.00', 4, 3, 'venta'),
(11, '1.00', '1000.00', 1, 4, 'venta'),
(12, '1.00', '22.00', 3, 5, 'venta'),
(13, '5.00', '22.00', 2, 6, 'venta'),
(14, '15.00', '13.00', 3, 7, 'venta'),
(15, '1.00', '22.00', 2, 8, 'venta'),
(16, '1.00', '22.00', 3, 9, 'venta'),
(17, '3.00', '22.00', 2, 1, 'cotiza'),
(18, '3.00', '10.00', 4, 1, 'cotiza'),
(19, '1.00', '1000.00', 1, 1, 'cotiza'),
(20, '3.00', '22.00', 3, 1, 'cotiza'),
(21, '100.00', '8.00', 4, 2, 'cotiza'),
(22, '1.00', '22.00', 3, 5, 'cuenta'),
(23, '1.00', '1000.00', 1, 6, 'apartado'),
(29, '4.00', '22.00', 3, 4, 'cotiza'),
(30, '3.00', '10.00', 4, 4, 'cotiza'),
(31, '3.00', '1000.00', 1, 4, 'cotiza'),
(32, '5.00', '200.00', 7, 4, 'cotiza'),
(33, '4.00', '100.00', 6, 4, 'cotiza'),
(34, '10.00', '22.00', 3, 10, 'venta'),
(35, '2.00', '10.00', 4, 10, 'venta'),
(36, '2.00', '100.00', 6, 10, 'venta'),
(37, '1.00', '200.00', 7, 10, 'venta'),
(38, '2.00', '22.00', 3, 11, 'venta'),
(39, '2.00', '10.00', 4, 11, 'venta'),
(40, '1.00', '100.00', 6, 12, 'venta'),
(41, '1.00', '200.00', 7, 12, 'venta'),
(42, '1.00', '22.00', 2, 12, 'venta'),
(43, '1.00', '10.00', 4, 12, 'venta'),
(44, '1.00', '200.00', 7, 13, 'venta'),
(45, '10.00', '10.00', 4, 14, 'venta'),
(46, '1.00', '100.00', 6, 7, 'cuenta'),
(47, '1.00', '200.00', 7, 7, 'cuenta'),
(48, '1.00', '1000.00', 1, 8, 'apartado'),
(49, '1.00', '22.00', 2, 8, 'apartado'),
(50, '2.00', '10.00', 4, 5, 'cotiza'),
(51, '1.00', '200.00', 7, 5, 'cotiza'),
(52, '1.00', '100.00', 6, 5, 'cotiza'),
(53, '1.00', '1000.00', 1, 5, 'cotiza'),
(54, '1.00', '22.00', 3, 5, 'cotiza'),
(55, '3.00', '22.00', 3, 15, 'venta'),
(56, '2.00', '10.00', 4, 16, 'venta'),
(57, '1.00', '22.00', 3, 16, 'venta'),
(58, '8.00', '4.00', 9, 17, 'venta'),
(59, '10.00', '10.00', 4, 17, 'venta'),
(60, '7.00', '22.00', 3, 6, 'cotiza'),
(61, '6.00', '1000.00', 1, 6, 'cotiza'),
(62, '20.00', '22.00', 2, 6, 'cotiza');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `nombre`, `telefono`, `password`) VALUES
(1, 'paco_hunter_dev', 'Francisco Rivera Hills', '2311459874', '$2y$10$gzUnjFNk5SUh3yGh2OXYeuIDtkzqUCGnJUnThqXjWoVU0/C9QCJb.'),
(2, 'janiss', 'Janis Joplin Perez', '6554789512', '$2y$10$foxks8Dg7NMu95HiTUbdhOeA4sqTPzdLTaja3ktHNYlizPq34AlwK'),
(3, 'robert_espy', 'Robert Rodriguez', '231456984', '$2y$10$d8v/L9j9bnWZTd5FkL8HxeNI0159F1inhGlJSMApHZoCwLuiYFomG'),
(5, 'popeye', 'Popeye el marino', '23112314523125', '$2y$10$PFR9QYZ8viczcxU6s87IjuNKu70IdEEuIjGI3H1Ar9qYU7Ix2aSTi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `total` decimal(9,2) NOT NULL,
  `pagado` decimal(9,2) NOT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `idUsuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fecha`, `total`, `pagado`, `idCliente`, `idUsuario`) VALUES
(1, '2022-06-25 17:30:52', '42.00', '50.00', 0, 1),
(2, '2022-06-25 17:52:56', '32.00', '50.00', 0, 1),
(3, '2022-06-28 13:38:54', '32.00', '50.00', 0, 1),
(4, '2022-06-28 14:48:09', '1000.00', '1000.00', 1, 1),
(5, '2022-07-01 16:43:50', '22.00', '30.00', 0, 1),
(6, '2022-07-01 17:25:46', '110.00', '200.00', 0, 1),
(7, '2022-07-02 18:05:34', '195.00', '200.00', 0, 1),
(8, '2022-07-02 18:15:48', '22.00', '50.00', 0, 1),
(9, '2022-07-02 18:18:22', '22.00', '50.00', 0, 1),
(10, '2022-07-06 14:57:27', '640.00', '1000.00', 0, 1),
(11, '2022-07-06 17:56:18', '64.00', '100.00', 0, 1),
(12, '2022-07-06 17:59:02', '332.00', '332.00', 0, 1),
(13, '2022-07-06 17:59:27', '200.00', '200.00', 2, 2),
(14, '2022-07-06 18:09:03', '100.00', '100.00', 0, 2),
(15, '2022-07-15 13:20:43', '66.00', '100.00', 0, 1),
(16, '2022-07-15 16:41:45', '42.00', '50.00', 4, 1),
(17, '2022-07-15 16:43:23', '132.00', '500.00', 0, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuentas_apartados`
--
ALTER TABLE `cuentas_apartados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuentas_apartados`
--
ALTER TABLE `cuentas_apartados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
