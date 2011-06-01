-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 01-06-2011 a las 23:07:21
-- Versión del servidor: 5.5.8
-- Versión de PHP: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `democraciadirecta`
--
CREATE DATABASE `democraciadirecta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `democraciadirecta`;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcar la base de datos para la tabla `pleyes`
--

INSERT INTO `pleyes` (`id`, `nombre`, `tags`, `descripcion`, `idUsuario`) VALUES
(1, 'No A Los Toros', '1;2;', 'blablabla', 1),
(2, 'Arbitros Con Bigote', '2;', 'ahahahah', 1),
(3, 'Museos Gratis', '2;3;', 'blablabla', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcar la base de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `nombre`) VALUES
(1, 'Deportes'),
(2, 'Juventud'),
(3, 'Cultura');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nick`, `password`, `email`, `nombre`) VALUES
(1, 'practica', 'practica', 'practica@us.es', 'Pr�ctica');
