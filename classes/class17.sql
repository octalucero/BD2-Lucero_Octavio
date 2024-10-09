-- 1
SELECT a.address_id, a.address, a.district, a.postal_code, c.city, co.country
FROM address a
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code IN ('0000', '12345');

SELECT a.address_id, a.address, a.district, a.postal_code, c.city, co.country
FROM address a
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code NOT IN ('0000', '12345');

CREATE INDEX idx_postal_code ON address(postal_code);

/*
El tiempo de ejecución de las consultas debería reducirse significativamente porque el índice permite a MySQL
encontrar rápidamente las filas con los postal_code deseados sin escanear la tabla completa. El motor de la 
base de datos usa el índice para buscar las filas necesarias de manera más eficiente, lo que reduce el tiempo 
de respuesta.
*/

-- 2
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOHN';

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'DOE';

/*
Al hacer la consulta donde buscamos por el aprllido el tiempo de ejecucin es significaticativamente menor 
por lo pode concluir que existe un indice para los apellidos
*/

-- 3
ALTER TABLE film_text ADD FULLTEXT (description);

SELECT film_id, title, description
FROM film
WHERE description LIKE '%action%';


SELECT film_id, title, description
FROM film_text
WHERE MATCH(description) AGAINST('action');

/*
En la mayoría de los casos, MATCH ... AGAINST será significativamente más rápido que LIKE para búsquedas
de texto en grandes volúmenes de datos. Esto se debe a que MATCH ... AGAINST utiliza un índice optimizado
para búsquedas de texto completo, mientras que LIKE realiza un escaneo de la tabla para cada fila que 
verifica si contiene el patrón buscado.
*/