SELECT *
FROM films JOIN reviews
	ON films.id = reviews.film_id;
    
SELECT *
FROM prime_minister JOIN president 
ON president.country = prime_minister.country;

/* which actors are in the highest imdb scoring film? */

SELECT people.name, reviews.imdb_score, films.title, roles.role
FROM films JOIN roles 
	ON films.id = roles.film_id 
    JOIN people ON people.id = roles.person_id
    JOIN reviews ON reviews.film_id = films.id
WHERE roles.role = 'Actor' 
	AND reviews.imdb_score = (SELECT MAX(reviews.imdb_score) FROM reviews)
ORDER BY name;

