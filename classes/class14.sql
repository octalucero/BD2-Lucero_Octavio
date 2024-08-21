-- 1
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, a.address, ci.city FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Argentina';

-- 2
SELECT f.title AS "Film Title", l.name AS "Language", CASE 
	WHEN f.rating = 'G' THEN 'General Audiences'
	WHEN f.rating = 'PG' THEN 'Parental Guidance Suggested'
	WHEN f.rating = 'PG-13' THEN 'Parents Strongly Cautioned'
	WHEN f.rating = 'R' THEN 'Restricted'
	WHEN f.rating = 'NC-17' THEN 'Adults Only'
	ELSE 'Not Rated' END AS "Rating"
FROM film f
INNER JOIN language l ON f.language_id = l.language_id;

-- 3

SELECT f.title, f.release_year
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name = LOWER('PENELOPE') AND a.last_name = LOWER('GUINESS');

-- 4 
SELECT f.title AS film_title, CONCAT(c.first_name, ' ', c.last_name) AS full_name, CASE 
	WHEN r.return_date IS NOT NULL THEN 'Yes'
	ELSE 'No'
    END AS returned
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5, 6);


-- 5
/*
Cast y convert se usa para convertir un tipo de dato en otro, por ejemplo de numero a texto pero Convert ofrece 
mas opcione de formato. 
CAST es más simple y estandarizado en SQL, mientras que CONVERT ofrece más opciones, especialmente para formatos
específicos,
*/
SELECT title, CONVERT(rental_rate, UNSIGNED) AS rental_rate_as_integer FROM film;
SELECT title, rental_rate, CAST(rental_rate AS CHAR) AS rental_rate_as_char FROM film;

-- 6
/* 
NVL se usa para reemplazar un valor nulo (NULL) por un valor especificado. Oracle, no disponible en MySql
ISNULL  también reemplaza un valor nulo con otro valor especificado, pero es específica de SQL Server y Sybase. No disponible en MySql
IFNULL igual que NVL y ISNULL. Disponible en MySql
COALESCE devuelve el primer valor no nulo de una lista de expresiones. Es parte del estándar SQL y es compatible con la mayoría de las bases de datos. Disponible en MySql
*/
SELECT NVL(NULL, 'No Data') FROM dual;
SELECT ISNULL(NULL, 'No Data');
SELECT IFNULL(NULL, 'No Data');
SELECT COALESCE(NULL, NULL, 'No Data', 'Data');
