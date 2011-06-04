-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generaci—n: 03-06-2011 a las 13:45:44
-- Versi—n del servidor: 5.1.44
-- Versi—n de PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `democraciadirecta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pleyes`
--

CREATE TABLE IF NOT EXISTS `pleyes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tags` varchar(100) NOT NULL,
  `descripcion` text CHARACTER SET latin1 NOT NULL,
  `idUsuario` int(10) NOT NULL,
  `Votos` int(50) NOT NULL DEFAULT '0',
  `Activa` enum('true','false') NOT NULL DEFAULT 'true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcar la base de datos para la tabla `pleyes`
--

INSERT INTO `pleyes` (`id`, `nombre`, `tags`, `descripcion`, `idUsuario`, `Votos`, `Activa`) VALUES
(1, 'No a los toros', '3;', 'Prohibici—n de las corridas de toros en Espa–a.', 1, 0, 'true'),
(2, 'Arbitros con bigote', '2;', 'Expulsi—n definitiva de todos los ‡rbitros con bigote de las federaciones deportivas espa–olas.', 1, 0, 'true'),
(3, 'Museos gratis para jovenes', '2;3;', 'Reforma que permita la entrada gratuita a todos los museos del estado a aquellos individuos menores de 26 a–os.', 1, 0, 'true'),
(4, 'Reforma agraria del pepino', '8;12;', 'Reforma agraria para favorecer el cultivo del pepino.', 2, 0, 'true'),
(5, 'Proteccion a ciudadanos de los mossos d-escuadra', '17;', 'Si algun mosso d-escuadra se pasa de violencia en sus actuaciones, se le eliminaran el casco, proteccion y defensa en sus proximas intervenciones con manifestantes. Tendran que defenderse con las manos.', 3, 0, 'true'),
(6, 'Derogacion de la ley Sinde', '7;11;', 'A la mierda con la ley.', 3, 0, 'true'),
(7, 'Derogacion ley de reproduccion asistida', '4;16;', 'No a la inseminación artificial (IA), la fecundación in vitro (FIV), con transferencia de embriones (TE), y la transferencia intratubárica de gametos (TIG)', 4, 150, 'true'),
(8, 'Apoyo a Ciencia, Tecnologia e Innovacion', '4;9;19;', 'La generación de conocimiento en todos los ámbitos, su difusión y su aplicación para la obtención de un beneficio social o económico', 5, 56, 'true'),
(9, 'Ley de bosques', '3;6;', 'No a la tala indiscriminada de bosques.', 1, 87, 'true'),
(10, 'Amparo de mujeres maltratadas', '15;16;17;', 'Protección a las maltratadas y muerte a los maltratadores.', 3, 121, 'true'),
(11, 'Stop inmigrantes rumanos chavolistas', '12;15;18;', 'Control del paso de inmigrantes rumanos que lleguen con toda la familia, una cabra, y en furgoneta.', 2, 1321, 'false'),
(12, 'Ley de inmigracion y extranjeria', '12;15;18;', 'Proteccion a inmigrantes explotados por empresarios del campo.', 5, 51, 'true'),
(13, 'Igualdad en el trabajo', '12;15;', 'Igualdad en funciones y sueldos independientemente del sexo.', 3, 566, 'true'),
(14, 'ELIMINACION DE LOS PRIVILEGIOS DE LA CLASE POLITICA', '15;11;20;', 'Control estricto del absentismo de los cargos electos en sus respectivos puestos. Sanciones específicas por dejación de funciones.', 5, 1123, 'true'),
(15, 'CONTRA EL DESEMPLEO', '11;12;', 'Reparto del trabajo fomentando las reducciones de jornada y la conciliación laboral hasta acabar con el desempleo estructural.', 5, 234, 'false'),
(16, 'DERECHO A LA VIVIENDA', '15;16;', 'Expropiación por el Estado de las viviendas construidas en stock que no se han vendido para colocarlas en el mercado en régimen de alquiler protegido.', 5, 657, 'true'),
(17, 'SERVICIOS PUBLICOS DE CALIDAD', '10;11;12', 'Supresión de gastos inútiles en las Administraciones Públicas y establecimiento de un control independiente de presupuestos y gastos.', 5, 97, 'false'),
(18, 'CONTROL DE LAS ENTIDADES BANCARIAS', '11;', 'Prohibición de cualquier tipo de rescate o inyección de capital a entidades bancarias: aquellas entidades en dificultades deben quebrar o ser nacionalizadas para constituir una banca pública bajo control social.', 5, 0, 'true'),
(19, 'FISCALIDAD', '11;', 'Aumento del tipo impositivo a las grandes fortunas y entidades bancarias.', 5, 748, 'true'),
(20, 'LIBERTADES CIUDADANAS Y DEMOCRACIA PARTICIPATIVA', '15;20;', 'Modificación de la Ley Electoral para garantizar un sistema auténticamente representativo y proporcional que no discrimine a ninguna fuerza política.', 5, 110, 'true'),
(21, 'REDUCCION DEL GASTO MILITAR', '17;11;', 'Reduccion del gasto militar.', 5, 556, 'true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcar la base de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `nombre`) VALUES
(1, 'Deportes'),
(2, 'Juventud'),
(3, 'Cultura'),
(4, 'Ciencia'),
(5, 'Energia'),
(6, 'Medio Ambiente'),
(7, 'Internet'),
(8, 'Agricultura'),
(9, 'Innovacion'),
(10, 'Educacion'),
(11, 'Economia'),
(12, 'Empleo'),
(13, 'Comercio'),
(14, 'Industria'),
(15, 'Igualdad'),
(16, 'Familia'),
(17, 'Violencia'),
(18, 'Inmigracion'),
(19, 'Tecnologia'),
(20, 'Politica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nick` varchar(15) CHARACTER SET latin1 NOT NULL,
  `password` varchar(15) CHARACTER SET latin1 NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tagsfav` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcar la base de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nick`, `password`, `email`, `nombre`, `tagsfav`) VALUES
(1, 'practica', 'practica', 'practica@us.es', 'Pr‡ctica', '1;2;3;4;5;6;7;'),
(2, 'jose', 'jose', 'jose@isg3.com', 'Jose', '1;2;3;15;4;8;'),
(3, 'mario', 'mario', 'mario@isg3.com', 'Mario', '1;6;7;10;'),
(4, 'ramon', 'ramon', 'ramon@isg3.com', 'Ram—n', '2;7;9;5;14;'),
(5, 'paco', 'paco', 'paco@isg3.com', 'Paco', '8;9;10;11;12;13;14;15;');
