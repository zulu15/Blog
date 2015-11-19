-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 19-11-2015 a las 01:59:03
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `blog`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE IF NOT EXISTS `categoria` (
`cat_id` bigint(20) NOT NULL,
  `cat_nombre` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`cat_id`, `cat_nombre`) VALUES
(1, 'Programcion'),
(2, 'Noticias'),
(3, 'Tecnologia'),
(4, 'Humor'),
(5, 'Politica'),
(6, 'Ciencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE IF NOT EXISTS `entrada` (
`ent_id` bigint(20) NOT NULL,
  `ent_usr_email` varchar(32) NOT NULL,
  `ent_fecha` date NOT NULL,
  `ent_descripcion` varchar(5000) NOT NULL,
  `ent_titulo` varchar(5000) NOT NULL,
  `ent_cat_id` bigint(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`ent_id`, `ent_usr_email`, `ent_fecha`, `ent_descripcion`, `ent_titulo`, `ent_cat_id`) VALUES
(1, 'email@email.com', '2015-11-18', 'Por su parte, el hombre del Frente para la Victoria, apuesta al silencio presidencial y tras un acto hoy en la ciudad de Buenos Aires junto a a científicos del Conicet, partirá por la tarde rumbo a la localidad cordobesa de Río Cuarto, donde se reunirá con productores locales; y luego irá a Mendoza junto al titular del ANSES, Diego Bossio, para recorrer obras del Plan Procrear. ', 'SCIOLI FPV', 5),
(3, 'lki@outlook.com.ar', '2015-11-13', 'La Policía gala ha dado por concluida poco antes del mediodía la operación antiterrorista abierta desde esta madrugada en el barrio de Saint Denis, al norte de París, contra varias personas sospechosas de estar vinculadas con los atentados del 13 de noviembre en París que provocaron 129 muertos. El objetivo del dispositivo que arrancó a las 04:20 horas de la noche en el número 8 de la rue Corbillon era capturar a Abdelhamid Abaaud, considerado el cerebro de los ataques del 13 de noviembre.', 'Dos muertos y siete detenidos en el asalto en Saint Denis contra el cerebro del 13-N', 2),
(4, 'usuario2@gmail.com', '2015-11-04', 'El uruguayo confirmó que seguirá su carrera en Monterrey de México el año próximo; "En el club cumplí todos mis sueños", dijo', 'Carlos Sánchez y su salida de River: "Era una oferta irresistible"', 2),
(9, 'prueba@email.com', '2015-11-01', 'El ministro de Ciencia, Tecnología e Innovación Productiva, Lino Barañao, y el presidente de ARSAT, Matías Bianchi, suscribieron esta tarde en la sede ministerial del Polo Científico Tecnológico un convenio para impulsar líneas de investigación con el objetivo de reemplazar tecnologías en uso por otras que incrementen la eficiencia de la plataforma satelital de ARSAT, con el fin último de contribuir a mejorar las prestaciones de los satélites geoestacionarios argentinos. El acto de firma contó con la participación del subsecretario de Evaluación Institucional de la cartera científica, Jorge Aliaga, y el gerente de Desarrollo Tecnológico e Innovación de ARSAT, Mariano Goldschmidt.', 'La cartera científica y ARSAT suman esfuerzos para el desarrollo de una nueva plataforma satelital', 6),
(10, 'lki@outlook.com.ar', '2015-11-12', 'Anonymous no es nada concreto más allá de un enjambre, presumiblemente enorme, de hackers conectados en la Red y encantados de esconder sus nombres y sus artes a mayor gloria de un colectivo. WikiLeaks, la gran factoría de filtraciones, los convirtió en activistas políticos en 2010. Hasta entonces, eran una mera “marca de usuarios conocidos por gastar bromas a los restaurantes, acosar a pedófilos y protestar contra la Iglesia de la Cienciología”. Así define al cibercolectivo, que este fin de semana se atrevió por segunda vez a amenazar a ISIS, la periodista de la revista Forbes Parmy Olson. Su libro We are Anonymous es el resultado de su amistad con Topiary, uno de los hackers estrella.', 'Anonymous declara la guerra al ISIS: quiénes son y qué han conseguido', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `usr_email` varchar(32) NOT NULL,
  `usr_password` varchar(32) NOT NULL,
  `usr_nick` varchar(32) NOT NULL,
  `usr_rol` varchar(100) NOT NULL DEFAULT 'USUARIO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usr_email`, `usr_password`, `usr_nick`, `usr_rol`) VALUES
('email@email.com', 'yoli2015', 'El Brian', ''),
('lki@outlook.com.ar', '0000', 'LKI', ''),
('nuevo@email.com', '1234', 'Locura2015', 'sin privilegios'),
('prueba@email.com', 'prueba', 'usuario', ''),
('usuario2@gmail.com', '1234', 'usuario2', ''),
('vete_elmenduco94@live.com.ar', 'code1234lomas', 'joaquin', 'ADMINISTRADOR');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
 ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `entrada`
--
ALTER TABLE `entrada`
 ADD PRIMARY KEY (`ent_id`), ADD KEY `FK_entrada` (`ent_cat_id`), ADD KEY `FK_entrada_usuario` (`ent_usr_email`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
 ADD PRIMARY KEY (`usr_email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
MODIFY `cat_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `entrada`
--
ALTER TABLE `entrada`
MODIFY `ent_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
ADD CONSTRAINT `FK_entrada` FOREIGN KEY (`ent_cat_id`) REFERENCES `categoria` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_entrada_usuario` FOREIGN KEY (`ent_usr_email`) REFERENCES `usuario` (`usr_email`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
