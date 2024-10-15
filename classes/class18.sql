#1
DELIMITER //
DROP PROCEDURE IF EXISTS count_copies;

CREATE PROCEDURE count_copies(
	IN film_id INT,IN store_id INT
)
	BEGIN
		select f.title, count(inv.inventory_id), inv.store_id
		from film f
		INNER JOIN inventory inv ON f.film_id = inv.film_id
		where f.film_id = film_id
		and inv.store_id = store_id
		group by f.title, inv.store_id;
	END //
	delimiter;

call count_copies(5,2);

#2 

DELIMITER //
DROP PROCEDURE IF EXISTS list_costumers;
CREATE PROCEDURE list_costumers(IN countryname VARCHAR(255), out lista_customers VARCHAR(255))
	BEGIN
    
    declare finished integer default 0;
    declare selectedCustomer varchar(255) default "";
    
    declare customerCursor cursor for
		select concat(c.first_name, ' ', c.last_name)
		from customer c
		INNER JOIN address ad ON c.address_id = ad.address_id
		INNER JOIN city ct ON ad.city_id = ct.city_id
		INNER JOIN country co ON ct.country_id = co.country_id
		where co.country = countryName;
    
    declare continue handler 
    for not found set finished = 1;
	
    set lista_customers = "";
		OPEN customerCursor;
    get_customer : LOOP
		FETCH customerCursor INTO selectedCustomer;
		
		if finished = 1 then
			leave get_customer;
		end if;
        
        set lista_customers = concat(lista_customers, '; ', selectedCustomer);
        
        END LOOP get_customer;
	CLOSE customerCursor;
    
	END //
	delimiter ;
set @lista_customers = '';
call list_customers('Colombia', @lista_customers);
SELECT @lista_customers;

#3
/*La función inventory_in_stock devuelve un tinyint(1) (verdadero o falso) y se basa en dos variables internas:
 una que contabiliza el número de veces que se ha alquilado el artículo y otra que registra los alquileres sin fecha
 de devolución. De esta manera, proporciona una verificación precisa de la disponibilidad del artículo en el 
 inventario de la tienda.
 */
 SET @result = inventory_in_stock(10);
SELECT @result;

/*
El procedimiento almacenado film_in_stock tiene como objetivo determinar cuántas copias de una película específica
 están disponibles para alquilar en una tienda determinada. Este procedimiento toma dos parámetros de entrada:
 p_film_id, que corresponde al ID de la película, y p_store_id, que indica la tienda donde se quiere consultar la
 disponibilidad.
*/
CALL film_in_stock(1, 1, @result);
SELECT @result;


