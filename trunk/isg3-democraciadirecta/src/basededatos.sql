-- phpMyAdmin SQL Dump
-- version 3.1.3.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-05-2011 a las 15:57:49
-- Versión del servidor: 5.1.33
-- Versión de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de datos: `democraciadirecta`
--
CREATE DATABASE `democraciadirecta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `democraciadirecta`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `leyes`
--

CREATE TABLE IF NOT EXISTS `leyes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `idtag` int(3) NOT NULL,
  `descripcion` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `leyes`
--

INSERT INTO `leyes` (`id`, `nombre`, `idtag`, `descripcion`) VALUES
(1, 'No A Los Toros', 1, 'blablabla'),
(2, 'Arbitros Con Bigote', 1, 'ahahahah');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `tag`
--

INSERT INTO `tag` (`id`, `nombre`) VALUES
(1, 'Deportes'),
(2, 'Juventud');

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
(1, 'practica', 'practica', 'practica@us.es', 'Práctica');
