-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 25, 2021 at 06:03 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `postgres`
--

-- --------------------------------------------------------

--
-- Table structure for table `weight`
--
CREATE DATABASE if not EXISTS postgres;

-- Table Definition
CREATE TABLE "public"."alembic_version" (
    "version_num" varchar(32) NOT NULL,
    PRIMARY KEY ("version_num")
);

-- Squences
CREATE SEQUENCE IF NOT EXISTS weight_id_seq

-- Table Definition
CREATE TABLE "public"."weight" (
    "id" int4 NOT NULL DEFAULT nextval('weight_id_seq'::regclass),
    "max" int4 NOT NULL,
    "min" int4 NOT NULL,
    "perbedaan" int4 NOT NULL,
    "tanggal" date NOT NULL,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."weight" ("id", "max", "min", "perbedaan", "tanggal") VALUES
(1, 50, 48, 2, '2018-08-18'),
(2, 51, 50, 1, '2018-08-19'),
(3, 52, 50, 2, '2018-08-20'),
(4, 49, 49, 0, '2018-08-21'),
(5, 50, 49, 1, '2018-08-22');