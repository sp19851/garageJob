-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Сен 17 2022 г., 11:00
-- Версия сервера: 10.4.24-MariaDB
-- Версия PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `qbcore`
--

-- --------------------------------------------------------

--
-- Структура таблицы `player_jobvehicles`
--

CREATE TABLE `player_jobvehicles` (
  `id` int(11) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `parked` varchar(255) NOT NULL DEFAULT '{}',
  `type` varchar(50) NOT NULL,
  `rang` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `player_jobvehicles`
--

INSERT INTO `player_jobvehicles` (`id`, `model`, `hash`, `mods`, `plate`, `job`, `garage`, `fuel`, `engine`, `body`, `state`, `depotprice`, `drivingdistance`, `status`, `parked`, `type`, `rang`) VALUES
(1, 'velum', '-1673356438', '{\"dashboardColor\":0,\"engineHealth\":1000.0,\"modArmor\":-1,\"neonColor\":[255,0,255],\"modSmokeEnabled\":false,\"modTransmission\":-1,\"model\":-1673356438,\"modSpeakers\":-1,\"modFrontWheels\":-1,\"modSuspension\":-1,\"fuelLevel\":26.0,\"color1\":111,\"modBrakes\":-1,\"modFrontBumper\":-1,\"modSpoilers\":-1,\"modFender\":-1,\"modAerials\":-1,\"modRoof\":-1,\"modShifterLeavers\":-1,\"modSteeringWheel\":-1,\"modExhaust\":-1,\"plate\":\"PEGASUS1\",\"modAirFilter\":-1,\"modEngineBlock\":-1,\"modTurbo\":false,\"modAPlate\":-1,\"modHood\":-1,\"dirtLevel\":8.0,\"modTrimA\":-1,\"wheels\":0,\"modStruts\":-1,\"modDial\":-1,\"modOrnaments\":-1,\"modFrame\":-1,\"modRearBumper\":-1,\"modRightFender\":-1,\"modLivery\":-1,\"neonEnabled\":[false,false,false,false],\"modHydrolic\":-1,\"modTrimB\":-1,\"extras\":[],\"modBackWheels\":-1,\"tankHealth\":1000.0,\"modHorns\":-1,\"modVanityPlate\":-1,\"modEngine\":-1,\"modSeats\":-1,\"modTank\":-1,\"modWindows\":-1,\"modCustomTiresR\":false,\"plateIndex\":0,\"modXenon\":false,\"modSideSkirt\":-1,\"modDashboard\":-1,\"modPlateHolder\":-1,\"interiorColor\":0,\"xenonColor\":255,\"modCustomTiresF\":false,\"pearlescentColor\":111,\"color2\":27,\"modGrille\":-1,\"modDoorSpeaker\":-1,\"modTrunk\":-1,\"bodyHealth\":1000.0,\"windowTint\":-1,\"modArchCover\":-1,\"tyreSmokeColor\":[255,255,255],\"wheelColor\":0}', 'Pegasus1', 'pilot', 'pilot', 26, 1000, 1000, 1, 0, 0, NULL, '{}', 'plane', 2),
(2, 'velum', '-1673356438', '{\"modCustomTiresR\":false,\"modWindows\":-1,\"modSpoilers\":-1,\"modTrimA\":-1,\"interiorColor\":0,\"modTrimB\":-1,\"modXenon\":false,\"modSteeringWheel\":-1,\"modSmokeEnabled\":false,\"windowTint\":-1,\"wheels\":0,\"extras\":[],\"xenonColor\":255,\"modSideSkirt\":-1,\"modOrnaments\":-1,\"modFrame\":-1,\"pearlescentColor\":111,\"modRearBumper\":-1,\"tankHealth\":1000.0,\"modSpeakers\":-1,\"modDoorSpeaker\":-1,\"modFrontWheels\":-1,\"modTurbo\":false,\"modGrille\":-1,\"modArmor\":-1,\"color1\":111,\"modEngine\":-1,\"model\":-1673356438,\"modCustomTiresF\":false,\"tyreSmokeColor\":[255,255,255],\"modPlateHolder\":-1,\"modTransmission\":-1,\"modSuspension\":-1,\"modTrunk\":-1,\"fuelLevel\":90.0,\"neonColor\":[255,0,255],\"modHydrolic\":-1,\"modVanityPlate\":-1,\"color2\":27,\"modStruts\":-1,\"neonEnabled\":[false,false,false,false],\"modHood\":-1,\"modArchCover\":-1,\"modAPlate\":-1,\"modEngineBlock\":-1,\"dirtLevel\":5.0,\"modBackWheels\":-1,\"modBrakes\":-1,\"modFrontBumper\":-1,\"modRightFender\":-1,\"modDial\":-1,\"plateIndex\":0,\"modAerials\":-1,\"modRoof\":-1,\"modDashboard\":-1,\"modExhaust\":-1,\"dashboardColor\":0,\"modFender\":-1,\"modSeats\":-1,\"bodyHealth\":985.1,\"modHorns\":-1,\"wheelColor\":0,\"engineHealth\":914.0,\"modAirFilter\":-1,\"modLivery\":-1,\"modTank\":-1,\"plate\":\"PEGASUS2\",\"modShifterLeavers\":-1}', 'Pegasus2', 'pilot', 'pilot', 90, 914, 986, 1, 0, 0, NULL, '{}', 'plane', 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `player_jobvehicles`
--
ALTER TABLE `player_jobvehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `player_jobvehicles`
--
ALTER TABLE `player_jobvehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
