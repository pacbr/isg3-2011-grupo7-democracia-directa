-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generaci—n: 13-06-2011 a las 17:34:49
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
CREATE DATABASE `democraciadirecta` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `democraciadirecta`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pleyes`
--

CREATE TABLE IF NOT EXISTS `pleyes` (
  `id` varchar(50) NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tags` varchar(100) NOT NULL,
  `descripcion` text CHARACTER SET latin1 NOT NULL,
  `idUsuario` varchar(50) NOT NULL,
  `Votos` int(50) NOT NULL DEFAULT '0',
  `Activa` enum('true','false') NOT NULL DEFAULT 'true',
  `visitas` int(10) NOT NULL DEFAULT '0',
  `posicionMax` int(10) NOT NULL DEFAULT '0',
  `posicionMin` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcar la base de datos para la tabla `pleyes`
--

INSERT INTO `pleyes` (`id`, `nombre`, `tags`, `descripcion`, `idUsuario`, `Votos`, `Activa`, `visitas`, `posicionMax`, `posicionMin`) VALUES
('1', 'No a los toros', '3;12;15;', 'Prohibicion de las corridas de toros en Espana.', '2', 5, 'true', 1, 25, 25),
('10', 'Amparo de mujeres maltratadas', '15;16;17;', 'Proteccion a las maltratadas y muerte a los maltratadores.', '3', 121, 'true', 0, 19, 21),
('11', 'Stop inmigrantes rumanos chavolistas', '12;15;18;', 'Control del paso de inmigrantes rumanos que lleguen con toda la familia, una cabra, y en furgoneta.', '1', 1321, 'false', 1, 0, 0),
('12', 'Ley de inmigracion y extranjeria', '12;15;18;', 'Proteccion a inmigrantes explotados por empresarios del campo.', '5', 51, 'true', 0, 18, 20),
('13', 'Igualdad en el trabajo', '12;15;18;', 'Igualdad en funciones y sueldos independientemente del sexo.', '3', 566, 'true', 0, 9, 9),
('14', 'Privilegios de la clase politica', '15;11;20;', 'Control estricto del absentismo de los cargos electos en sus respectivos puestos. Sanciones especificas por dejacion de funciones.', '5', 1123, 'true', 0, 2, 2),
('15', 'Contra el desempleo', '3;15;11;12;', 'Reparto del trabajo fomentando las reducciones de jornada y la conciliacion laboral hasta acabar con el desempleo estructural.', '5', 234, 'false', 0, 0, 0),
('16', 'Derecho a vivienda', '12;15;18;', 'Expropiacion por el Estado de las viviendas construidas en stock que no se han vendido para colocarlas en el mercado en regimen de alquiler protegido.', '5', 657, 'true', 0, 4, 4),
('17', 'Servicios publicos de calidad', '10;11;12;15;18;', 'Supresion de gastos inutiles en las Administraciones Publicas y establecimiento de un control independiente de presupuestos y gastos.', '5', 97, 'false', 0, 0, 0),
('18', 'Control de las Entidades Bancarias', '11;', 'Prohibicion de cualquier tipo de rescate o inyeccion de capital a entidades bancarias: aquellas entidades en dificultades deben quebrar o ser nacionalizadas para constituir una banca p?blica bajo control social.', '5', 0, 'true', 0, 22, 22),
('19', 'Fiscalidad', '11;12;15;18;', 'Aumento del tipo impositivo a las grandes fortunas y entidades bancarias.', '5', 749, 'true', 1, 3, 3),
('2', 'Arbitros con bigote', '2;12;15;18;', 'Expulsion definitiva de todos los arbitros con bigote de las federaciones deportivas espanolas.', '2', 5, 'true', 2, 26, 26),
('20', 'Libertades Ciudadanas y Democracia Participativa', '15;20;', 'Modificacion de la Ley Electoral para garantizar un sistema autenticamente representativo y proporcional que no discrimine a ninguna fuerza pol?tica.', '5', 110, 'true', 0, 14, 16),
('21', 'Reduccion del Gasto Militar', '3;17;11;12;15;', 'Reduccion del gasto militar.', '2', 556, 'true', 0, 6, 6),
('22', 'Ley de la jornada', '11;12;13;14;15;', 'Reduzcamos la jornada a la que tienen en el resto de europa', '4', 87, 'true', 0, 20, 23),
('23', 'Protesta belica', '2;14;15;', 'No al ejercito, no nos hace falta', '4', 187, 'true', 0, 15, 17),
('24', 'Protesta impuestos', '7;8;9;10;11;', 'Bajemos los impuestos', '4', 287, 'true', 0, 13, 15),
('25', 'Esto no puede seguir asi', '1;2;3;4;5;6;', 'Porque no, no puede seguir asi...', '4', 387, 'true', 0, 11, 11),
('26', 'Queja contra mi vecino', '7;', 'Tiene camaras que me graban, prohibamos las camaras', '4', 488, 'true', 1, 10, 10),
('27', 'Demanda a Google', '7;', 'No me gusta que tenga dos oes, que se cambie el nombre a Gugle', '4', 588, 'true', 1, 7, 7),
('28', 'Ley anti telefonica', '11;12;13;14;15;19', 'Que no se cambie de nombre a movistar', '4', 687, 'true', 0, 5, 5),
('29', 'Ley de las salamandras', '6;', 'Reduccion del caos que causan las salamandras.', '4', 567, 'true', 0, 8, 8),
('3', 'Museos gratis para jovenes', '3;12;15;18;', 'Reforma que permita la entrada gratuita a todos los museos del estado a aquellos individuos menores de 26 a?os.', '2', 5, 'true', 1, 27, 27),
('30', 'Propuesta para recibir aliens', '12;15;18;', 'Que cuando vengan se pasen por mi casa.', '4', 66, 'true', 0, 23, 25),
('31', 'Queja sobre las abducciones', '3;12;15;18;', 'Que no se produzcan pasadas las 4 de la madrugada, es molesto volver a casa a las 7 y que piensen que has estado de juerga.', '4', 56, 'true', 0, 24, 26),
('32', 'Primer', '1;2;7;8;9;10;11;', 'Soy el primero que postea una ley!.', '4', 1, 'true', 1, 31, 31),
('33', 'Vaya no he sido primer', '9;', 'Vaya, por poquito!.', '4', 1, 'true', 1, 32, 32),
('34', 'Propuesta anti spam', '7;10;19', 'Reducir el spam que recibe esta pagina de trolls y demas personajillos', '4', 24428, 'true', 0, 1, 1),
('4', 'Reforma agraria del pepino', '8;12;15;18;', 'Reforma agraria para favorecer el cultivo del pepino.', '2', 5, 'true', 1, 12, 12),
('5', 'Proteccion a ciudadanos de los mossos d-escuadra', '17;', 'Si algun mosso d-escuadra se pasa de violencia en sus actuaciones, se le eliminaran el casco, proteccion y defensa en sus proximas intervenciones con manifestantes. Tendran que defenderse con las manos.', '3', 5, 'true', 0, 28, 28),
('6', 'Derogacion de la ley Sinde', '7;11;15;', 'A la mierda con la ley.', '3', 5, 'true', 0, 29, 29),
('7', 'Derogacion ley de reproduccion asistida', '4;15;', 'No a la inseminacion artificial (IA), la fecundacion in vitro (FIV), con transferencia de embriones (TE), y la transferencia intratuberica de gametos (TIG)', '4', 150, 'true', 0, 16, 18),
('8', 'Apoyo a Ciencia, Tecnologia e Innovacion', '4;9;15;19;', 'La generacion de conocimiento en todos los ambitos, su difusion y su aplicacion para la obtencion de un beneficio social o economico', '5', 56, 'true', 0, 17, 19),
('9', 'Ley de bosques', '3;6;', 'No a la tala indiscriminada de bosques.', '1', 89, 'true', 2, 20, 22);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` varchar(50) NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcar la base de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `nombre`) VALUES
('1', 'Deportes'),
('10', 'Educacion'),
('11', 'Economia'),
('12', 'Empleo'),
('13', 'Comercio'),
('14', 'Industria'),
('15', 'Igualdad'),
('16', 'Familia'),
('17', 'Violencia'),
('18', 'Inmigracion'),
('19', 'Tecnologia'),
('2', 'Juventud'),
('20', 'Politica'),
('3', 'Cultura'),
('4', 'Ciencia'),
('5', 'Energia'),
('6', 'Medio Ambiente'),
('7', 'Internet'),
('8', 'Agricultura'),
('9', 'Innovacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` varchar(50) NOT NULL,
  `nick` varchar(15) CHARACTER SET latin1 NOT NULL,
  `password` varchar(15) CHARACTER SET latin1 NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tagsfav` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `leyesvotadas` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcar la base de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nick`, `password`, `email`, `nombre`, `tagsfav`, `leyesvotadas`) VALUES
('1', 'practica', 'practica', 'practica@us.es', 'Practica', '1;2;3;4;5;7;6;', '1;2;3;4;5;6;7;27;32;9;26;19;'),
('2', 'jose', 'jose', 'jose@isg3.com', 'Jose', '1;2;3;8;14;6;18;', '1;2;3;4;5;6;7;33;9;'),
('3', 'mario', 'mario', 'mario@isg3.com', 'Mario', '1;6;7;10;', '1;2;3;4;5;6;7;'),
('4', 'ramon', 'ramon', 'ramon@isg3.com', 'Ramon', '2;7;9;5;14;', '1;2;3;4;5;6;7;'),
('5', 'paco', 'paco', 'paco@isg3.com', 'Paco', '8;9;10;11;12;13;14;15;', '1;2;3;4;5;6;7;');
