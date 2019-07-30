/*1. Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и поля принимающие 
значение NULL. Напишите запрос, который заменяет все такие поля на строку ‘empty’. Помните, что на уроке мы 
установили уникальность на поле name. Возможно ли оставить это условие? Почему?*/

use shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название раздела'
-- UNIQUE unique_name(name(10)) Требуется исключить условие, т.к empty не сможет повторяться.
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES 
(DEFAULT, 'Proccesors'),
(DEFAULT, 'Motherboard'),
(DEFAULT, 'Videocard'),
(DEFAULT, ''),
(DEFAULT, NULL),
(DEFAULT, 'CD-ROM');

UPDATE catalogs SET name = 'Empty'
WHERE name = ' ' or name IS NULL;

SELECT * FROM catalogs;

/*2. Спроектируйте базу данных, которая позволяла бы организовать хранение медиа-файлов, загружаемых пользователем 
(фото, аудио, видео). Сами файлы будут храниться в файловой системе, а база данных будет хранить только пути к файлам,
названия, описания, ключевых слов и принадлежности пользователю.*/

CREATE DATABASE media;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название раздела',
UNIQUE unique_name(name(10))
) COMMENT = 'Разделы медиа-файлов';

INSERT INTO catalogs VALUES 
(DEFAULT, 'Photo'),
(DEFAULT, 'Audio'),
(DEFAULT, 'Video');
SELECT * FROM catalogs;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя пользователя'
) COMMENT = 'Пользователи';

INSERT INTO users (id, name) VALUES (1, 'Albert');
SELECT * FROM users;

DROP TABLE IF EXISTS file;
CREATE TABLE file (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название',
description TEXT COMMENT 'Описание',
file_path TEXT COMMENT 'Путь к файлу',
catalog_id INT UNSIGNED,
user_id INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
KEY index_of_catalog_id(catalog_id),
KEY index_of_user_id(user_id)
) COMMENT = 'Файлы';

INSERT INTO file(name, description, file_path, catalog_id, user_id) VALUES 
('Song1', 'About 1', '/home/student/audio', 2, 1),
('Video1', 'About 1', '/home/student/video', 3, 1),
('Photo1', 'About 1', '/home/student/photo', 1, 1);

SELECT * FROM file;

/*3. (по желанию) В учебной базе данных shop присутствует таблица catalogs. Пусть в базе данных sample имеется
таблица cat, в которой могут присутствовать строки с такими же первичными ключами. Напишите запрос, который
копирует данные из таблицы catalogs в таблицу cat, при этом для записей с конфликтующими первичными ключами 
в таблице cat должна производиться замена значениями из таблицы catalogs.*/

use sample;

DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название раздела',
UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO cat(name) VALUES ('Mouse');

REPLACE INTO cat SELECT * FROM shop.catalogs;

SELECT * FROM cat;