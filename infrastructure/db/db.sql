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
    "margin" int4 NOT NULL,
    "date" date NOT NULL,
    PRIMARY KEY ("id")
);

-- public."language" definition

-- Drop table

-- DROP TABLE public."language";

CREATE TABLE public."language" (
	id varchar NOT NULL,
	"language" varchar NOT NULL,
	active varchar NOT NULL,
	CONSTRAINT language_pkey PRIMARY KEY (id)
);


-- public."language" foreign keys

-- public."user" definition

-- Drop table

-- DROP TABLE public."user";

CREATE TABLE public."user" (
	id serial4 NOT NULL,
	email varchar NOT NULL UNIQUE,
	username varchar NOT NULL,
	"password" varchar NOT NULL,
	fullname varchar NOT NULL,
	phone varchar NOT NULL,
	gender public.gender_types NOT NULL,
	active bool NOT NULL,
	ip_address varchar NOT NULL,
	created_at timestamp NULL,
	updated_at timestamp NULL,
	language_id varchar NULL,
	CONSTRAINT user_pkey PRIMARY KEY (id)
);


-- public."user" foreign keys

ALTER TABLE public."user" ADD CONSTRAINT user_language_id_fkey FOREIGN KEY (language_id) REFERENCES public."language"(id);