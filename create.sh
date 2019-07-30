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

# Задание 3. Урок 1.
# создание дампа БД example и разворот содержимого дампа в новую базу данных sample
mysqldump example > sample.sql

CREATE DATABASE sample;

sample < sample.sql

# Задание 4. Урок 1.
# Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того,
# чтобы дамп содержал только первые 100 строк таблицы.

mysqldump mysql help_keyword WHER ='TRUE LIMIT 100' > help_keyword_dump.sql
