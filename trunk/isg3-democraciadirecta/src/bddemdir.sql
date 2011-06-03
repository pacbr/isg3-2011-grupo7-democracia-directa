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
(2, 'çrbitros con bigote', '2;', 'Expulsi—n definitiva de todos los ‡rbitros con bigote de las federaciones deportivas espa–olas.', 1, 0, 'true'),
(3, 'Museos gratis para j—venes', '2;3;', 'Reforma que permita la entrada gratuita a todos los museos del estado a aquellos individuos menores de 26 a–os.', 1, 0, 'true'),
(4, 'Reforma agraria del pepino', '8;12;', 'Reforma agraria para favorecer el cultivo del pepino.', 2, 0, 'true'),
(6, 'Derogaci—n de la ley Sinde', '7;11;', 'A la mierda con la ley.', 3, 0, 'true');

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
(5, 'Energ’a'),
(6, 'Medio Ambiente'),
(7, 'Internet'),
(8, 'Agricultura'),
(9, 'Innovaci—n'),
(10, 'Educaci—n'),
(11, 'Econom’a'),
(12, 'Empleo'),
(13, 'Comercio'),
(14, 'Industria'),
(15, 'Igualdad');

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
