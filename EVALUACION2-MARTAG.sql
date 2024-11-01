USE sakila;
     

-- Ej:1. Selecciona todos los nombres de las películas sin que aparezcan duplicados

                             -- *Saco los títulos de las peliculas

SELECT DISTINCT title
	FROM film;               -- *Uso DISTINCT para evitar titulos duplicados de las peliculas



-- Ej: 2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13

SELECT title							-- *Consigo la columna con el nombre de las pelis(title) y 
	FROM film                       	
	WHERE rating = "PG-13";             -- *Filas de la columna con la clasificacion que sean igual a "PG-13"
		

-- 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, description 				 -- *Seleccionamos el título y la descripción de las películas
	FROM film
	WHERE description LIKE '%amazing%';  -- *Uso LIKE para buscar "amazing" en la descripción ( % delante y detrás)


-- 4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title 							-- *Seleccio solo el título de las películas
	FROM film
	WHERE length > 120;  				-- *Filtro para obtener películas con duración mayor a 120 minutos(length:


-- 5.Recupera los nombres de todos los actores.


SELECT *
	FROM actor;        	 -- *compruebo cuantas filas hay con nombres de actores


SELECT first_name
	FROM actor;    		 -- * los nombres de todos los actores
        
        
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido
        
        
SELECT first_name, last_name        -- *Selecciona las columnas first_name y last_name de la tabla actor
	FROM actor                      
	WHERE last_name LIKE "Gibson";  -- *Aplica un filtro para seleccionar solo las filas donde last_name es exactamente "Gibson"


-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.


  
SELECT actor_id, first_name                       -- *Muestro los nombres de los actores y los actor_id -- donde las filas de id se encuentren dentro del rango indicado 
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20;   	   
	  
 
 SELECT first_name                                -- *Solo los nombres de los actores 
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20;



-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.


SELECT title, rating      -- *Selecciono las columnas title (título) y rating (clasificación) de la tabla film
	FROM film            
    WHERE rating NOT IN ("R", "PG-13");   -- *Filtro las filas donde la clasificación (rating) no sea "R" ni "PG-13"


-- Ej:9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.


SELECT rating, COUNT(*) AS Count          -- *Selecciono la columna rating y cuenta el total de filas por cada valor único de rating.
	FROM film
	GROUP BY rating;                      -- *Agrupo los resultados por cada valor único en la columna rating.
    
    
    
-- EJ:10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
-- apellido junto con la cantidad de películas alquiladas.


SELECT *
	FROM customer;                                               -- *Para saber cuantas filas tiene la tabla customer

SELECT customer_id, COUNT(rental_id) AS total_rentals            -- *Selecciono customer_id y cuenta el total de rental_id por cliente
	FROM rental
	GROUP BY customer_id;                                        -- *Agrupo los resultados por cada valor único en la columna customer_id   



SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals      -- *Selecciono ID, nombre, apellido del cliente y cuenta el total de alquileres
	FROM customer c                                                                      
	LEFT JOIN rental r ON c.customer_id = r.customer_id                                   -- *Realizo un LEFT JOIN con la tabla rental para incluir todos los clientes, incluso los que no tienen alquileres
	GROUP BY c.customer_id, c.first_name, c.last_name;                                    -- *Agrupo por ID, nombre y apellido del cliente para obtener el total de alquileres de cada cliente




-- Ej:11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
-- recuento de alquileres.


SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals  -- *Selecciono el nombre de la categoría y cuenta el total de rental_id en cada categoría
	FROM category c                       
	INNER JOIN film_category fc ON c.category_id = fc.category_id    -- *Realizo un INNER JOIN entre category y film_category usando category_id para vincular categorías con películas
	INNER JOIN film f ON fc.film_id = f.film_id                      -- *Realizo un INNER JOIN entre film_category y film usando film_id, para acceder a los detalles de cada película en una categoría
	INNER JOIN inventory i ON f.film_id = i.film_id                  -- *Realizo un INNER JOIN entre film e inventory usando film_id, para vincular cada película con su inventario
	INNER JOIN rental r ON i.inventory_id = r.inventory_id           -- *Realizo un INNER JOIN entre inventory y rental usando inventory_id, para vincular cada inventario con sus registros de alquileres
		GROUP BY c.category_id, c.name;                                  -- *Agrupo los resultados por category_id y name, obteniendo el total de alquileres para cada categoría


-- EJ:12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
-- clasificación junto con el promedio de duración.



SELECT DISTINCT rating                              -- *Compruebo cuantas clasificaciones distintas hay en tabka film
	FROM film;

SELECT rating, AVG(length) AS average_duration      -- *Selecciono la columna rating y calcula el promedio de length (duración) para cada grupo   
	FROM film
		GROUP BY rating;                                -- *Agrupo los resultados por cada valor único en la columna rating


-- EJ:13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".



SELECT actor.first_name, actor.last_name                             -- *Selecciono el nombre y apellido 
	FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id    -- *Realizo un INNER JOIN entre actor y film_actor usando actor_id, para vincular actores con películas en las que actuaron
	INNER JOIN film ON film_actor.film_id = film.film_id             -- *Realizo un INNER JOIN entre film_actor y film usando film_id, para acceder al título de la película correspondiente
		WHERE film.title = "Indian Love";                            -- *Filtro los resultados para obtener solo los registros donde el título de la película sea "Indian Love"


-- Ej:14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.



SELECT title, description                                            -- *Selecciono las columnas title  y description  de la tabla film
FROM film 
WHERE description LIKE "%dog%" OR description LIKE "%cat%";          -- *Filtro las filas donde la descripción contiene las palabras "dog" o "cat"

    

SELECT title                                                         -- *Selecciono solo la columna title de la tabla film
	FROM film
	WHERE description LIKE "%dog%" OR description LIKE "%cat%";      -- *Filtro las filas donde la descripción contiene las palabras "dog" o "cat"


-- Ej:15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.


SELECT actor_id, first_name, last_name                -- *Selecciona actor_id, first_name y last_name de la tabla actor
FROM actor  
WHERE actor_id NOT IN (                               -- *Filtro los actores cuyo actor_id no se encuentra en el subconjunto que define la subconsulta
    SELECT DISTINCT actor_id                          -- *Selecciono todos los IDs únicos de actores de la tabla film_actor
    FROM film_actor                                  
);


-- Ej:16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.


SELECT title, release_year                           -- *Selecciono las columnas title  y release_year
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;        -- *Filtro las filas donde release_year está entre 2005 y 2010, incluyendo ambos años

SELECT title                                         -- *Selecciono solo la columna title 
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;        -- *Filtro las filas donde release_year está entre 2005 y 2010, incluyendo ambos años



-- Ej:17. Encuentra el título de todas las películas que son de la misma categoría que "Family".


SELECT f.title, c.name AS category_name                            -- *Selecciono el título de la película y el nombre de la categoría, renombrado como category_name
	FROM film f 
	INNER JOIN film_category fc ON f.film_id = fc.film_id          -- *Realizo un INNER JOIN entre film y film_category usando film_id, para vincular cada película con su categoría
	INNER JOIN category c ON fc.category_id = c.category_id        -- *Realizo un INNER JOIN entre film_category y category usando category_id, para obtener el nombre de la categoría
		WHERE c.name = "Family";                                   -- *Filtro los resultados para mostrar solo las películas en la categoría "Family"



SELECT f.title                                                     -- *Selecciono únicamente el título de la película
	FROM film f  
	INNER JOIN film_category fc ON f.film_id = fc.film_id          -- *Realizo un INNER JOIN entre film y film_category usando film_id
	INNER JOIN category c ON fc.category_id = c.category_id        -- *Realizo un INNER JOIN entre film_category y category usando category_id
		WHERE c.name = "Family";                                   -- *Filtro los resultados para mostrar solo las películas en la categoría "Family"


-- EJ:18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.



SELECT a.first_name, a.last_name                          -- *Selecciono el nombre y apellido del actor
	FROM actor a  
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id  -- *Realizo un INNER JOIN entre actor y film_actor usando actor_id, para vincular cada actor con las películas en las que ha actuado
		GROUP BY a.actor_id                               -- *Agrupo los resultados por cada actor, usando actor_id para identificar a cada actor de manera única
		HAVING COUNT(fa.film_id) > 10;                    -- *Filtro los actores que han actuado en más de 10 películas, utilizando HAVING para aplicar la condición sobre el conteo agrupado


-- Ej:19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.


SELECT title, rating, length                       -- *Selecciono el título de la película, la clasificación y la duración en minutos
	FROM film
	WHERE rating = 'R' AND length > 120;           -- *Filtro las películas con clasificación 'R' y duración mayor a 120 minutos



SELECT title                                       -- *Selecciono el título de la película
	FROM film
	WHERE rating = 'R' AND length > 120;           -- *Filtro las películas con clasificación 'R' y duración mayor a 120 minutos


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
-- nombre de la categoría junto con el promedio de duración.


SELECT c.name AS category_name, AVG(f.length) AS average_duration  -- *Selecciono el nombre de la categoría y calcula el promedio de duración de las películas en esa categoría
	FROM category c  
	INNER JOIN film_category fc ON c.category_id = fc.category_id  -- *Realizo un INNER JOIN entre category y film_category usando category_id, para vincular categorías con películas
	INNER JOIN film f ON fc.film_id = f.film_id                    -- Realizo un INNER JOIN entre film_category y film usando film_id, para acceder a la duración de cada película en la categoría
		GROUP BY c.category_id, c.name                             -- Agrupo los resultados por cada categoría (usando category_id y nombre de la categoría)
		HAVING AVG(f.length) > 120;                                -- Filtro los resultados para mostrar solo las categorías donde el promedio de duración es mayor a 120 minutos

 

-- EJ:21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
-- cantidad de películas en las que han actuado


 WITH actors_films AS (                                          -- *Defino una CTE llamada actors_films
    SELECT actor_id, COUNT(film_id) AS count_films               -- *Selecciono actor_id y cuenta el número de películas (film_id) en las que ha actuado cada actor
		FROM film_actor 
		GROUP BY actor_id                                        -- *Agrupo los resultados por actor_id para contar las películas de cada actor
		HAVING COUNT(film_id) >= 5                               -- *Filtro para incluir solo los actores que han actuado en 5 o más películas
)
SELECT actor.first_name, actor.last_name, af.count_films         -- *Selecciono el nombre, apellido y número de películas de cada actor que cumple el criterio
	FROM actor  
	INNER JOIN actors_films af ON actor.actor_id = af.actor_id;  -- *Realizo un INNER JOIN entre actor y la CTE actors_films para incluir solo los actores con 5 o más películas


-- Nota:


-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
-- encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

 SELECT title                                                                     -- *Selecciono la columna title 
FROM film   
	WHERE film_id IN (                                                            -- *Filtro las películas cuyo film_id está en el conjunto de resultados de la subconsulta
		SELECT inventory.film_id                                                  -- *Selecciono el film_id de las películas que cumplen la condición de alquiler
			FROM rental                                                           -- *Defino rental como la tabla principal de la subconsulta
			INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id        -- *Realizo un INNER JOIN con inventory usando inventory_id, para vincular cada alquiler con su inventario
				WHERE DATEDIFF(return_date, rental_date) > 5                            -- *Filtro solo los registros donde la diferencia entre la fecha de devolución y la de alquiler es mayor a 5 días
);
 
  
  
  

-- EJ:23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
-- exclúyelos de la lista de actores.








-- BONUS --


-- Ej:24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
-- tabla film.

-- Ej:25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
-- mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
  
  
  
  


 
