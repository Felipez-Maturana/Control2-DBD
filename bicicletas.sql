-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-05-2017 a las 10:48:19
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bicicletas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anuncios`
--

CREATE TABLE `anuncios` (
  `id_anuncio` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `texto` varchar(40) NOT NULL,
  `visitas` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `anuncios`
--

INSERT INTO `anuncios` (`id_anuncio`, `id_usuario`, `texto`, `visitas`, `fecha`) VALUES
(1, 1, 'anuncio1', 5, '2017-05-23'),
(2, 2, 'texto2', 7, '2017-04-30'),
(3, 2, 'texto3', 50, '2017-05-02'),
(4, 4, 'texto4', 60, '2017-04-30'),
(6, 2, 'usuario2', 400, '2017-05-17'),
(7, 1, 'usuario1', 500, '2017-05-30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_anuncio` int(11) NOT NULL,
  `texto` varchar(20) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `id_usuario`, `id_anuncio`, `texto`, `fecha`) VALUES
(1, 1, 2, 'usuario1 anuncio2', '2017-05-31'),
(2, 3, 1, 'usuario3anuncio1', '2017-05-24'),
(3, 2, 3, 'usuario2anuncio3', '2017-05-29'),
(4, 4, 4, 'usuario4anuncio4', '2017-05-27'),
(5, 4, 2, 'usuario4anuncio2', '2017-05-18');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `comentariosporuser`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `comentariosporuser` (
`id_usuario` int(11)
,`anuncioscomentados30Abril` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `publicaciones30abril`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `publicaciones30abril` (
`id_anuncio` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `publicacionsmaximo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `publicacionsmaximo` (
`maximo` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `usuarioanuncios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `usuarioanuncios` (
`id_usuario` int(11)
,`NUMEROANUNCIOS` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nomrbe` varchar(20) NOT NULL,
  `foto` varchar(20) NOT NULL,
  `correo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nomrbe`, `foto`, `correo`) VALUES
(1, 'juan', 'fotojuan.jpg', 'juan@juan.cl'),
(2, 'felipe', 'fotofelipe.png', 'felipe@felipe.cl'),
(3, 'carolina', 'fotocarolina.png', 'carolina@carolina.cl'),
(4, 'fran', 'fotofran.png', 'fran@fran.cl'),
(5, 'anonimo', 'anon.png', 'anon@anon.cl');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `uv2`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `uv2` (
`id_usuario` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visitas1`
--

CREATE TABLE `visitas1` (
  `id_anuncio` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `visitas1`
--

INSERT INTO `visitas1` (`id_anuncio`, `id_usuario`, `fecha`) VALUES
(1, 1, '2017-05-24'),
(1, 2, '2017-05-23'),
(4, 2, '2017-05-25'),
(2, 4, '2017-05-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visitas2`
--

CREATE TABLE `visitas2` (
  `id_anuncio` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_comentario` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `visitas2`
--

INSERT INTO `visitas2` (`id_anuncio`, `id_usuario`, `id_comentario`, `fecha`) VALUES
(1, 1, 1, '2017-05-03'),
(2, 2, 3, '2017-05-19');

-- --------------------------------------------------------

--
-- Estructura para la vista `comentariosporuser`
--
DROP TABLE IF EXISTS `comentariosporuser`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `comentariosporuser`  AS  select `comentarios`.`id_usuario` AS `id_usuario`,count(0) AS `anuncioscomentados30Abril` from (`comentarios` join `publicaciones30abril`) where (`comentarios`.`id_anuncio` = `publicaciones30abril`.`id_anuncio`) group by `comentarios`.`id_usuario` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `publicaciones30abril`
--
DROP TABLE IF EXISTS `publicaciones30abril`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `publicaciones30abril`  AS  select `anuncios`.`id_anuncio` AS `id_anuncio` from `anuncios` where ((month(`anuncios`.`fecha`) = 4) and (dayofmonth(`anuncios`.`fecha`) = 30)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `publicacionsmaximo`
--
DROP TABLE IF EXISTS `publicacionsmaximo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `publicacionsmaximo`  AS  select max(`usuarioanuncios`.`NUMEROANUNCIOS`) AS `maximo` from `usuarioanuncios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `usuarioanuncios`
--
DROP TABLE IF EXISTS `usuarioanuncios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usuarioanuncios`  AS  select `anuncios`.`id_usuario` AS `id_usuario`,count(0) AS `NUMEROANUNCIOS` from `anuncios` where (month(`anuncios`.`fecha`) = 5) group by `anuncios`.`id_usuario` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `uv2`
--
DROP TABLE IF EXISTS `uv2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `uv2`  AS  select `anuncios`.`id_usuario` AS `id_usuario` from (`anuncios` join `visitas2`) where ((`anuncios`.`id_anuncio` = `visitas2`.`id_anuncio`) and (`anuncios`.`id_usuario` = `visitas2`.`id_usuario`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `anuncios`
--
ALTER TABLE `anuncios`
  ADD PRIMARY KEY (`id_anuncio`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_anuncio` (`id_anuncio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `visitas1`
--
ALTER TABLE `visitas1`
  ADD KEY `FK_anuncio` (`id_anuncio`),
  ADD KEY `FK_usuario` (`id_usuario`);

--
-- Indices de la tabla `visitas2`
--
ALTER TABLE `visitas2`
  ADD KEY `FK_anuncio2` (`id_anuncio`),
  ADD KEY `FK_usuario2` (`id_usuario`),
  ADD KEY `FK_comentario2` (`id_comentario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `anuncios`
--
ALTER TABLE `anuncios`
  MODIFY `id_anuncio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `anuncios`
--
ALTER TABLE `anuncios`
  ADD CONSTRAINT `anuncios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id_anuncio`);

--
-- Filtros para la tabla `visitas1`
--
ALTER TABLE `visitas1`
  ADD CONSTRAINT `FK_anuncio` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id_anuncio`),
  ADD CONSTRAINT `FK_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `visitas2`
--
ALTER TABLE `visitas2`
  ADD CONSTRAINT `FK_anuncio2` FOREIGN KEY (`id_anuncio`) REFERENCES `anuncios` (`id_anuncio`),
  ADD CONSTRAINT `FK_comentario2` FOREIGN KEY (`id_comentario`) REFERENCES `comentarios` (`id_comentario`),
  ADD CONSTRAINT `FK_usuario2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
