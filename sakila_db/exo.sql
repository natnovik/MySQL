select *from actor limit 5;
SELECT concat(first_name, ' ', last_name) AS Actor_Name FROM actor;
SELECT concat(LOWER(first_name), '.', UPPER(last_name)) AS Actor_Name  FROM actor;
SELECT concat(UPPER(last_name), '.', LEFT(first_name,1), '', lower(right(first_name, length(first_name) -1))) AS Actor_Name FROM actor;
SELECT concat(UPPER(last_name), '.', substring(first_name,1,1),'',lower(substring(first_name,2, length(first_name)))) AS Actor_Name FROM actor;
SELECT * FROM actor where first_name = "JENNIFER";
SELECT * FROM actor where LENGTH(first_name) = 3;
SELECT actor_id, first_name, last_name, length(first_name), length(last_name) FROM actor order by LENGTH(first_name) DESC; 
SELECT actor_id, first_name, last_name, length(first_name), length(last_name) FROM actor order by LENGTH(first_name) DESC, LENGTH(last_name) ASC; 
SELECT * FROM actor where last_name LIKE "%SON%";
SELECT * FROM actor where last_name LIKE "JOH%";
SELECT last_name, first_name FROM actor where last_name LIKE "%li%"order by last_name DESC, first_name DESC; 
SELECT actor.last_name, actor.first_name FROM sakila.actor where actor.last_name LIKE "%LI%" order by actor.last_name, actor.first_name ASC;
SELECT * FROM sakila.country WHERE (country.country = "China" OR country.country = "Afghanistan" OR country.country = "Bangladesh" );

ALTER TABLE sakila.actor ADD middle_name varchar(45) not null AFTER first_name;
alter table sakila.actor modify middle_name blob(20);
SELECT * from actor;
alter table actor drop column middle_name;

select last_name, count(last_name) as total from sakila.actor group by last_name having count(last_name) > 1 order by last_name DESC;
select last_name, count(last_name) as total from sakila.actor group by last_name having count(last_name) > 3 order by last_name ASC;
select first_name, count(first_name) as total from sakila.actor group by first_name having count(first_name) > 1 order by first_name ASC;

INSERT INTO sakila.actor ( first_name, last_name) VALUES ( "John", "Doe" );
SET SQL_SAFE_UPDATES=0;
UPDATE sakila.actor SET first_name= "Jean" WHERE first_name = "John";
SET SQL_SAFE_UPDATES=1;
DELETE FROM sakila.actor WHERE last_name = "Doe";
delete from sakila.actor order by actor_id desc limit 1;
select * from sakila.actor where last_name = "Doe";

update sakila.actor set  first_name = "HARPO" where first_name = "GROUCHO" and last_name = "WILLIAMS";

select * from sakila.actor where actor_id = 173;
update sakila.actor set first_name =(case 
when (first_name = "ALAN") then "ALLAN" 
else (first_name = "MUCHO ALLAN") end) where actor_id = 173;
/* showing but not updating
select  case when first_name ="ALAN" then "ALLAN" else "MUCHO ALLAN" end as first_name 
     from sakila.actor where actor_id = 173 ;
SELECT IF(first_name ="ALAN", "ALLAN", "MUCHO ALLAN") as first_name from sakila.actor where actor_id = 173 ;
 */
       
select staff.first_name, staff.last_name, address.address from staff  inner join address on staff.address_id = address.address_id;
select staff.staff_id, staff.first_name, staff.last_name, count(payment.staff_id), sum(payment.amount) as salary
from sakila.staff
inner join payment on staff.staff_id = payment.staff_id
WHERE payment.payment_date >= '2005-08-01 00:00:00'
group by payment.staff_id;

select film.film_id, film.title, COUNT(film_actor.actor_id) 
FROM film inner join film_actor
on film_actor.film_id = film.film_id
GROUP BY film.title order by COUNT(film_actor.actor_id)  desc;
select * from film where title = "Hunchback Impossible";
select film.film_id, film.title, COUNT(inventory.film_id) as global_stock from film inner join inventory on film.film_id = inventory.film_id GROUP BY film.title;
select film.title from film inner join language on language.language_id = film.language_id
where film.title LIKE "K%" or film.title LIKE "Q%"and language.name = "English";

select actor.first_name, actor.last_name from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film.film_id = film_actor.film_id
where film.title = "ACADEMY DINOSAUR";

select film.film_id, film.title
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on category.category_id = film_category.category_id
where category.name = "Family";

select film.film_id, film.title, film.rental_rate from film order by  film.rental_rate desc;

select store.store_id, city.city, country.country
from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id;

select store.store_id, city.city as store_loc, sum(payment.amount) as le_chiffre_d_affaire
from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join inventory on inventory.store_id = store.store_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by store.store_id
order by le_chiffre_d_affaire desc;

create view revenue_film_copies
as select count(inventory.film_id) as film_copie, sum(payment.amount) as revenue
from inventory
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by inventory.film_id
order by revenue desc;
select * from revenue_film_copies;
create view top_five_genres
as select category.name, revenue
from revenue_film_copies
inner join film_category on film_copie = film_category.film_id
inner join category on category.category_id = film_category.category_id
group by category.name
order by revenue desc limit 5;

select * from top_five_genres;
DROP VIEW top_five_genres;
















