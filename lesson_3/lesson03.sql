/*Урок 3.
1. Пусть в таблице users поля created_at и updated_at оказались 
незаполненными. Заполните их текущими датой и временем.*/

SELECT * FROM users;

INSERT INTO users(id, name, birthday_at, created_at, updated_at)
VALUES 
(NULL, 'Andrey', '1988-08-07', NULL, NULL),
(NULL, 'Maxim', '1988-06-07', NOW(), NULL),
(NULL, 'Sasha', '1988-05-07', NULL, NULL);

UPDATE users SET created_at = NOW(), updated_at = NOW()  WHERE created_at is NULL OR updated_at is NULL;

SELECT * FROM users;

/* 2.Таблица users была неудачно спроектирована. Записи created_at 
и updated_at были заданы типом VARCHAR и в них долгое время помещались
значения в формате "20.10.2017 8:10". Необходимо преобразовать поля 
к типу DATETIME, сохранив введеные ранее значения.*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя покупателя',
birthday_at DATE COMMENT 'Дата рождения',
created_at VARCHAR(255),
updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users (id, name, birthday_at, created_at, updated_at)
VALUES 
(NULL, 'Alexey', '1979-01-27', '20.10.2017 8:10', '20.10.2017 8:10');


UPDATE
users
SET
created_at = STR_TO_DATE(created_at,'%d.%m.%Y %T'),
updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %T');

ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

SELECT * FROM users; 

/* 3. В таблице складских запасов storehouses_products в поле 
value могут встречаться самые разные цифры: 0, если товар закончился
и выше нуля, если на складе имеются запасы. Необходимо отсортировать
записи таким образом, чтобы они выводились в порядке увеличения 
значения value. Однако, нулевые запасы должны выводиться в конце,
после всех записей.*/

SELECT * FROM storehouses_products;
TRUNCATE TABLE storehouses_products;

INSERT INTO storehouses_products(id, storehouse_id, product_id, value) 
VALUES
(NULL, 1, 1, 2),
(NULL, 1, 2, 0),
(NULL, 1, 3, 3),
(NULL, 1, 4, 12),
(NULL, 1, 5, 10),
(NULL, 1, 6, 13);

SELECT * FROM storehouses_products ORDER BY value = 0, value;

/* 4.(по желанию) Из таблицы users необходимо извлечь пользователей,
родившихся в августе и мае. Месяцы заданы в виде списка английских 
названий ('may', 'august') */

SELECT * FROM users;

INSERT INTO users (id, name, birthday_at)
VALUES 
(NULL, 'Marat', '1979-08-27'),
(NULL, 'Andrey', '1988-05-20'),
(NULL, 'Igor', '1990-02-17'),
(NULL, 'Maksim', '1967-03-27'),
(NULL, 'Oleg', '1969-05-25');

SELECT id, name, birthday_at FROM users WHERE DATE_FORMAT(birthday_at,'%M') IN ('May', 'August');

/* 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи
запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте 
записи в порядке, заданном в списке IN. */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id = 5 DESC;

/* Урок 4.
1. Подсчитайте средний возраст пользователей в таблице users*/

SELECT SUM(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) /  COUNT(*) AS Average_age FROM users;

/* 2.Подсчитайте количество дней рождения, которые приходятся на каждую
из дней недели. Следует учесть, что необходимы дни недели текущего года,
а не года рождения.*/

SELECT DATE_FORMAT(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at)), '%W') AS day,
COUNT(*) AS total
FROM users
GROUP BY day;
 
/*(по желанию) 
3.Подсчитайте произведение чисел в столбце таблицы*/

SELECT EXP(SUM(LN(id))) AS Multiplication from catalogs;
