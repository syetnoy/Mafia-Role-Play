-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Окт 21 2019 г., 15:10
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `newserv`
--

-- --------------------------------------------------------

--
-- Структура таблицы `infoserv`
--

CREATE TABLE IF NOT EXISTS `infoserv` (
  `NameServ` varchar(32) NOT NULL,
  `SiteServ` varchar(32) NOT NULL,
  `LangueServ` varchar(11) NOT NULL,
  `NumServ` varchar(3) NOT NULL,
  `ClientServ` varchar(7) NOT NULL,
  `MapServ` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `infoserv`
--

INSERT INTO `infoserv` (`NameServ`, `SiteServ`, `LangueServ`, `NumServ`, `ClientServ`, `MapServ`) VALUES
('Evolve Role Play', 'Evolve-Rp.Ru', 'Russian', '04', '0.3.7', 'San Andreas');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
