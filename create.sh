# Задание 1. Урок 1.
# Установил СУБД MySQL. создал файл .my.cnf
nano .my.cnf
[client]
user=root
password=master

# Задание 2. Урок 1.
# создание базы данных example
CREATE DATABASE example;

# создание таблице users из двух столбцов числового id и текстового name
CREATE TABLE users(id INT, name TEXT);
