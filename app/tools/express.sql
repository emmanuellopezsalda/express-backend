-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-12-2024 a las 15:55:21
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `express`
--
CREATE DATABASE IF NOT EXISTS `express` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `express`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_DELETE_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_USER` (IN `_id` INT(11))   BEGIN
DELETE FROM users WHERE id = _id;

END$$

DROP PROCEDURE IF EXISTS `SP_GET_SHIPMENTS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_SHIPMENTS` ()   BEGIN
SELECT * FROM shipments;
END$$

DROP PROCEDURE IF EXISTS `SP_GET_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GET_USER` ()   BEGIN
SELECT * FROM users;
END$$

DROP PROCEDURE IF EXISTS `SP_LOGIN_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGIN_USER` (IN `p_username` VARCHAR(255), IN `p_password` VARCHAR(255))   BEGIN
    DECLARE user_exists INT DEFAULT 0;
    DECLARE user_id INT DEFAULT 0;

    -- Verificar si el usuario existe con el username y password proporcionados
    SELECT `id`, COUNT(*) 
    INTO user_id, user_exists
    FROM `users`
    WHERE `username` = p_username AND `password` = p_password;

    -- Si el usuario existe, devolver el ID del usuario, de lo contrario devolver un valor 0
    IF user_exists > 0 THEN
        SELECT user_id AS `user_id`, 'Login Successful' AS `message`;
    ELSE
        SELECT 0 AS `user_id`, 'Invalid username or password' AS `message`;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `SP_POST_SHIPMENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_SHIPMENT` (IN `shipment_date` DATE, IN `city_a` VARCHAR(50), IN `city_b` VARCHAR(50), IN `weight` INT, IN `broad` INT, IN `large` INT, IN `height` INT, IN `commercial_value` INT)   BEGIN
    INSERT INTO `shipments`(`shipment_date`, `city_a`, `city_b`, `weight`, `broad`, `large`, `height`, `commercial_value`) 
    VALUES (shipment_date, city_a, city_b, weight, broad, large, height, commercial_value);
END$$

DROP PROCEDURE IF EXISTS `SP_POST_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_POST_USER` (IN `p_username` VARCHAR(200), IN `p_email` VARCHAR(200), IN `p_address` VARCHAR(200), IN `p_document` INT(10), IN `p_cellphone` INT(10), IN `p_password` VARCHAR(100))   BEGIN
INSERT INTO `users`(`username`, `email`, `address`, `document`, `cellphone`, `password`) VALUES (p_username, p_email, p_address, p_document, p_cellphone, p_password);
END$$

DROP PROCEDURE IF EXISTS `SP_UPDATE_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UPDATE_USER` (IN `p_id` INT(11), IN `p_username` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_address` VARCHAR(255), IN `p_document` VARCHAR(255), IN `p_cellphone` VARCHAR(15), IN `p_password` VARCHAR(255))   BEGIN
    UPDATE `users`
    SET 
        `username` = p_username,
        `email` = p_email,
        `address` = p_address,
        `document` = p_document,
        `cellphone` = p_cellphone,
        `password` = p_password
    WHERE `id` = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `shipments`
--

DROP TABLE IF EXISTS `shipments`;
CREATE TABLE `shipments` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `shipment_date` date NOT NULL,
  `city_a` varchar(50) NOT NULL,
  `city_b` varchar(50) NOT NULL,
  `weight` int(100) NOT NULL,
  `broad` int(100) NOT NULL,
  `large` int(100) NOT NULL,
  `height` int(100) NOT NULL,
  `commercial_value` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `shipments`
--

INSERT INTO `shipments` (`id`, `id_user`, `shipment_date`, `city_a`, `city_b`, `weight`, `broad`, `large`, `height`, `commercial_value`) VALUES
(1, 1, '2024-12-03', 'Medellín', 'Palmitas', 6767, 9899, 909, 99, 767);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `document` varchar(10) NOT NULL,
  `cellphone` varchar(10) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `address`, `document`, `cellphone`, `password`) VALUES
(1, 'ff', 'gg', 'gg', '33', '44', 'hh'),
(2, 'prueba', 'prueba@gmail.com', 'prueba', '14434535', '4467787', '123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `shipments`
--
ALTER TABLE `shipments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `shipments`
--
ALTER TABLE `shipments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `shipments`
--
ALTER TABLE `shipments`
  ADD CONSTRAINT `id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
