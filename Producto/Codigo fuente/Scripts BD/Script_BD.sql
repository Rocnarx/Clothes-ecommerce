-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-02-2025 a las 02:03:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fis`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTUALIZAR_STOCK` (IN `estampa` INT)   BEGIN
	DECLARE stockInicial INT;
    SELECT e.stock INTO stockInicial FROM estampas e WHERE e.codigoEstampa = estampa;
	UPDATE estampas SET stock = stockInicial-1 WHERE codigoEstampa = estampa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ARTISTAS_MAS_VENDIDOS` (IN `limite` INT)   BEGIN
	IF limite>0 THEN
		SELECT a.username, SUM(dv.cantidad) AS total
		FROM Estampas e
		JOIN detallesventas dv ON dv.codigoEstampa = e.codigoEstampa
		JOIN Usuarios a ON a.cedula = e.cedula
		GROUP BY a.username LIMIT limite;
	ELSE
		SELECT a.username, SUM(dv.cantidad) AS total
		FROM Estampas e
		JOIN detallesventas dv ON dv.codigoEstampa = e.codigoEstampa
		JOIN Usuarios a ON a.cedula = e.cedula
		GROUP BY a.username;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CLIENTES_TOTALES` ()   BEGIN
	SELECT 
		SUM(CASE WHEN idRol = 1 THEN 1 ELSE 0 END) AS total
	FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTAMPAS_MAS_VENDIDAS` (IN `limite` INT)   BEGIN
	IF limite>0 THEN
		SELECT e.nombreEstampa, SUM(dv.cantidad) AS total
		FROM detallesventas dv JOIN estampas e ON dv.codigoEstampa = e.codigoEstampa
		GROUP BY e.codigoEstampa LIMIT limite;
    ELSE
		SELECT e.nombreEstampa, SUM(dv.cantidad) AS total
		FROM detallesventas dv JOIN estampas e ON dv.codigoEstampa = e.codigoEstampa
		GROUP BY e.codigoEstampa;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ESTAMPAS_STOCK` ()   BEGIN
	SELECT 1;
	/*
    ¿ACA QUE?
    */
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RECAUDO_ARTISTAS` (IN `cedula` INT)   BEGIN
	IF cedula=0 THEN
		SELECT u.username, SUM(dv.precioUnitario * dv.cantidad) AS total
		FROM detallesventas dv 
		JOIN Estampas e ON dv.codigoEstampa = e.codigoEstampa
		JOIN Usuarios u ON e.cedula = u.cedula
		GROUP BY u.username;
	ELSE
		SELECT u.username, SUM(dv.precioUnitario * dv.cantidad) AS total
		FROM detallesventas dv 
		JOIN Estampas e ON dv.codigoEstampa = e.codigoEstampa
		JOIN Usuarios u ON e.cedula = u.cedula;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TOTAL_RECAUDADO` ()   BEGIN
	SELECT SUM(totalCompra) AS total FROM VENTAS;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VENTAS_TOTALES` ()   BEGIN
	SELECT COUNT(idVenta) AS total FROM ventas;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesventas`
--

CREATE TABLE `detallesventas` (
  `idDetalleVenta` int(11) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `codigoEstampa` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT 'Blanco',
  `talla` varchar(5) NOT NULL DEFAULT 'M',
  `material` varchar(20) NOT NULL DEFAULT 'Algodon',
  `ubicacionEstampa` varchar(20) NOT NULL DEFAULT 'Central',
  `tamañoEstampa` varchar(20) NOT NULL DEFAULT 'Mediano',
  `diseño` varchar(30) NOT NULL DEFAULT 'Predeterminado',
  `descripcionPersonalizada` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallesventas`
--

INSERT INTO `detallesventas` (`idDetalleVenta`, `idVenta`, `codigoEstampa`, `cantidad`, `precioUnitario`, `color`, `talla`, `material`, `ubicacionEstampa`, `tamañoEstampa`, `diseño`, `descripcionPersonalizada`) VALUES
(1, 1, 9, 20, 10000.00, 'blanco', 'M', 'algodon', 'central', 'mediano', 'predeterminado', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estampas`
--

CREATE TABLE `estampas` (
  `codigoEstampa` int(11) NOT NULL,
  `nombreEstampa` varchar(30) DEFAULT NULL,
  `descripcionEstampa` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `imagen` varchar(200) DEFAULT NULL,
  `cedula` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estampas`
--

INSERT INTO `estampas` (`codigoEstampa`, `nombreEstampa`, `descripcionEstampa`, `precio`, `stock`, `imagen`, `cedula`) VALUES
(9, 'Spiderman', 'Estampita Spide', 10000.00, 10, 'http://localhost:4000/src/public/imagenes-estampas/Spider-Man-1739142994294.jpeg', 1023302262);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `nombreRol`) VALUES
(1, 'Cliente'),
(2, 'Artista'),
(3, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `cedula` bigint(20) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `username` varchar(15) DEFAULT NULL,
  `contraseña` varchar(100) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` bigint(20) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`cedula`, `nombre`, `username`, `contraseña`, `direccion`, `telefono`, `idRol`) VALUES
(1023302261, 'Juan Pablo Angulo', 'Crew', '$2b$05$WOT2KvEt0NCwe3eomxTaPu6DLLZI1TtSRvXI5Oez.5Qd766.dFtHO', 'Calle 142 #13 -47', 3224118958, 1),
(1023302262, 'Leonardo Da Vinci', 'LeoVi', '$2b$05$xbftuXeywaSgLnU4eTGdSecGdRwY324PuSla65D8zRNKUYbzWGaeW', 'Calle Italia # Renacimiento ', 3224118958, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` int(11) NOT NULL,
  `fechaCompra` datetime DEFAULT current_timestamp(),
  `cedula` bigint(20) NOT NULL,
  `totalCompra` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `fechaCompra`, `cedula`, `totalCompra`) VALUES
(1, '2025-02-10 09:57:46', 1023302261, 200000.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detallesventas`
--
ALTER TABLE `detallesventas`
  ADD PRIMARY KEY (`idDetalleVenta`),
  ADD KEY `idVenta` (`idVenta`),
  ADD KEY `codigoEstampa` (`codigoEstampa`);

--
-- Indices de la tabla `estampas`
--
ALTER TABLE `estampas`
  ADD PRIMARY KEY (`codigoEstampa`),
  ADD KEY `cedula` (`cedula`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`cedula`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idRol` (`idRol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `cedula` (`cedula`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detallesventas`
--
ALTER TABLE `detallesventas`
  MODIFY `idDetalleVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `estampas`
--
ALTER TABLE `estampas`
  MODIFY `codigoEstampa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detallesventas`
--
ALTER TABLE `detallesventas`
  ADD CONSTRAINT `detallesventas_ibfk_1` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `detallesventas_ibfk_2` FOREIGN KEY (`codigoEstampa`) REFERENCES `estampas` (`codigoEstampa`) ON DELETE CASCADE;

--
-- Filtros para la tabla `estampas`
--
ALTER TABLE `estampas`
  ADD CONSTRAINT `estampas_ibfk_3` FOREIGN KEY (`cedula`) REFERENCES `usuarios` (`cedula`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `usuarios` (`cedula`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
