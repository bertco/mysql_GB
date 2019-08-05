/*Вебинар 2. Урок 4. Домашнее задание (по желанию)
Запросы по БД vk

1. Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим 
пользоваетелем.*/

SELECT 
(SELECT CONCAT(firstname, ' ', lastname)
		FROM users
		WHERE id = from_user_id) AS friend, 
COUNT(*) AS message
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY message DESC
LIMIT 1;

/* 2.Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.*/

SELECT * FROM profiles;
-- Определили 10 самых молодых пользователей
SELECT user_id,
TIMESTAMPDIFF(DAY, birthday, NOW()) AS age_day FROM profiles
ORDER BY age_day
LIMIT 10;

-- Общее количество лайков 10ти самых молодых пользователей
DESC likes;
SELECT * FROM likes;

SELECT COUNT(*) AS total_likes FROM likes WHERE to_subject_id IN (
	SELECT id FROM media WHERE user_id IN (
	SELECT youngest.user_id FROM(
	(SELECT user_id, TIMESTAMPDIFF(DAY, birthday, NOW()) AS age_days FROM profiles
ORDER BY age_days LIMIT 10) as youngest)));


/* 3.Определить кто больше поставил лайков (всего) - мужчины или женщины?*/
DESC profiles;
SELECT * FROM profiles;

SELECT 'female' AS sex, COUNT(*) AS total_likes FROM likes WHERE from_user_id IN(
	SELECT user_id FROM profiles WHERE sex = 'F'
)
UNION
SELECT 'male' AS sex, COUNT(*) AS total_likes FROM likes WHERE from_user_id IN(
	SELECT user_id FROM profiles WHERE sex = 'M'
);

/* 4.Найти 10 пользователей, которые проявляют наименьшую активность в использовании
социальной сети.*/

/* Определяем следующие критерии активности пользователя:
 1. Количество лайков - вес 0,25
 2. Количество друзей - вес 0,25
 3. Количество медиа - вес 0,25
 4. Количество сообщений - вес 0,25
 */

SELECT user_id, SUM(total) FROM (
SELECT from_user_id AS user_id, COUNT(*) AS total FROM likes GROUP BY from_user_id
UNION ALL
SELECT user_id, COUNT(*) AS total FROM friendship GROUP BY user_id
UNION ALL
SELECT user_id, COUNT(*) AS total FROM media GROUP BY user_id
UNION ALL
SELECT from_user_id AS user_id, COUNT(*) AS total FROM messages GROUP BY from_user_id
) 
AS total_list GROUP BY user_id ORDER BY SUM(total) LIMIT 10;

