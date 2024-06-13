-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2024 a las 04:53:26
-- Versión del servidor: 11.4.0-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `api`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `idCompra` int(11) NOT NULL,
  `numerocompra` varchar(100) NOT NULL,
  `fechacompra` date NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `idProveedor` int(11) NOT NULL,
  `estado` enum('Completada','Anulada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`idCompra`, `numerocompra`, `fechacompra`, `descuento`, `iva`, `subtotal`, `total`, `idProveedor`, `estado`) VALUES
(1, 'NC12345', '2024-06-11', 10.50, 5.25, 100.00, 115.75, 1, 'Completada'),
(2, 'NC12346', '2024-06-12', 15.00, 7.50, 150.00, 172.50, 2, 'Completada'),
(3, 'NC12347', '2024-06-13', 5.00, 2.50, 50.00, 57.50, 3, 'Anulada'),
(4, 'NC12348', '2024-06-14', 20.00, 10.00, 200.00, 230.00, 4, 'Completada'),
(6, 'NC12349', '2024-06-15', 8.00, 4.00, 80.00, 92.00, 2, 'Anulada'),
(7, 'NC12350', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 1, 'Completada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `idDetalle` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `preciounitario` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `idDetalle` int(11) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cantidad` int(10) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nombre`, `cantidad`, `precio`, `estado`) VALUES
(1, 'Lg', 5, 25.00, 'Activo'),
(2, 'Celular', 5, 25.00, 'Activo'),
(3, 'iPhone', 5, 25.00, 'Activo'),
(4, 'Lavadora', 2, 100.00, 'Activo'),
(5, 'Renault 4', 1, 100.00, 'Inactivo'),
(6, 'Cafe granulado', 5, 25.00, 'Activo'),
(7, 'Cafe colado', 5, 25.00, 'Inactivo'),
(8, 'Nevera', 3, 25.00, 'Activo'),
(9, 'Congelador', 1, 100.00, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedor`, `nombre`, `direccion`, `telefono`, `estado`) VALUES
(1, 'Samsung', 'Calle uno', '456789', 'Activo'),
(2, 'Lg', 'Calle dos', '4567890', 'Activo'),
(3, 'Lg', 'Calle tres', '567890', 'Activo'),
(4, 'Lg', 'Calle tres', '567890', 'Inactivo'),
(5, 'Hacer', 'Calle cuatro', '67890', 'Activo'),
(6, 'Cangrejo', 'Calle cinco', '7890', 'Inactivo'),
(7, 'Coltaaco', 'Calle seis', '8904', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `rol` enum('Administrador','Usuario') NOT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL,
  `google` enum('true','false') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `correo`, `contrasena`, `img`, `rol`, `estado`, `google`) VALUES
(1, 'Juan Perez', 'juan.perez@example.com', '$2a$10$cRzsjiX0/5RYv7K5vJ9sNO6LFTjXdAk9vNPfzS986rRxl6ZV3.9Xm', 'juan.jpg', 'Administrador', 'Activo', 'false'),
(2, 'Maria Gomez', 'maria.gomez@example.com', '$2a$10$QsDUgtDzmHIHz2Gg.RG/g.TKWqiDvH0k6G8pDN.jIqONbLeOKUcJy', 'maria.jpg', 'Usuario', 'Inactivo', 'false'),
(3, 'Carlos Ramirez', 'carlos.ramirez@example.com', '$2a$10$l0YPjn3.ooFq1buMkjoLDuh5oWRk2knleF0SXCEp2LZ8rKwAEnQnO', 'carlos.jpg', 'Usuario', 'Inactivo', 'false'),
(4, 'Ana Martinez', 'ana.martinez@example.com', '$2a$10$jA.ZCGa6ZHdMg0QJjz1SXODAz2/LTRRhFRF6YVYG5/LvanS39mSNG', 'ana.jpg', 'Administrador', 'Inactivo', 'false'),
(5, 'Luis Fernandez', 'luis.fernandez@example.com', '$2a$10$mAsaU.CfS/jDBqmg.SKSGOC4lQ0uyhhMWXEndF1Z26I4R6o7sDtTy', 'luis.jpg', 'Usuario', 'Inactivo', 'false'),
(6, 'Laura Sanchez', 'laura.sanchez@example.com', '$2a$10$Us/o.ReQJJTvXlyvWv6esexnyuKkZshAmMMV9Uh55PM7tVVJCHUMm', 'laura.jpg', 'Administrador', 'Inactivo', 'false'),
(7, 'Miguel Torres', 'miguel.torres@example.com', '$2a$10$vnvbBdvIVG01HvUSY.hMSen7K/SP7B5YO.troCvZK3KVxvPNxDHE.', 'miguel.jpg', 'Usuario', 'Inactivo', 'false'),
(8, 'Sofia Ruiz', 'sofia.ruiz@example.com', '$2a$10$zDA2Vyx0EaMp9/3ypKjSG.UgkiEoxkGIpytUhU/WNOnXaTmw0Ex0G', 'sofia.jpg', 'Administrador', 'Activo', 'false'),
(9, 'David Hernandez', 'david.hernandez@example.com', '$2a$10$XrlMzCPa6v7xyxAP7YqbJesCp7uTNLLDDeRuvw9w6C31al973jKai', 'david.jpg', 'Usuario', 'Activo', 'false'),
(10, 'Isabel Castro', 'isabel.castro@example.com', '$2a$10$KwXhxAkGudrLnFZxvPCAqusWjk2OVJbgZpShPKcYgx/puPi7F2OH.', 'isabel.jpg', 'Administrador', 'Activo', 'false'),
(11, 'Jorge Diaz', 'jorge.diaz@example.com', '$2a$10$DlM0NMoeI/fVgI7RD21nuOyceCv64WwttFblt.0ooixv.fGIhDkG2', 'jorge.jpg', 'Usuario', 'Activo', 'false'),
(12, 'Carolina Vega', 'carolina.vega@example.com', '$2a$10$EskdksolS9Qj7njj53bv1ejDfuq9QOhRduADLHLP1QBpQqYhTlTZi', 'carolina.jpg', 'Administrador', 'Inactivo', 'false'),
(13, 'Ricardo Morales', 'ricardo.morales@example.com', '$2a$10$fmrtbuqnv3k2IkDPv/SQxONnWnRqUwznayiXcDQzfqpPFhmp3vSga', 'ricardo.jpg', 'Usuario', 'Activo', 'false'),
(14, 'Patricia Soto', 'patricia.soto@example.com', '$2a$10$3dce7aAKTPTInn0uKvTFm.fDBnw6TAixbQCByiaTSyg4TDEIZl/B2', 'patricia.jpg', 'Administrador', 'Activo', 'false'),
(15, 'Eduardo Peña', 'eduardo.pena@example.com', '$2a$10$ZnlPMv6iSFXb6l1pctjq5eZmNPKk74Q9gzq.yXlpFwnB5MTkM3RhO', 'eduardo.jpg', 'Usuario', 'Activo', 'false'),
(16, 'Valeria Castillo', 'valeria.castillo@example.com', '$2a$10$ToxRAHrzevFJggrs4UACQOr8Jh3ztxRtgVmf.gvCfxGbQTTyJ5PzO', 'valeria.jpg', 'Administrador', 'Activo', 'false'),
(17, 'Alejandro Ortiz', 'alejandro.ortiz@example.com', '$2a$10$B/rvx2IUt7/5e1q1/kH/6e1cqTTngZsffWMLFRv9fgJuBhbNbVPJa', 'alejandro.jpg', 'Usuario', 'Activo', 'false'),
(18, 'Gabriela Muñoz', 'gabriela.munoz@example.com', '$2a$10$eozghDBa6QIF0.wCy5dREuBd8RsJ5WseyAfPLdxh02UkJO11bM7VC', 'gabriela.jpg', 'Administrador', 'Activo', 'false'),
(19, 'Fernando Rojas', 'fernando.rojas@example.com', '$2a$10$TxKVf2I6Z4U8SGFRyFkfTe2SVzkUYcdlKKpJP2mf8v5onyizpMyNy', 'fernando.jpg', 'Usuario', 'Activo', 'false'),
(20, 'Camila Morales', 'camila.morales@example.com', '$2a$10$PgVwDyfs0c5baqajRvoMtOrlEIbfAzRQdhR9bipDGlGLOWwoQunCi', 'camila.jpg', 'Administrador', 'Inactivo', 'false'),
(21, 'Wendy', 'wendy@example.com', '$2a$10$KE/mKtR8p7dGlXidCwADDuNNzFwl4Q0FkaDe5UdVJyc4W0ccPNNEi', 'wendy.jpg', 'Usuario', 'Activo', 'false'),
(22, 'Karen', 'karen@example.com', '$2a$10$iPjJ/IPX47khUVRENf2/K.AvYWk3Zxv9iB/VTPPtsk.EjAlP34VnS', '', 'Usuario', 'Activo', 'false');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` int(11) NOT NULL,
  `nombreCliente` varchar(100) NOT NULL,
  `fechaVenta` date NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Realizada','Anulada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `nombreCliente`, `fechaVenta`, `descuento`, `iva`, `subtotal`, `total`, `estado`) VALUES
(1, 'Alejandro', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(2, 'Daniel', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(3, 'Andrea', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(4, 'Camila', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(5, 'Eduardo', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(6, 'Faber', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada'),
(7, 'Luz', '2024-06-16', 25.00, 12.50, 250.00, 287.50, 'Realizada');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `idProveedor` (`idProveedor`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`idDetalle`),
  ADD KEY `idCompra` (`idCompra`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`idDetalle`),
  ADD KEY `idVenta` (`idVenta`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVenta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `idCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `idDetalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `idDetalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`idCompra`) REFERENCES `compras` (`idCompra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
