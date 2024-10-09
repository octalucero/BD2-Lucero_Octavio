#1
CREATE VIEW list_of_customers AS
	SELECT c.customer_id, c.first_name, c.last_name, ad.address, ad.postal_code, ad.phone, c.store_id, ct.city,co.country,
	case
		when c.active=1 then "active"
		else "inactive"
		end as active
	FROM customer c
	INNER JOIN address ad ON c.address_id = ad.address_id
	INNER JOIN city ct ON ad.city_id = ct.city_id
	INNER JOIN country co ON ct.country_id = co.country_id;

#2
CREATE VIEW film_details AS	
	SELECT f.film_id, f.title, f.description, f.replacement_cost, f.length, f.rating, group_concat(distinct c.name), group_concat(concat(a.first_name," ",a.last_name))
	FROM film f 
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
	INNER JOIN film_actor fa ON f.film_id = fa.film_id
	INNER JOIN actor a ON fa.actor_id = a.actor_id
	group by f.film_id, f.title, f.description, f.replacement_cost, f.length, f.rating;
    
#3
CREATE VIEW sales_by_film_category AS
	SELECT count(r.rental_id), c.name
	FROM rental r
	INNER JOIN inventory i ON r.inventory_id = i.inventory_id
	INNER JOIN film f ON i.film_id = f.film_id
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
	group by c.name;
    
#4
CREATE VIEW actor_information AS
	SELECT a.actor_id, a.first_name, a.last_name, count(fa.film_id)
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
	group by a.actor_id, a.first_name, a.last_name;

#5
select a.actor_id, a.first_name, a.last_name, group_concat(distinct concat(c.name, ": ", f.title) separator "; ") from actor a
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by a.actor_id, a.first_name, a.last_name;

/*
La view de actor_info permite motrar la relación entre actores y 
las películas en las que han actuado.Es muy parecida a la view de actor_information, solo que esta muestra la
categoria junto al titulo de la pelicula. Para hacer esto se  usa el group concat y la funcion concat. 
*/


#6
/*
Una vista materializada es una vista que almacena físicamente los resultados de una consulta en lugar de 
calcularlos cada vez que se consulta, lo que mejora el rendimiento en operaciones complejas o frecuentes. 
Son útiles para reportes y análisis, ya que evitan recalcular datos y aceleran las consultas.
DBMS con soporte de vistas materializadas:
Oracle: Soporte completo y actualizaciones automáticas.
PostgreSQL: Se deben refrescar manualmente.
SQL Server: Implementadas como Indexed Views.
MySQL: No tiene soporte nativo, pero se pueden emular.
Las alternativas a usarse pueden ser indices (estructuras de datos optimizadas),
tablas de resumen (cuando se neecesitan generar estadisticas, promedios, etc), particionamiento de tablas,
materializacion del sistema en general
*/ 
